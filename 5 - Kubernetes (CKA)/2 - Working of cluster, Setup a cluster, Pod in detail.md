## How does Kubernetes works - step by step.

- Step-1: **User Sends a Request to the Cluster**

  Imagine you want to deploy a web application. You write a configuration file (usually a YAML file) that defines:
    - What container image your application will use.
    - How many instances (pods) you want running.
    - Any other settings like storage, networking, etc.

- Step-2: **API Server in the Control Plane**

  The **API Server** is the component that receives user requests. It acts as a bridge between users and the internal workings of the cluster.
    - When you submit the configuration file, the API Server stores the desired state (what you want to happen) in a database called **etcd**.


- Step-3: **Scheduler**

  Next, the Scheduler comes into play. Its job is to look at the current state of the cluster and decide on which worker nodes to run your application. The scheduler finds the most suitable node by considering:
    - Available resources (CPU, memory, etc.).
    - Where it makes sense to place your application for load balancing.


- Step-4: **Controller Manager**

  The **Controller Manager** ensures that the actual state of the cluster matches the desired state. For example, if you requested 3 instances of your web app (pods) and only 2 are running, the controller manager will instruct Kubernetes to create another po d to meet the target of 3.
    - It continuously watches over the cluster and takes action if something goes wrong, like restarting failed pods or scaling applications up and down.


- Step-5: **Pods and Containers**

  Once the control plane has decided where to run your application, the **Kubelet** (an agent running on each worker node) ensures that the **pod** (a group of containers) for your web app is created and running.
    - A **pod** is the smallest deployable unit in Kubernetes. Each pod contains one or more **containers**.
    - Kubernetes then runs your application in the container (which is your web app).
  

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

### Create Kubernetes Cluster

To create kubernetes cluster we have to create Master node and Worker node. Kind tool first creates the Master Node which run as a seperate container then it creates the worker node which run as a seperate container. 

**Create a Multi-Node kubernetes cluster**

Multi-node kubernetes cluster means one master node (control-plane) and multiple worker nodes.

To create multi-node cluster, we have to create a yaml file.

**Step-1:- Create a Yaml file (cluster_config.yaml)**: Suppose we are creating cluste with one master node and two worker node

  ```
  kind: Cluster
  apiVersion: kind.x-k8s.io/v1alpha4
  nodes:
    - role: control-plane
    - role: worker
    - role: worker
  ```

**Step-2:- Create a cluster using that yaml file (cluster_config.yaml) with 1.29 version**

 ```kind create cluster --image kindest/node:v1.29.8@sha256:d46b7aa29567e93b27f7531d258c372e829d7224b25e3fc6ffdefed12476d3aa --name my-cluster --config cluster_config.yaml```


Note: To create a cluster with latest verson, you can remove the --image from the above command.

**Kubernetes Commands Cheat Sheet**: https://kubernetes.io/docs/reference/kubectl/quick-reference/

<br>
<hr>

### Pod in Kubernetes.

A pod is the smallest and most basic unit of deployment.

**What is a Pod?**

- Think of a pod as a small package or container for your application.

- Inside this pod there can be one or more **containers**, which are lightweight environment for running applications. Most of time each pod contains just single container, but is special case it may contain multiple containers that work very closely together.

- Pods are designed to be disposable; they can be created, destroyed, and replaced quickly, which helps keep your applications flexible and resilient.

**Purpose of Pod**

- Pods are like wrappers for your application’s container(s), providing them with resources such as storage, networking, and instructions on how to run.
- Each pod is assigned an IP address, allowing it to communicate within the Kubernetes cluster.

**How pod works?**

- Pods are created and managed by controllers (like Deployments) in Kubernetes. These controllers handle pod replication and scaling, as well as replacement if something goes wrong.
- Each pod runs on a worker node (a virtual or physical machine in the Kubernetes cluster).
- Kubernetes schedules pods onto nodes based on available resources, so pods can run on different nodes within the same cluster.

**Example: How a Pod Fits in Kubernetes Workflow**

