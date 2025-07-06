# Modules in Terraform

```Terraform module एक folder होता है जिसमे terraform files होती हैं जैसे main.tf, variables.tf और output.tf| फिर इन terraform की files को अलग main.tf file मैं call करते हैं module block के through जिससे ये files main.tf file मैं use हो जाती हैं और हमको बार बार same code नहीं लिखना पढता|```

```इसको ऐसे समझिये```:

```जैसे किसी भी programming language मैं हम function create करते हैं और उस function को call करते हैं जब function का logic हमको चाइये होता है| वैसे ही ये module होता है इसमें हम वह code लिखते हैं जो हमको बार बार terraform की main.tf file मैं लिखना होता है| Terraform की main.tf file मैं एक ही code बार बार न लिखेके हम एक module बना लेते हैं और उस module को अलग main.tf file मैं call कर लेते हैं और वो code जो module मैं लिखा था वो अब अलग main.tf file मैं use हो जायेगा| बस यही काम मॉडल का होता है|```

<br>

Terraform ka main idea hai Infrastructure as Code:
- Declare karo tumhe kya chahiye, Terraform woh state achieve karega.

Lekin jab infra bada hota hai — jaise multiple resource groups, VMs, storage accounts — tumhara code itna bada ho jaata hai ki:
- Maintain karna mushkil ho jaata hai.
- Copy-paste galtiyon ki wajah se bugs aate hain.
- Team mein alag log alag style mein likhte hain → inconsistency.

Modules ka purpose yeh problem solve karna hai ki sabhi resources ki configuration jaise sabhi resource block ek hi ```main.tf``` file main na likhke usko ek alag folder main likha jaye aur fir apki root ```main.tf``` file main likha jaye.

<br>

Terraform mein 2 main styles mein kaam hota hai:

**1 - Monolithic Approach (without modules)**:
- Sab resource ek hi file ya kuch files mein likh dete hain.
- Jaise:

```
resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "mystorageacct"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

Problem:
- Code huge ho jaata hai.
- Maintain karna mushkil ho jaata hai.
- Reuse nahi hota.


**2 - Modular Approach**:
- Resources ko logical blocks (modules) mein divide kar dete hain aur ek folder ke ander define kar dete hain aur call kar lete hain.
- Reusability aur clarity badh jaati hai

Example:
```
root/
├── main.tf
├── variables.tf
└── modules/
      ├── resource_group/
      └── storage_account/
```

<br>
<br>

### Structure of Module

A module is typically a directory containing:
- ```main.tf``` → Main configuration.
- ```variables.tf``` → Declares variables (inputs).
- ```outputs.tf``` → Declares outputs (values you want to retrieve).
- ```versions.tf``` (optional) → Provider versions.
- ```README.md``` (optional) → Documentation.

Syntax:
```
<module_folder>/
│
├── main.tf         # Resources ka logic
├── variables.tf    # Inputs define karne ke liye
└── outputs.tf      # Outputs define karne ke liye
```

Example: Module for a azure resource group.
```
modules/
└── resource_group/
      ├── main.tf
      ├── variables.tf
      └── outputs.tf
```

Explanation:
```जैसे आपको resource group का module बनाना है तो आप एक folder create करो modules, उसके अंदर resource folder create करो इसके अंदर resource group module की files होंगी और ये module folder आपको उसी folder के अंदर create करना जहा पे आपकी main.tf file होगी जिसमे आप इस module को use करना चाहते हैं|```

<br>
Mbr>

### How to create a module

Example: Create an azure resource group module.

**Step-1: Create folder structure**:

First create a folder structure in root directory.

```
modules/
└── resource_group/
      ├── main.tf
      ├── variables.tf
      └── outputs.tf
