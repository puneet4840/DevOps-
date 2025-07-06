# Remote Module in Terraform

```जब हम किसी module को local directory के बजाये किसी remote source से import करते हैं - जैसे Github, Terraform registry, BitBucket, Azure Storage. - तो उसे हम remote module कहते हैं.```

```Local module मैं हम क्या कर रहे थे की अपने system पर module बना कर उसको root main.tf file मैं use कर रहे थे| लेकिन remote module मैं ऐसा नहीं होता है remote module मैं module remote location पर होता है उस remote location से directly हम वह module अपने terraform script मैं use करना होता है और resource create हो जाता है|```

<br>

### Local vs Remote module

| Feature         | Local Module                         | Remote Module                                |
| --------------- | ------------------------------------ | -------------------------------------------- |
| Source          | Local folder (e.g., `./modules/vpc`) | GitHub, Terraform Registry, S3, GitLab, etc. |
| Reusability     | Only for local project               | Can be reused across projects/teams          |
| Version Control | Not versioned automatically          | Can be versioned using Git tags/branches     |
| Sharing         | Manual copy required                 | Easily shared via URLs                       |


<br>

### Syntax of Remote Module

```
module "vpc" {
  source  = "git::https://github.com/puneetcloud/terraform-azure-vpc.git//modules/vnet"

  name     = "my-vnet"
  location = "East US"
  address_space = ["10.0.0.0/16"]
}
```
Explanation:
- module: Keyword
- "vpc" – logical name for resource.
- source – remote location:
  - git:: → Git repository (GitHub, GitLab, Bitbucket).
  - "//modules/vnet" → sub-folder path inside repo (double slash //).
- Inputs – jaise variables pass karte ho.

**Note**:

- ```Remote module मैं simply हमको source मैं URL देना होता है और local मैं हमको local system ka path देना होता है|```
- ```Remote module मैं हमको बाकी और files जैसे variable.tf, outputs.tf नहीं create करनी पड़ती जो हम local module मैं करते हैं| सिर्फ main.tf file मैं module keyword का use करके module import करना होता है और resource create हो जाता है|```

<br>

### Types of Remote Sources (Supported by Terraform)

| Remote Source Type  | Example                                             |
| ------------------- | --------------------------------------------------- |
| Terraform Registry  | `Azure/resource-group/azurerm`                      |
| Git (GitHub/GitLab) | `git::https://github.com/user/repo.git`             |
| Bitbucket           | `git::https://bitbucket.org/org/repo.git`           |
| HTTP Archive (zip)  | `https://example.com/modules/vpc.zip`               |
| Terraform Cloud     | `app.terraform.io/<org>/<module>/<provider>`        |
| S3 Bucket           | `s3::https://s3.amazonaws.com/mybucket/modules.zip` |
| Mercurial Repo      | `hg::https://example.com/repo`                      |


<br>

###  Example 1: Remote Module from Terraform Registry (Azure)

```
module "rg" {
  source  = "Azure/resource-group/azurerm"
  version = "5.1.0"

  name     = "my-remote-rg"
  location = "East US"
}
```

Registry module URL format:
```
<namespace>/<module-name>/<provider>
```

Explanation:
- Azure → namespace (organization).
- resource-group → module name.
- azurerm → provider

<br<

### Example 2: GitHub Remote Module

Suppose repo: ```https://github.com/puneetcloud/terraform-azure-modules.```

Aur usme ek subfolder hai ```resource_group/.```

Use it like:
```
module "rg" {
  source = "git::https://github.com/puneetcloud/terraform-azure-modules.git//resource_group"

  name     = "git-rg"
  location = "West Europe"
}
```

```git::``` prefix zaroori hai Terraform ko batane ke liye ki yeh Git repo hai.

<br>
<br>

### How Terraform Downloads Remote Modules

When you run:
```
terraform init
```

Terraform:
- Downloads the module from remote location (e.g., GitHub).
- Extracts it to a local ```.terraform/modules``` directory.
- Then applies the configuration.
- Remote modules are cached locally and reused until explicitly updated.

<br>

### Use-Case Example – Complete Azure Project using Remote Module

Remote Module Repo:
```
https://github.com/puneetcloud/terraform-azure-core-infra
```

Folder structure in repo:
```
terraform-azure-core-infra/
├── modules/
│   ├── resource_group/
│   └── storage_account/
```

Now in your root ```main.tf```:
```
module "rg" {
  source = "git::https://github.com/puneetcloud/terraform-azure-core-infra.git//modules/resource_group?ref=v1.0.0"

  name     = "my-remote-rg"
  location = "East US"
}

module "storage" {
  source = "git::https://github.com/puneetcloud/terraform-azure-core-infra.git//modules/storage_account?ref=v1.0.0"

  name                = "mystorageacct"
  resource_group_name = module.rg.resource_group_name
  location            = "East US"
}
```

Then run:
```
terraform init

terraform plan

terraform apply
```

**Note**:

Agar tum private GitHub repo se remote module la rahe ho:

- Option 1: Use Personal Access Token (in Git URL).
```
source = "git::https://<token>@github.com/org/repo.git//module"
```
Not Recommended (security risk) because token is available in your terraform script.

- Option 2: Use SSH-based access.
  - Setup SSH key-based auth.
 
<br>

### Benefits of Remote Modules

| Benefit               | Explanation                             |
| --------------------- | ----------------------------------------|
| Reusability           | Across teams and projects               |
| Centralization        | Code is managed in one place            |
| Version control       | Use Git branches/tags                   |
| CI/CD Integration     | Can use modules in GitOps pipelines     |
| Team Collaboration    | Teams can work on modules independently |


### Limitations / Challenges

| Challenge             | Notes                                           |
| --------------------- | ----------------------------------------------- |
| Debugging harder      | Hard to debug remote module issues              |
| Update visibility     | Hard to track what changed inside remote module |
| Breaking changes      | If version is not pinned, future runs may fail  |
| Network dependency    | Internet required to fetch remote sources       |

<br>
<br>
<br>

## Create Your Own Remote Terraform Module

We can create our own terraform module.

**Step 1 → Apna Module Locally Banao**

Chalo maan lo tum ek Azure Resource Group ke liye custom module banana chahte ho.

Local Folder Structure:
```
terraform-azure-modules/
└── resource_group/
      ├── main.tf
      ├── variables.tf
      ├── outputs.tf
      └── README.md
```

```resource_group/main.tf```
```
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
```

```resource_group/variables.tf```
```
variable "name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default     = {}
}
```

```resource_group/outputs.tf```
```
output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the Resource Group"
}

output "resource_group_id" {
  value       = azurerm_resource_group.this.id
  description = "The ID of the Resource Group"
}
```

```resource_group/outputs.tf```
```
output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the Resource Group"
}

output "resource_group_id" {
  value       = azurerm_resource_group.this.id
  description = "The ID of the Resource Group"
}
```

```resource_group/README.md```
```
# Terraform Module - Azure Resource Group

## Usage

```hcl
module "rg" {
  source   = "git::https://github.com/puneetcloud/terraform-azure-modules.git//resource_group?ref=v1.0.0"

  name     = "my-rg"
  location = "East US"
  tags = {
    environment = "dev"
    owner       = "puneet"
  }
}
```

**Note**: Before pusing code to github, test it locally on your system then push.

<br>

**Step 2 → Create Git Repo**

Apne module ke liye GitHub repo bana lo.

Repo name:
```
terraform-azure-modules
```

<br>

**Step 3 → Push code to Github**

Run the below command:
```
cd terraform-azure-modules

git init
git add .
git commit -m "Initial commit - Azure RG module"
git remote add origin https://github.com/puneetcloud/terraform-azure-modules.git
git push -u origin main
```

<br>

**Step 4 → Version Tag Create karo**

Versioning karna bahut important hai. Taaki tumhare users specific versions use kar sakein.
```
git tag v1.0.0
git push origin v1.0.0
```

Ab tumhara repo yeh URL serve karega:
```
https://github.com/puneetcloud/terraform-azure-modules.git
```

<br>

**Step 5 → Use Remote Module in Any Project**

Ab tumhare paas remote module ready hai. Ab kisi bhi Terraform project mein use karo.

Example:

Suppose tumhara naya project hai:
```
my-new-project/
├── main.tf
├── providers.tf
```

```providers.tf```
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

```main.tf```
```
module "rg" {
  source = "git::https://github.com/puneetcloud/terraform-azure-modules.git//resource_group?ref=v1.0.0"

  name     = "rg-remote-example"
  location = "West Europe"
  tags = {
    environment = "prod"
    owner       = "puneet"
  }
}
```

Run Terraform commands:
```
terraform init
terraform plan
terraform apply
```

Terraform will:
- Clone your GitHub repo into ```.terraform/modules/``` locally.
- Read variables, outputs.
- Create resource group on Azure.

**How Terraform Downloads Remote Module**:

When you run:
```
terraform init
```

- Terraform sees ```"git::https://github.com/..."```.
- Clones that repo into:
```
.terraform/modules/resource_group
```
- All files of your module are now locally available.
