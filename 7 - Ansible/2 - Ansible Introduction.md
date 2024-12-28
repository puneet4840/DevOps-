# Ansible Introduction

Ansible is the open-source IT Automation tool which is used for **Infrastructure Provisioning**, **Application Deployment** and **Configuration Management**. It helps system administrators and DevOps teams manage and automate tasks like configuring servers, deploying applications, and orchestrating workflows.

It is written in Python.

Ansible is primarily used for **Configuration Management**. System engineers and DevOps Professionals use the Ansible for Configure the servers.

Configuration Management is simply managing the configuration of servers to desried state using tools.

```Ansible एक IT Automation tool है, जो Infrastructure Provisoning, Configuration Management, Application Deployment कर सकता है. लेकिन Ansible को mainly Configuration Management यानि Servers को Desired State मैं maintain रखने के लिए किया जाता है|```

```System Engineer या फिर DevOps engineer normally एक server पर login करके उस server को maintain कर सकते हैं लेकिन अगर DevOps engineer को एक साथ 50 या 100 servers पर Java setup या कोई और application setup करने के लिए कहा जाये तो वह इस task को easily और time से complete नहीं कर पायेगा जिसमे काफी misakes भी हो सकती है तो ऐसे task को complete करने के लिए Ansible का use किया जाता है, Ansible के through हम सिस्टम को configure easily कर सकते हैं|```

In short, Ansible lets you:
- Automate repetitive tasks (e.g., installing software on multiple servers).

<br>

## The Key Features of Ansible

- **Agentless**:

  Unlike many other tools, Ansible doesn’t require you to install any special software (called an agent) on the machines it manages. It uses SSH (for Linux/Unix) or WinRM (for Windows) to communicate with systems. This makes it easy to set up and maintain.

  Agentless means no need of installing an agent on remote server. It works by logging onto those server.

- **Human-Readable Language (YAML)**

  Ansible uses **YAML** to define configurations and workflows. YAML is simple and easy to understand, even for people who aren’t developers. You describe the desired state of your systems in plain text files called playbooks.

- **Idempotency**

  Ansible ensures that tasks are only applied if necessary. For example, if you tell Ansible to install a program, it will check if the program is already installed. If it is, Ansible won’t install it again. This prevents redundant actions and ensures your systems stay in the desired state.

  If the program is already installed on the server then Ansible will not install it again.

- **Push-Based Architecture**

  Ansible works by "pushing" configurations and commands from a central control node (your workstation or a server) to remote servers.

- **Modular and Extensible**

  Ansible comes with a large library of **modules**—pre-built scripts that perform specific tasks, like managing files, users, or services. You can also write your own modules if needed.

<br>

## Components in Ansible

Ansible is composed of several key components that work together to configure a server.

- ### Control Node

  **What It Is**: The control node is the machine where Ansible is installed and from which you execute commands or playbooks.

  **Purpose**: It acts as the central point of control, sending instructions to the managed nodes (remote systems) over SSH (for Linux) or WinRM (for Windows).

  **Key Requirements**:
  - Python installed on control Node (Ansible itself is written in Python).
  - SSH access to managed nodes (no additional software is needed on managed nodes). Control node should be able to access the managed nodes using SSH aur WinRM.

  **Example**: Your workstation or a dedicated server can serve as the control node.

- ### Managed Nodes

  **What They Are**: These are the systems (servers, network devices, containers, cloud instances, etc.) that you want to configure or manage using Ansible.

  **Purpose**: These nodes receive instructions from the control node and execute tasks locally. Control node sends the instructions to managed nodes.

  **Key Features**:
  - No need to install an agent—Ansible connects to managed nodes via SSH or WinRM.
  - Can be Linux, Windows, or any other supported platform.

  **Example**: Web servers, database servers, load balancers, and even cloud instances like AWS EC2 or Azure VMs.

- ### Inventory

  **What It Is**: An inventory is simply a list of the computers (servers, network devices, etc.) that you want to manage. Inventory file contains the access details of managed nodes. It can be a static file or dynamically generated.

  **Purpose**: The inventory tells Ansible where the servers are and how to connect to them.

  **Types of Inventory**:
  - Static Inventory: A simple text file listing all hosts and their groups.

    Example (inventory.ini):
    ```
    [webservers]
    web1.example.com
    web2.example.com

    [databases]
    db1.example.com
    db2.example.com
    ```

  - Dynamic Inventory: A script or plugin that queries systems (e.g., cloud APIs) to generate the inventory dynamically.
    - Example: Pulling inventory from AWS or Azure.

  **Groups**: Hosts can be grouped to apply configurations selectively. For instance, you can group servers by roles like webservers or databases.

- ### Playbooks

  **What They Are**: Playbooks are YAML files where you define a series of tasks for Ansible to perform on managed nodes. Simple YAML files where we write what to configure on managed nodes.

  **Purpose**: They describe the desired state of your systems in a human-readable, reusable format.

  **Structure**:
  - Plays: A play is a set of tasks applied to a group of hosts.
  - Tasks: Tasks define individual actions, such as installing software or copying files.

  **Example**:

  ```
  - name: Configure web servers
    hosts: webservers
    tasks:
      - name: Install Nginx
        apt:
          name: nginx
          state: present

      - name: Start Nginx
        service:
          name: nginx
          state: started
  ```

- ### Modules

  **What They Are**: Modules are small, reusable units of code that perform specific actions, like managing files, installing packages, or configuring network devices. Modules are also called plugins.

  **Purpose**: They are the building blocks of Ansible tasks, providing the functionality needed to automate various operations.

  **Key Points**:
  - Ansible comes with hundreds of built-in modules (e.g., ```apt```, ```yum```, ```copy```, ```user```).
  - Custom modules can be created to handle specialized tasks.

  **Example**:
  - Installing software with the ```apt``` module:

    ```
    - name: Install Nginx
      apt:
        name: nginx
        state: present
    ```

  - Managing services with the ```service``` module:

    ```
    - name: Start Nginx
      service:
        name: nginx
        state: started
    ```

- ### Tasks

  **What They Are**: Tasks are individual actions defined in playbooks.

  **Purpose**: Each task corresponds to a specific action you want to perform, such as installing software, copying files, or starting a service.

  **Key Features**:
  - Tasks use modules to perform actions.
  - Tasks are idempotent, meaning they only make changes if necessary.

  **Example**:

  ```
  tasks:
    - name: Install Git
      apt:
        name: git
        state: present
    - name: Copy configuration file
      copy:
        src: /local/config.cfg
        dest: /etc/config.cfg
  ```

- ### Variables

  **What They Are**: Variables allow you to customize playbooks and make them dynamic.

  **Purpose**: Reuse the same playbooks with different configurations.

  **Example**:
  - Defining a variable:

    ```
    vars:
      webserver_port: 8080
    ```

  - Using the variable:

    ```
    - name: Configure Nginx
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
    ```

<br>

## How does Ansible Works?

- **Write a Playbook**: You create a YAML file (the playbook) that describes the tasks you want to automate. This includes specifying which hosts to target, which modules to use, and what parameters to pass to those modules.

- **Define the Inventory**: You create an inventory file that lists your managed nodes.

- **Run the Playbook**: You execute the playbook from the control node using the ansible-playbook command.

- **Ansible Connects**: Ansible connects to the managed nodes (using SSH or WinRM) based on your inventory.

- **Modules Execute**: Ansible transfers the necessary modules to the managed nodes, executes them, and collects the results.

- **Report Results**: Ansible reports the results of the execution back to the control node, telling you if the tasks were successful or if there were any errors.
