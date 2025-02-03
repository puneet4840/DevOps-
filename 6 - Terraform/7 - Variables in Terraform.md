# Variables in Terraform

A Variable is a container that stores the data.

OR

A Variable is a storage location that holds the data.

### What is a Variable in Terraform?

A Variable in terraform is a storage or placeholder for values which conatains data.

Instead of writing the same information again and again, we use variables to make our code more flexible and reusable.

Terraform variables allow you to make your infrastructure code reusable, flexible, and configurable. Instead of hardcoding values like resource names, regions, and instance sizes, you can define variables and assign values dynamically.

<br>

**Example Without Variables (Hardcoded Values)**

Imagine we want to create an Azure Resource Group (which is like a folder that contains all our cloud resources).

```
resource "azurerm_resource_group" "example" {
  name     = "MyResourceGroup"
  location = "East US"
}
```

Here, ```"MyResourceGroup"``` and ```"East US"``` are fixed values. If we want to change them, we have to edit the code manually.

<br>

**Example With Variables**

Instead of writing fixed values, we define variables:

```
variable "resource_group_name" {}
variable "location" {}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}
```

Now, when we run Terraform, we can set different values for these variables without changing the code.

<br>

### Why Use Variables in Terraform?

Variables provide the following benefits:

- **Reusability**: You can reuse the same configuration for different environments (e.g., dev, staging, prod) by changing variable values.
- **Flexibility**: Variables allow you to customize your infrastructure without modifying the core Terraform code.
- **Maintainability**: Centralized variable definitions make it easier to manage and update values.
- **Security**: Sensitive data (e.g., passwords, API keys) can be managed securely using sensitive variables.

<br>

### Variable Types:

Terraform supports different types of variables.

“| Type | Description | Example | | --- | --- | --- | | **string** | A single line of text | `"eastus"` | | **number** | A numeric value | `3` | | **bool** | Boolean (`true` or `false`) | `true` | | **list** | A list of values | `["eastus", "westus"]` | | **map** | A key-value pair | `{ env = "dev", location = "eastus" }` | | **object** | A structured collection of values | `{ name = "app", size = "Standard_B2s" }` | | **tuple** | A sequence of different data types | `["dev", 3, true]` |”



### Types of Variables in Terraform

Terraform supports three types of variables:

- **Input Variables**:
  - Input variable is used to provide values to ```main.tf``` file.
  - ```Input variables simply main.tf file मैं value provide करने के लिए होते हैं|```
  - Let’s say we are creating a resource group and we want to pass the resource group name as an input variable.
  
- **Local Varibales**:
  - Locals are temporary variables used within a Terraform module.

  Example: Using Local Variables

  Let’s say we need to generate a naming convention for Azure resources.

  ```
  locals {
    project_name = "myproject"
    location     = "eastus"
    environment  = "dev"
  
    # Constructing a standard name
    resource_name = "${local.project_name}-${local.environment}"
  }

  resource "azurerm_resource_group" "example" {
    name     = local.resource_name
    location = local.location
  }
  ```
    
- **Output Variables**:
  - Output variables are used to display important values after Terraform finishes execution. ```यह variable सिर्फ तब use होता है जब हमको कोई information as an output चाइये होती है|```
  - These are useful for getting resource details like public IPs or storage account names.
 
  Example: Displaying the Public IP of a VM:-

  ```
  output "vm_public_ip" {
    description = "The public IP address of the VM"
    value       = azurerm_public_ip.example.ip_address
  }
  ```

  After running ```terraform apply```, you will see:

  ```vm_public_ip = "52.168.23.45"```
