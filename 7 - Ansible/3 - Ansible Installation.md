# Installation of Ansible 

Ansible is not natively supported on Windows as a control node (the machine running Ansible). However, you can still set up Ansible on a Windows machine by installing it in a Linux-like environment using Windows Subsystem for Linux (WSL).

## Using Windows Subsystem for Linux (WSL)

This is the most recommended method as WSL provides a Linux environment within Windows.

- **Step 1: Install WSL**:

  - Open PowerShell as Administrator.
  - Run the following command to enable WSL:

    ```
    wsl --install
    ```
    - This will install WSL and a default Linux distribution (Ubuntu).
    - If you already have WSL installed, upgrade to WSL 2 for better performance:

      ```
      wsl --set-default-version 2
      ```

  - Restart your computer if prompted.

- **Step 2: Install Ubuntu or Your Preferred Linux Distribution**:

  - Launch the Microsoft Store.
  - Search for and install Ubuntu or another supported Linux distribution.
  - Open the installed distribution and complete the initial setup (username and password).

- **Step 3: Install Ansible in WSL**:

  - Update the package index:

    ```
    sudo apt update
    ```

  - Upgrade existing packages:

    ```
    sudo apt upgrade -y
    ```

  - Add the official Ansible PPA (Personal Package Archive):

    ```
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    ```

  - Install Ansible:

    ```
    sudo apt install ansible -y
    ```

  - Verify the installation:

    ```
    ansible --version
    ```

    
