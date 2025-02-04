
# Terraform State File

### What is a state in terraform?

In terraform, **state** is the current status of the infrastructure that terraform is managing. State is actually the status of infrastructure.

```State का मतलब है की जो resources terraform ने cloud पर create किये हैं उनका status होता है, जैसे की- resources cloud पर create हुआ हैं या नहीं| क्या-क्या resources create हुए हैं, उनकी resources की configuration क्या है इसी को state बोलते हैं| और यह सब terraform एक state file मैं store करता है|```

### What is the State File?

When terraform creates or changes your infrastructure, it needs to keep track of what it has done. This is where **state file** comes in. 

```State File is a json file where terraform stores the details of resources it has created```.

Think of a state file as a "notebook" where terraform writes down:
- What resources it has created (e.g., server, database).
- Details about those resources (e.g., server name, server ip address).
- How the resources are connected to each other.

Terraform stores its state in a file called ```terraform.tfstate```. This file is:
- Generated automatically after running terraform inti.
- Contains JSON format data that records all resource details.
- Updated on every Terraform execution (apply, destroy, refresh).

Terraform creates that state file with the name ```terraform.tfstate``` at the same location where your other tf file are located.

```Suppose हमने terraform से azure cloud पर एक resource group बनाया| अब हमको पता है की cloud पर एक resource group बना हुआ है जिसको हम azure portal पर चेक कर सकते हैं लेकिन terraform को कैसे पता होगा की resource group बना हुआ है तो यह पर terraform state file का concept आता है| Terraform state file मैं जाके check कर लेगा की एक resource group create है क्युकी वहां पर उस resource की configuration save होगी और जब हम terraform init command run करते हैं तो automatically एक state file बन जाती है|```

<br>

### Why Do We Need the State File?

The state file is super important because:

- **It Remembers What Terraform Did**:
  - Without the state file, Terraform wouldn’t know what resources it created or how to manage them. Every time you run Terraform, it would create everything from scratch.
  - For example, if you ask Terraform to delete a server, it needs to know which server to delete. The state file tells it.
 
- **It Tracks Changes**:
  - If someone manually changes your infrastructure (e.g., resizes a server), Terraform can compare the actual state (what’s created on cloud) with the desired state (what you defined in your code) and fix any differences.
 
- **Dependency Management**:
  - Terraform uses the state file to understand dependencies between resources.
  - For example, if Resource A depends on Resource B, Terraform ensures that Resource B is created before Resource A.
 
- **Prevents Resource Duplication**:
  - If Terraform didn’t have a state file, every time you run ```terraform apply```, it would recreate the same resources again and again. The state file helps Terraform understand:
    - What is already created.
    - What needs to be updated.
    - What should be deleted.
   
<br>

### Actual State VS Desired State

- **Desired State**:

  - Desired state is the terraform .tf file in which you have written the script to create infrastructure. Desired state is like ```आप terraform script लिखकर क्या resource create करना चाहते हो|```
  - For example, you might write code to say, “I want one server with 2 CPUs, 4 GB of RAM, and a public IP address.” This is the desired state.  

- **Actual State**:

  Actual state is the infrastructure already create on your cloud portal. Actual state is represented by the state file ```क्युकी resources create होने के बाद state file मैं resources का status update हो जाता है|```

<br>

### How Does Terraform Uses the State File?

- **When you run** ```Terraform init```:

  Terraform download the required plugins and creates a ```terraform.tfstate``` file.

- **When you run** ```Terrafrom plan```:

  Terraform looks at your desired state (your code) and compares it with the actual state (the state file).

- **When you run** ```Terraform apply```:

  Terraform makes the changes to your infrastructure and updates the state file to reflect the new actual state.

- **When you run** ```Terraform destroy```:

  Terraform uses the state file to know which resources to delete.

<br>

## Where is the Terraform State File is stores?

Terraform state is stored in a file called ```terraform.tfstate```. This file contains a record of all the infrastructure that Terraform manages. Depending on your setup, Terraform can store the state locally on your computer or remotely in a cloud storage system.

**Types of Terraform State Storage**:

