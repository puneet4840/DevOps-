# Conditions in Ansible

In **Ansible**, conditions allow you to control when a task is executed. You can use conditional statements to specify that a task should run only if certain criteria are met.

In **Ansible**, conditions let you control whether a task should run or not. Instead of blindly running every task in a playbook, you can use conditions to make sure tasks are executed only when certain requirements are met. This makes your automation smarter and more efficient.

## Why Use Conditions?

- **Customization**: Execute tasks only for specific scenarios, like certain hosts, variables, or states.
- **Efficiency**: Avoid running unnecessary tasks, saving time and resources.
- You only want to install a specific software if the operating system is Ubuntu.

## How Conditions Work in Ansible

In Ansible, conditions are written using the ```when``` keyword. A task with a ```when``` clause will run only if the condition is true.

**Basic Syntax**:

```
when: <condition>
```

<br>

## Examples to Understand Conditions

### Example 1: Run a Task Based on Operating System

Let’s say you want to install Apache web server, but you want to first check if the managed node's OS is Ubuntu or RedHat.

```
---
- name: Install Apache on the right OS
  hosts: all
  become: yes

  tasks:
    - name: Install Apache on Debian
      ansible.builtin.package:
        name: apache2
        state: present
      when: ansible_os_family == "Debian"

    - name: Install Apache on Red Hat
      ansible.builtin.package:
        name: httpd
        state: present
      when: ansible_os_family == "RedHat"
```

What’s Happening?
- ```ansible_os_family``` checks the system type:
  - If it’s **Debian**, it runs the first task to install ```apache2```.
  - If it’s **RedHat**, it runs the second task to install ```httpd```.

Why is it useful?
- You don’t have to create separate playbooks for different OS types. One playbook can handle both.

### Example 2: Run a Task Only If a Variable Has a Specific Value

Let’s say you have a variable called ```install_software``` and you only want to install a package if this variable is set to ```yes```.

```
---
- name: Install software based on user input
  hosts: all
  become: yes

  vars:
    install_software: yes

  tasks:
    - name: Install a package
      ansible.builtin.package:
        name: htop
        state: present
      when: install_software == "yes"
```

What’s Happening?
- The task runs only if the variable ```install_software``` equals ```"yes"```.
- If the variable is ```"no"```, the task is skipped.

### Example 3: Combining Multiple Conditions

You can combine conditions using logical operators like AND, OR, and NOT. Let’s say you want to restart a service, but only if:
- The operating system is Debian AND.
- The distribution version is 10 or higher.

```
---
- name: Restart a service based on conditions
  hosts: all
  become: yes

  tasks:
    - name: Restart the service
      ansible.builtin.service:
        name: nginx
        state: restarted
      when: 
        - ansible_facts['os_family'] == "Debian"
        - ansible_facts['distribution_version'] | int >= 10
```

What’s Happening?
- Multiple Conditions:
  - The OS must be Debian.
  - The version must be 10 or higher.

- AND Logic: Both conditions must be true for the task to run.
- Result: The nginx service is restarted only if the managed node meets both criteria.

- ```| int```: This is a Jinja2 filter that converts the string value of distribution_version to an integer. This is important for numerical comparison.
