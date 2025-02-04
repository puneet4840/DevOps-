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

| Type   | Description                        | Example                                 |
|--------|------------------------------------|-----------------------------------------|
| String | A single line of text              | "eastus"                                |
| Number | A numeric value                    |    3                                    |
| Bool   | Boolean (True or False)            |   true                                  |
| List   | A list of values                   | ["eastus", "westus"]                    |
| Map    | A key-value pair                   | { env = "dev", location = "eastus" }    |
| Object | A structured collection of values  | { name = "app", size = "Standard_B2s" } |
| Tuple  | A sequence of different data types | ["dev", 3, true]                        |

<br>

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

<br>
<br>

## Steps to use variables in terraform.

### Defining Variables in Terraform.

Variables are defined in Terraform using the ```variable``` block in a seperate ```variable.tf``` file. This block specifies the variable's name, type, description, default value, and other attributes.

Create a ```variable.tf``` file and define the variables.

```
variable "variable_name" {
  type        = data_type
  default     = default_value
  description = "A description of the variable"
}
```

**Example**:

```
variable "resource_group_name" {
  type        = string
  default     = "my-rg"
  description = "The name of the Azure resource group"
}
```

Explanation:
- ```variable```: This is the keyword which tells that this is a variable block.
- ```resource_group_name```: This is the name of the variable which we will use in main.tf file.
- ```type```: This is the type of variable like string, num, etc.
- ```default```: This is the default value we provide to variable. This value will be used if we especially do not define a value for variable.
- ```description```: It is the description for the variable.

### How to Use Variables?

Once you define a variable, you can use it in your Terraform code by referencing it with ```var.variable_name```. 

**Example**: ```main.tf``` file

```
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "East US"
}
```

Explanation:
- ```var.resource_group_name``` refers to the value of the ```resource_group_name``` variable.
- If no value is provided, Terraform will use the default value (my-rg).

<br>
<br>

### Assigning Values to Variables

After using variables in ```main.tf``` file. You have to provide values to the defines variables.

There are several ways to provide values to variables:

- **Default Values**:

  If you define a default value in the variable block, Terraform will use it unless you override it.
 
- **Command-Line Input**:

  You can pass values directly when running Terraform commands:

  ```
  terraform apply -var="resource_group_name=my-new-rg"
  ```

- **Variable Files (.tfvars)**:

  You can create a seperate ```terraform.tfvars``` file and create key-value pairs of variables to store values.

  ```
  resource_group_name = "my-rg"
  location           = "East US"
  ```

- **Using Environment Variables**:

  You can export the variables as environment variables in terminal and terraform will automatically pick the variables.

  ```
  export TF_VAR_resource_group_name="myRG"
  ```

### Run terraform plan

Now run ```terraform plan``` command to see the preview of your terraform script. You will see the defined varibale in the output.

<br>
<br>

## Handling Sensitive Variables (For Passwords, Secrets)

Some values, like passwords, should not be shown on the screen. Terraform lets us mark variables as **sensitive**:

```
variable "client_secret" {
  type      = string
  sensitive = true
}
```

Then, we can use it:

```
provider "azurerm" {
  features {}
  
  client_secret = var.client_secret
}
```

Terraform will hide the secret in the output to keep it safe.

<br>
<br>

## Example (Lab): Complete setup of variable in terraform.

Let’s create a complete example for deploying an Azure resource group and virtual machine using variables.

**Step-1: Create a variables.tf file.**:

```variables.tf```: Define the variables in seperate file.

```
variable "resource_group_name" {
  type        = string
  default     = "my-rg"
  description = "The name of the Azure resource group"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "The Azure region to deploy resources"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "The size of the virtual machine"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Admin password for the VM"
}
```

<br>

**Step-2: Create a main.tf file and assign the defined values**:

```main.tf```: Assign the defined variable.

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "my-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "my-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "my-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "myvm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
```

<br>

**Step-3: Create terraform.tfvars file and provide the actual values to variables**:

```terraform.tfvars```: Provide the variable values.

```
resource_group_name = "my-rg"
location           = "East US"
vm_size            = "Standard_B1s"
admin_username     = "adminuser"
admin_password     = "P@ssw0rd123!"
```

**Steps to Run This Code**:
- Save the files (variables.tf, main.tf, terraform.tfvars).
- Run ```terraform init``` to initialize Terraform.
- Run ```terraform plan``` to preview the terraform output.
- Run ```terraform apply``` to create the resources in Azure.
- Terraform will use the values from ```terraform.tfvars``` to deploy the infrastructure.


<br>
<br>

## Example (LAB): Complete setup of variables in terraform

**Step-1: Create main.tf file**:

Create ```main.tf``` file

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }

  backend "azurerm" {
      resource_group_name  = "Learning"
      storage_account_name = "terraformpuneet"
      container_name       = "terraform-blob"
      key                  = "terraform.tfstate"
      access_key           = "BzyGlaQa9ccnXlEzl8hHuGrCTUyinZhGWDz4LaSATxihSIyPCyabjAOgftRb4C0ORpCmi1QCdF/I+AStFipBcg=="
  }

}


provider "azurerm" {
  # Configuration options

  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret

  features {
    
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.azure_rm_resource_group_name
  location = var.azure_rm_location_name
}
```

**Step-2: Create variables.tf file**:

Now create ```variables.tf``` file 

```
variable "subscription_id" {
    default = "f721bf30-04fd-4757-a7ad-e1aeeab1a6dc"
}

variable "tenant_id" {
    default = ""
}

variable "client_id" {
    default =""
}

variable "client_secret" {
    default = ""
}

variable "azure_rm_resource_group_name" {
    default = ""
}

variable "azure_rm_location_name" {
    default =""
}
```

**Step-3: Create terraform.tfvars file**:

Create ```terraform.tfvars``` file 

```
subscription_id = "f721bf30-04fd-4757-a7ad-e1aeeab1a6dc"
tenant_id = "b94db9d6-e2d9-4485-ba28-bd37e7a8d30c"
client_id = "520c5958-2fd2-45ea-835d-dfcaa1934c0b"
client_secret = "~VG8Q~ls_tVcyw1pOua7Pkr.cIaKjXKOs4l3jbGy"
azure_rm_resource_group_name = "my-rg"
azure_rm_location_name = "West Europe"
```

**Step-4: Run terraform init command**:

Run ```terraform init``` command.

**Step-5: Run terraform plan command**:

Run ```terraform plan``` caommand.

**Step-6: Run terraform apply command**:

Run ```terraform apply``` command.

<br>
<br>

### Important Note:

I create a backend configuration inside main.tf file and was assining the variable in backend. So, here I was getting error that variables not allowed.

This means we can not use variables inside backend configuration of state file.
