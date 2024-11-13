# Health Probes in Kubernetes

Health Probes are the mechanism that is used to monitor the health status of container inside the pod.

So you’ve built an amazing app and deployed it to Kubernetes — congrats! But how do you make sure your app stays up and running as intended? That’s where liveness and readiness probes come in. It is used inside the pods yaml or deployment yaml.

```Health probes pods के अंदर run हो रहे containers की health को monitor करते हैं.```

In Kubernetes, health probes are tools to help keep your applications running smoothly by checking if each container in your cluster is "healthy." If a container is having issues, these probes let Kubernetes know so it can take action to keep your application up and running.

### Why Health Probes Are Important

In a Kubernetes cluster, applications are packaged as containers, and these containers can sometimes face issues like:

- **Crashes** (where the application stops unexpectedly).
- **Freezes** (where the application gets stuck and becomes unresponsive).
- **Slowdowns** (where the application responds very slowly).

To keep applications reliable, Kubernetes needs a way to monitor whether each container is healthy and working as expected. Health probes are Kubernetes’ solution for this. They check each container periodically and take corrective actions if something goes wrong.

<img src="https://drive.google.com/uc?export=view&id=14HhOV6uYyAkFazhO4kftG36-cB6czLk5" width="600" height="300">

### Types of Health Probes in Kubernetes

Kubernetes provides three types of health probes:

- **Liveness Probe**.
- **Readiness Probe**.
- **Startup Probe**.

Each probe type has a different purpose. Here’s a breakdown of each:

### Liveness Probe

Liveness Probe check if your container is up and running. If a container fails then liveness probe also fails. Then kubernetes restart the pod again.
This helps ensure that applications are more resilient, automatically recovering from failures and maintaining high availability.

**How Liveness Probes Work**

The liveness probe can be configured to perform three different types of checks:

- **HTTP Request (httpGet)**: Kubernetes sends an HTTP GET request to a specified url in the container. If it receives a success status code (e.g., 200 OK), the container is considered "alive". If it receives an error code (like 500) or no response, it considers the container "dead" or unresponsive.

- **TCP Socket (tcpSocket)**: Kubernetes tries to establish a TCP connection to a specified port on the container. If it successfully connects, the container is "alive." If it can’t connect, it considers the container unhealthy.

- **Command Execution (exec)**: Kubernetes runs a specific command inside the container. If the command completes successfully (returns exit code 0), the container is healthy. If the command fails (returns a non-zero exit code), the container is unhealthy.

**Example Configuration of a Liveness Probe**

  Here’s a simple example of a liveness probe configured in a Kubernetes YAML file:

  ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: example-pod
    spec:
      containers:
      - name: example-container
        image: example-image
        livenessProbe:
          httpGet:
            path: /healthz    # Kubernetes checks this endpoint for health status
            port: 8080
          initialDelaySeconds: 5   # Waits 5 seconds after the container starts before the first check
          periodSeconds: 10        # Checks every 10 seconds
          timeoutSeconds: 2        # Waits 2 seconds for a response before considering it a failure
          failureThreshold: 3      # After 3 consecutive failures, the container is restarted
  ```

Liveness Probe Configuration Parameters:

Each liveness probe has several configuration options that control how Kubernetes performs the health check:

- ```initialDelaySeconds```: This is the delay before Kubernetes performs the first liveness check after the container starts. For example, setting initialDelaySeconds: 5 means the first probe will run 5 seconds after the container starts, giving it time to initialize before being checked.

- ```periodSeconds```: This is the interval between consecutive liveness checks. In our example, it’s set to 10 seconds, meaning Kubernetes will check the container’s health every 10 seconds.

- ```timeoutSeconds```: This is the maximum amount of time Kubernetes waits for a response before marking the probe as failed. If set to 2 seconds, Kubernetes will wait 2 seconds for a response from the health endpoint. If it doesn’t get one, it will count this as a failure.

- ```failureThreshold```: This is the number of consecutive probe failures required before Kubernetes considers the container unhealthy and restarts it. In this example, it’s set to 3, so if the probe fails three times in a row, Kubernetes restarts the container.

**What Happens When a Container Fails the Liveness Probe**

- **Consecutive Failures**: Each time a liveness probe check fails, Kubernetes counts it as a failure. If a probe fails three times consecutively (as per ```failureThreshold: 3```), Kubernetes will restart the container. If it passes even once during this time, the failure count resets to zero.

- **Container Restart**: When the ```failureThreshold``` is reached, Kubernetes stops the existing container and starts a new instance of it. This is done by terminating the container process and launching a new one with the same configuration.

- **Pod Behavior**: This liveness restart is internal to the container, so it doesn’t affect the pod itself. The pod remains in a "Running" state, even if the container within it is restarted multiple times. Kubernetes only restarts the container, not the entire pod.


**Example of Liveness Probe in Action**

Imagine you have a web server container running in a pod, and the web server is configured to respond to http://localhost:8080/healthz to indicate its health status. Here’s how a liveness probe might work:

- **Initialization**: The container starts, and Kubernetes waits for the specified ```initialDelaySeconds``` (say, 5 seconds) before beginning the probe.

- **Health Check Begins**: Kubernetes sends an HTTP GET request to ```http://localhost:8080/healthz``` every 10 seconds (as per ```periodSeconds: 10```).

