
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

