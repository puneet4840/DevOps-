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
  - Hurray!!!

<br>
<br>

### Explanation of Above Ansibl Playbook

- **File Header**:

  ```
  ---
  - name: Install Nginx and Deploy HTML on Ubuntu
  ```
  - The ```---``` indicates the beginning of a YAML document.
  - ```name```: Provides a descriptive name for the play, helping to identify its purpose. In this case, it installs and configures Nginx.

- **Target Hosts**:

  ```
  hosts: all
  ```
  - ```hosts```: Specifies the target machines (managed nodes) on which the playbook will execute.
  - ```all```: Refers to a all machines defined in the inventory file (hosts).

- **Privilege Escalation**:

  ```
  become: yes
  ```
  - ```become```: Enables privilege escalation (e.g., using ```sudo```) to execute tasks requiring administrative rights.
  - ```yes```: Indicates that the tasks should run with elevated privileges.
 
- **Tasks**:

  The tasks section defines the series of steps to be executed. Each task is described using:
  - ```name```: A human-readable description.
  - A specific Ansible module (e.g., ````apt```, ```service```, ```copy```).

<br>

### Tasks in Detail

- **Task 1: Update the APT Cache**:

  ```
    - name: Update APT package manager
      apt:
        update_cache: yes
  ```
  - Purpose: Ensures the package database on the target machine is updated, avoiding issues with outdated repositories.
  - Module: apt (used for managing Debian-based package systems like Ubuntu).
  - Key Parameter: update_cache: yes updates the list of available packages.

- **Task 2: Install Nginx**:

  ```
  - name: Install Nginx
      apt:
        name: nginx
        state: present
  ```
  - Purpose: Installs the Nginx package.
  - Module: ```apt```.
  - Key Parameters:
    - ```name: nginx```: Specifies the package to install.
    - ```state: present```: Ensures the package is installed (if not already installed).

- **Task 3: Ensure Nginx is Running**:

  ```
   - name: Ensure Nginx is running
      service:
        name: nginx
        state: started
        enabled: yes
  ```
  - Purpose: Ensures Nginx is running and starts automatically on boot.
  - Module: ```service``` (manages system services).
  - Key Parameters:
    - ```name: nginx```: Specifies the service to manage.
    - ```state: started```: Ensures the service is running.
    - ```enabled: yes```: Ensures the service starts automatically on system boot.

- **Task 4: Copy the index.html file from control node to managed node**

  ```
  - name: Deploy custom HTML file
      copy:
        src: /home/puneet/ansible/index.html
        dest: /var/www/html/index.html
        owner: www-data
        group: www-data
        mode: '0644'
  ```
  - Purpose: Copy index.html file to the Nginx web server's default document root.
  - Module: ```copy``` (copies files or content to a destination).
  - Key Parameters:
    - ```src```: The source path for the index.html file in control node.
    - ```dest```: The destination path for the file (```/var/www/html/index.html```), which is the default web directory for Nginx.
    - ```owner```: Sets the file's ownership to www-data, the user under which Nginx runs.
    - ```group```: Sets the file's group ownership to www-data.
    - ```mode```: Sets file permissions to 0644 (read and write for the owner, read-only for others).

- **Task 5: Restart Nginx**:

  ```
   - name: Restart Nginx to apply changes
      service:
        name: nginx
        state: restarted
  ```

  - Purpose: Restarts the Nginx service to ensure it reflects the changes made (e.g., new HTML content).
  - Module: ```service```.
  - Key Parameter:
    - ```state: restarted```: Ensures the service is stopped and started again.

### How It All Comes Together

- The control node executes the playbook using Ansible.
- Ansible connects to the managed nodes defined in the inventory file.
- Tasks are executed sequentially:
  - Update APT cache.
  - Install Nginx.
  - Start and enable the Nginx service.
  - Deploy a custom HTML file to the web server.
  - Restart Nginx to apply the changes.
- The result: A fully configured Nginx web server serving the custom HTML page.
