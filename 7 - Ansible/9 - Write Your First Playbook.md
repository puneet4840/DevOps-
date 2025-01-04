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

<br>

## Example (LAB): Install Nginx Web Server on Ubuntu VM and Deploy an application

It is assuming that you have setup ansible on control node and Established a password-less connection between control node and managed node (ubuntu VM).

- ### Step:1 - Create an Inventory File on control node

  - There is a file named ```hosts``` inside ```/etc/ansible/``` path.
  - Edit the ```hosts``` file and enter your vm details in it using the below example.

    ```
    puneet@172.191.83.193
    ```

- ### Step:2 - Create a playbook yaml file on control node

  - Create a directory for ansible playbooks and create playbook yaml file named ```deploy_nginx.yaml```.

- ### Step:3 - Write the plays in playbook yaml file

  - Write the below play in playbook file using below content.

  ```
  ---
  - name: Install Nginx and Deploy HTML on Ubuntu
    hosts: webservers
    become: yes  # Run tasks with sudo privileges

    tasks:
      - name: Update APT package manager
        apt:
          update_cache: yes

      - name: Install Nginx
        apt:
          name: nginx
          state: present

      - name: Ensure Nginx is running
        service:
          name: nginx
          state: started
          enabled: yes

      - name: Copy index.html file from control node to managed node
        copy:
          src: /home/puneet/ansible/index.html
          dest: /var/www/html/index.html
          owner: www-data
          group: www-data
          mode: '0644'

      - name: Restart Nginx to apply changes
        service:
          name: nginx
          state: restarted
  ```

- ### Step:4 - Create the HTML file (index.html)

  - Create a ```index.html``` file inside the same directory as your playbook with the following content

    ```
    <!DOCTYPE html>
    <html>
    <head>
        <title>Welcome to my website!</title>
    </head>
    <body>
        <h1>Hello from Ansible!</h1>
        <p>This is a simple web page deployed with Ansible.</p>
    </body>
    </html>
    ```

- ### Step:5 - Run the playbook

  - Run the playbook using below command

    ```
    ansible-playbook deploy_nginx.yaml
    ```

- ### Step:6 - Access the Application

  - Copy the VM's Public Ip from portal and paste in your browser.
  - Huray!!!
