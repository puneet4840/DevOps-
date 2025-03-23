### What is Deployment?

Deployment is the process in kubernetes which is responsible for controlling the behavior of a pod.

```OR```

Deployment is the process that is used to manage your pods. Because deployment file has the specification related to the pod.

```Deployment actually kubernetes cluster को Auto - Healing, Auto - Scaling जैसे features provide करता है क्युकी एक deployment YAML file मैं Pod के बारे मैं Auto - Healing, Auto - Scaling, कोनसी container image use करनी है, कोनसे port पर container run करना है. ये सारी information deployment YAML file मैं लिखी होती है.```

```जैसे हम चाहते हैं की Node मैं pod के 2 replica होने चाइये. तो इस specification को हम deployment.yaml file मैं mention कर देंगे फिर replica-set 2 pods बना देगा.```

A **Deployment** in Kubernetes is a way to define the desired state of an application. It manages how your application is run, updated, and scaled, automating the creation and management of application instances.

<br>

**Note**: The standard rule is we only create the deployment then pod is created after the deployment automatically. We don't need to create a pod itself using yaml file. We only create deployment.

**How does deployment works?**

Generally we do not create pod directly rather we create the deployment, that deployment contains pod's specification in deployment.yaml file.
To create deployment we need deployment.yaml file. When we create deployment then ReplicaSet is created by the deployment automatically, than that ReplicaSet create the pods and maintain the state.

<br>

**e.g.,** Sample deployment.yaml file nginx application.
```
# deployment.yaml
apiVersion: apps/v1             # The API version for the Deployment resource
kind: Deployment                # This is a Deployment object
metadata:
  name: nginx-deployment         # The name of the Deployment
spec:
  replicas: 3                   # Number of Pods we want running at any given time
  selector:
    matchLabels:
      app: nginx                # Label selector to find and manage Pods
  template:
    metadata:
      labels:
        app: nginx              # Label assigned to each Pod
    spec:
      containers:
      - name: nginx
        image: nginx:latest     # The Docker image for our web server
        ports:
        - containerPort: 80     # The port Nginx will listen on inside the container

```

**Explaination of each section of YAML file**:

- ```# deployment.yaml```

    This line is a comment that shows the filename. Comments are only meant for humans reading the file and are ignored by Kubernetes.

- ```apiVersion: apps/v1```

    The **apiVersion** field defines which version of the Kubernetes API is used to create this Deployment. The API version can change over time as Kubernetes improves, so we specify apps/v1 here to use the most current Deployment API.

- ```kind: Deployment```

    The **kind** field tells Kubernetes what type of resource we are creating. In this case, Deployment means Kubernetes will treat this as a Deployment object. Other options could be Pod, Service, etc., but Deployment is used to manage multiple identical Pods.

- ```
    metadata:
      name: nginx-deployment  
  ```

    The metadata section contains identifying information about the resource. Here, we specify a name nginx-deployment. This name is how Kubernetes identifies this Deployment among all other resources. Names help us manage and refer to resources easily.

- ```
    spec:
      replicas: 3 
  ```

    The spec section defines the details of the Deployment. Here, we set replicas: 3, which means we want three identical Pods running at any time. Kubernetes will make sure there are three Pods by creating new ones if they crash or are deleted. These Pods are instances of the application managed by the Deployment.

- ```
    selector:
      matchLabels:
        app: nginx 
  ```

    The selector field is a set of rules that help the Deployment find and manage its Pods. In this case, the selector app: nginx looks for Pods that are labeled with app: nginx so it knows which ones to control. This selector and the Pod template labels (in the template section) must match for the Deployment to manage the Pods correctly.

- ```
     template:
      metadata:
        labels:
          app: nginx 
  ```

    The template section describes the configuration of each Pod that will be created by the Deployment. It contains both metadata for identifying the Pods and a spec section that defines the Pod’s contents (containers, images, ports, etc.).

    The metadata in the template has labels which act like tags for each Pod. This label app: nginx must match the selector defined above (matchLabels: app: nginx) so the Deployment knows to manage Pods with this label.

- ```
    spec:
      containers:
  ```

    The spec field under the Pod template defines how each Pod will be set up. In Kubernetes, a Pod can contain one or more containers. Containers are the smallest deployable units in Kubernetes, and each container runs an application.

**Container Definition**

  ```- name: nginx```

  The name field here names the container nginx. Naming a container is helpful for tracking, especially if there are multiple containers in a Pod.

  ``` image: nginx:latest```

  The image field specifies the Docker image that the container should use. Here, nginx:latest is the version of the Nginx image. An image is a lightweight, standalone, and executable software package that includes everything needed to run a piece of software.

  ```
      ports:
        - containerPort: 80  
  ```

  The ports section opens up specific ports on the container. The line containerPort: 80 means that inside the container, Nginx will listen for requests on port 80, which is the standard HTTP port for web servers.

**How Kubernetes uses this above YAML file**

- **Create and Configure a Deployment**:  When this YAML file is applied in Kubernetes (```using kubectl apply -f deployment.yaml```), Kubernetes will create a Deployment named ```nginx-deployment```.

