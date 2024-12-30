# Password-Less Authentication in Ansible

Password-less authentication in ansible is the ability of control node (the system running Ansible) to connect to managed node (target systems) without requiring a password to each connection.

Instead of typing passwords, authentication is achieved using **SSH keys** or other mechanisms that don’t require manual input.

<br>

## Why Do We Need Password-less Authentication in Ansible?

- **Automation**:
  
  - Ansible is designed for automation. If the control node requires a password for each connection, automation is interrupted, as human intervention is needed to enter the password.

- **Scalability**:

  - In environments where Ansible manages hundreds or thousands of nodes, manually entering passwords is impractical.
 
- **Security**:

  - Password-less authentication (via SSH keys) eliminates the need to store passwords in plain text or share them across multiple systems.

- **Efficiency**:

  - Password-less authentication is faster than entering passwords manually for each connection, reducing deployment and configuration times.

<br>

## How Password-less Authentication Works in Ansible

Ansible uses **SSH keys** to establish secure, password-less connections between the control node and the managed nodes.

### What are SSH Keys?

- **SSH Key Pair**: A pair of cryptographic keys used for authentication:
  - **Private Key**: Stays securely on the control node.
  - **Public Key**: Shared with the managed nodes.

The private key is used to authenticate access to systems that have the corresponding public key.

<br>

## The Authentication Process

To understand how Ansible connects to managed nodes using **password-less authentication**.

- ### Key Generation on the Control Node

  - Imagine the control node (your main computer running Ansible) wants to securely connect to other computers (called managed nodes).
  - To do this, it creates a special "key pair":
    - **Private Key**: This is like a secret key that stays on your control node. You must keep it safe and never share it with anyone.
    - **Public Key**: This is like a lock that you can share with the managed nodes. Anyone with this lock can trust messages that are "opened" with your private key.

  - The key pair is created using a tool like ```ssh-keygen```, and you get two files:
    - ```id_rsa``` (private key, secret).
    - ```id_rsa.pub``` (public key, shareable).

- ### Sharing the Public Key with Managed Nodes

  - The next step is to send your **public key** (the lock) to the managed nodes.
  - On each managed node, this public key is added to a special file called ```~/.ssh/authorized_keys```.
    - Think of this file as a guest list—anyone with a key listed here is allowed to enter without a password.

  - For example, you can use the ssh-copy-id command to easily send your public key to the managed node:

    ```
    ssh-copy-id user@managed-node
    ```

    Now, the managed node knows to trust your control node.


- ### Establishing an SSH Connection

  When you use Ansible (or any SSH client) to connect to the managed node, this is what happens behind the scenes:

  **Step 1: Control Node Sends Its Public Key**

  - During the connection process, the control node introduces itself to the managed node by saying, "Here is my public key. Do you recognize it?"
 
  **Step 2: Managed Node Checks the Key**

  - The managed node looks in its ```~/.ssh/authorized_keys``` file. If it finds the public key in the list, it thinks, "This key is on my guest list. Let's verify it."

  **Step 3: Challenge-Response Process**

  - To make sure it’s really the control node, the managed node creates a challenge (a random secret message).
  - The managed node encrypts this challenge using the public key of the control node and sends it back.

  **Step 4: Control Node Proves Its Identity**

  - The control node receives the encrypted challenge and uses its private key to decrypt it (remember, only the **private key** can unlock a message encrypted with the public key).
  - The control node sends the decrypted challenge back to the managed node.
 
  **Step 5: Managed Node Grants Access**

  - The managed node compares the response from the control node to the original challenge.
  - If the response matches, the managed node knows, "This must be the real control node because only it could decrypt my challenge."
  - It grants access.

- ### Password-less Automation

  - Once the public key is set up on the managed nodes, the control node can connect to them without needing a password.
  - This means you can run Ansible playbooks and commands on multiple nodes seamlessly without manually entering passwords for each connection.
