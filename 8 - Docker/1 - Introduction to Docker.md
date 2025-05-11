# Docker

Docker is an open source tool which package an application and its all dependencies together in the form of container.

Docker is a tool which create containers. Containers encapsulate everything an application needs to run, including code, runtime, system tools, and libraries.

```Docker एक tool है जो applications और उसकी dependencies जैसे code, libraries को combine करके एक अलग environment create कर देता है जिसको हम container कहते हैं|```

Docker is a containerization tool by which you can pack your application and its all dependencies into a container. 

<br>

### What was Before Docker?

Before docker software was typicllay installed and run directly on the operating system of a server or a vm. When you wanted to run an application on a new machine, you had to manually:
- Install the OS.
- Install the required runtime (like Java, Python, .NET).
- Install all application dependencies (like libraries, frameworks).
- Set environment variables.
- Set up network ports, storage paths, and permissions.
- Handle version conflicts if multiple apps needed different library versions.

This setup was known as the traditional deployment method.

<br>

### What problem docker solves?

Before docker, developers faces a common challenge: The **It works on my machine** problem. 

Developers would build and run their application on their personal machine. It would work perfectly fine there. But when the code was moved to another environment like QA, staging, or production — it would crash, behave differently, or refuse to start altogether. So, developer say that It works on my machine.

  ```Docker use करने से पहले developers के बीच एक common problem आती थी की यह application सिर्फ मेरे machine (PC) मैं ही work कर रहा है दूसरे PC या deploying environment मैं work नहीं कर रहा है|```

**Why did this happen?**

Because different environments had:
- Different versions of operating systems.
- Missing or mismatched dependencies (e.g. one system had Python 3.10 while another had Python 3.8).
- Different library versions.
- Different environment variables and configuration files.
- Some machines lacked the required runtime, for example, Java, Node.js, or PHP.

This issue arose because different developers had slightly different development environments, which cause applications do not work across different stages like development, QA and production.

Example-1: 

A developer builds a Node.js application on their laptop running Node.js version 16. The app works fine. But when deployed to the production server running Node.js version 14, it breaks due to compatibility issues.

Example-2:

Imagine two devlopers working on a web application. Each developer has their own laptop with a slightly different configuration. Developer A's laptop might have a newer version of programming library, while developer B's laptop might have an older version. When developer A tests the application on their laptop, everything works perfectly. However, when they pass the code to developer B for testing, the application does not work on developer B's laptop due to the version difference. So, this problem makes frustration and delay. To overcomefrom this problem we have docker tool.

<br>

### How Docker Solves that Problem?

Docker solves that **It works on my machine** problem by introducing the concept of containers. Docker create containers, those containers ensuring same behaviour across different environments. Here, container encapsulate an application and its all dependencies. So, container can run on any machine where docker is installed.

```हम Docker की help से application और उसकी dependencies की एक docker image बना देते हैं फिर वह image हम developer को forward करते हैं| अब developer इस image को run करेगा जिससे एक container बन जायेगा, जैसे ही container बनेगा वह application developer के system मैं run हो जाएगी|```

**Note**:-

In the docker world, developers build a docker container that includes their application and all its dependencies. When developer A creates a container and hands it over to developer B, both developers are working in the exact same environment. 

In this scenario, Docker ensures that the "Is works on my machine" in no longer an issue.
