# File Module in Ansible (Create, Delete, Update File and Directory on managed node)

The ```file``` module in Ansible is used to manage files and directories on the managed nodes. This module allows you to create, delete, modify permissions, change ownership, and set attributes of files or directories.


## Why Use the file Module?

The ```file``` module is used when you need to:
- Create directories with specific ownership and permissions.
- Change permissions or ownership of files/directories.
- Remove unwanted files or directories.
- Create symbolic links.


## Key Parameters of the file Module

Parameters are used withing the module.

- ```path```: Specifies the path of the file or directory on the managed node.
- ```state```: Defines the desired state of the file or directory. Common values:
  - ```file```: Ensures a file exists.
  - ```directory```: Ensures a directory exists.
  - ```absent```: Ensures the file or directory is removed.
  - ```link```: Creates a symbolic link.
  - ```touch```: Creates an empty file or updates its timestamp.

- ```owner```: Specifies the user who should own the file/directory on managed node.
- ```group```: Specifies the group ownership of the file/directory.
- ```mode```: Sets the file or directory permissions in octal format (e.g., ```0644```).
- ```recurse```: If yes, applies the ownership and permissions recursively for directories.


<br>

## Examples of the file Module

### Example 1: Create a Directory

```
---
- name: Create a directory with specific permissions
  hosts: all
  become: yes

  tasks:
    - name: Ensure the logs directory exists
      file:
        path: /var/log/myapp
        state: directory
        owner: root
        group: root
        mode: '0755'
```

Explanation:
- Path (```path```):
  - ```/var/log/myapp```: The directory to be created.
    
- State (```state```):
  - ```directory```: Ensures the path is a directory.
    
- Owner and Group (owner, group):
  - Sets the directory ownership to ```root```.

- Permissions (mode):
  - ```0755``` allows the owner to read, write, and execute, and others to read and execute.

<br>

### Example 2: Change File Permissions

```
---
- name: Change permissions of a file
  hosts: all
  become: yes

  tasks:
    - name: Modify file permissions
      file:
        path: /etc/myapp/config.ini
        state: file
        owner: appuser
        group: appgroup
        mode: '0640'
```

Explaination:
- Path (```path```):
  - ```/etc/myapp/config.ini```: The file whose attributes are being changed.

- State (```state```):
  - ```file```: Ensures it is a regular file.

- Owner and Group:
  - Changes ownership to ```appuser``` and group to ```appgroup```.

- Permissions:
  - ```0640```: Owner can read and write; group can read; others have no permissions.
 
<br>

### Example 3: Delete a File

```
---
- name: Remove a file
  hosts: all
  become: yes

  tasks:
    - name: Delete an old log file
      file:
        path: /var/log/myapp/old.log
        state: absent
```

Explaination:
- Path:
  - ```/var/log/myapp/old.log```: Specifies the file to be removed.

- State:
  - ```absent```: Ensures the file is deleted.

<br>

### Example 4: Remove a Directory

```
---
- name: Remove a directory
  hosts: all
  become: yes

  tasks:
    - name: Delete an unused directory
      file:
        path: /var/tmp/old_data
        state: absent
```

Explaination:
- Path:
  - ```/var/tmp/old_data```: The directory to be removed.

- State:
  - ```absent```: Ensures the directory (and its contents) are removed.
 
<br>

### Example 5: Create an Empty File or Update Timestamp

```
---
- name: Create an empty file or update its timestamp
  hosts: all
  become: yes

  tasks:
    - name: Touch a file
      file:
        path: /var/tmp/updated_file.txt
        state: touch
        owner: root
        group: root
        mode: '0644'
```

Explaination:
- Path:
  - ```/var/tmp/updated_file.txt```: The file to create or update its timestamp.

- State:
  - ```touch```: Ensures the file exists. If it already exists, its timestamp is updated.
 
- Ownership and Permissions:
  - Sets the file owner, group, and permissions.

<br>

### Common Scenarios

- **Prepare Directories for Applications**:

  - Use the ```file``` module to create required directories with correct ownership and permissions before deploying an application.
 
- **Clean Up Unused Files or Directories**:

  - Automate the removal of outdated or unnecessary files.

- **Set Permissions for Security**:

  - Enforce strict file permissions to meet security compliance requirements.
