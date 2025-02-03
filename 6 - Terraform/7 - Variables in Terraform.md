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

