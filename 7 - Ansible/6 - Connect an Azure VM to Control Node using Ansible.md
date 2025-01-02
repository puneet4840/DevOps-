## Example (LAB): Create an Azure VM and Connect to Control Node using ansible.

- **Step:1 - Get the username and Public IP of VM**.

  username: puneet
  
  Public IP: 172.191.83.193

- **Step:2 - Establish Password-Less Authentication Between your Control Node and Azure VM (managed node)**

  If your control node is Linux.

  - Create ssh keys on your control node:

    ```
    ssh-keygen -t rsa -b 2048
    ```

  - Send the ssh public key to the azure vm (manages node):
 
    ssh-copy-id username@public_ip
    
    ```
    ssh-copy-id puneet@172.191.83.193
    ```

- **Step:3 - Go to host file in ansible at** ```/etc/ansible/hosts``` **and edit the hosts file**

- **Step:4 - Paste the vm details given below in the hosts file**

  ```
  puneet@172.191.83.193
  ```

- **Step:5 - Connect to managed node by using below adhoc command**:

  ```
  ansible -i hosts -m ping "all"
  ```

  Explaination:
  - -i: targeting your default hosts file.
  - -m: module
  - ping: module name
  - all: It means this command is targeting to all managed nodes listed in the hosts file.
 
- **Step:6 - To connect only specified host**:

  To connect to the specified host listed in your hosts file.

  ```
  ansible -i hosts -m ping puneet@172.191.83.193
  ```

- **Connection Output**

  You will get the below output when connection is successful

  ```
  puneet@172.191.83.193 | SUCCESS => {
      "ansible_facts": {
          "discovered_interpreter_python": "/usr/bin/python3"
      },
      "changed": false,
      "ping": "pong"
  }
  ```

- **Done**

