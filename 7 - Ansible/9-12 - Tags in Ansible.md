# Tags in Ansible 

In Ansible, **tags** are a powerful feature that allows you to selectively execute specific tasks or subsets of tasks within a playbook.

```Suppose ansible playbook मैं 5 tasks है और हमको उनमें से सिर्फ 2 tasks ही run करने है तो ऐसे हम tags के through कर सकते है| हम हर task पर एक tag देते हैं और जिस भी task को run करना होता है ansible command मैं उस tag को mention कर देते हैं|```

## Why Use Tags?

- **Selective Execution**: Run only the tasks you need without executing the entire playbook.
- **Efficiency**: Save time by skipping irrelevant tasks during testing or debugging.

## How Tags Work?

- You assign tags to individual tasks, blocks, roles, or plays in a playbook.
- When running a playbook, you can use the ```--tags``` or ```--skip-tags``` options to specify which tagged tasks should or should not execute.

## Basic Syntax for Tags

```
- name: Task with a tag
  ansible.builtin.command: echo "This is a tagged task"
  tags:
    - example_tag
```

<br>

## Using Tags in Playbooks

### Example 1: Tagging Individual Tasks

```
---
- name: Example playbook with tagged tasks
  hosts: all

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
      tags:
        - install
        - nginx

    - name: Start nginx service
      service:
        name: nginx
        state started
      tags:
        - start
        - nginx

```

**Command to Run Specific Tags**:

- Run Only the ```install``` Tag:

  ```
  ansible-playbook install_nginx.yaml --tags install
  ```

  What Happens?
  - Only the task to install nginx runs.

- Run Multiple Tags:

  ```
  ansible-playbook playbook.yml --tags "install,config"
  ```

  What Happens?
  - The tasks for installing nginx and copying the configuration file execute.

- Skip a Specific Tag:

  ```
  ansible-playbook playbook.yml --skip-tags start
  ```

  What Happens?
  - All tasks except the one tagged ```start``` will execute.

<br>
<br>

## Example Practical (Lab): Managing a Web Server

Playbook: ```webserver.yml```

```
---
- name: Manage web server
  hosts: all
  become: yes

  tasks:
    - name: Install nginx
      ansible.builtin.yum:
        name: nginx
        state: present
      tags:
        - install
        - nginx

    - name: Start nginx service
      ansible.builtin.service:
        name: nginx
        state: started
      tags:
        - start
        - nginx

    - name: Stop nginx service
      ansible.builtin.service:
        name: nginx
        state: stopped
      tags:
        - stop
        - nginx

    - name: Remove nginx
      ansible.builtin.yum:
        name: nginx
        state: absent
      tags:
        - uninstall
        - nginx
```

### Use Cases

- **Install and Start Nginx**

  ```
  ansible-playbook webserver.yml --tags "install,start"
  ```

  What Happens?
  - Installs nginx and starts the service.

- **Stop and Uninstall Nginx**:

  ```
  ansible-playbook webserver.yml --tags "stop,uninstall"
  ```

  What Happens?
  - Stops and removes nginx from the managed node.

- **Skip Uninstall Task**:

  ```
  ansible-playbook webserver.yml --skip-tags uninstall
  ```

  What Happens?
  - Executes all tasks except the one for uninstalling nginx.
