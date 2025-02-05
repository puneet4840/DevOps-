# File and Directory Structure in Terraform

When you write terraform code, you need to organize your files properly so that Terraform can read and execute them easily. So that we divide the terraform scrips in multiple files.

A directory structure in Terraform is the way we organize files and folders in a project. It helps manage different parts of the infrastructure efficiently.

### Why Do We Need a Directory Structure?

Imagine you are working on a large project where you need to manage:
- Virtual Machines.
- Databases.
- Networks.
- Storage.

If you dump all the files in a single folder, it becomes chaotic. You will not know:
- What file does what.
- Which configuration belongs to which environment (dev,prod).
- How to reuse parts of infrastructure.

By using a structured directory and file organization, you can:
- Easily find specific configuration.
- Reuse modules (instead of writing same code again).
- Seperate production and development environments.
- Collabrate with teams easily.