- **Spawn and Manage Pods**: The Deployment will create **3 Pods**, each with the label ```app: nginx```, and keep them running as defined by the ```replicas: 3``` field.

- **Handle Pod Failures**: If any Pod crashes, Kubernetes will automatically create a new one to maintain 3 replicas.

- **Selectors and Labels**: The selector helps the Deployment keep track of only the Pods with the label app: nginx. If the Pods created do not match this label, Kubernetes won’t manage them as part of this Deployment. Let the Deployment know which Pods to manage.

### Example: Detailed Explaination - What Happens When We Apply a Deployment with replicas: 3 in Kubernetes?

When you create a Kubernetes Deployment with replicas: 3, Kubernetes ensures that exactly three Pods are always running, even if one crashes or is deleted.

- **Step 1: User Applies Deployment YAML**:

  ```
  kubectl apply -f deployment.yaml
  ```

  the following sequence of events occurs:

- **Step 2: Request Reaches API Server**:
  - The kubectl apply command sends an HTTP POST request to the Kubernetes API Server (kube-apiserver).
  - The API Server validates the YAML file to ensure it is syntactically correct.
  - The request is stored in etcd (the cluster’s distributed key-value store).
  - The API Server acknowledges the request and updates the cluster state.
 
- **Step 3: API Server Informs the Controller Manager**
  - The Controller Manager continuously watches for changes in Deployments.
  - It detects that a new Deployment (replicas: 3) has been created or updated.
  - The Controller Manager creates a new ReplicaSet for this Deployment.

- **Step 4: ReplicaSet Ensures Desired Pod Count**
  - The ReplicaSet controller detects that zero Pods exist but three are required (replicas: 3).
  - It creates three new Pods based on the template in the Deployment YAML.
  - The API Server registers these new Pods in etcd.

- **Step 5: Scheduler Assigns Pods to Nodes**
  - Each new Pod is initially in a Pending state.
  - The Kubernetes Scheduler detects these new unassigned Pods.
  - It checks for available worker nodes based on:
    - Resource availability (CPU, Memory).
    - Node selectors, tolerations, and taints.
    - Affinity/anti-affinity rules (if defined).
  - It selects the best Node for each Pod and assigns it.
  Now, the API Server updates the Pod objects with their assigned Worker Nodes.

- **Step 6: Kubelet Pulls the Image and Starts the Containers**
  - Each Worker Node runs a process called Kubelet, which is responsible for managing Pods.
  - The Kubelet on each assigned Node detects that a new Pod has been scheduled.
  - It reads the Pod specification and pulls the container image (e.g., nginx) from the configured container registry (Docker Hub, Azure Container Registry, etc.).
  - Once the image is downloaded, Kubelet:
    - Starts the container using the Container Runtime (Docker, containerd, etc.).
    - Mounts any defined volumes.
    - Configures networking (attaches it to the correct Service if defined).
  - At this point, the Pods are running, but Kubernetes needs to check if they are truly ready.
 
- **Step 7: Pod Becomes Ready and Exposed**
  - The Pod runs a health check (livenessProbe, readinessProbe if defined).
  - Once the checks pass, Kubernetes marks the Pod as "Ready".
  - If a Service is defined for this Deployment, the new Pods are added to the Service’s Endpoint List.
  - Traffic can now be distributed among the three running Pods.
 
- **Step 8: Ongoing Monitoring & Self-Healing**
  - The ReplicaSet controller keeps watching the Pod count.
  - If a Pod crashes or gets deleted, the ReplicaSet automatically creates a new one.
  - The entire system remains in a self-healing state.


<br>

### Difference between Container, Pod and Deployment.

- **Container**: ```हम containers बनाते हैं तो command लिखकर बनाते हैं जैसे "docker run -itd -p 3000:3000 image_name .", जो की docker tool का use करके create हैं. Container सिर्फ एक runtime environment है.```

- **Pods**: ```जब kubernetes market मैं आया तो kubernetes ने decide  किया की हम container बनाने के लिए enterprise model को use करें इसका मतलब है की container बनाने के लिए हम command का use न करके एक file के अंदर वही सब लिख लेते हैं जो container बनाने के लिए docker मैं commands लिखते हैं. तो pod एक running specification होता है ```

- **Deployment**: ```Kubernetes ने pod तो बना लिया अब pod को Auto-Heal, Auto-Scale कैसे किया जाये. तो यहाँ deployment process का use किया जाता है. एक deployment.yaml file बनाई जाती है, जिसमे pods की specification और Auto-Scaling के बारे मैं लिखा होता है. तो deployment यहाँ replica set के साथ मिलकर auto - scaling करता है. ```

<br>
<br>

### What is Replica-Set?

A replica set is a controller in the kubernetes that make sure the specified number of pods should be running in your kubernetes cluster.

```यह एक controller होता है को kubernetes cluster की actual state को desired state बनाने का काम करता है. जो configuration deployment.yaml file मैं लिखी जाती है, उसी desired state को replica-set cluster के अंदर maintain करता है.```

