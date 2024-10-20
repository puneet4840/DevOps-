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
    
<br>
<br>

<hr>

### Setting up Multi-Node Kubernetes Cluster (Kind Cluster) in our Local Machine.

Here, we are going to setup Multi node Kubernetes cluster on our local machine using Kind. We are going to do practical using this Kind cluster.

**What is Kind?**

Kind stand for **Kubernetes in Docker** is a tool for running local kubernetes cluster using docker containers in your local machine. This tool is used to experience and test kubernetes in your local environment. It runs in your docker container. It spin up a docker container and each docker container is treated as a node. Then you can use those nodes as your control plane and worker node.

**Prerequisite before using Kind**
  - Docker should be installed.
  - Kubectl should be installed: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
  - kind should be installed: https://kind.sigs.k8s.io/docs/user/quick-start/

**Documentation for using kind**

  - https://kind.sigs.k8s.io/docs/user/quick-start/

<br>

**Create Kubernetes Cluser**

To create kubernetes cluster we have to create Master node and Worker node. Kind tool first creates the Master Node which run as a seperate container then it creates the worker node which run as a seperate container. 

1 - Create Master node with latest kubernetes version

  ```kind create cluster --name <cluster_name>``` : This command directly create the master node with latest kubernetes version.

  ```
  kind create cluster --name my-cluster
  ```

2 - Create Master node with any selected kubernetes version

  ```kind create cluster --image <version_name> --name <cluster_name>``` : This command will create a k8s cluster with your specified version. 

  ```
  kind create cluster --image kindest/node:v1.29.8@sha256:d46b7aa29567e93b27f7531d258c372e829d7224b25e3fc6ffdefed12476d3aa --name my-cluster
  ```

  <version_name>:- You can take the version name from the given link https://github.com/kubernetes-sigs/kind/releases
