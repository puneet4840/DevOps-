
# Terraform State File

### What is a state in terraform?

In terraform, **state** is the current status of the infrastructure that terraform is managing.

### What is the State File?

When terraform creates or changes your infrastructure, it needs to keep track of what it has done. This is where **state file** comes in. 

Think of a state file as a "notebook" where terraform writes down:
- What resources it has created (e.g., server, database).
- Details about those resources (e.g., server name, server ip address).
- How the resources are connected to each other.

Terraform creates that state file with the name ```terraform.tfstate``` at the same location where your other tf file are located.
