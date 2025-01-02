
# Ad-hoc Commands in Ansible

Ansible ad-hoc commands are simple, one-liner commands used to perform quick tasks on managed nodes without the need to create a playbook.

## Why Use Ad-Hoc Commands?

- **Quick Tasks**: Ideal for immediate, one-time operations like restarting a service, checking disk usage, or updating packages.
- **No Setup Required**: They don’t require the creation of YAML playbooks.
- **Efficient Troubleshooting**: Perfect for investigating or resolving issues on remote systems quickly.
- **Testing Environment**: Useful for testing Ansible configurations or verifying inventory setups.

<br>

## How Ad-Hoc Commands Work?

Ad-hoc commands use the ```ansible``` command-line tool (not ```ansible-playbook```) to target hosts or groups from the inventory.

**Basic Syntax**:

```
ansible [pattern] -m [module] -a "[arguments]" [options]
```

Explaination:
- ```[pattern]```: Specifies the hosts or groups to target (e.g., ```all```, ```webservers```).
- ```-m [module]```: Indicates the Ansible module to use (e.g., ```ping```, ```yum```, ```command```).
- ```-a "[arguments]"```: Provides arguments to the module.
- ```[options]```: Additional options like specifying inventory or user credentials.

<br>

## Common Use Cases and Examples

- ### Ping Managed Nodes

  - The ```ping``` module checks connectivity between the control node and the managed nodes.
 
  - Example:

    ```
    ansible all -m ping
    ```

    Explaination:
    - ```all```: Targets all hosts in the inventory.
    - ```-m ping```: Uses the ping module to check connectivity.

  - Output:

    ```
    puneet@172.191.83.193 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "ping": "pong"
    }
    ```

- ## Execute Commands

  The ```command``` module runs shell commands on the target nodes.

  ```
  ansible webservers -m command -a "uptime"
  ```

  Explaination:
  - Targets the ```webservers``` group.
  - Executes the ```uptime``` command to check how long the system has been running.
  - ```-a```: argument passing to the command module.

  Output:

  ```
  puneet@172.191.83.193 | CHANGED | rc=0 >>
   19:14:24 up  1:42,  1 user,  load average: 0.07, 0.02, 0.00
  ```

- ## Install a Package

  The ```yum``` module installs software on nodes using YUM (for Red Hat-based systems). The ```apt``` module installs the software on ubuntu nodes.

  ```
  ansible all -m apt -a "name=nginx state=present" -b
  ```

  This command wiil install nginx web server on managed node.

  Explaination:
  - ```-m apt```: This specifies the module to use. In this case, it's the apt module, which is used for managing packages on Debian/Ubuntu systems.
  - ```name=nginx```: This tells the apt module that the package to manage is nginx (the web server).
  - ```state=present```: This tells the apt module to ensure that the nginx package is present (i.e., installed). If it's not installed, it will be installed. If it's already installed, Ansible will do nothing (due to idempotency).
  - ```-b``` or ```--become```: This is the become option. It tells Ansible to use privilege escalation to execute the command as a different user, usually root. Since installing packages requires root privileges, this option is essential. By default, Ansible will try to use sudo for privilege escalation.

- ## Copy a File

  The ```copy``` module transfers files from the control node to managed nodes.

  ```
  ansible all -m copy -a "src=/home/puneet/file1.txt dest=/home"
  ```

  Explaination:
  - ```src```: This is the file location on control node.
  - ```dest```: This is the location where the file will be copied on managed node.

- ## Gather System Facts

  The ```setup``` module collects detailed information about the managed nodes. Fetches facts like IP address, operating system details, and hardware information.

  ```
  ansible all -m setup
  ```

  
