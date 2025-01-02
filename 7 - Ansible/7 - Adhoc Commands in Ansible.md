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

  