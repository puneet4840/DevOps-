# Docker Architecture

<br>

<img src="https://drive.usercontent.google.com/download?id=100QCMwG8MXrrFYqO9tm2eTPg31Frfnsq" height=400 weight=400>

<br>

Docker uses the Client-Server architecture where docker client sends REST API request to docker daemon then docker daemon process that API request.

Example:

User write a docker command on terminal that terminal is the docker client or docker cli. Docker cli send this command to docker daemon over (REST API ya Unix socket). Now docker daemon performs the action on that command.

Client (CLI) aur Docker daemon ke beech communication hota hai through:
- Unix socket (default in Linux): ```/var/run/docker.sock```.
- Ya phir REST API over TCP (mostly in remote setups).

<br>

### Components of Docker Architecture.

**Docker Client**

Docker client is a CLi tool which help to interact with docker daemon through commands. 

Docker client is a CLI tool which help user ot communicate with docker daemon.

Docker Client ek command-line tool hai (CLI) jo user aur Docker daemon ke beech ek interface ka kaam karta hai matlab user aur docker daemon ke beech main communication create karta hai. Jab bhi aap docker command chalate ho terminal mein — aap Docker Client se baat kar rahe hote ho.

Docker client REST API ya Unix Socker ke through Docker daemon ko request send karta hai jo aap command likhte ho. Fir docker daemon us command ko process karta hai aur docker client ko response send karta hai. Commands like ```docker build```, ```docker run```.

It can reside on the same machine as the Docker Daemon or on a different system.

<br>

**Docker Host**

This is the system where docker is installed or running. It includes the Docker Daemon and maintains the local images and containers.

Docker Host ek aisi machine hoti hai (physical ya virtual server) jahan Docker Daemon (dockerd) run karta hai, aur yahi machine:
- Docker Images store karta hai.
- Containers run karta hai.
- Networks aur Volumes manage karta hai.

Ye wo environment hai jahan aapke containers actually run hote hain.

**Components of Docker Host**:

| Component                        | Description                                                           |
| -------------------------------- | --------------------------------------------------------------------- |
|    **Docker Daemon (`dockerd`)** | Server-side engine jo client requests ko process karta hai            |
|    **Images**                    | Base templates jaise NGINX, Redis, Python                             |
|    **Containers**                | Running instances of images                                           |
|    **Networks**                  | Bridge, host, overlay jaise networks                                  |
|    **Volumes**                   | Persistent data ke liye storage units                                 |
|    **Storage Driver**            | Image aur container layers ko manage karta hai (overlay2, aufs, etc.) |

<br>

**Local vs Remote Docker Host**:

| Scenario        | Description                                                                                                                                        |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Local Host**  | Docker daemon same machine pe run ho raha hai jahan docker client run ho rha hai (common dev setup)                                                      |
| **Remote Host** | Docker daemon kisi aur server pe run ho raha hai, aur docker client kisi aur server pe run ho rha hai, aap remote se docker Docker daemon ko Docker client ke zariye control kar rahe ho (cloud servers, CI/CD, Swarm clusters) |

Note: Docker Host par background main docker daemon hi sab kuch karta hai.

<br>

**Docker Daemon**

Docker Daemon is a background process that manages the docker objects like containers, images, networking, volumes.

The process that is known as docker daemon is ```dockerd```. This dockerd process manages all the docker objects.

Docker Daemon (binary: dockerd) ek background process hai jo:
- Docker client se requests accept karta hai.
- Images build/pull karta hai.
- Containers ko run/start/stop karta hai.
- Volumes, networks aur plugins manage karta hai.

**How does Docker Daemon works?**

- Aap docker client pe command chalate ho:

  ```docker run nginx```.

- Docker client internally Docker Daemon ko API request bhejta hai (via socket or TCP).
- Docker Daemon:
  - nginx image ko locally check karta hai.
  - agar locally docker host main available nahi hai to registry se pull karta hai.
  - container create karke run karta hai.
- Response client ko wapas bhej diya jata hai (container ID, logs, etc.).

Docker Daemon (dockerd) ek long-running background service hai jo Docker client ke instructions ko execute karta hai, aur sabhi containers, images, volumes, aur networks ka actual management karta hai.

<br>

### How It All Works Together

- The user runs a command like ```docker run nginx```.
- The client sends this to the Docker daemon.
- The daemon checks for the image locally:
  - If not found, it pulls it from the Registry.
- The daemon creates a container using that image.
- The container runs on the Docker Host.

