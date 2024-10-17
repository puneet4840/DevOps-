### How does Kubernetes works - step by step.

- Step-1: **User Sends a Request to the Cluster**

  Imagine you want to deploy a web application. You write a configuration file (usually a YAML file) that defines:
    - What container image your application will use.
    - How many instances (pods) you want running.
    - Any other settings like storage, networking, etc.

<br>

- Step-2: **API Server in the Control Plane**

  The **API Server** is the component that receives user requests. It acts as a bridge between users and the internal workings of the cluster.
    - When you submit the configuration file, the API Server stores the desired state (what you want to happen) in a database called **etcd**.

<br>

- Step-3: **Scheduler**

  Next, the Scheduler comes into play. Its job is to look at the current state of the cluster and decide on which worker nodes to run your application. The scheduler finds the most suitable node by considering:
    - Available resources (CPU, memory, etc.).
    - Where it makes sense to place your application for load balancing.

<br>

- Step-4: **Controller Manager**

  The **Controller Manager** ensures that the actual state of the cluster matches the desired state. For example, if you requested 3 instances of your web app (pods) and only 2 are running, the controller manager will instruct Kubernetes to create another po d to meet the target of 3.
    - It continuously watches over the cluster and takes action if something goes wrong, like restarting failed pods or scaling applications up and down.

<br>

- Step-5: **Pods and Containers**

  Once the control plane has decided where to run your application, the **Kubelet** (an agent running on each worker node) ensures that the **pod** (a group of containers) for your web app is created and running.
    - A **pod** is the smallest deployable unit in Kubernetes. Each pod contains one or more **containers**.
    - Kubernetes then runs your application in the container (which is your web app).
  
<br>

- Step-6: **Networking (Service Discovery)**

  Kubernetes also handles **networking** to ensure your applications can communicate with each other, and users can access them. It creates an internal IP for each pod, but since these IPs can change, Kubernetes uses something called **Services** to give your application a stable endpoint (like a load balancer or DNS entry).

  So, when a user tries to access your web application (e.g., from a web browser), Kubernetes routes the request to the correct pods via the service, ensuring the application is reachable.
    
