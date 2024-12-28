# Ansible Introduction

Ansible is the open-source IT Automation tool which is used for **Infrastructure Provisioning**, **Application Deployment** and **Configuration Management**. It helps system administrators and DevOps teams manage and automate tasks like configuring servers, deploying applications, and orchestrating workflows.

Ansible is primarily used for **Configuration Management**. System engineers and DevOps Professionals use the Ansible for Configure the servers.

Configuration Management is simply managing the configuration of servers to desried state using tools.

```Ansible एक IT Automation tool है, जो Infrastructure Provisoning, Configuration Management, Application Deployment कर सकता है. लेकिन Ansible को mainly Configuration Management यानि Servers को Desired State मैं maintain रखने के लिए किया जाता है|```

```System Engineer या फिर DevOps engineer normally एक server पर login करके उस server को maintain कर सकते हैं लेकिन अगर DevOps engineer को एक साथ 50 या 100 servers पर Java setup या कोई और application setup करने के लिए कहा जाये तो वह इस task को easily और time से complete नहीं कर पायेगा जिसमे काफी misakes भी हो सकती है तो ऐसे task को complete करने के लिए Ansible का use किया जाता है, Ansible के through हम सिस्टम को configure easily कर सकते हैं|```

In short, Ansible lets you:
- Automate repetitive tasks (e.g., installing software on multiple servers).

<br>

## The Key Features of Ansible

- **Agentless**:

  Unlike many other tools, Ansible doesn’t require you to install any special software (called an agent) on the machines it manages. It uses SSH (for Linux/Unix) or WinRM (for Windows) to communicate with systems. This makes it easy to set up and maintain.

  Agentless means no need of installing an agent on remote server. It works by logging onto those server.

- **Human-Readable Language (YAML)**

  Ansible uses **YAML** to define configurations and workflows. YAML is simple and easy to understand, even for people who aren’t developers. You describe the desired state of your systems in plain text files called playbooks.

- **Idempotency**

  Ansible ensures that tasks are only applied if necessary. For example, if you tell Ansible to install a program, it will check if the program is already installed. If it is, Ansible won’t install it again. This prevents redundant actions and ensures your systems stay in the desired state.

  If the program is already installed on the server then Ansible will not install it again.

- **Push-Based Architecture**

  Ansible works by "pushing" configurations and commands from a central control node (your workstation or a server) to remote servers.

- **Modular and Extensible**

  Ansible comes with a large library of **modules**—pre-built scripts that perform specific tasks, like managing files, users, or services. You can also write your own modules if needed.