- **Response Evaluation**:
  - **Healthy Response**: If the container responds with an HTTP 200 OK status within 2 seconds (```timeoutSeconds: 2```), it is considered healthy, and the probe passes.
  - **Unhealthy Response or Timeout**:  If the container fails to respond, responds with an error (like 500), or takes longer than 2 seconds, it fails the probe.

- **Failure Threshold**:  If the probe fails three times in a row (```failureThreshold: 3```), Kubernetes assumes the container is not functioning correctly and automatically restarts it. This action clears any potential issues and gives the application a fresh start.

- **Probe Reset**: After restarting, the failure count is reset. If the container fails again after this, the same process repeats.

The liveness probe is a vital part of Kubernetes health checks, used to detect if a container is "alive" and functioning correctly. By regularly probing with HTTP requests, TCP connections, or commands, Kubernetes can restart any container that fails its liveness probe. This keeps applications stable and helps them recover automatically from failures, maintaining uptime and reliability in your Kubernetes environment.

<br>

### Readiness Probe

The **readiness probe** in Kubernetes is a health check that determines if a container is **ready to serve traffic**. Unlike the liveness probe, which checks if the container is "alive" and working, the readiness probe checks if the container is prepared to handle incoming requests. If a container fails the readiness probe, Kubernetes will stop routing traffic to it until it passes the probe again. This is crucial for ensuring that only fully operational containers are available to handle requests.

**Purpose of the Readiness Probe**

The readiness probe is useful in scenarios where:

- The application requires some time to start up and get ready after the container is running.
- The application might need to connect to external services (like a database) before it can handle requests.
- Temporary issues, like high resource usage or network problems, could make the application unable to handle traffic.

By temporarily marking the container as "not ready" during these conditions, Kubernetes can ensure users don’t experience errors, and other healthy containers can continue to handle requests.

**How the Readiness Probe Works**

The readiness probe can use three different methods to check if a container is ready to serve traffic:

