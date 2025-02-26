# Project:1 - Production-Grade Azure Infrastructure with Terraform

**Scenario**:

We are going to set up an Azure infrastructure where a load balancer fronts a VM scale set (VMSS) running a web application, with a Network Security Group (NSG) that allows only traffic coming from the load balancer and a NAT gateway providing outbound Internet connectivity (for patching, updates, etc.) to the VMSS. In this scenario, the public IP is attached only to the load balancer while the VMSS nodes have private IPs. Outbound traffic from the VMSS is routed via a NAT gateway and a NSG attached to vmss only allow traffic from load balancer to vmss block other traffic.

**Diagram**

This diagram shows the scenario.

<img src="https://drive.google.com/uc?export=view&id=1zZF6iJ-OGCPlIRK_WJoA1t2P0PMrvFdW" alt="terraform-project-1.png" width="630" height="380">

<br>
<br>

### Steps to setup using Azure Portal

**Step-1: Create a Resource Group**:

- In the left-hand menu, select Resource groups.
- Click + Create.
- Enter a name (for example, MyResourceGroup) and select a region (e.g., East US or West Europe).
- Click Review + create, then Create.


**Step-2: Create a Virtual Network (VNet) and Subnet**

- In the portal, click Create a resource and search for Virtual Network.
- Click Create.

- Basics Tab:
  - Subscription: Select your subscription.
  - Resource Group: Choose the resource group you created (MyResourceGroup).
  - Name: For example, MyVNet.
  - Region: Same as your resource group.

- IP Addresses Tab:
  - Address space: e.g., 10.0.0.0/16.
  - Subnet: Create a default subnet. Name it MySubnet with an address range such as 10.0.1.0/24.

- Click Review + create and then Create.

**Step-3: Create a NAT Gateway for Outbound Connectivity**

- Create a Public IP for NAT Gateway:
  - Click Create a resource and search for Public IP address.
  - Click Create.
    
  - Basics Tab:
    - Name: e.g., MyNatGatewayPublicIP.
    - SKU: Select Standard.
    - Assignment: Static.
    - Resource Group: Use MyResourceGroup.
      
  - Click Review + create then Create.
 
- Create the NAT Gateway:
  - Click Create a resource and search for NAT gateway.
  - Click Create.
    
  - Basics Tab:
    - Name: e.g., MyNatGateway.
    - Resource Group: MyResourceGroup.
    - Region: Same as VNet.
      
  - Configuration Tab:
    - Under Public IP addresses, select the public IP you just created (MyNatGatewayPublicIP).
    - Set Idle timeout (for example, 10 minutes).
      
  - Click Review + create then Create.

- Associate NAT Gateway with the Subnet:
  - Go to Virtual networks in the portal, select your VNet (MyVNet), and then click on Subnets.
  - Click your subnet (MySubnet).
  - Under NAT gateway, click Associate, select your NAT gateway (MyNatGateway), and click Save.


**Step-4: Create a Public Load Balancer**

- Create a Public IP for the Load Balancer:
   - Click Create a resource and search for Public IP address.
   - Click Create.
 
   - Basics:
     - Name: e.g., MyLoadBalancerPublicIP.
     - SKU: Select Standard.
     - Assignment: Static.
     - Resource Group: MyResourceGroup.
    
    - Click Review + create then Create.

- Create the Load Balancer:
  - Click Create a resource and search for Load Balancer.
  - Click Create.
 
  - Basics Tab:
    - Name: e.g., MyLoadBalancer.
    - Resource Group: MyResourceGroup.
    - Region: Same as other resources.
    - SKU: Standard.
    - Type: Public.

  - Frontend IP Configuration Tab:
    - Click Add a frontend IP configuration.
    - Name: e.g., MyFrontEnd.
    - Select the public IP you just created (MyLoadBalancerPublicIP).

  - Backend Pool Tab:
    - Create a backend pool. Name it, for example, MyBackEndPool.
   
  - Click Review + create then Create.

- Configure a Health Probe:
   - In the Load Balancer resource, select Health probes and click + Add.
   - Name: e.g., MyHealthProbe.
   - Protocol: TCP.
   - Port: 80.
   - Interval and Unhealthy threshold: Default values are acceptable.
   - Click OK.
 
