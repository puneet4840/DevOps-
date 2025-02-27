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

- ```providers.tf```

```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret
  features {}
}
```

- ```terrafrom.tfvars```

```
subscription_id = "f721bf30-04fd-4757-a7ad-e1aeeab1a6dc"
tenant_id = "b94db9d6-e2d9-4485-ba28-bd37e7a8d30c"
client_id = "520c5958-2fd2-45ea-835d-dfcaa1934c0b"
client_secret = "~VG8Q~ls_tVcyw1pOua7Pkr.cIaKjXKOs4l3jbGy"
```

- ```variables.tf```

```
variable "subscription_id" {
  type        = string
}

variable "tenant_id" {
  type        = string
}

variable "client_id" {
  type        = string
}

variable "client_secret" {
  type        = string
}
```

- ```main.tf```

```
resource "random_pet" "lb_hostname" {
}

# 1. Creating resource group
resource "azurerm_resource_group" "rg" {
    name = "Learning-rg"
    location = "West Europe"
  
}


# 2. Creating Vritual Network
resource "azurerm_virtual_network" "test" {
  name                = "vnet-01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 3. Creating subnet inside virtual network
resource "azurerm_subnet" "subnet" {
  name                 = "terraform-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.0.0/20"]
}

# 4. Network security group for the subnet with a rule to allow http, https and ssh traffic
resource "azurerm_network_security_group" "myNSG" {
  name                = "myNSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  #ssh security rule
  security_rule {
    name                       = "allow-ssh"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# 5. Adding nsg to subnet
resource "azurerm_subnet_network_security_group_association" "myNSG" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.myNSG.id
}


# 6. A public IP address for the load balancer
resource "azurerm_public_ip" "example" {
  name                = "lb-publicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  domain_name_label   = "${azurerm_resource_group.rg.name}-${random_pet.lb_hostname.id}"
}


# 7. A load balancer with a frontend IP configuration and a backend address pool
resource "azurerm_lb" "example" {
  name                = "myLB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "myPublicIP"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_lb_backend_address_pool" "bepool" {
  name            = "myBackendAddressPool"
  loadbalancer_id = azurerm_lb.example.id
 
}


# 8. Set up load balancer rule from azurerm_lb.example frontend ip to azurerm_lb_backend_address_pool.bepool backend ip port 80 to port 80
resource "azurerm_lb_rule" "example" {
  name                           = "http"
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "myPublicIP"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool.id]
  probe_id                       = azurerm_lb_probe.example.id
}


# 9. Set up load balancer probe to check if the backend is up
resource "azurerm_lb_probe" "example" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.example.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

# 10. Add lb nat rules to allow ssh access to the backend instances
resource "azurerm_lb_nat_rule" "ssh" {
  name                           = "ssh"
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "myPublicIP"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bepool.id
}

# 11. NAT GAteway public ip
resource "azurerm_public_ip" "natgwpip" {
  name                = "natgw-publicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}


# 12. Add nat gateway to enable outbound traffic from the backend instances
resource "azurerm_nat_gateway" "example" {
  name                    = "nat-Gateway"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}


resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_nat_gateway.example.id
}


# 13. Add nat gateway public ip association
resource "azurerm_nat_gateway_public_ip_association" "example" {
  public_ip_address_id = azurerm_public_ip.natgwpip.id
  nat_gateway_id       = azurerm_nat_gateway.example.id
}


# 14. VMSS
resource "azurerm_orchestrated_virtual_machine_scale_set" "vmss_terraform_tutorial" {
  name                        = "vmss-terraform"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  sku_name                    = "Standard_D2s_v4"
  instances                   = 3
  platform_fault_domain_count = 1     # For zonal deployments, this must be set to 1
  zones                       = ["1"] # Zones required to lookup zone in the startup script

  #user_data_base64 = base64encode(file("user-data.sh"))
  os_profile {
    linux_configuration {
      disable_password_authentication = false # Allow password authentication
      admin_username                  = "azureuser"
      admin_password                  = "P@ssw0rd1234!" 
    }
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-LTS-gen2"
    version   = "latest"
  }
  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                          = "nic"
    primary                       = true
    enable_accelerated_networking = false

    ip_configuration {
      name                                   = "ipconfig"
      primary                                = true
      subnet_id                              = azurerm_subnet.subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bepool.id]
    }
  }

  boot_diagnostics {
    storage_account_uri = ""
  }

  # Ignore changes to the instances property, so that the VMSS is not recreated when the number of instances is changed
  lifecycle {
    ignore_changes = [
      instances
    ]
  }
}



  # Deploy a sample web app via a custom script extension.
  # Make sure your install-web.sh is hosted in a publicly-accessible URL.
  extension {
    name                 = "CustomScript"
    publisher            = "Microsoft.Azure.Extensions"
    type                 = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
      {
        "fileUris": ["https://<your-storage-account-or-GitHub-url>/install-web.sh"],
        "commandToExecute": "./install-web.sh"
      }
SETTINGS
  }
}

# 7. Output the Load Balancer Public IP
output "load_balancer_public_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}
```
