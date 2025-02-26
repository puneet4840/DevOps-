# Project:1 - Production-Grade Azure Infrastructure with Terraform

**Scenario**:

We are going to set up an Azure infrastructure where a load balancer fronts a VM scale set (VMSS) running a web application, with a Network Security Group (NSG) that allows only traffic coming from the load balancer and a NAT gateway providing outbound Internet connectivity (for patching, updates, etc.) to the VMSS. In this scenario, the public IP is attached only to the load balancer while the VMSS nodes have private IPs. Outbound traffic from the VMSS is routed via a NAT gateway.

<img src="https://drive.google.com/uc?export=view&id=1zZF6iJ-OGCPlIRK_WJoA1t2P0PMrvFdW" alt="terraform-project-1.png" width="570" height="340">
