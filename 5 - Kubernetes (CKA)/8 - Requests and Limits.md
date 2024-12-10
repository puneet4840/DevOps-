# Requests and Limits in Kubernetes

```Pods के अंदर container या application run होती है और इस application को node पर run होने के लिए कुछ CPU और Memory (RAM) की जरुरत होती है| Suppose आपके पास 2 applications हैं, उन दोनों को एक node पर run होना है तो आपने दोनों applications को run किया तो application-1 को node पर run होने के लिए 2 CPU और 500 mi memory की जरुरत होती है लेकिन application-2 को node पर run होने के लिए few esources की जरुरत होती है| तो होता क्या है की application-1 पर load बढ़ जाता है और application-1 को और CPU और Memory की जरुरत है तो ऐसे मैं resources की कमी की वजह से application-1 crash हो जायेगा| तो इसके लिए हम Requests और Limits का use करते हैं जिससे हर application ज्यादा resources use न कर सके|```

Requests and Limits are the resource configuration in kubernetes which is used to manage and control how much CPU and Memory (RAM) each container within a Pod can use.

```
OR
```

Requests and Limits are the settings which apply for pod to control how much CPU and Memory (RAM) each container within a pod can use.

Requests and limits help you make sure no one app takes too much and leaves others struggling.

### What are Requests?

A request is the minimum amount of CPU and Memory(RAM) an app(container) needs to work properly.

When you set a request, you're saying, "This app needs at least this much power (CPU) and space (memory) to run smoothly."

- If a node has enough resources to meet the requests of a Pod, it will schedule the Pod to run on that node.

- Requests are considered when Kubernetes decides where to place a Pod. If the total requested resources of all containers in a Pod exceed what’s available on a node, Kubernetes won’t schedule the Pod on that node.

**Example of CPU and Memory Requests**

Suppose you set a **CPU request** of 200m (200 millicores) and a **memory request** of 256Mi (256 megabytes). This means:

  - Kubernetes will try to place this container on a node that has at least 200 millicores of CPU and 256Mi of memory free.
  - Kubernetes will only put the app on a machine that has at least these requested resources available.

### What are Limits?

A limit in Kubernetes defines the maximum amount of CPU or memory that a container can use. 

By setting a limit, you make sure that no app uses too much power or memory, which could cause other apps to slow down or stop working.
  - If a container tries to use more than its CPU limit, Kubernetes will throttle it, which means it will reduce the container’s CPU usage to prevent it from exceeding the limit.

  - If a container exceeds its memory limit, Kubernetes will terminate (or “kill”) it. This is because exceeding memory limits can cause serious issues on a node, like memory shortage, so it’s strictly enforced.

**Example of CPU and Memory Limits**

Let’s say you set a CPU limit of ```500m``` and a memory limit of ```512Mi``` for a container. This means:
  - The container will not be allowed to use more than 500 millicores of CPU.
  - If the container tries to use more than 512Mi of memory, Kubernetes will kill it to prevent memory overuse.

  This ensures no single container takes up too many resources, which could cause other containers to struggle with resource availability.


### Setting Requests and Limits

Requests and limits can be set in the configuration file (YAML) when defining a Pod or Deployment.

  ```
    apiVersion: v1
    kind: Pod
      metadata:
        name: example-pod
    spec:
      containers:
      - name: example-container
        image: nginx
        resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
          limits:
            memory: "512Mi"
            cpu: "500m"
  ```

  In this example:
  - **Request**: The container is guaranteed 200m CPU and 256Mi memory.
  - **Limit**: The container cannot exceed 500m CPU and 512Mi memory.

### Why Use Requests and Limits?

  - **Prevent Resource Overuse**: Limits prevent one container from using all available resources, ensuring fair distribution across the cluster.
    
  - **Ensure Resource Availability**: Requests make sure that each container has the resources it needs to run efficiently.
    
  - **Efficient Scheduling**: Requests help Kubernetes decide where to place Pods, ensuring that nodes have enough resources for each Pod.
    
  - **Stability**: Preventing overuse and managing resources keeps applications stable and prevents unexpected crashes due to resource shortages.


