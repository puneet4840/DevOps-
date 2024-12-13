# Introduction to Terraform and its basics

## What is Infrastructure?

Infrastructure in context of cloud is the services like (Server, Networks, Databases) which is the collection of Hardware and Software and works together to serve the users.

```Hardware और Software से मिलकर बनी services होती हैं जैसे Server, Network, Database, इसी को ही Infrastructure कहते हैं ```

## What is Infrastructure as Code (IaC)?

Infrastructure as Code means: You write a code to create your infrastructure instead of manually creating it.

It is a new approach to implementing infrastructure. Is is the practice of managing and provisioning computing infrastructure using machine readable configuration file rather than through manual process. 

For Example:

Imagine you need a new computer for your work. Normally, you would:
- Choose the type of computer (laptop or desktop).
- Install the operating system.
- Add software (like browsers, tools, etc.).

Now, instead of setting it up manually, imagine writing a set of instructions that say:
- "Get a laptop with 16GB RAM."
- "Install Windows 10."
- "Install Microsoft Office."

You give these instructions to a robot, and it sets up the laptop automatically for you. That’s what IaC does, but for big IT systems!

IaC automates the setup of infrastructure like servers, databases, and networks using code instead of doing it manually. It's like programming instructions for creating your digital world.

## Why do we need IAC?

- **Traditional Infrastructure Management Challenges**

  Before IaC, infrastructure was typically managed manually, which involved:
  - Clicking through cloud provider interfaces to create resources like virtual machines, databases, or networks.
  - Documenting the steps for others to replicate.

  This manual approach created several challenges:
  - **Human Error**: Repeated manual tasks are prone to mistakes, leading to inconsistent environments.
  - **Time-Consuming**: Setting up and maintaining infrastructure manually is slow.
  - **Difficulty in Scaling**: As systems grow, managing infrastructure manually becomes unmanageable.
  - **No Version Control**: Manual changes are hard to track, undo, or replicate.
  - **Inconsistent Environments**: Development, testing, and production environments often differ, causing issues when deploying applications.

- **Benefits of Infrastructure as Code**

  IaC solves these problems by automating infrastructure management using code. Here's how it helps:
  - **Consistency**:

    Code ensures that the same configuration is applied every time, reducing discrepancies between environments (e.g., development and production).

  - **Speed and Automation**:

    Infrastructure can be deployed, updated, or destroyed in seconds with a single command or through automated pipelines.

  - **Scalability**:

    You can quickly scale infrastructure up or down by adjusting the code, making it ideal for cloud environments.

  - **Version Control**:

    IaC files can be stored in version control systems (e.g., Git), enabling:
    - Auditing: Know who made changes and why.
    - Rollbacks: Revert to a previous state if something goes wrong.
    - Collaboration: Multiple team members can work on the infrastructure simultaneously.

  - **Reusability**:

    IaC scripts can be modular and reusable across projects, saving time and effort.

  - **Testing**:

    Infrastructure code can be tested and validated before deployment, ensuring reliability.

## How Does IaC Work?

IaC tool like **Terraform** take your written instructions (code) and:

- Understand what you want.
  - For example, you want 2 servers and 1 database.
 
- Talk to the cloud provider (e.g., AWS, Azure, or Google Cloud).
  - They send requests to create the resources.
 
- Set everything up automatically.

## Tools for IaC

1 - Terraform.

2 - Azure Resource Manager.

3 - AWS CloudFormation.

### Note: We are going to use Terraform as IaC tool.

<br>
<br>

# What is Terraform?

Terraform is an open-source **Infrastructure as Code (IaC)** tool that helps you automate the **creation**, **updation** and **management** of infrastructure (servers, databases, networks) using simple text files. Instead of manually clicking around cloud platform like Azure, AWS, GCP and etc, you write instruction (code) in a text files and terraform does the work for you.

Terraform is an Infrastructure as Code (IaC) tool that allows users to manage and provision infrastructure through code instead of manual processes

## Why use Terraform?

```जब हमारे पास Cloud के IaC tool थे जैसे की Azure के लिए Azure Resource Manager Teamplate, AWS के लिए Cloud Formation. जब हम इन tools का use करके cloud पर resources create करने के लिए use कर रहे थे तो हमको Terraform को जरुरत क्यों हुई.```

```क्युकी हमको Terraform की जरुरत इसलिए हुई क्युकी Terraform सभी Cloud providers के साथ compatible है. हम terrafrom से Azure, AWS, Google Cloud सभी पर resources create कर सकते हैं```

- **Speed**: It's much faster to write code using terraform than to manually click through web interfaces.
- **Accuracy**: Less chance of mistakes when using code to provision infrastructure.
- **Consistency**: You can easily recreate your infrastructure.
- **Multi-Cloud Support**: Works with AWS, Azure, Google Cloud, Kubernetes, and more.
- **State Management**: Keeps track of your infrastructure using a state file.

## Key Features of Terraform

- **Infrastructure as Code (IaC)**:

  You describe your infrastructure (like servers, networks, databases) in simple text files. Terraform reads these files and sets up everything automatically.

- **Cloud Independence**:

  Terraform works with many cloud providers like AWS, Azure, and Google Cloud. You can manage resources from different providers in the same code.

- **State Management**:

  Terraform keeps track of what’s already created using a "state file." This helps it understand what needs to be added, changed, or deleted.

