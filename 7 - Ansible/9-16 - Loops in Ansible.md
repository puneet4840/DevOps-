# Loops in Ansible

In Ansible, loops allow you to repeat a task multiple times with different items. This is particularly useful when you need to perform the same operation on multiple files, packages, users, or any other items. Instead of writing the same task multiple times, you use loops to simplify and automate repetitive tasks.

The simplest form of looping in Ansible is to iterate over a list of items, taking each item, inputting it into the playbook task, and running it each time using the input.

```Suppose आपको server पर 10 users create करने हैं, तो हर user को create करने के लिए अलग-अलग play लिखने की जगह हम एक play मैं ही loop का use करके users को create कर सकते हैं|```

## Why Use Loops?

- **Iterating Over Items**: The most common use case is to perform the same action on multiple items, such as:
  - Creating multiple users.
  - Installing multiple packages.
  - Creating multiple directories.
  - Managing multiple files.
 
- **Reducing Code Duplication**: Without loops, you would have to write the same task multiple times, changing only the value for each iteration. Loops allow you to write the task once and iterate over a list of values.

- **Making Playbooks Dynamic**: Loops make your playbooks more dynamic by allowing you to work with lists of data that might change over time.


## How Loops Work?

Ansible provides the ```loop``` keyword to iterate over a list of items. For each item in the list, the task is executed once.

## Basic Syntax of Loops

```
- name: Task description
  module_name:
    parameter: value
  loop:
    - item1
    - item2
    - item3
```

<br>

## Examples of Loops in Ansible

### Example 1: Installing Multiple Packages

Suppose you want to install a list of packages on your managed nodes.

```
---
- name: Install multiple packages
  hosts: all
  become: yes

  tasks:
    - name: Install required packages
      ansible.builtin.package:
        name: "{{ item }}"
        state: present
      loop:
        - htop
        - vim
        - curl
```

Explanation:
- Task: Installs multiple packages.
- Loop: The ```loop``` iterates over the list (```htop```, ```vim```, ```curl```) and installs each package.
- Dynamic Execution: The task runs once for each item in the list, ensuring all specified packages are installed.

### Example 2: Creating Multiple Users

Imagine you need to create multiple users on your managed nodes.

```
---
- name: Create multiple users
  hosts: all
  become: yes

  tasks:
    - name: Create users
      ansible.builtin.user:
        name: "{{ item }}"
        state: present
      loop:
        - alice
        - bob
        - charlie
```

Explanation:
- Task: Creates users on the managed nodes.
- Loop: The ```loop``` iterates over the list (```alice```, ```bob```, ```charlie```) and creates each user.
- Result: All specified users are created without writing separate tasks for each one.

### Example 3: Copying Multiple Files

Suppose you have multiple files on the control node that need to be copied to the managed nodes.

```
---
- name: Copy multiple files
  hosts: all
  become: yes

  tasks:
    - name: Copy files to remote nodes
      ansible.builtin.copy:
        src: "{{ item.src }}"
        dest: "{{ item.dest }}"
      loop:
        - { src: "/path/to/file1.txt", dest: "/destination/file1.txt" }
        - { src: "/path/to/file2.txt", dest: "/destination/file2.txt" }
        - { src: "/path/to/file3.txt", dest: "/destination/file3.txt" }
```

