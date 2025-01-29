# Create Your First Resource (Resource Group) using Terraform

To create resources using Terrafrom, you need to write terraform script. We will see step-by-step implementation below.

### Steps to create resources

We will learn how to create resources using terraform using a single main.tf file.

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
