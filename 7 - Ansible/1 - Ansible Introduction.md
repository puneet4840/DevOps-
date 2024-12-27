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

