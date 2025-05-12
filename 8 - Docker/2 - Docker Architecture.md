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

Docker Client ek command-line tool hai (CLI) jo user aur Docker daemon ke beech ek interface ka kaam karta hai. Jab bhi aap docker command chalate ho terminal mein — aap Docker Client se baat kar rahe hote ho.

<br>

**Docker Host**

This is the system where docker is installed or running. It includes the Docker Daemon and maintains the local images and containers.

Docker Host ek aisi machine hoti hai (physical ya virtual server) jahan Docker Daemon (dockerd) run karta hai, aur yahi machine:
- Docker Images store karta hai.
- Containers run karta hai.
- Networks aur Volumes manage karta hai.

Ye wo environment hai jahan aapke containers actually run hote hain.

Components of Docker Host:

| Component                        | Description                                                           |
| -------------------------------- | --------------------------------------------------------------------- |
|    **Docker Daemon (`dockerd`)** | Server-side engine jo client requests ko process karta hai            |
|    **Images**                    | Base templates jaise NGINX, Redis, Python                             |
|    **Containers**                | Running instances of images                                           |
|    **Networks**                  | Bridge, host, overlay jaise networks                                  |
|    **Volumes**                   | Persistent data ke liye storage units                                 |
|    **Storage Driver**            | Image aur container layers ko manage karta hai (overlay2, aufs, etc.) |
