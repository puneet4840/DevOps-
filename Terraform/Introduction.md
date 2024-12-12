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
