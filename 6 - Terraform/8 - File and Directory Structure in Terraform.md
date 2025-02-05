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
