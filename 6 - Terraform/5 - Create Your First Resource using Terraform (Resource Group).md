# Create Your First Resource (Resource Group) using Terraform

To create resources using Terrafrom, you need to write terraform script. We will see step-by-step implementation below.

### Steps to create resources

We will learn how to create resource group using terraform using a single main.tf file.

**Step - 1: Create a main.tf file in VS Code:**

First step is to create a main.tf file. Terraform uses the **.tf** extension file.

<br>

**Step - 2: Define Terraform Provider block:**

In terrafrom .tf file everything is created as a block. We have to mention on which cloud provider we want to create resource. If we want to create resources on azure then we should use azure provider.

```
# 1. Specify the version of the AzureRM Provider to use
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"    # Azure Provider Version
      version = "~> 4.8.0"
    }
  }
  required_version = ">=1.9.0"        # Terraform Version
}
```

<br>

**Step - 3: Define the block to use Terraform provider**

```ऊपर हमने एक provider block बनाया जिसमे हमने AzureRM provider का version define किया| अब हमको उस provider को use करने के लिए एक block बनाना होगा जिसमे हम उस provider को mention करेंगे|```

```
# 2. Configure the AzureRM Provider
provider "azurerm" {
  features {}
}
```

The AzureRM Provider supports authenticating using via the Azure CLI, a Managed Identity and a service principal. Actually we use this block to manage the azure provider.

<br>

**Step - 4: Authenticate terraform with Azure**

You must authenticate terraform with azure before creating resources. Refer this document to authenticate terraform with azure "https://github.com/puneet4840/DevOps-/blob/main/6%20-%20Terraform/2%20-%20Terraform%20Authentication%20with%20Azure.md"

<br>

**Step - 5: Define a resource block**

We want to create a resource group in azure. So, we will create a resource block.

```
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
```

Explanation:

- ```resource``` Block:
  - The ```resource``` keyword defines a new Azure resource to be created.
  - ```"azurerm_resource_group"``` is the resource type, which tells Terraform to create an Azure Resource Group.
  - ```"example"``` is the logical name of the resource within Terraform (it helps in referencing this resource in other parts of the code).
 
- ```name``` Argument
  - ```"example-resources"``` is the name of the Resource Group that will be created in Azure.
  - It must be unique within the Azure subscription.
 
- ```location``` Argument
  - ```"West Europe"``` specifies the Azure region where the Resource Group will be created.

<br>

**Step - 6: Terraform Plan**

Run this command to preview changes before applying.

```
terraform plan
```

<br>

**Step - 7: Terraform Validate**

Run this command to validate syntax of your terraform main.tf file.

```
terraform valudate
```

**Step - 8: Terraform Apply**

Run this command to create the resource group in azure portal.

```
terraform apply
```

<br>
<br>

## Example LAB: Creating resource group 

```main.tf``` file

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
}

provider "azurerm" {
  # Configuration options

  subscription_id = "f721bf30-04fd-4757-a7ad-e1aeeab1a6dc"
  tenant_id = "b94db9d6-e2d9-4485-ba28-bd37e7a8d30c"
  client_id = "520c5958-2fd2-45ea-835d-dfcaa1934c0b"
  client_secret = "~VG8Q~ls_tVcyw1pOua7Pkr.cIaKjXKOs4l3jbGy"

  features {
    
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "Learning"
  location = "West Europe"
}
```

**Run terraform commands**:

- ```terraform init```

- ```terraform plan```

- ```terraform apply```
