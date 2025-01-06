# Handlers in Ansible

**Handlers** in Ansible are special tasks that execute only when triggered by another task.

They are typically used to perform actions that should occur only after a specific change is made on a managed node, such as restarting a service after modifying its configuration.

A handler is the same as a normal task but will run when another task calls.

Handlers are commonly used in Ansible to start, reload, restart, and stop services.

```Handler एक special task होता है, जैसे programming language मैं function call करने पर run होता है, Same वैसे ही handler किसी task के call करने पर एक्सेक्यूटे होता है|```

## Why Use Handlers?

- **Efficiency**: Handlers execute only when changes occur, avoiding unnecessary operations.
- **Dependency Management**: They ensure that dependent actions (e.g., service restarts) happen only after the necessary changes are made.
- **Idempotence**: Handlers run only once, even if triggered by multiple tasks in the same playbook.

## Key Features of Handlers

- **Triggered by the notify Directive**: A task can ```notify``` one or more handlers to run after it completes. It means we use notify directive to run any specific or more handlers.

- **Execute Only Once per Run**: Even if notified multiple times, a handler executes only once at the end of the playbook run.

- **Define Handlers Separately**: Handlers are defined under a handlers section in a playbook or role.


## Structure of Handlers

- Define handlers in a dedicated ```handlers``` section of the playbook.
- Use the ```notify``` directive in tasks to trigger handlers.

<br>

## Handler Examples

### Example 1: Restarting a Service

Playbook:

```
---
- name: Configure and restart a service
  hosts: all
  become: yes

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present

    - name: Update nginx configuration
      copy:
        src: /path/to/nginx.conf
        dest: /etc/nginx/nginx.conf
        owner: root
        group: root
        mode: '0644'
      notify: Restart Nginx

  handlers:
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
```

Explanation:

- Installing Nginx:
  - The ```apt``` module installs the ```nginx``` package.
  - This task does not notify the handler since it doesn't modify the configuration.

- Updating Nginx Configuration:
  - The ```copy``` module updates the ```/etc/nginx/nginx.conf``` file.
  - If the configuration file changes, it triggers the ```Restart Nginx``` handler using the ```notify``` directive.

- Handler: Restart Nginx:
  - The ```service``` module restarts the ```nginx``` service.
  - This happens only if the configuration file changes.
 
<br>

### Example 2: Multiple Handlers for a Single Task

Playbook:

```
---
- name: Configure a web server
  hosts: all
  become: yes

  tasks:
    - name: Deploy website files
      ansible.builtin.copy:
        src: /path/to/index.html
        dest: /var/www/html/index.html
        owner: root
        group: root
        mode: '0644'
      notify:
        - Reload Nginx
        - Log Deployment

  handlers:
    - name: Reload Nginx
      ansible.builtin.service:
        name: nginx
        state: reloaded

    - name: Log Deployment
      ansible.builtin.shell: echo "Website deployed on $(date)" >> /var/log/deployment.log
```

Explanation:

- Deploy Website Files:
  - The ```copy``` module uploads the website file ```index.html```.
  - It notifies two handlers: ```Reload Nginx``` and ```Log Deployment```.

- Handlers:
  - Reload Nginx: The ```service``` module reloads the ```nginx``` service configuration without a full restart.
  - Log Deployment: A shell command appends a timestamped log entry to ```/var/log/deployment.log```.

- Execution Order:
  - Both handlers run at the end of the play if the file upload changes.


<br>

### When Do Handlers Run?

- Handlers execute after all tasks in the play are completed.
- If a play has multiple tasks that notify the same handler, the handler runs only once

