# File and Directory Structure in Terraform

When you write terraform code, you need to organize your files properly so that Terraform can read and execute them easily. So that we divide the terraform scrips in multiple files.

A directory structure in Terraform is the way we organize files and folders in a project. It helps manage different parts of the infrastructure efficiently.

```अब तक हम simple एक main.tf file मैं ही resources, variables और बाकी terraform की configuration को define कर रहे थे लेकिन अब हम इसी configuration को उनकी अलग-अलग files मैं define करेंगे|```

```ऐसा हम इसलिए कर रहे हैं क्युकी जब बहुत सारे resources को एक ही file मैं रखने से वो एक messy file बन जाती है और कुछ समझ नहीं आता या फिर कोई team member उस infrastructure पे work करेगा और terraform की scripts देखेगा तो उसको चीज़े समझ नहीं आएँगी इसलिए resources को उनकी अलग-अलग files मैं रखेंगे| ऐसा करने से terraform की कितनी भी बड़ी scripts को हम easily समझ सकते है|```

<br>

### Why Do We Need a Directory Structure?

Imagine you are working on a large project where you need to manage:
- Virtual Machines.
- Databases.
- Networks.
- Storage.

If you dump all the files in a single folder, it becomes chaotic. You will not know:
- What file does what.
- Which configuration belongs to which environment (dev,prod).
- How to reuse parts of infrastructure.

By using a structured directory and file organization, you can:
- Easily find specific configuration.
- Reuse modules (instead of writing same code again).
- Seperate production and development environments.
- Collabrate with teams easily.

<br>

### What If We Don't Use a Proper Directory Structure?

Problems You Might Face:

- **Hard to Manage** – If everything is in one big file, it becomes confusing.
- **No Reusability** – You will repeat the same code for different environments (like dev and prod).
- **Difficult Debugging** – If something goes wrong, you won't know where to look.
- **Collaboration Issues** – If multiple people work on the same messy project, they will face conflicts.

**Example of a Messy Structure (BAD PRACTICE)**:
```
my-terraform-project/
│── everything-in-one-file.tf
│── some-random-config.tf
│── unused-config.tf
│── backup-copy.tf
│── old-version.tf
│── new-version-final.tf
```
😨 It’s a disaster!

<br>

## Basic Terraform Project Structure

A minimal Terraform project consists of the following files:

```
my-terraform-project/
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars
│── provider.tf
│── backend.tf
│── .terraform/
│── .terraform.lock.hcl
│── terraform.tfstate
│── terraform.tfstate.backup
│── README.md
```

Each of these files serves a specific purpose.

### Explanation of each file

- ```main.tf``` file: **The Core Terraform Configuration**
  - This is the main terraform scripts where you define your infrastructure (like virtual machines, networks, databases). In this you write the code for the resources you want to create on cloud.

  Example: Creating an Azure Resource Group

  ```
  resource "azurerm_resource_group" "rg" {
    name     = "my-resource-group"
    location = "East US"
  }
  ```

- ```variables.tf``` file: **Defining Input Variables**
  - In this file we define the variables and assign values in ```terraform.tfvars```.
  - Instead of hardcoding values, we use variables for flexibility.

  Example: 
  ```
  variable "location" {
    description = "The Azure region where resources will be created"
    type        = string
    default     = "East US"
  }

  variable "admin_username" {
    description = "Admin username for the VM"
    type        = string
  }

  variable "admin_password" {
    description = "Admin password for the VM"
    type        = string
    sensitive   = true
  }
  ```

- ```terraform.tfvars``` file: **Assigning Variable Values**
  - This file contains actual values for the variables defined in ```variables.tf```.

  Example: Assigning Values

  ```
  location        = "East US"
  admin_username  = "adminuser"
  admin_password  = "MySecurePassword123!"
  ```

- ```outputs.tf``` file: **Displaying Important Information**
  - Used to show useful details after Terraform finishes running.
  - After running Terraform, we might want to see important details (like VM public IP). To display the variables we use this file.
 
  Example: Displaying VM Public IP

  ```
  output "vm_public_ip" {
    description = "Public IP address of the virtual machine"
    value       = azurerm_network_interface.nic.private_ip_address
  }
  ```

- ```provider.tf``` file: **Defining the Cloud Provider**
  - Terraform needs to know which cloud it’s working with. So we define the cloud provider details in this file.

  Example: Setting Up Azure Provider

  ```
  terraform {
    required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.0"
      }
    }
  }

  provider "azurerm" {
    features {}
  }
  ```

- ```backend.tf``` file: **Configuring Remote State Storage**
  - By default, Terraform stores its state file locally (terraform.tfstate). To collaborate with a team, it’s better to store this state file in Azure Storage. So we define the remote backend details in this file
 
  Example: Using Azure Storage for State File

  ```
  terraform {
    backend "azurerm" {
      resource_group_name  = "terraform-backend-rg"
      storage_account_name = "myterraformstate"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }
  }
  ```

- ```.terraform/```: **Hidden Terraform Folder**
  - Terraform automatically creates this hidden folder.
  - It stores downloaded provider plugins and modules.
  - You should never manually edit this folder!.
 
- ```.terraform.lock.hcl``` file: **Dependency Lock File**
  - This file locks the Terraform provider versions to avoid unexpected changes.
  - Ensures that your infrastructure does not break due to automatic provider updates.
  - Think of this like a “freeze” file that locks software versions in a project.

- ```terraform.tfstate``` file: **Terraform’s State File**
  - Terraform tracks all created resources in this file.
  - It remembers what’s been deployed to prevent duplicate creations.
  - Never manually edit this file!
  - Think of this like a database keeping track of everything you own.
 
- ```terraform.tfstate.backup``` file: **Backup of State File**
  - Terraform automatically creates a backup of the last working state file.
  - If something goes wrong, you can use this to restore your infrastructure.

- ```README.md``` file: **Documentation File**
  - Describes the project purpose, usage, and instructions.

  Example content:

  ```
  # Terraform Azure VM Project
  This Terraform project deploys an Azure Virtual Machine.

  ## Steps to Run:
  1. Install Terraform
  2. Authenticate with Azure using `az login`
  3. Run `terraform init`
  4. Run `terraform apply`
  ```

<br>
<br>

## Example LAB: Concept of file and directory structure with creating a resource group.

Scenario: We are going to create resource group using file and directory structure.

**Create the below files**:
- main.tf
- provider.tf
- output.tf
- backend.tf
- variables.tf
- terraform.tfvars

**Step-1: Define the provider in provider.tf file**

```provider.tf```

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

**Step-2: Define main.tf**

```main.tf```

```
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
```

**Step-3: Define variables.tf**

```variables.tf```

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

variable "resource_group_name" {
  type        = string
  default     = ""
}

variable "resource_group_location" {
  type        = string
  default     = ""
}

```

**Step-4: Define terraform.tfvars**

```terraform.tfvars```

```
subscription_id = "f721bf30-04fd-4757-a7ad-e1aeeab1a6dc"
tenant_id = "b94db9d6-e2d9-4485-ba28-bd37e7a8d30c"
client_id = "520c5958-2fd2-45ea-835d-dfcaa1934c0b"
client_secret = "~VG8Q~ls_tVcyw1pOua7Pkr.cIaKjXKOs4l3jbGy"
resource_group_name = "Learning"
resource_group_location = "West Europe"
```

**Step-5: Run below commands**

- terraform.init
- terraform.plan
- terraform.apply
