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

- ```create_before_destroy```

  ```इस rule को अगर हम किसी resource block के अंदर define करते हैं तो यह rule उस resource को delete करने से पहले उसी का नया resource create कर देगा जिससे downtime बिलकुल कम  हो जायेगा|```

  By default, Terraform destroys a resource before creating a new one. This can cause downtime.

  ```create_before_destroy``` ensures the new resource is created first before the old one is deleted.

**Example: Ensure Azure VM is Created Before Deleting the Old One**