- **Repeatable and Predictable**:

  You can reuse your configuration files to create the same infrastructure multiple times without mistakes.

## How Does Terraform Work?

Terraform uses three main ideas: **Providers**, **Resources**, and **State**.

- **Providers**

  - Providers are like plugins that let Terraform communicate with cloud services or other systems (e.g., AWS, Azure, or GitHub).
  - Example: If you want to create a virtual machine in AWS, Terraform needs the aws provider.

  Example:

  ```
  provider "aws" {
    region = "us-west-2"  # Region where your resources will be created
  }
  ```

- **Resources**

  Resources are the actual things Terraform creates, like servers, storage buckets, or databases.

  Code Example (Creating an AWS EC2 instance):

  ```
  resource "aws_instance" "example" {
    ami           = "ami-0c55b159cbfafe1f0"  # Machine image ID
    instance_type = "t2.micro"              # Server type (small instance)
  }
  ```

  Explaination:
  - Here, ```aws_instance``` is the type of resource, and "example" is its name.

- **State**

  - When Terraform creates resources, it keeps track of them in a state file (```terraform.tfstate```).
  - Example: If you’ve already created a server and run Terraform again, it knows not to create a duplicate.

  
## Terraform Workflow

Terraform's workflow revolves around a series of commands designed to manage the entire lifecycle of infrastructure.

The Terraform workflow involves these primary steps:

- **Write Configuration Files**: Describe the desired infrastructure using ```.tf``` files.

- **Initialize**: Set up the environment with ```terraform init```.

- **Plan**: Preview changes using ```terraform plan```.

- **Apply**: Apply changes to create or update resources using ```terraform apply```.

- **Manage State**: Manage infrastructure updates and changes with the state file.

- **Destroy**: Tear down infrastructure when it's no longer needed with ```terraform destroy```.

<br>

## Commands in Terraform

- ```terraform init``` – Initialization

  - **What It Does**:
    - Prepares the working directory for Terraform.
    - Downloads necessary provider plugins (e.g., AWS, Azure).
    - Configures backend settings (e.g., for remote state storage).

  - **When to Use**:
    - The first time you run Terraform in a new directory.
    - Anytime you modify the provider configurations or backend settings.

  - **Example Output**:

    ```
    Initializing the backend...
    Initializing provider plugins...
    - Finding hashicorp/aws versions matching ">= 2.0.0"...
    - Installing hashicorp/aws v4.0.0...
    Terraform has been successfully initialized!
    ```

- ```terraform plan``` – Execution Plan

  - **What It Does**:
    - Creates a preview of what Terraform will do.
    - Shows the resources to be created, modified, or destroyed.
    - Helps prevent unexpected changes by letting you review the plan.

  - **When to Use**:
    - Before running ```terraform apply```, to ensure you understand the changes.

  - **Example Command**:

    ```
    terrafrom plan
    ```

  - **Example Output**:

    ```
    Terraform will perform the following actions:

    + aws_instance.web_server
        ami:                  "ami-0c55b159cbfafe1f0"
        instance_type:        "t2.micro"

    Plan: 1 to add, 0 to change, 0 to destroy.
    ```

- ```terraform apply``` – Apply Changes

  - **What It Does**:
    - Executes the changes described in the plan.
    - Creates, updates, or destroys resources to match the configuration.

  - **When to Use**:
    - After reviewing and confirming the execution plan.
   
  - **Example Command**:

    ```
    terraform apply
    ```
    - Terraform will prompt for confirmation before applying changes. Use the ```-auto-approve``` flag to skip this prompt.

  - **Example Output**:

    ```
    aws_instance.web_server: Creating...
    aws_instance.web_server: Creation complete after 10s [id=i-0abcdef1234567890]

    Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
    ```

- ```terraform destroy``` – Destroy Infrastructure

  - **What It Does**:
    - Deletes all resources defined in the configuration.
    - Useful for cleaning up after testing or decommissioning infrastructure.

  - **When to Use**:
    - When you no longer need the infrastructure.
    - To reset and start fresh with a new configuration.
   
  - **Example Command**:

    ```
    terraform destroy
    ```

  - **Example Output**:

    ```
    aws_instance.web_server: Destroying... [id=i-0abcdef1234567890]
    aws_instance.web_server: Destruction complete after 5s

    Destroy complete! Resources: 1 destroyed.
    ```

- ```terraform validate``` – Validate Configuration

  - **What It Does**:
    - Checks the configuration files for syntax or logical errors.
   
  - **When to Use**:
    - After writing or editing configuration files, before planning or applying.

  - **Example Command**:

    ```
    terraform validate
    ```

  - **Example Output**:

    ```
    Success! The configuration is valid.
    ```

- ```terraform show``` – Display Current State

  - **What It Does**:
    - Displays the current state of infrastructure as described in the state file.

  - **When to Use**:
    - To inspect the current configuration and values of resources.
   
  - **Example Command**:

    ```
    terraform show
    ```

- ```terraform output``` – View Outputs

  - **What It Does**:
    - Displays the output values defined in your configuration.
   
  - **When to Use**:
    - To retrieve important information (e.g., IP addresses or resource IDs).
   
  - **Example Command**:

    ```
    terraform output
    ```

  - **Example Configuration**:

    ```
    output "web_server_ip" {
      value = aws_instance.web_server.public_ip
    }
    ```

  - **Example Output**:

    ```
    web_server_ip = "54.123.45.67"
    ```
