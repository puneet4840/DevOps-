# Terraform Life Cycle rules

```अब तक क्या हो रहा था की हम terraform की scripts लिखकर उसको apply कर देते थे और resources create हो जाते थे लेकिन terraform के life-cycle rules लिखकर हम कुछ advancements भी कर सकते हैं|```

Terraform lifecycle rules allow you to control how Terraform manages resource creation, updates, and deletion.

```Terraform life cycle rules के through हम resources का creation, updates and deletion को manage करते हैं|```

By default, Terraform follows this flow:

- If a resource exists and has configuration changes → Terraform updates it.
- If a resource is removed from the configuration → Terraform destroys it.
- If a resource needs replacement → Terraform destroys the old and creates a new one.

**Why is this a problem?**

- Accidental deletion can occur.
- Downtime may happen when Terraform destroys a resource before creating a new one.
- Some attributes change automatically, but Terraform should not override them (e.g., auto-scaling values).

**Solution: Use Terraform Lifecycle Rules**

Terraform provides lifecycle rules to customize how resources are handled.


<br>

### What are Terraform life cycle rules:

- ```create_before_destroy```: Ensures the new resource is created before destroying the old one.
- ```prevent_destroy```: Prevents deletion of the resource to avoid accidental removal.
- ```ignore_changes```: Ignores changes to specific attributes, preventing unnecessary updates.

<br>

### Why Do We Need Terraform Lifecycle Rules?

**Without Lifecycle Rules**:

Terraform follows its default process, which may cause:
- Downtime when replacing resources.
- Accidental deletions.
- Unnecessary updates.

**With Lifecycle Rules**:

You can:
- Prevent deletion of critical resources.
- Ensure a new resource is created before destroying the old one.
- Ignore specific changes that don’t need updates.

<br>

### Terraform Lifecycle Rule Syntax

Lifecycle rules are defined inside a ```lifecycle {}``` block within a resource.

**General Syntax**:

```
resource "resource_type" "resource_name" {
  # resource configuration

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [attribute_name]
  }
}
```

<br>

### Explanation of Terraform Life Cycle Rules:

- ```create_before_destroy```:

  - ```इस rule को अगर हम किसी resource block के अंदर define करते हैं तो यह rule उस resource को delete करने से पहले उसी का नया resource create कर देगा जिससे downtime बिलकुल कम  हो जायेगा|```

  - By default, Terraform destroys a resource before creating a new one. This can cause downtime.

  - ```create_before_destroy``` ensures the new resource is created first before the old one is deleted.

**Example: Ensure Azure VM is Created Before Deleting the Old One**

```
resource "azurerm_virtual_machine" "vm" {
  name                = "my-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vm_size             = "Standard_DS1_v2"

  lifecycle {
    create_before_destroy = true
  }
}
```

**What Happens?**
- Terraform creates the new VM first.
-  After the new VM is ready, it deletes the old one.
-  No downtime occurs.

**When to Use?**
- When replacing **Azure Virtual Machines** to prevent downtime.
- When updating **Load Balancers**, **Firewalls**, or **Kubernetes clusters**.
- ```अब ऊपर लिखी हुई script से होगा ये की पहले नयी vm create होगी फिर old vm delete होगी|```

<br>

- ```prevent_destroy```:
  
  - By default, Terraform will delete a resource if removed from the configuration.
  - ```prevent_destroy``` blocks this to avoid accidental deletions.
  - ```अगर इस rule को किसी resource की configuration मैं define कर दिए और फिर terraform destroy command run कर दी तो यह rule उस resource को delete नहीं होने देगा और error through करेगा|```
 
**Example: Protect an Azure Storage Account from Deletion**

```
resource "azurerm_storage_account" "storage" {
  name                     = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    prevent_destroy = true
  }
}
```

**What Happens?**:
- If you try to run ```terraform destroy```, Terraform **fails with an error** and stops the deletion.

**When to Use?**:
- Protect **databases**, **storage accounts**, **networking components**.
- Prevent accidental deletion of **Azure Key Vault** or **Terraform state storage**.

**Caution**:
- To delete the resource, you must first remove ```prevent_destroy```, apply the changes, and then delete it.

<br>

- ```ignore_changes```:

  - By default, Terraform tracks and enforces every attribute in a resource.
  - If you manually change a resource in the Azure portal, Terraform will override it in the next ```terraform apply```.
  - If an attribute changes automatically (e.g., auto-scaling settings), Terraform will detect it as a difference and try to change it back.
  - The ```ignore_changes``` rule tells Terraform to ignore specific attributes, so Terraform does not update or override them.
 
**Example 2: Ignore Changes to Azure Storage Account access_tier**

Azure automatically updates the ```access_tier``` of a storage account based on usage.

Terraform **detects this change** and tries to **revert i**t in every ```terraform apply```, which is unnecessary.

Solution: Ignore access_tier changes.

```
resource "azurerm_storage_account" "storage" {
  name                     = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    ignore_changes = [access_tier]
  }
}
```

**What Happens?**:
- Terraform creates the storage account with the initial ```access_tier```.
- Azure automatically updates ```access_tier``` based on usage.
- Terraform **does not revert the auto-changed** ```access_tier```.

<br>

### Summary Table

| Lifecycle Rule        | Purpose                               |             Example Use Case             |
|-----------------------|---------------------------------------|:----------------------------------------:|
| create_before_destroy | Prevent downtime                      | Replace Azure VM without downtime        |
| prevent_destroy       | Prevent deletion                      | Protect critical resources (DB, Storage) |
| ignore_changes        | Ignore updates to specific attributes | Ignore manual updates to VM tags         |


Terraform lifecycle rules give you full control over how your Azure infrastructure is managed.

They help prevent downtime, protect critical resources, and reduce unnecessary updates.