A **ReplicaSet** in Kubernetes ensures a specified number of Pods (instances of your application) are running at any time.

**Features of ReplicaSet**

- **Maintains Pod Count**: If you specify that three Pods should be running, the ReplicaSet will create new ones if any go down.

- **Part of Deployment**: Usually, you don’t manage a ReplicaSet directly. When you create a Deployment, it automatically creates and manages the ReplicaSet for you.


**How does it works?**

In Kubernetes, the **Deployment** and the **ReplicaSet** work closely together to manage and maintain the desired number of running Pods, ensuring availability and consistency. When you create a Deployment, Kubernetes automatically creates and manages a ReplicaSet to make sure that the desired number of Pods are running at all times.

- **Creating a deployment**

  When you create a **Deployment** using a YAML file (such as ```deployment.yaml```), you define several things:

  - Number of replicas (how many Pods you want running).
  - Pod template (how each Pod should be set up, including container image and other configurations).

  For example, consider the following YAML file:

  ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my-deployment
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: my-app
      template:
        metadata:
          labels:
            app: my-app
        spec:
          containers:
          - name: my-container
            image: my-image

  ```

  In this file:
  - We’re asking Kubernetes to create a Deployment named my-deployment.
  - We want 3 replicas of the Pods to be running.
  - We provide a template that describes how each Pod should be created (e.g., with the my-image container).

- **Controller Manager comes in the picture**

  Kubernetes has a background process called the **Controller Manager**. This Controller Manager is like a supervisor: it continuously monitors the cluster’s state and tries to make the current state match the desired state.

  When you create a Deployment, the Controller Manager jumps into action:
  - Reads the Deployment configuration (like the number of replicas and Pod template).
  - Creates a ReplicaSet to fulfill the Deployment’s instructions.

- **The role of ReplicaSet**

  The ReplicaSet is an object created by the Deployment, and its sole purpose is to ensure that a specific number of identical Pods are always running.

  In this case:
  - The ReplicaSet is set to manage **3 replicas**, meaning it will make sure that 3 Pods are running at all times based on the Deployment’s instructions.

  The ReplicaSet:
  - Creates new Pods if the number of running Pods falls below the desired count (e.g., if a Pod crashes or is deleted).
  - Removes excess Pods if there are more than the desired number of Pods running.

  The ReplicaSet relies on labels to identify and manage the Pods it controls. In our example, the label ```app: my-app``` is applied to all Pods created by the ReplicaSet, allowing it to recognize and manage only those Pods.

<br>

**How ReplicaSet works in practise**

- **Deployment file is created**:
  - You run ```kubectl apply -f deployment.yaml```.
  - The Controller Manager sees this new Deployment and creates a ReplicaSet.

- **ReplicaSet creates Pods**:
  - The ReplicaSet checks and finds that there are no existing Pods with the label app: my-app.
  - It creates 3 new Pods with this label to match the replicas: 3 specified in the Deployment.

- **ReplicaSet maintains Pods**:
  - If one of the Pods crashes, the ReplicaSet notices that only 2 Pods are running.
  - It creates a new Pod to get back to 3 replicas, maintaining the Deployment’s desired state.
 
- **Deployment updates**:
  - If you update the Deployment (e.g., change the container image), the Deployment will create a new ReplicaSet to handle the new Pods with the updated configuration.
  - It will gradually shift traffic to the new Pods while terminating the old Pods managed by the old ReplicaSet.

<br>
<br>

### Lab 

**Creating a deployment for an Nginx application**-

We are going to deploy nginx application on kubernetes cluster.

**Step-1: - Write the Deployment YAML File**:-

Create a file called ```deployment.yaml``` with the following contents:

```
apiVersion: apps/v1              # Specifies the API version
kind: Deployment                 # Specifies that this is a Deployment resource
metadata:
  name: nginx-deployment          # The name of the Deployment
spec:
  replicas: 3                     # Specifies the number of Pods to run
  selector:
    matchLabels:
      app: nginx                  # Label used to identify the Pods managed by this Deployment
  template:
    metadata:
      labels:
        app: nginx                # Labels applied to Pods created by this Deployment
    spec:
      containers:
      - name: nginx               # The name of the container
        image: nginx:1.14.2       # Specifies the Docker image for the Nginx application
        ports:
        - containerPort: 80       # Container port that Nginx listens on

```

**Step-2: Apply the YAML file to create the deployment**:-

```kubectl apply -f deployment.yaml```

This command will create a deployment. With the deployment 3 pods will be created with nginx application. Kubernetes will automatically manage the replicas, ensuring that 3 Pods of the Nginx application are always running.

**Step-3: Verify the deployment**:-

```kubectl get deployment```

This command will show the deployment you created for nginx application using above yaml file.

**Step-4: Verify the pods**:-

```kubectl get pods```

This command will show the total 3 pods are running.

**Step-5: Checks status of pod**:-

```kubectl describe pod <pod_name>```

This command will show the each and every details of pod.
