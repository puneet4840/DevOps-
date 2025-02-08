# Conditional Operation in Terraform

Conditional Operation in terraform is like if-else conditions in programming language.

A terraform conditional expression is a short ```if-else``` statement that picks one value or another based on condition.

Imagine you have to make a decision. For example, you might say:
- "If it is raining, I'll take an umbrella; otherwise, I won't."

In Terraform, a conditional expression lets you do something very similar in your code. It’s a way to choose between two values based on a condition. It works like a tiny "if-else" statement

**Syntax**:

```condition ? true_value : false_value```

Explanation:
- **condition**: Any expression that evaluates to a Boolean (true or false).
- **true_value**: The value returned if the condition is true.
- **false_value**: The value returned if the condition is false.

<br>

### Why Do We Use Conditional Expressions?

- Conditional expressions help you write one Terraform configuration that can adapt to different situations. Instead of writing separate code for different cases, you can write one line that automatically picks the right value. This makes your code more flexible and easier to maintain.

- It lets you write flexible, adaptable code.

<br>

### Simple Azure Example

**Example-1: Setting the Azure Region Based on Environment**:

Imagine you want your production resources to be deployed in ```"eastus"``` and development resources in ```"westus2"```. You can do this by using a conditional expression.

main.tf

```
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

locals {
  azure_location = var.environment == "prod" ? "eastus" : "westus2"
}

provider "azurerm" {
  features {}
  # The location can be used when creating resources
}

resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = local.azure_location
}
```

Explanation:
- The conditional expression checks if ```var.environment``` equals ```"prod"```. If true, ```local.azure_location becomes``` ```"eastus"```; if not, it defaults to ```"westus2"```. This value is then used to set the location of your resource group.

<br>

**Example-2: Choosing a VM Size Based on Environment**

You might want to use a larger VM for production workloads and a smaller one for development.

main.tf

```
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

locals {
  vm_size = var.environment == "prod" ? "Standard_DS3_v2" : "Standard_DS1_v2"
}

resource "azurerm_virtual_machine" "example_vm" {
  name                  = "example-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  vm_size               = local.vm_size

  # Other required properties, such as network interfaces, OS profile, etc.
}
```

Explanation:
- The VM size is dynamically set based on whether the environment is production (```"prod"```) or not. This ensures that production deployments get a more powerful VM while development gets a cost-effective option.

<br>

### Additional Considerations

- **Type Consistency**:
  - Both the true and false values must be of the same type (e.g., both strings, both maps) because Terraform needs to determine the resulting type of the expression.
 
- **Complex Expressions**:
  - You can use functions, logical operators, and even more complex expressions within the condition.
 
<br>

### Best Practises

- Use locals to store conditional results for clarity.
- Ensure type consistency between true and false values.
- Keep your conditionals as simple and readable as possible.

