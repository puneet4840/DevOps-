# Loops in Terraform

```Terraform मैं कभी-कभी आपको एक ही resource multiple बार create करना होता है, जैसे multiple Virtual machine, storage account, network interface. तो जो resource multiple बार create करना है, तो normally हम main.tf file मैं उसके resource block को उतनी बार copy paste करके लिखे सकते हैं और resource create हो जायेगा लेकिन ये efficient नहीं है|``` 


```तो इसको करने के लिए terraform 2 meta arguments provide करता है count और for_each.```

<br>

### What are Meta Arguments in Terraform?

Meta-Argument is a special type of argument that can be used with resource block and modules to control how resources are created, updated and destroyed.

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

**Example: Create 3 Azure Resource Groups**
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

