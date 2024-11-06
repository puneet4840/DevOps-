# Static pod in kubernetes

We know that scheduler schedule the pods on the worker nodes if new pod is going to be created. So, In general control plane components are responsible to create a pod on worker node. 

Control plane components run as a pod inside master node. So these important components are running as a pod. So who is responsible for these pods. I mean who is managing these pods. Here comes the concept of static pod.

### What is Static Pod?

Static pod is the component of control plane that is not managed by the schedular. Schedular is not respondible for these type of pods. So **Kubelet** component on the control plane is managing these important pods. The main task of static pod is make sure control plane components should be always up and running.

We can say that static pod is the yaml manifest which are present in ```/etc/kubernetes/manifests/```.

A static pod in Kubernetes is a type of pod that is directly managed by the Kubernetes kubelet on a specific node rather than by the Kubernetes control plane (like the API server, controller manager, etc.). Unlike regular pods, which are created by controllers like Deployments or DaemonSets, static pods are managed by the kubelet itself. 

Static pods differ from other Kubernetes objects because:

- **They are not managed by the API server**: The kubelet directly manages the lifecycle of static pods on each node.
- **The kubelet only reads static pod configurations**: The kubelet checks the pod configuration file on the node’s filesystem and uses it to create and manage the pod.

<br>

### Why use static pod?

Static pods are typically used for running critical system components or tasks on a node where you need them to always run, even if the control plane is down. Here are some common use cases:

- **Node-specific monitoring**: Run a logging or monitoring tool directly on each node.
- **Critical services must always be running on a specific node**: You might want to ensure that certain services are always running on a given node, even if the Kubernetes control plane is unavailable.

Static pods ensure that essential components on a node continue to run even if the control plane is temporarily down, making them useful for node-specific tasks that don’t need to be scheduled across the whole cluster.

<br>

### How Static Pods Work

- **Configuration File**: Static pods are defined by YAML configuration files located on each node. Typically, these files are stored in a directory like ```/etc/kubernetes/manifests/```.

- **Kubelet Reads Configurations**: The kubelet regularly scans this directory for configuration files. When it finds a new pod configuration file, it creates the pod on the node.

- **Direct Management**: The kubelet manages the static pod directly, restarting it if it fails.

- **No API Server Representation**: Static pods do not have an API object managed by the Kubernetes API server. However, a mirror pod is automatically created in the API server for informational purposes, allowing users to view the pod status via kubectl.

<br>

### Example (LAB): Creating a Static Pod

Let’s say you want to run an Nginx web server as a static pod on a node to serve a simple webpage.

- **Write the Configuration File**: Create a file called static-nginx-pod.yaml with the following content:

  ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: static-nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
  ```

  - This configuration defines a pod named ```static-nginx```.
  - The pod has a container running the ```nginx:latest``` image, which will serve HTTP requests on port 80.

- **Save the File on the Node**: Save this file in the directory ```/etc/kubernetes/manifests/``` on the node where you want to run the pod. This directory is where the kubelet looks for static pod configurations.

- **Kubelet Creates the Pod**: The kubelet on that node reads the file, creates the ```static-nginx``` pod, and keeps it running. If the pod crashes, the kubelet will restart it.

- **View the Pod**: Even though this pod isn’t managed by the Kubernetes API, you can still see it using kubectl commands because of the mirror pod created in the API server:

  ```kubectl get pods -o wide```

  You should see the s```tatic-nginx``` pod listed, showing it’s running on the node.

- **Deleting the Pod**: To delete the static pod, simply delete the ```static-nginx-pod.yaml``` file from ```/etc/kubernetes/manifests/```. The kubelet will notice the file is gone and will stop the pod.


<br>

### Mirror Pods

When the kubelet creates a static pod, it also creates a mirror pod in the Kubernetes API. This mirror pod allows you to see the static pod’s status using ```kubectl```, even though the pod isn’t actually managed by the API server.

For example, when you run ```kubectl get pods```, you’ll see the static pod listed, but it will have a special annotation marking it as a mirror pod.


### Real-Life Use Case: Running a Monitoring Agent as a Static Pod