### CPU and Memory Measurement Units

  - **CPU**: Measured in units called millicores. ```1000m``` (1000 millicores) is equivalent to 1 CPU core. ```500m``` would be half of a CPU core.

  - **Memory**: Measured in bytes, with common shorthand:
      - ```Mi``` (Mebibyte(MiB), equivalent to 1024 * 1024 bytes).
      - ```Gi``` (Gibibyte(GiB), equivalent to 1024 * 1024 * 1024 bytes).

  **Explaination of MiB and GiB**

  In Kubernetes, you’ll see terms like MebiByte (MiB) and GibiByte (GiB) when setting memory sizes, like in resource requests and limits. These terms may look a little different from the more familiar Megabyte (MB) and Gigabyte (GB).

  **What is a MebiByte (MiB)?**

  - A MebiByte (MiB) is a unit of data measurement, similar to a Megabyte (MB), but it’s based on powers of 2 instead of 10. Here’s how they compare:
      - 1 Megabyte (MB) = 1,000,000 bytes (10^6).
      - 1 MebiByte (MiB) = 1,048,576 bytes (2^20).

    So, 1 MiB is a little bit larger than 1 MB because it uses a binary base (2^20), while MB uses a decimal base (10^6).

  **What is a GibiByte (GiB)?**

  - A GibiByte (GiB) is similar to a Gigabyte (GB), but again, it’s based on powers of 2 instead of 10:
      - 1 Gigabyte (GB) = 1,000,000,000 bytes (10^9).
      - 1 GibiByte (GiB) = 1,073,741,824 bytes (2^30).
   
    So, 1 GiB is slightly larger than 1 GB for the same reason as above: it uses a binary base (2^30) instead of a decimal base (10^9).


  **Why Does Kubernetes Use MiB and GiB?**

  Kubernetes uses MiB and GiB to clearly show that it’s working with binary values, which align more closely with how computers process data. Computers operate using binary (base-2) units, so using MiB and GiB is a more precise way to specify memory amounts that computers actually use.

  For example, if you set a memory request of 512Mi in Kubernetes, you’re saying you want 512 MebiBytes of memory, which is 512 x 1,048,576 bytes (approximately 536.87 MB).

  - MebiByte (MiB): Based on binary (2^20 = 1,048,576 bytes), slightly larger than 1 MB.
  - GibiByte (GiB): Based on binary (2^30 = 1,073,741,824 bytes), slightly larger than 1 GB.


<br>

### How Requests and Limits Impact Kubernetes

Let’s consider a few scenarios to see how these settings work in real situations:

- **Scenario 1: Under the Limit and Request**
    - Requests: CPU: 200m, Memory: 256Mi
    - Limits: CPU: 500m, Memory: 512Mi

    If the container uses 300m CPU and 300Mi memory. It’s within the limits and above the requests, so it continues running without any issues.

- **Scenario 2: Exceeding the Limit**
    - Requests: CPU: 200m, Memory: 256Mi
    - Limits: CPU: 500m, Memory: 512Mi

    If the container tries to use 600m CPU and 600Mi memory:
    - Kubernetes will throttle the container to keep it under 500m.
    - Kubernetes will terminate the container for trying to use more than 512Mi of memory.

### Default Behavior if Requests and Limits are Not Set

If you don’t set requests and limits, Kubernetes will:

  - Schedule the Pod based on available resources, but there’s no guarantee the container will have a certain minimum.

  - Allow the container to use resources as needed, potentially taking up a lot of resources and affecting other applications.

<br>
<br>

### Example (LAB): Running a Web Application in Kubernetes

Suppose you are deploying a small web application in a Kubernetes cluster. The application has predictable memory usage, and you want to ensure that each pod:
  - Has enough memory to run smoothly.
  - Does not exceed a certain amount of memory, which could impact other applications running in the cluster.

- **Step-1: Define the Deployment YAML File**

  Create a YAML file named ```webapp-deployment.yaml```. This file will define your web application and include the memory requests and limits.

  webapp-deployment.yaml:

  ```
    apiVersion: apps/v1
    kind: Deployment
      metadata:
        name: webapp
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: webapp
      template:
        metadata:
          labels:
            app: webapp
        spec:
          containers:
          - name: webapp-container
            image: nginx   # We'll use NGINX as a sample web application
            resources:
              requests:
                memory: "512Mi"   # Request 512 MiB of memory
              limits:
                memory: "1Gi"     # Limit memory usage to 1 GiB
            ports:
            - containerPort: 80
  ```

  In this YAML file:

    - We’re deploying a web application using the NGINX container image.
    - We set 2 replicas to create two identical pods running the application.
    - We define memory requests and limits for the container.

  **Memory Requests and Limits Explanation**

    - Request: 512Mi — This is the minimum amount of memory Kubernetes guarantees for each pod. It will try to ensure each pod gets at least 512 MiB (approximately 536 MB).
 
    - Limit: 1Gi — This is the maximum memory each pod can use. If a pod tries to use more than 1 GiB (approximately 1024 MB), it may be terminated or restarted.
 
- **Step 2: Apply the YAML File to Your Cluster**

  - Save the ```webapp-deployment.yaml``` file.
  - Run the following command to apply the deployment configuration to your cluster:

      ```kubectl apply -f webapp-deployment.yaml```
    
    This command creates the deployment in the Kubernetes cluster.


- **Step 3: Verify the Deployment**

  To confirm that your deployment is running, you can check the pods created by Kubernetes:

    ```kubectl get pods```

  You should see two pods running since we set the replicas to 2.


- **Step 4: Monitor Memory Usage**

  To see memory usage in real-time, you can use the following commands:

    - Get Pod Details:
  
      ```kubectl describe pod <pod-name>```

    - View Resource Usage (if you have metrics-server installed):
 
      ```kubectl top pod```

      This command will show you the current memory usage for each pod. You’ll notice that each pod is using some portion of its 512 MiB request and should not exceed the 1 GiB limit.

- **Step 5: Simulate High Memory Usage (Optional)**

  If you want to test what happens when a pod tries to exceed its memory limit, you could:

    - Run a memory-intensive process inside the container, which might cause it to exceed the 1 GiB limit.
 
    - Watch how Kubernetes reacts—typically, it will terminate and restart the container if it exceeds the set limit.