- Imagine you have a simple web application you want to run on Kubernetes.
- First, you define your pod in a YAML file with details about the container image, port, and resources.
- You then apply this YAML file to Kubernetes, and a controller will create the pod for your application.
- Kubernetes schedules the pod to run on a node, assigning it an IP address, and provides network and storage access as configured.
- If traffic increases, you can configure Kubernetes to replicate your pod, adding more instances to handle the load.

<br>

**Ways to create a pod in kubernetes**

There are two ways to create a pod in kubernetes:-

- Imperative: In imperative way we simply write the kubectl command to create a pod such as "Kubectl create pod nginx-server --image nginx:latest". This is the way we create a pod using imperative way.
  
- Declarative: In declarative way we create yaml file where we define the pod's specification then we apply the yaml file to create a pod such as "kubectl apply -f pod-config.yaml". This is the way we create a pod using or create any resource in kubernetes using declarative way.


We create pod or any resource in kubernetes using the yaml file. This is the best practise. So we need to know about how to create resource using yaml file. 

In the next section we are going to learn it.

<br>
<hr>

### YAML in Kubernetes.

YAML stand for **Yet Another Markup Language**. 

It is a data format that is easy to read and write. It uses indentation to structure data. It is a case-sensitive language.

Yaml files have '''.yaml''' or '''.yml''' extensions.

In kubernetes, YAML is used to describe what we want to create run in the cluster.

**Basic YAML Syntax**

- YAML uses key-value pair: Each entry is the combination of a key and a value.

- It uses indentation to define the scope of data type.

- YAML supports data-types:
    - **Strings**: Text values. It can be represented by double cotes or withour double cotes.

      e.g.,
      ```
        name: "Puneet"
        company: Nagarro
      ```
      
    - **Numbers**: Plane numeric values.

      e.g.,
      ```
        age: 25
        price: 100
      ```
      
    - **Lists**: Represented with '''-''' for each item.
 
      e.g.,
      ```
        subjects:
          - "English"
          - "Maths"
          - "Science"
      ```
 
    - **Dictionaries**: Represented by indentation.
 
      e.g.,
      ```
        subjects:
          "English"
          "Maths"
          "Science"
      ```

**e.g.,** Complete example of above yaml syntax

```
name: "MyApp"           # This is a string value
version: 1.0            # This is a numeric value
features:               # This is a list
  - authentication
  - notifications
  - payments
configurations:         # This is a dictionary
  theme: "dark"
  language: "English"

```

<br>

**Why YAML in Kubernetes?**

Kubernetes uses YAML files to define the desired state of your infrastructure and applications. When you apply a YAMl configuration, Kubernetes interprets it to create, update and delete resources like Pods, Deployments and Services.

  - Common Kubernetes Resources:
      - Pod: Smallest unit in deployment.
      - Deployment: Manages replicas of a pod for availability.
      - Service: Exposes pod to the network so they can be accessed.

<br>

**Basic Structure of Kubernetes YAML file**

Kubernetes YAML file has 4 main sections:-

- **apiVersion**: It specifies the version of kubernetes api.

- **kind**: It tells why type of resource we are creating like Pod, Deployment, service.

- **metadata**: It gives our resource a name and labels to identify it.

- **spec**: It defines the desired state of our resource like what specifications our resource should have.


**Step-by-step writing a kubernetes YAMl file**

A simple pod YAML. This pod running as a nginx container.

```
apiVersion: v1                    # API version
kind: Pod                          # We're creating a Pod
metadata:
  name: my-first-pod               # Name of the Pod
  labels:
    app: myapp                     # Label for organizational purposes
spec:
  containers:
    - name: my-container           # Name of the container
      image: nginx:latest          # Docker image to use
      ports:
        - containerPort: 80        # Port to expose within the container

```

We can create any customized key-value pair inside the labels of our choice.

Once you create a YAML file, you can apply it to your kubernetes cluster.

- Save the file, e.g., ```pod.yaml```.
- Run the below command to apply it.
    - ```kubectl apply -f pod.yaml```.

- Verify it's running using below command.
    - ```kubectl get pods```.
