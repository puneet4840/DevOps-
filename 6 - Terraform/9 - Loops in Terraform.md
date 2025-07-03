# Loops in Terraform

```Terraform मैं कभी-कभी आपको एक ही resource multiple बार create करना होता है, जैसे multiple Virtual machine, storage account, network interface. तो जो resource multiple बार create करना है, तो normally हम main.tf file मैं उसके resource block को उतनी बार copy paste करके लिखे सकते हैं और resource create हो जायेगा लेकिन ये efficient नहीं है|``` 


```तो इसको करने के लिए terraform 2 meta arguments provide करता है count और for_each.```

<br>

### What are Meta Arguments in Terraform?

Meta-Argument is a special type of argument that can be used with resource block and modules to control how resources are created, updated and destroyed.

count and for_each are meta arguments.

<br>

### count

```Count एक meta-argument है जो किसी भो resource को multiple बार create करने के लिए use किया जाता है|```

```Suppose हमको azure में multiple resource group बनाने हैं, तो हम resource block के अंदर count use कर लेंगे और जितने resource group बनाने हैं उतनी value assign कर देंगे, तो count क्या करेगा की एक जैसे नाम के उतने resource group बना देगा|```

```Count identical resource create करता है|```

- ```अगर आपको किसी resource की कई copies चाहिए (जैसे 3 EC2 instances, या 5 S3 buckets), तो आप resource block के साथ count लगा सकते हैं।```
- ```count integer value लेता है।```

The count meta-argument allows you to specify how many instances of a particular resource should be created. Terraform will create count number of identical resource instances.

**Syntax**:
```
resource "resource_type" "name" {
  count = <number>

  # other configurations
}
```

**Example-1: Create 3 Azure Resource Groups**
```
resource "azurerm_resource_group" "rg" {
  count    = 3
  name     = "my-rg"
  location = "East US"
}
```
Explanation:
- ```ये कोड एक जैसे नाम के ३ रिसोर्स ग्रुप बना देगा|```
  - ```my-rg```.
  - ```my-rg```.
  - ```my-rg```.
 
<br>

**Note**: ```लेकिन हमको एक ही नाम के resource नहीं चाइये होते हैं हम चाहते हैं की resources का नाम अलग-अलग हो तो उसके लिए count index का use किया जाता है```

**count.index**:
- ```Count एक जैसे नाम के resource बनाता है| अगर हमको resources के नाम एक जैसे नहीं चाइये हैं. तो हम resources के नाम मैं count के index number को use करके resources का नाम अलग रख सकते हैं|```
- Count is also be used as a index value.

**Example**:
```
resource "azurerm_resource_group" "rg" {
  count    = 3
  name     = "my-rg-${count.index}"
  location = "East US"
}
```
Output:
```
my-rg-0

my-rg-1

my-rg-2
```
Explanation:
- ```count = 3``` → creates 3 resource groups.
- ```count.index``` gives the current loop iteration number (starting at 0). ```यानी count.index पहले resource के लिए 0 होगा, दूसरे के लिए 1, तीसरे के लिए 2, और ऐसे ही आगे।```

<br>

**Example-2: Count with List**

Agar tumhare paas ek list hai aur tum uske upar resource create karna chahte ho, tab bhi count ka use hota hai.

```
variable "names" {
  default = ["dev", "qa", "prod"]
}

resource "aws_s3_bucket" "buckets" {
  count = length(var.names)

  bucket = "my-bucket-${var.names[count.index]}"
  acl    = "private"
}
```
Output:
```
my-bucket-dev

my-bucket-qa

my-bucket-prod
```
Explanation:
- Har bucket ka naam alag hai, kyunki tum count.index se list ka element nikaal rahe ho.

<br>

**Example-3: Conditional Resource Creation using count**

You can use count with a conditional expression:
```
resource "azurerm_resource_group" "optional_rg" {
  count    = var.create_rg ? 1 : 0
  name     = "optional-rg"
  location = "East US"
}
```
Explanation:
- If ```var.create_rg``` is true, Terraform creates 1 resource.
- If ```false```, no resource is created.

<br>

**Count ki Limitations**:
- Count se hamesha numeric index milta hai.

<br>
<br>

### for_each

The ```for_each``` meta-argument is used to create multiple instances of a resource based on a set of unique values (a map or set of strings).

```for_each एक meta-argument है जो किसी भो resource को multiple बार create करने के लिए use किया जाता है|```

```ऊपर count से तुम एक ही नाम के resources बना रहे थे| लेकिन for_each meta argument से तुम अलग-अलग नाम के resources बना सकते हो|```

- ```for_each``` ka use tab hota hai jab tumhe resources uniquely identify karne hain. Matlab resources unique naam se banane hain.
- Isme tum **map** ya **set of strings** de sakte ho.
- Har element ka ek unique key hota hai – isse tum resource ko easily manage kar sakte ho.

<br>

**Syntax**:
```
resource "resource_type" "name" {
  for_each = <set or map>

  # other configurations
}
```

<br>

**Example-1: Create Multiple Azure Resource Groups with Unique Names using set**:

We are using set data type in this example.

```
variable "resource_groups" {
  type    = set(string)
  default = ["rg-dev", "rg-uat", "rg-prod"]
}

resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name     = each.value
  location = "East US"
}
```
Output:
```
rg-dev

rg-uat

rg-prod
```

Explanation:
- ```for_each = var.resource_groups``` → iterates over each value.
- ```each.value``` gives the current value in the loop.

<br>

**Example-2: Create Multiple Azure Resource Groups with Unique Names using Map**:

We are suing map in this example.

```
variable "resource_groups" {
  type = map(string)
  default = {
    "dev"  = "East US"
    "uat"  = "West US"
    "prod" = "Central US"
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name     = "rg-${each.key}"
  location = each.value
}
```
Output:
```
rg-dev in East US

rg-uat in West US

rg-prod in Central US
```

Explanation:
- each.key refers to "dev", "uat", "prod".
- each.value refers to "East US", "West US", etc.

