# Copy Files from Control Node to Managed Node

The **copy** module in Ansible is used to transfer files from your control node (where you run Ansible from) to your managed nodes (the servers you're controlling).

## Concept of the copy Module

The ```copy``` module is an Ansible module specifically designed for transferring files and directories from the control node to a specific location on the managed node.

**Key Features**:
- Copies local files or content from the control node to the managed node.
- Allows setting ownership, permissions, and file attributes on the managed node.
- Overwrites the destination file if it already exists (can be controlled).

### Common Use Cases

- Deploying configuration files (e.g., web server configuration, database setup files).
- Uploading scripts to be executed on the remote system.
- Distributing application files or assets.

<br>

## Basic Syntax of the copy Module

```
- name: Copy a file to the managed node
  copy:
    src: /path/to/local/file
    dest: /path/to/remote/file
    owner: user
    group: group
    mode: '0644'
```

**Parameters**:
- ```src```: Path of the file on the control node.
- ```dest```: Destination path on the managed node.
- ```owner```: User who will own the file on the managed node.
- ```group```: Group ownership of the file.
- ```mode```: File permissions (in octal format).

<br>

## Examples:

### Example:1 - Copy a file

Here, We are going to copy a file from control node to managed node without managing any permission or ownership.

```
- name: Copy a file from control node to managed node
  hosts: all
  tasks:
    - name: Copy a file to managed node
      copy:
        src: /home/puneet/file1.txt
        dest: /home/files/
```

Explaination: 
- Above playbook will simply copy file. The permission and ownership of copied file on managed node will be same as the file had on the control node.

<br>

### Example:2 - Copy a file with permissions and ownership

```
- name: Copy a file
  hosts: all
  become: yes
  tasks:
    - name: Copy the sample configuration file
      copy:
        src: /home/user/sample.conf
        dest: /etc/myapp/sample.conf
        owner: puneet
        group: root
        mode: '0644'
```

Explanation:
- **Source (src)**:
  - The file ```/home/user/sample.conf``` on the control node is specified as the source.

- **Destination (dest)**:
  - The file is copied to ```/etc/myapp/sample.conf``` on the managed node.

- **Owner and Group**:
  - The file will be owned by ```puneet``` with the group ```root``` on the managed node.

- **Permissions (mode)**:
  - The file will have read and write permissions for the owner and read-only permissions for others (```0644```).

**Command to Run**:

```
ansible-playbook copy_file.yml
```

<br>

### Example 3: Copy Inline Content

Playbook: ```copy_content.yml```

```
---
- name: Copy inline content to a file
  hosts: all
  become: yes

  tasks:
    - name: Write a custom message to a file
      copy:
        content: |
          # This is a configuration file
          setting1 = value1
          setting2 = value2
        dest: /etc/myapp/config.ini
        owner: root
        group: root
        mode: '0600'
```

Explaination:
- Inline Content (content):
  - Instead of using a file from the control node, inline content is directly written into ```/etc/myapp/config.ini``` on the managed node.

<br>

### Example 4: Copy a Directory Recursively

Playbook: ```copy_directory.yml```

```
---
- name: Copy a directory to the managed node
  hosts: all
  become: yes

  tasks:
    - name: Copy the web assets
      copy:
        src: /home/user/web-assets/
        dest: /var/www/html/
        owner: www-data
        group: www-data
        mode: '0755'
```

<br>

### Important Notes

- Idempotence: The copy module is idempotent, meaning it will only copy files if they are missing or different from the source.
- Directory Behavior: When copying directories, the destination directory must include a trailing slash (/) to avoid creating a nested structure.
- File Overwriting: The module will overwrite files if the content differs unless force: no is specified.

<br>
<br>

## Backup File using Ansible

To take backup of copied file.

Simple put ```backup: true``` inside the playbook.

```
---
- name: Copy a directory to the managed node
  hosts: all
  become: yes

  tasks:
    - name: Copy the web assets
      copy:
        src: /home/user/web-assets/
        dest: /var/www/html/
        owner: www-data
        group: www-data
        mode: '0755'
        backup: true
```

Whenever you run the playbook, ansible will first create a backup file on the same path then copy your file.