- Create a Load Balancing Rule:
  - In the Load Balancer resource, select Load balancing rules and click + Add.
  - Name: e.g., MyLBRule.
  - Frontend IP: Select MyFrontEnd.
  - Backend Pool: Select MyBackEndPool.
  - Protocol: TCP, Frontend port: 80, Backend port: 80.
  - Health probe: Select MyHealthProbe.
  - Click OK.

**Step-5: Create a Network Security Group (NSG) to Restrict Inbound Traffic**

- Create an NSG:
  - Click Create a resource and search for Network security group.
  - Click Create.

  - Basics Tab:
    - Name: e.g., MyVMSSNSG.
    - Resource Group: MyResourceGroup.
    - Region: Same as other resources.

  - Click Review + create then Create.

- Configure an NSG Rule for Load Balancer Traffic:
  - Open your NSG (MyVMSSNSG).
  - Go to Inbound security rules and click + Add.

  - Rule Details:
    - Source: Service Tag
    - Source service tag: AzureLoadBalancer. (This tag represents traffic coming from the Azure load balancer.)
    - Source port ranges: *
    - Destination: Any
    - Destination port ranges: 80
    - Protocol: TCP
    - Action: Allow
    - Priority: e.g., 100
    - Name: e.g., Allow-HTTP-From-LoadBalancer
   
  - Click Add.

- Default Deny:
  - The NSG automatically denies all inbound traffic that does not match any allow rule. No additional rule is needed if you only allow AzureLoadBalancer traffic.

- Associate NSG with the Subnet or VMSS:
  - Subnet Association:
    - Go to your VNet, select Subnets, click your subnet (MySubnet), and under Network security group, select MyVMSSNSG.

  - Or VMSS NIC Association:
    - When creating your VM scale set, you can specify the NSG to attach to the VMSS network interfaces.

**Step-6: Create a VM Scale Set (VMSS) and Link to Load Balancer**

- Create a VM Scale Set:
  - Click Create a resource and search for Virtual machine scale set.
  - Click Create.
 
  - Basics Tab:
    - Subscription: Your subscription.
    - Resource Group: MyResourceGroup.
    - Name: e.g., MyVMSS.
    - Region: Same as other resources.
    - Image: Choose an image (for example, Ubuntu Server 20.04 LTS).
    - Authentication: Set up SSH keys or password.

  - Instance Details:
    - Set the instance count as desired (for example, 2).
    - Under Networking, select the virtual network (MyVNet) and subnet (MySubnet).
    - Under Load balancing, choose Yes for load balancing.
   
    - Load Balancer:
      - Select Existing and choose MyLoadBalancer.
      - Under Backend pool, select MyBackEndPool.

  - Advanced Options:
    - For public IP configuration of the VMSS, choose None (so the instances remain private).
    - Under Network Security Group, select Attach an existing NSG and choose MyVMSSNSG if not already associated with the subnet.

  - Click Review + create then Create.
 
- Wait for the VMSS Deployment:
  - The VMSS will be provisioned and registered in the backend pool of the load balancer.
 
**Step - 7: Deploy a Sample Web Application on the VM Scale Set**

- Prepare a Web Installation Script:
  - Create a simple bash script (for example, install-web.sh) that installs Apache and deploys a sample page:

    ```
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    echo "<html><body><h1>Hello from Azure VMSS!</h1></body></html>" | sudo tee /var/www/html/index.html
    sudo systemctl restart apache2
    ```

    Save this file and upload it to an accessible location (for example, an Azure Storage account with public blob access or GitHub).

- Add the Custom Script Extension:
  - In the Azure Portal, navigate to your VM scale set (MyVMSS).
  - Under Settings, select Extensions.
  - Click + Add and choose Custom Script Extension.
  - In the extension settings, provide the URL(s) to your script (for example, https://<your-storage-account>/install-web.sh) and set the command to execute (for example, ./install-web.sh).
  - Click Create.

**Step-8: Testing the Setup**

In your browser, navigate to http://<LoadBalancerPublicIP>:80. You should see the sample web page (e.g., “Hello from Azure VMSS!”).


<br>
<br>


## Implementation using Terraform