- **HTTP Request (httpGet)**: Kubernetes sends an HTTP GET request to a specific endpoint inside the container (e.g., http://localhost:8080/ready). If the container returns a successful status code (like 200 OK), it is considered "ready." If it returns an error code or no response, it is considered "not ready."

- **TCP Socket (tcpSocket)**:  Kubernetes attempts to open a TCP connection to a specified port on the container. If the connection is successful, the container is considered "ready." If the connection fails, the container is "not ready."

- **Command Execution (exec)**: Kubernetes runs a specified command inside the container. If the command completes successfully (exit code 0), the container is ready. If it fails (non-zero exit code), the container is "not ready."

**Example Configuration of a Readiness Probe**

Here’s a simple example of a readiness probe in a Kubernetes YAML file:

```
  apiVersion: v1
  kind: Pod
  metadata:
    name: example-pod
  spec:
    containers:
    - name: example-container
      image: example-image
      readinessProbe:
        httpGet:
          path: /ready        # Kubernetes checks this endpoint for readiness
          port: 8080
        initialDelaySeconds: 5 # Waits 5 seconds before starting readiness checks
        periodSeconds: 10      # Checks every 10 seconds
        timeoutSeconds: 2      # Waits 2 seconds for a response before marking it as "not ready"
        failureThreshold: 3    # If it fails 3 times, it marks the container as "not ready"
        successThreshold: 1    # Requires only 1 success to mark it "ready" again
```

Readiness Probe Configuration Parameters

Readiness probes have a few configurable settings that control how Kubernetes performs the checks:

- **initialDelaySeconds**: This sets the delay before Kubernetes runs the first readiness check after the container starts. For example, if ```initialDelaySeconds``` is set to 5, Kubernetes will wait 5 seconds after the container starts before checking readiness.

- **periodSeconds**: This defines how often Kubernetes checks the readiness of the container. In this example, it’s set to 10 seconds, meaning Kubernetes will check every 10 seconds.

- **timeoutSeconds**: This is the maximum amount of time Kubernetes waits for a response before considering the probe a failure. If set to 2 seconds, Kubernetes will wait for 2 seconds for a response from the readiness endpoint. If no response is received, the probe is marked as failed.

- **failureThreshold**: This sets the number of consecutive failed checks required before marking the container as "not ready." Here, if the probe fails 3 times in a row, Kubernetes will assume the container is not ready and stop sending traffic to it.

- **successThreshold**: This is the number of consecutive successful checks required before marking the container as "ready" again. By default, it’s set to 1, so a single successful check will mark the container as ready.

**What Happens When a Container Fails the Readiness Probe**

When a container fails the readiness probe:

- **Traffic is Stopped**: If the probe fails, Kubernetes temporarily removes the container from the pool of endpoints that can receive traffic. This means the container stops receiving external requests.

- **Container Remains Running**: The readiness probe failure doesn’t restart or terminate the container. The container keeps running, and Kubernetes keeps checking it periodically.

- **Automatic Recovery**: Once the container starts passing the readiness probe again (after passing the specified ```successThreshold```), it is marked as ready, and Kubernetes begins routing traffic to it again.

- **Pod Status Impact**: A pod remains in a "Running" state even if one or more of its containers are not ready. However, Kubernetes will not send any traffic to a container that fails the readiness check.

**Example Scenario with Readiness Probe**

Imagine you have a container running a web application that requires a connection to an external database before it can serve requests. Here’s how the readiness probe works in this scenario:

- **Initialization**:  The container starts, and Kubernetes waits for the ```initialDelaySeconds``` (e.g., 5 seconds) before starting the first readiness check.

- **Checking Readiness**: Kubernetes sends an HTTP GET request to the container’s ```/ready``` endpoint every 10 seconds (```periodSeconds: 10```).

- **Unready State**:  If the web application hasn’t connected to the database yet, it might return an error status (like 500 Internal Server Error) at ```/ready```, failing the readiness probe. After three consecutive failures (as per ```failureThreshold: 3```), Kubernetes marks the container as "not ready," and traffic is not routed to it.

- **Ready State**: Once the application successfully connects to the database and begins returning 200 OK status at ```/ready```, it passes the readiness check. With one successful probe (as per ```successThreshold: 1```), Kubernetes marks the container as "ready" and starts routing traffic to it.

The readiness probe helps Kubernetes route traffic only to containers that are fully prepared to serve it.

The readiness probe in Kubernetes is a key component for traffic management. By checking if a container is ready to serve requests, Kubernetes ensures only fully functional containers handle user traffic. Configured with parameters like initialDelaySeconds, periodSeconds, timeoutSeconds, failureThreshold, and successThreshold, readiness probes can prevent users from experiencing errors due to unready applications, improve rolling update smoothness, and support efficient resource use in a Kubernetes cluster.

<br>
<br>

### Example (LAB): Liveness probe example

Here’s a step-by-step lab example to demonstrate how to use a liveness probe in Kubernetes. In this lab, we’ll create a simple pod with a container running an application that fails after a certain amount of time. We'll configure a liveness probe to detect this failure and automatically restart the container.

**Lab Prerequisites**

- Kubernetes Cluster
- kubectl

**Lab Steps**

**Step 1: Create a Docker Image with a Failing Application**

For this lab, let’s create a Docker image for a simple application that simulates failure by exiting after a specific time. This can be done using a simple shell script that sleeps for a set period and then exits.

- **Create a New Directory**:

  ```mkdir liveness-lab```

  ```cd liveness-lab```

- **Create the Shell Script (app.sh)**:

  ```
    echo '#!/bin/bash
    echo "Starting application..."
    sleep 15
    echo "Simulating failure..."
    exit 1' > app.sh
    chmod +x app.sh
  ```

  This script will:

  - Print "Starting application..."
  - Sleep for 15 seconds
  - Print "Simulating failure..." and exit with code 1 (simulating a crash).

- **Create a Dockerfile**:

  ```
    FROM alpine:latest
    COPY app.sh /app.sh
    CMD ["/app.sh"]
  ```

- **Build the Docker Image**:

  ```docker build -t liveness-example .```

- **Push the Docker Image to a Registry**:

  Suppose the image has been pushed with name to dockerhub ```puneet/failing-image:latest```.


**Step 2: Create a Kubernetes Manifest for the Pod with a Liveness Probe**

Now that the image is ready, let’s create a Kubernetes manifest that defines a pod running this container, with a liveness probe to check if the container is still "alive."

- **Create a YAML File (liveness-pod.yaml)**:

  ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: liveness-pod
    spec:
      containers:
      - name: failing-container
        image: <your_dockerhub_username>/liveness-example
        livenessProbe:
          exec:
            command: ["sh", "-c", "ps aux | grep app.sh | grep -v grep"]
          initialDelaySeconds: 5
          periodSeconds: 10
  ```

  In this configuration:
  
  - livenessProbe: We’re using an exec liveness probe to check if the app.sh script is still running. The command ps aux | grep app.sh | grep -v grep checks for the process; if it’s not found, the probe fails.
 
  - initialDelaySeconds: We set this to 5 seconds, which means Kubernetes will start the probe 5 seconds after the container starts.
 
  - periodSeconds: The probe runs every 10 seconds.


**Step 3: Deploy the Pod in Kubernetes**

- **Apply the Pod Manifest**:

  ```kubectl apply -f liveness-pod.yaml```

- **Verify the Pod**: Run the following command to see the pod’s status-

  ```kubectl get pods```

You should see the liveness-pod in a Running state initially.

**Step 4: Observe the Liveness Probe in Action**

- **Describe the Pod**: Use kubectl describe to check the details of the liveness probe:

  ```kubectl describe pod liveness-pod```

  This will show the liveness probe settings under the Events section.

- **Watch for Restart Events**: Since our application script intentionally exits after 15 seconds, the liveness probe will detect this and restart the container. Run the following command to watch the restarts in real-time:

  ```kubectl get pod liveness-pod -w```

You’ll see the RESTARTS column increase as Kubernetes detects the failure and restarts the container after each failure.

**Step 5: Verify Logs to See Probe Actions**

- **Check Container Logs**: View the logs to see how the application behaves, and you’ll notice the script restarting every time it fails:

  ```kubectl logs liveness-pod -c failing-container```

  This should output:

  ```
    Starting application...
    Simulating failure...
  ```

  Every restart cycle will repeat this message, showing that the container has been restarted.


**Explanation of How the Liveness Probe Works in this Example**

- The container runs a script that simulates a failure by exiting after 15 seconds.
- The liveness probe runs an exec command (ps aux | grep app.sh | grep -v grep) every 10 seconds to check if the app.sh script is running.
- When the script exits (and thus fails), the liveness probe fails because the ps aux command won’t find app.sh.
- After three consecutive failed probes (based on default failureThreshold), Kubernetes restarts the container, giving it a fresh start.

