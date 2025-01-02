# Inventory in Ansible

An Inventory is a file in ansible which contains the list of managed nodes. These are the nodes which we want to manage through ansible.

The inventory is a structured way to define the systems (hosts) you manage and group them for efficient task execution. It is the starting point of any Ansible automation because it tells Ansible what machines to manage, where they are, and how to connect to them.


The inventory is essentially a file or directory that:
- Lists all the managed nodes (hosts).
- Groups them logically based on purpose, location, environment, or any criteria you choose.
- Specifies configuration details like IP addresses, connection methods, ports, or user credentials.

## Structure of Inventory

An inventory consists of:

- **Hosts**:
  - The systems or nodes you want to manage are called **hosts**.
  - Each host can be identified by its hostname, IP address, or alias.
    - Hostname: E.g., ```web1.example.com```.
    - IP Address: E.g., ```192.168.1.1```.
    - Aliases: An alternate name to reference a host, such as ```webserver1```.
  - Hosts represent individual machines or servers that Ansible will manage.

- **Groups**:
  - A group is a collection of related hosts.
  - Hosts can be organized into groups to apply tasks collectively.
  - Groups can represent environments (e.g., ```production```, ```staging```), roles (e.g., ```webservers```, ```dbservers```), or any other logical grouping.

    Exmaple:
    
    ```
    [webservers]
    web1.example.com
    web2.example.com

    [databases]
    db1.example.com
    ```

- **Variables**:
  - Variable in playbooks are very similar to using variables in any programming language. It helps you to use and assign a value to a variable and use that anywhere in the playbook.

    Example:

    ```
    ansible_user=admin ansible_port=2222
    ```
<br>

## Types of Inventory

There are two types of inventory in ansible:

### 1 - Static Inventory

A Static Inventory is a text file (usually named ```hosts``` or ```inventory```) that list the host you want to manage. It is called static because the list of hosts is directly defined in the file and doesn't change dynamically unless you manually edit it.

Example of static inventory file:

```
# Individual hosts
192.168.1.1
192.168.1.2

# Groups of hosts
[webservers]
web1.example.com
web2.example.com

[databases]
db1.example.com ansible_user=dbadmin ansible_port=3306

# Nested groups
[all_servers:children]
webservers
databases

# Group-level variables
[databases:vars]
ansible_ssh_private_key_file=/path/to/key.pem
```

### 2 - Dynamic Inventory

- Automatically generates the list of hosts and groups at runtime.
- Uses scripts, APIs, or plugins to fetch host information from sources like AWS, Azure, GCP, VMware, or Kubernetes.
- Ideal for cloud environments or large-scale, dynamic infrastructures.

<br>

## Inventry File Location

Ansible inventry file is located at ```/etc/ansible/hosts```. The name of inventory file is ```hosts```.

<br>

## How Inventory Works with Ansible

- **Defining the Inventory**:

  - Ansible reads the inventory to identify which hosts to connect to and their configurations.
  - Specify the inventory file when running Ansible commands:

    ```
    ansible-playbook -i inventory playbook.yml
    ```

- **Host Targeting**:

  - Playbooks or commands use the ```hosts``` keyword to specify which hosts or groups to target.

- **Inventory Parsing**:

  - Ansible parses the inventory, resolves group memberships, and applies any variables defined.

- **Execution**:

  - Ansible connects to the hosts via SSH (or other specified methods) and performs the defined tasks.

<br>

## Adding Hosts to Inventory File

In Ansible, the inventory file is the foundational component for defining which machines you will manage. Adding hosts to this file involves specifying their names, IP addresses, and optionally grouping them or providing variables for configuration.

- ### Understand the Inventory File Format

  Ansible supports multiple formats for inventory files:
  - **INI Format** (default and simplest format).
  - **YAML Format** (preferred for advanced use cases).

  By default, the inventory file is located at ```/etc/ansible/hosts```. You can also create and specify custom inventory files.

- ### Adding Hosts in INI Format

  The INI format organizes hosts, groups, and variables using a simple structure.

  - **Example 1: Adding Individual Hosts**

    Syntax:

    ```user_id@IP_Address```

    ```
    ubuntu@172.168.10.20
    ```

    Explanation:
    - ubuntu: This is the user of server.
    - IP_Address: This is the Public IP Address of the server.

  - **Example 2: Grouping Hosts**

    Syntax:

    ```
    [server_category_name]
    server_detail
    ```

    ```
    [app]
    ubuntu@172.168.10.20

    [db]
    ubuntu@172.168.10.30
    ```
<br>

## Create or Modify an Inventory File

- **Default Inventory File**: Modify ```/etc/ansible/hosts``` (requires root privileges):

  ```
  sudo vi /etc/ansible/hosts
  ```

  Add hosts or groups using the formats described above.

- **Custom Inventory File**: Create a new file at ```/etc/ansible/```, for example, ```my_inventory.ini```:

  ```
  sudo vi my_inventory.ini
  ```

  Add your hosts and groups.

  Specify the custom inventory file when running Ansible commands:

  ```
  ansible all -i my_inventory.ini -m ping
  ```

<br>

## Example (LAB): Create an Azure VM and Connect to Control Node using ansible.

- **Step:1 - Get the username and Public IP of VM**.

  username: puneet
  
  Public IP: 172.191.83.193

- **Step:2 - Establish Password-Less Authentication Between your Control Node and Azure VM (managed node)**

  If your control node is Linux.

  - Create ssh keys on your control node:

    ```
    ssh-keygen -t rsa -b 2048
    ```

  - Send the ssh public key to the azure vm (manages node):
 
    ssh-copy-id username@public_ip
    
    ```
    ssh-copy-id puneet@172.191.83.193
    ```

- **Step:3 - Go to host file in ansible at** ```/etc/ansible/hosts``` **and edit the hosts file**

- **Step:4 - Paste the vm details given below in the hosts file**

  ```
  puneet@172.191.83.193
  ```

- **Step:5 - Connect to managed node by using below adhoc command**:

  ```
  ansible -i hosts -m ping "all"
  ```

  Explaination:
  - -i: targeting your default hosts file.
  - -m: module
  - ping: module name
  - all: It means this command is targeting to all managed nodes listed in the hosts file.
 
- **Step:6 - To connect only specified host**:

  To connect to the specified host listed in your hosts file.

  ```
  ansible -i hosts -m ping puneet@172.191.83.193
  ```

- **Connection Output**

  You will get the below output when connection is successful

  ```
  puneet@172.191.83.193 | SUCCESS => {
      "ansible_facts": {
          "discovered_interpreter_python": "/usr/bin/python3"
      },
      "changed": false,
      "ping": "pong"
  }
  ```

- **Done**
