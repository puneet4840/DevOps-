# Password-Less Authentication in Ansible

Password-less authentication in ansible is the ability of control node (the system running Ansible) to connect to managed node (target systems) without requiring a password to each connection.

Instead of typing passwords, authentication is achieved using **SSH keys** or other mechanisms that don’t require manual input.

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
