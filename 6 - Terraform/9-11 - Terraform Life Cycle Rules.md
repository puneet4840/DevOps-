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

