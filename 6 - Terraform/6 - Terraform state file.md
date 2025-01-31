
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

```Suppose हमने terraform से azure cloud पर एक resource group बनाया| अब हमको पता है की cloud पर एक resource group बना हुआ है जिसको हम azure portal पर चेक कर सकते हैं लेकिन terraform को कैसे पता होगा की resource group बना हुआ है तो यह पर terraform state file का concept आता है| Terraform state file मैं जाके check कर लेगा की एक resource group create है और जब हम terraform init command run करते हैं तो automatically एक state file बन जाती है|```