Terraform state can be stored in two main ways:
- Local State (Default).
- Remote State (For Teams & Collaboration).

<br>

### Local State (Default Storage):

By default, when you run terraform apply, Terraform stores the state file on your local machine in your project directory.

Where is the Local State File Stored?
- The state file is created in the same folder where you run Terraform.
- It is named ```terraform.tfstate```.


**Example of Local State Storage**:

Let's say you create an Azure VM using Terraform. Now, you run ```terraform apply```. So, terraform will create Virtual Machine on azure and Saves the details in terraform.tfstate.

This means Terraform remembers that it created an VM on azure with particular configuration.

**Problems with Local State Storage**:

- **Not good for teams**: If multiple people are working, they won’t have access to the same state file.
- **Risk of losing state**: If your laptop crashes or the file is deleted by any chance, Terraform forgets what it built. Then If you will run ```terraform apply``` command without having state file then terraform will create entire written infra on cloud.

**When to Use Local State?**
- Good for small projects and personal use.
- When working alone on a test environment.

<br>

### Remote State (For Teams & Collaboration)

```इसका मतलब है की state file को किसी remote storage (like azure storage) मैं store करना जिससे terraform उस state file को remotely acces कर ले|```

Terraform tracks infrastructure using a state file (```terraform.tfstate```). By default, Terraform stores this file locally on your computer. However, in team environments, a local state file causes problems:

- **Collaboration issues** – If state file is stored on you local machine and If you are working with team on terraform and other team members wants to make changes to infra then other team members cannot see the state.
- **Risk of data loss** – If your computer crashes, the state file is lost.
- **State corruption** – If two people run Terraform at the same time, the state file can become corrupt.

**Solution**: Remote State Storage. 
- Terraform allows storing state in a remote backend such as Azure Storage, AWS S3, or Terraform Cloud.

<br
  >
**What is Remote Backend?**

Storing ```terraform.tfstate``` in a cloud service like Azure Storage.

A remote backend is a shared location where Terraform stores its state file.

<br>

**Why Use Azure Remote State Storage?**
- **Collaboration**:
  - Problem with Local State: If you’re working in a team, everyone needs access to the same state file. Storing it locally makes this difficult because only one person can access it at a time.
 
  - Solution with Remote Backend: The state file is stored in a shared location (e.g., Azure Storage or Terraform Cloud), so everyone on the team can access it. This ensures that everyone is working with the latest infrastructure information.
 
- **State Locking**:
  - Problem with Local State: If two people run terraform apply at the same time, they might overwrite each other’s changes, leading to conflicts or corrupted infrastructure.
 
  - Solution with Remote Backend: Remote backends like Terraform Cloud, S3 (with DynamoDB), and others support state locking. This prevents multiple people from running Terraform simultaneously. If someone is already applying changes, others will have to wait until the lock is released.
 
- **Safety and Durability**:
  - Problem with Local State: If your local machine crashes, or the state file is accidentally deleted, you lose the state. Without the state file, Terraform won’t know how to manage your infrastructure.
 
  - Solution with Remote Backend: The state file is stored securely in a remote location, reducing the risk of loss or corruption. Many backends (like S3) also support versioning, so you can recover previous versions of the state file if something goes wrong.
 
- **Centralized Management**:
  - Problem with Local State: Managing state files for multiple projects or environments (e.g., dev, staging, prod) can become messy if they’re stored locally.
 
  - Solution with Remote Backend: You can store state files for all your projects and environments in one place (e.g., an S3 bucket or Terraform Cloud). This makes it easier to manage and organize your infrastructure.
 
- **Security**:
  - Problem with Local State: Local state files might not be encrypted or protected, making them vulnerable to unauthorized access.
 
  - Solution with Remote Backend: Remote backends often provide built-in security features like encryption (at rest and in transit), access controls, and IAM roles to ensure that only authorized users can access the state file.

<br>

**How Does Remote Backend Work?**

- **When You Run terraform init**:
  - Terraform checks the backend settings in ```main.tf```.
  - Terraform authenticates with Azure.
  - If a local state file (terraform.tfstate) exists, Terraform uploads it to Azure Storage.
 
