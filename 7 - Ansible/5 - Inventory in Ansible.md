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
  - You can define variables specific to hosts or groups within the inventory.
  - These variables can be used to customize the behavior of playbooks.