```

<br>

**Step-2: Create the files main.tf, variables.tf, outputs.tf and write the code in it.**

```main.tf```
```
resource "azurerm_resource_group" "my-rg" {
  name     = var.name
  location = var.location
}
```
Explanation:
- ```हमको रिसोर्स ब्लॉक लिखना है रिसोर्स ग्रुप क्रिएट करने के लिए और इसमें हमको इसके arguments को variables के thorugh assign करना है क्युकी इसके arguments को value तब मिलेगी जब main.tf file मैं module block से इस resource group module को call किया जायेगा|```


```variables.tf```
```
variable "name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}
```
Explanation:
- We are defining variables in ```variables.tf``` file for resource group module.


```outputs.tf```
```
output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.my-rg.name
}
```
Explanation:
- To print the information from resource group module we use this ```outputs.tf``` file.

<br>
<br>

### How to use or call a module in terraform script

```ऊपर हमने एक resource group module को create किया है एक अलग folder मैं और वो folder उसी directroy मैं create होगा जहा main.tf फाइल created है|```

```अब हम resource group module को main.tf file मैं use करेंगे|```

**Syntax to call module in main.tf file**:
```
module "<logical_name>" {
  source = "<path_to_module>"
  
  # Input variables to the module
  var1 = value1
  var2 = value2
}
```
Explanation:
- ```module``` → keyword hai jisse module call hoga.
- ```<logical_name>``` → logical name for module like ```resource-group``` ya ```network```.
- ```source``` → module kahaan rakha hai, source main path dena hai module folder ka:
  - local folder: ```"./modules/my-module"```.
 
- ``var1```: Yaha pe variables dene hain jo humne module main define kiye hain.

**Example to call module in main.tf file**:

```main.tf```
```
module "rg_dev" {
  source   = "./modules/resource_group"
  name     = "rg-dev"
  location = "East US"
}

module "rg_prod" {
  source   = "./modules/resource_group"
  name     = "rg-prod"
  location = "West Europe"
}
```

Explanation:
- Hum module ko jitna chahe utni baar call kar sakte hain. Ab ye do resource groups bana dega, without tumhe same code baar-baar likhne ki zarurat.

<br>
<br>

### Example - 1: Resource Group Module

Creating a resource group module.

**Step-1: Module folder banao aur files main code likho**
```
modules/
└── resource_group/
       ├── main.tf
       ├── variables.tf
       └── outputs.tf
```
Complete Folder ese hoga:
```
root/
├── main.tf
├── variables.tf
├── provider.tf
├── backend.tf
├── terraform.tfvars
└── modules/
      └── resource_group/
             ├── main.tf
             ├── variables.tf
             └── outputs.tf 
```

```/modules/resource_group/main.tf```
```
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
```

```/modules/resource_group/variables.tf```
```
variable "name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resource group will be created"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the resource group"
  type        = map(string)
  default     = {}
}
```

```/modules/resource_group/outputs.tf```
```
output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_location" {
  value = azurerm_resource_group.this.location
}
```

**Step-2: Call module in root main.tf file**

```/root/main.tf```
```
module "rg_dev" {
  source   = "./modules/resource_group"
  name     = "dev-rg"
  location = "East US"
  tags = {
    environment = "dev"
    owner       = "puneet"
  }
}
```

**Step-3: Run the commands**
```
terraform plan
terraform apply
```

<br>

### Example-2: Azure Storage Account Module

Creating a storage account module

**Step-1: Module folder banao aur files main code likho**

Folder Structure:
```
modules/
└── storage_account/
      ├── main.tf
      ├── variables.tf
      └── outputs.tf
```

Complete folder structure:
```
root/
├── main.tf
├── variables.tf
├── provider.tf
├── backend.tf
├── terraform.tfvars
└── modules/
      └── resource_group/
             ├── main.tf
             ├── variables.tf
             └── outputs.tf 
```

```/modules/storage_account/main.tf```
```
resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  tags                     = var.tags
}
```

```/modules/storage_account/variables.tf```
```
variable "name" {
  description = "Name of storage account"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

variable "location" {
  description = "Location of resource"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Replication type"
  type        = string
  default     = "LRS"
}

variable "tags" {
  type    = map(string)
  default = {}
}
```

```modules/resource_group/outputs.tf```
```
output "storage_account_id" {
  value = azurerm_storage_account.this.id
}
```

**Step-2: Call module in root main.tf file**

```/main.tf```
```
module "storage" {
  source               = "./modules/storage_account"
  name                 = "mystorageacctpuneet"
  resource_group_name  = module.rg_dev.resource_group_name
  location             = "East US"
  account_tier         = "Standard"
  replication_type     = "GRS"
  tags = {
    environment = "dev"
    owner       = "puneet"
  }
}
```

**Step-3: Run the commands**
```
terraform plan
terraform apply
```

<br>
<br>
