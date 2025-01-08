# Creating Nginx Role (Installing nginx and deploying simple html application on managed node)

## Lab: Creating an Nginx Role

### Step 1: Setup Prerequisites

- **Control Node**:
  - Ensure Ansible is installed and configured.
  - SSH password-less authentication is set up between the control node and the managed node(s).
 
- **Managed Node**:
  - python should be installed to run playbooks.

- **Ansible Inventory File**:
  - Define the managed node(s) in the hosts file (e.g., hosts):

    ```
    [webservers]
    192.168.1.100 
    ```

### Step 2: Create the Role

- Navigate to your Ansible working directory:

  ```
  cd /path/to/your/ansible/project
  ```

- Create a new role using the ```ansible-galaxy init``` command:

  ```
  ansible-galaxy init nginx_role
  ```

  This creates the following directory structure:

  ```
  nginx_role/
  ├── defaults/
  ├── files/
  ├── handlers/
  ├── meta/
  ├── tasks/
  ├── templates/
  ├── tests/
  └── vars/
  ```

### Step 3: Configure the Role Components

- **defaults/main.yml**:

  Define default variables.

  ```
  # defaults/main.yml
  nginx_port: 80
  html_file_name: index.html
  html_file_path: /var/www/html/index.html
  nginx_service_name: nginx
  ```

- **files/**:

  Place the static HTML file in the ```files/``` directory. Create a file named ```index.html``` in ```nginx_role/files/```.

  ```
  <!-- files/index.html -->
  <!DOCTYPE html>
  <html>
  <head>
      <title>Welcome to Nginx</title>
  </head>
  <body>
      <h1>Deployed by Ansible Role</h1>
  </body>
  </html>

  ```

- **handlers/main.yml**:

  Define a handler to restart the Nginx service after configuration changes.

  ```
  # handlers/main.yml
  - name: Restart Nginx
    ansible.builtin.service:
      name: "{{ nginx_service_name }}"
      state: restarted
  ```

- **tasks/main.yml**:

  Define tasks to install Nginx, copy the HTML file, and start the service.

  ```
  # tasks/main.yml
  - name: Install Nginx
    ansible.builtin.package:
      name: "{{ nginx_service_name }}"
      state: present

  - name: Ensure /var/www/html directory exists
    ansible.builtin.file:
      path: /var/www/html
      state: directory

  - name: Copy HTML file to web server
    ansible.builtin.copy:
      src: "{{ html_file_name }}"
      dest: "{{ html_file_path }}"

  - name: Start and enable Nginx service
    ansible.builtin.service:
      name: "{{ nginx_service_name }}"
      state: started
      enabled: true

  - name: Notify handler to restart Nginx
    ansible.builtin.debug:
      msg: "This will trigger the handler."
    notify: Restart Nginx
  ```

### Step 4: Create a Playbook to Use the Role

Create a playbook in the parent directory, for example, deploy_nginx.yml.

```
---
- name: Deploy Nginx and Host HTML File
  hosts: webservers
  become: yes
  roles:
    - nginx_role
```

### Step 5: Inventory File

Define the managed nodes in the hosts file.

```
[webserver]
127.168.10.20
```

### Step 6: Run the Playbook

Run the playbook to deploy Nginx and host the HTML file.

```
ansible-playbook -i inventory deploy_nginx.yml
```

### Step 7: Verify

- SSH into the managed node or visit the server's IP address in a browser.
- You should see the HTML page with the message.

After creating a role mention the role inside playbook file and run playbook.
