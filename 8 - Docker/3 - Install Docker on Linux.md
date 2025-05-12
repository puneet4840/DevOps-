# Install Docker on Ubuntu

To install docker on ubuntu, we have to follow below instruction.

**Step-1: Install Docker on Ubuntu**

```sudo apt-get install docker.io```

This command will install docker on ubuntu.

<br>

**Step-2: Check If Docker Engine is Running**

```sudo systemctl status docker```

This command will show you the status of Docker engine or Docker host.

<br>

When you trying to run commands on docker cli or docker client. You will get an permission denied error. That error specifies that docker cli does not have permission to connect with docker daemon OR docker client is not able to send unic socket request to docker daemon.

For that we have to add current user to docker group.

**Step-3: Add current user to Docker group**

```sudo usermod -aG docker $USER```

This command states that add current user to docker group.

<br>

**Step-4: Refresh Docker Group**

After adding current user to docker group, you have to refresh the docker group.

```newgrp docker```

<br>

**Step-5: Check connectivity with docker daemon**

```docker ps```

This command will show running container on docker host.

