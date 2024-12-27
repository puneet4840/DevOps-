# What is Configuration Management and Why we need Ansible?

The story starts with **Configuration Management**.

## The need for Configuration Management:-

Imagine you are a **system engineer** in a company. Your job is to manage the systems and computers that power your company's website, applications and internal systems. These servers are like engine of a car - if they are not working properly, the company can't operate efficiently.

Lets say your company start small with **5 servers**. You set each one manually:
- Install the operating system (like Linux or Windows).
- Add necessary softwares (like web servers, databases, etc).
- Configure network settings, security rules, and permission.
- Regularly update the servers with patches and fixez.

At first this is not big deal - you can handle 5 servers easily by logging into each one and doing the work. But now your company is growing, suddenly you have **50 servers** to manage. A new problem arises everyday:

- ### The problems faced by system engineers

  - **Manual Work Becomes Overwhelming**:

    Manually logging into 50 servers to make small change (like updating a piece of software) is time consuming and exhausting. Imagine typing the same commands 50 times - it is boring and prone to mistake.

  - **Inconsistencies Lead to Errors**:

    Human erros happen when you are repeating the same task. Maybe you forget a step on one server or type the wrong command. These mistake cause incosistencies, where one server behaves differently from the rest. For example, one server might have outdated software, causing your website to crash for some users.

  - **Scaling Becomes Impossible**:

    Now the company needs 200 servers. Hiring more engineers to handle this isn’t cost-effective, and even with more people, mistakes are still likely. You need a solution that can handle the growing number of servers without relying solely on human effort.

  - **Recreating Environments is Hard**:

    If your company needs a **testing environment** that’s identical to the production environment (the one users interact with), you must manually set up everything again. This is tedious and almost impossible to get 100% right.

  - **Troubleshooting is Time-Consuming**:

    When a server breaks, figuring out what went wrong is hard if every server is slightly different. You can’t easily compare them because there’s no guarantee they were set up in the same way.

<br>

## The Beginning of Configuration Management

System engineers realized they needed a way to automate this work. Instead of repeating the same steps on every server manually, they wanted to:

- Write down the steps once.
- Have a tool apply those steps to every server automatically.
- Ensure every server was configured **exactly the same**.

This idea of managing server settings and configurations using a tool is called **configuration management**. It ensures consistency, saves time, and reduces errors.

**What is Configuration Management?**

Configuration Management is the process of maintaing the Computer Systems, Server, Softwares in desired and consistent state.

```Configuration Management एक process होता है जिसमे system engineer computers, servers और softwares को update रखते हैं|```

```
OR
```

```System की configuration को tools के through manage करना ही configuration management होता है|```

<br>

## The Story of Configuration Management Tools

- **Early Days: Manual Scripts**:

  The first attempt to automate server management were simple **Scripts**. A system engineer would write a script (a list of commands) that could be run on each server to set it up. While helpful scripts had problems:

  - They were hard to maintain as systems became more complex.
  - If something went wrong during execution, the script would fail, and fixing it wasn’t easy.
  - Scripts didn’t adapt well to different operating systems or environments.

- **First Generation Tools: Puppet (2005) and Chef (2009)**:

  Around the mid-2000s, tools like **Puppet** and **Chef** were developed. These tools allowed engineers to describe the desired state of a server using special programming languages. For example, you could write a configuration file saying, “This server should always have a web server installed, with these specific settings.” The tool would then ensure the server matched this description.

  - **Disadvantages of Chef and Puppet**:

    - **Complexity and Learning Curve**:

      Puppet: Uses a declarative language that, while powerful, can be complex to learn and master, especially for those unfamiliar with its specific syntax and concepts.

      Chef: Relies heavily on Ruby, requiring users to have a good understanding of the language to write cookbooks (Chef's configuration scripts). This posed a barrier for system administrators who weren't proficient in Ruby.

    - **Agent-Based Architecture**:

      Puppet and Chef: Both traditionally rely on an agent-based architecture. This means that an agent needs to be installed on each managed node to communicate with the central server.

      - **Challenges of Agent-Based Systems**:

        - Installation and Maintenance: Deploying and maintaining agents across a large infrastructure can be a significant overhead.

        - Security Concerns: Agents can introduce potential security vulnerabilities if not properly managed and updated.

        - Resource Consumption: Agents consume system resources, even when not actively performing configuration tasks.

    - **Performance and Scalability**:

      Puppet and Chef: In some cases, these tools could face performance bottlenecks when managing very large infrastructures due to their architecture and the complexity of their configurations.

    - **Speed of Execution**:

      Puppet and Chef: Due to their more complex architectures and the need for agent communication, configuration changes could sometimes take longer to propagate across the infrastructure.

- **The Arrival of Ansible (2012)**

  Ansible was created by Michael DeHaan to address the shortcomings of existing configuration management tools. Ansible was designed to simplify configuration management and automation. It aimed to be:

  - Simple: Easy to learn and use.
  - Agentless: Unlike Puppet or Chef, Ansible doesn’t require agents. It uses SSH (or WinRM for Windows) to communicate with systems.
  - Flexible: Handle configuration management, application deployment, and orchestration.
  - YAML Syntax: Ansible configurations (playbooks) are written in YAML, a human-readable language.
  - Push-Based Architecture: The control node (where Ansible is installed) pushes configurations to managed nodes. No need for pull mechanisms.

<br>

## How Configuration Management Works in Practice

Imagine your company wants to set up 50 new servers to handle an increase in website traffic. Without configuration management, you’d manually:

- Log into each server.
- Install the required software.
- Apply the necessary configurations.

With configuration management (like Ansible), you:

- Write a playbook (a set of instructions in YAML).
- Run the playbook once, and the configuration management tool applies these steps to all 50 servers automatically.

<br>

## The Bigger Picture

As companies rely more on technology, their infrastructure grows. Configuration management tools like Ansible are vital for managing this complexity. They allow system engineers to focus on solving higher-level problems instead of wasting time on repetitive, manual tasks. In modern IT, configuration management is the backbone of efficient, reliable, and scalable operations, ensuring businesses can grow without the risk of chaos and inefficiency.