- **When You Run terraform plan or terraform apply**
  - Terraform downloads the state file from Azure Storage.
  - Terraform compares the actual infrastructure with the desired state in ```main.tf```.
  - Terraform applies changes to match the desired state.
  - Terraform updates the remote state file in Azure Storage.
 
- **State Locking (Prevents Conflicts)**
  If two people run Terraform at the same time, there is a risk of corrupting the state file.

  Azure Storage supports state locking using Azure Blob Storage leases:
  - If a user is running Terraform, the state file is locked.
  - Other users cannot modify the state until the first Terraform process is finished.
 
<br>
<br>

## How to Store Terraform State File in Azure Storage (Step by Step)

**Step 1: Create an Azure Storage Account for Remote State**

First, create an Azure Storage Account where Terraform will store its state file.

Run the following Azure CLI commands:

```
# Set variables
RESOURCE_GROUP_NAME="terraform-backend-rg"
STORAGE_ACCOUNT_NAME="terraformstate12345"
CONTAINER_NAME="tfstate"

# 1. Create a Resource Group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# 2. Create a Storage Account
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --location eastus --sku Standard_LRS

# 3. Create a Storage Container inside the Storage Account
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
```

**Step 2: Configure Terraform Backend to Use Azure Storage**:

In your Terraform configuration (```main.tf```), configure the backend to use Azure Storage:

```
terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-backend-rg"
    storage_account_name  = "terraformstate12345"
    container_name        = "tfstate"
    key                   = "prod.terraform.tfstate"
    access_key            = "BzyGlaQa9ccnXlEzl8hHuGrCTUyinZhGWDz4LaSATxihSIyPCyabjAOgftRb4C0ORpCmi1QCdF/I+AStFipBcg=="
  }
}
```

Explanation:
- resource_group_name: The Azure resource group where the storage account is created.
- storage_account_name: The Azure Storage Account where Terraform will store the state file.
- container_name: The Azure Storage Container inside the Storage Account.
- key: The name of the Terraform state file (e.g., prod.terraform.tfstate).
- access_key: It is the key to access the storage account directly from your terraform. Without this key, terrafomr will not work.

**Step 3: Initialize Terraform with Remote Backend**:

Now, initialize Terraform so that it connects to the Azure remote backend:

```
terraform init
```

What Happens Internally?
- Terraform reads the backend configuration from ```main.tf```.
- Terraform connects to Azure Storage.
- Terraform uploads the local state file to Azure.
- Terraform confirms that Azure will be used as the backend from now on.

**Step 4: Apply Terraform Configuration**:

After initializing the backend, apply Terraform:

```
terraform apply
```

Terraform will now:
- Fetch the state file from Azure Storage.
- Deploy infrastructure according to the Terraform configuration.
- Update the state file and store it back in Azure Storage.

<br>
<br>

## Example (LAB): Setup terraform backend on azure to store state file on remote backend (storage account).

**Step:1 - Create main.tf file**

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

  subscription_id = "f721bf30-04fd-4757-a7ad-e1aeeab1a6dc"
  tenant_id = "b94db9d6-e2d9-4485-ba28-bd37e7a8d30c"
  client_id = "520c5958-2fd2-45ea-835d-dfcaa1934c0b"
  client_secret = "~VG8Q~ls_tVcyw1pOua7Pkr.cIaKjXKOs4l3jbGy"

  features {
    
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = "West Europe"
}
```

Explanation:

- Define the azure provider block.
  
- Define the Remote Backend block.
  - In the remote backend provide the details of storage account like resource group name, storage account name, container name, state file name and access key of storage account.
  - This access key is most important thing. If you do not mention it inside backend then remote backend will not work.

- Define the provider again.

- Define your resource block.

**Step-2: Run terraform init command**

Now run ```terraform init``` command to initialize the provider and backend. This command will create a state file in resource group.

**Step-3: Run terraform plan command**

Now run ```terraform plan``` command to review the terraform apply command.

**Step-4: Run terraform apply command**

Now run ```terraform apply``` command to create resources on azure.

