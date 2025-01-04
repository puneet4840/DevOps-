# Learn How to write Playbooks

## What is a Playbook?

An Ansible playbook is a YAML file that desribes a set of tasks to be executed on managed nodes.

```
OR
```

An Ansible playbook is a YAML file which consists the list of plays.

```Playbook एक YAML file होती है जिसमे list of plays होते हैं मतलब एक playbook मैं plays लिखे होते हैं इसलिए इसको playbook कहते हैं|```

## What is a Play?

A play is a set of instructions that are executed on managed nodes.

<br>

## Structure of Play

A playbook starts from three hyphens (---).

Any play you write in your playbook, just give a hyphen (-) and write a play. It means a play start from a single hyphen (-).

Suppose your task is to create a DB server and a Web Server on a ubuntu virtual machine (managed node). So you have to create two plays in your ansible playbook.

One play for DB Server and Other Play for web server.

- ### Basic Structure a Play consists:

  - **Hosts**: A host inside a play defines on which node you want to execute the play's task.

  - **Remote**: A remote inside a play means from which user you want to executes tasks such as ubuntu user, root user. Because a vm or node always has a user using that user we login to the machine.

  - **Tasks**: A task is the exact instructions you want to run on managed node such as installing a db server, run a db server.
    - **Modules**: Modules are the plugins OR reusable units of code that executes the task e.g. (yum, apt, shell, command, etc).


## Complete Playbook structure

```
---
- name: Play Name (What the play does)
  hosts: Target Hosts (e.g., webservers, vm name)
  become: yes (Use sudo privileges)
  vars: (Optional Variables)
    variable_name: value
  tasks:
    - Task 1
    - Task 2
```

