# Kubernetes

Kubernetes is the container management tool which is used to manage conatiner deployment, container scaling and descaling and load balancer.

```Kubernetes containers को manage करने के लिए एक tool होता है जिससे हम containers की automatic deployment करना, Scaling और De-scaling करना और containers के बीच मैं load को balance करना ये सब operations हम kubernetes के through करते हैं```

It was developed by google but now it is maintained by Cloud Native Computing Foundation (CNCF).

<br>
<br>

**Before Kubernetes**

Before kubernetes applications were built based on **Monotlithic architecture** that means applications have single codebase for entire application and hosted on physical servers or virtual machines. During that time scaling was slow, updates cause downtime and resources were often wasted. 

**After Kubernetes**

With the rise of **Containerization**(like Docker) and **Kubernetes** the applications started building based on **Microservice Architecture** that means applications are broken into microservices where each part (e.g., user service, payment service) codebase is seperate and developed, deployed and scaled seperately. 

<br>
<br>

### Why do we need Kubernetes?

To host our application on containers so we use kubernetes.

We know that docker creates the container, the problem is docker can create containers but it cannot manage the containers completely for development and production environments. So that we use kubernetes.

```Docker containers को create करने का एक essentail tool है लेकिन kubernetes उन containers को manage करने का tool है.```

```Docker के through हम containers को manage नहीं कर पाते हैं इसलिए Kubernetes का यूज़ किया जाता है```

### Problems with the Docker:-

Here we are discussing some problems with that docker in details.

- **1 - Single Host Problem**:-

  ```Single host problem यह है की एक ही operating system पर docker tool चल रहा है और उस docker पर suppose हम 100 containers run कर देते हैं| So starting के 1, 2 या 3rd containers system के mostly resources use कर लेंगे तो बाकी के बचे containers को resources use करने को मिलेंगे ही नहीं और वह containers धीर-धीरे die हो जायेंगे और उन containers के अंदर की application down हो जाएँगी.```

  ```तो इस problem को kubernetes multiple hosts के through solve करता है. Kubernetes multiple nodes create करके उनपे containers को run करता है जिससे किसी एक node पर containers का load बढ़ रहा हो तो Kubernetes कुछ containers को वहां से हटा कर दूसरे node पर create कर देता है.```

- **2 - Auto-Healing Problem**:-

  ```Suppose docker के through हमने कुछ containers को run किया. अगर कोई container किसी भी reason से down हो जाता है या kill हो जाता है तो उस container के अंदर की application accessible नहीं होगी. Suppose docker पर 100 containers running हैं और लेकिन इनमे से कुछ containers kill हो गए और containers kill होने के बाद खुद से run नहीं हो रहे हैं. तो Docker user बार बार खुद से इतने सारे containers को तो start करेगा नहीं ये एक overhead हो जायगे.```

  ```तो इसका मतलब है की docker मैं auto - healing feature नहीं होता है. तो died container का खदु से start ना होना एक बोहोत बड़ी problem है. एक ये भी problem है जिसकी वजह से हम kubernetes का use करते हैं. ```

- **3 - Auto-Scaling Problem**:-

  ```Docker मैं Auto-Scaling feature नहीं होता है. Suppose एक application 10,000 users को server कर रही है और उसी application पर 1,00,000 users आ जाये तो ऐसे मैं container auto scale नहीं हो पायेगा.```

- **4 - Docker does not support Enterprise level standards**
    - Load Balancing.
    - Firewall.
    - Auto-Scale.
    - Auto-Healing.
    - Api Gateway.

So these are the problems which docker faces. To deal with these problems we use the kubernetes tool.

<br>
<br>

### Kubernetes Architecture

A kubernetes architecture consists of two components **Master Node** (Control Plane) and **Worker Node**. ```Master node और worker nodes के combination को ही kubernetes cluster बोलते हैं.```

**Node**: A node is a physical machine or virtual machine that contains multiple componenets.

<br>
<br>

<img src="https://drive.google.com/uc?export=view&id=1DjsEmGrDtIY1Ct-cc8N4gRRo15lUZdZf" alt="kuberetes architecture.png" width="570" height="340">

<br>
<br>

**1 - Master Node (Control Plane)**

A master node is a virtual machine that controls and manage the worker nodes in a cluster. It is responsible for scheduling the tasks and monitoring the state of the cluster.

```Master Node mainly worker nodes को manage करने के लिए होता है.```

**Componentes in Master Node**:

Master node consists of multiple components - API Server, etcd, Scheduler, Controller Manager and Cloud Controller Manager.

- **API server**

  API Server is the main component which manages the entire cluster. It receives all the request from user through kubectl and tells other components what to do.

  When you interact with kubernetes cluster using the kubectl cli, you are actually communicating with the api server component.

  ```API server का काम kubernetes cluster के साथ user का interaction करना होता है. User kubectl commands के through API server को request send करता है. फिर API server user के command के according work करता है जो भी काम हम cluster मैं करना चाहते हैं वह सब api server के through होते हैं.```

  How does API Server works:-

    - Clients send requests: Client sends request to api server through kubectl asking to do things like create a pod (kubectl create pod), delete a deployment (kubectl delete deployement), or check the status of a service.

    - API server validates: The api server checks if the request is valid or client has permisssion to do it.

    - API server processes: If the request is valid, api server process it by talking to other components like scheduler, controller manager and kubelet.

    - API server updates: Api server update the desired state of cluster in the etcd storage.

<br>

- **Scheduler**

  Scheduler is the component in the kubernetes cluster which is used to schedule or assign the pods on the suitable worker node.

  ```Scheduler pod को एक suitable node पर assign करने के लिए काम आता है.```

  Api server gets the pod creation request, then api server transer the request to scheduler for scheduling the pod. Scheduler iterates throgh all the worker nodes and evaluate each node's suitablity for the pod. Then scheduler assigns a score to each node. The node with the highest score is selected as the target node for the pod placement. The process of scheduling the pod is called scheduling.

  How does Scheduler works:-

    - User Sends a Request to Deploy a Pod:
        - A user sends a request to api server to create a new pod. For example, they might use ```kubectl apply -f pod.yaml``` to ask for a new pod.
 
    - API Server Stores the Request:
        - The api server takes this request and store the details of the pods in ```etcd```, a database that holds the current state of the cluster.
        - At this point the pod is in "pending" state because kubernetes hasn't decided where it will run yet.

    - Scheduler gets involved:
        - The scheduler is responsible to picking the best node to run this new pod.
        - The scheduler constantly monitors for any new pending pods and when it detects one it begins the process of scheduling.

    - Scheduler selects a node:
        - The scheduler looks at the available nodes in the cluster and checks a few things before deciding where to place the pod:
            - Node Resource: Does the node have enough CPU and Memory for the new pod?
            - Pod Constraints: Does the pod require any specific node (for example, a node with GPU or specific storage)?
            - Node Affinity: Are there any rules saying the pod must run on a certain type of node (e.g., node in a specific region)?
            - Taints and Tolerations: Does the pod tolerate certain node conditions (e.g., only allowing special workloads)?
         
        After considering these factor, the scheduler picks the most suitable node.

    - API server update the pod definition in etcs:
        - Once the scheduler decides a node, it tells the api server, which updates the pod information in the etcd database.
        - Now the pod is assigned to specific node, and the "Pending" status changes to "Scheduled".

    - Kubelet takes over:
        - The kubelet, a small agent running on each worker node, is responsible for actually starting the pod.
        - The kubelet on the chosen node sees that a new pod is assigned to it. It pulls the necessary container images and start the pod.
     
    - Pod is running:
        - Once the kubelet successfully starts the pod, the pod's status is updated to "Running", meaning the pod is ready and functioning on the node.

<br>

- **Controller Manager**

  Controller Manager is the componenets in the control plane which is used for maintaining the desired state of the clsuter by running the multiple controllers.

  ```Controller manager का काम clsuter को desired state मैं maintain करने के लिए होता है की cluster hamesha जिस state मैं हम चाहते हैं उस state मैं रहे.```

  ```Kubernete मैं एक actual state होती है और एक desired state होती है. Actual state का मतलब है जिस condition मैं cluster अब running है. Desired state का मतलब जिस condition मैं हम cluster को run करना चाहते हैं. ```

  It is the collection of different kubernetes controllers that run permanently in a loop. Its main taks is to watch for change in the desired state of the objects and make sure the actual state change towards a new desired state.

  e.g.,  

  Suppose you want to create a deployment, you specify the desired state in the manifest YAML file. For example, 2 replicas, one volume, mount, etc. The in-built deployment controller ensures that the deployment is in the desired state all the time. If a user updates the deployement with 5 replicas, the deployement contoller regonizes it and ensure the desired stare is 5 replicas.

<br>

- **etcd**

  etcs is basically the key-value storage. It stores the entire kubernetes cluster information in the form of objects as a key-value pair.

  When you use kubectl to get kubernetes obejcts details, you are getting it from the etcd. API server is the only component in the control plane which directlry interacts with the etcd storage.

  Key function of etcd:
  - Configuration Storage: Etcd stores configuration data for Kubernetes components, including:
      - API server configuration
      - Controller manager configuration
      - Scheduler configuration
      - Cluster-wide settings (e.g., network configuration, authentication settings)

  - State Storage: Etcd stores the current state of the cluster, including:
      - Pod information (e.g., status, IP address, node assignment)
      - Service information (e.g., endpoints, selectors)
      - Deployment information (e.g., desired replicas, current replicas)
      - Other resource information (e.g., secrets, configmaps)

<br>

- **Cloud Controller Manager (CCM)**

  Cloud Controller Manager is the component of kubernetes control plane which is used to connecting Kubernetes Cluster with Cloud provider. It ensure that kubernetes cluster can work seamlessly with cloud provider resources such as load balancer, storage volumes and virtual machines. Cloud controller manager acts as a bridge between cloud platofrm api and the kubernetes clsuter.

  Actually we use the kubernetes cluster from the cloud provider such as AKS, EKS. So, these kubernetes clusters are provided by cloud provider. ```तो होता क्या है की अगर हमको cloud की किसी service जैसे load balancer या persistent volume जैसे resource की जरुरत हो अपने kubernetes cluster मैं तो हम इन services को cloud से लेके अपने kubernetes मैं use करेंगे. तो इन service और kubernetes cluster को connect करने के लिए हम cloud और clouster के बीच मैं connectivity चाइये तो वो cloud controller manager के through होती है.```

  e.g.,

  ```Suppose हम azure kubernetes service का use कर रहे हैं. AKS पर cluster बना हुआ है. हम चाहते हैं की traffic manage करने के लिए हम azure से load balancer का use करे. तो यहाँ CCM  azure api से interact करेगा की cluster needs a load balancer तो kubernetes cluster को azure api से interect करना azure cloud पर cluster के लिए resources बनाने के लिए यही काम ccm का होता है.```

  Functions of CCM:-

    - Node Management: Ensures that Kubernetes nodes (the VMs or instances in the cloud) are correctly registered with the Kubernetes cluster.
 
    - Route Management: Configures networking routes in the cloud to ensure that traffic can flow between nodes and services.
 
    - Load Balancer Management: Manages cloud-based load balancers to expose Kubernetes services outside the cluster.
 
    - Volume Management: Handles the attachment and detachment of cloud storage volumes (like EBS in AWS or Managed Disks in Azure) to Kubernetes pods.


  Components of CCM:-

    - Node Contoller:  Monitors nodes in the cloud and checks if they are running properly.
        e.g., If a node (VM) is deleted from the cloud provider, the Node Controller will detect it and remove the node from the Kubernetes cluster as well.

    - Route Contoller: Configures network routes so pods across different nodes can communicate.

    - Service Controller: Manages cloud load balancers.
        e.g., When you create a Kubernetes service of type LoadBalancer, the Service Controller interacts with the cloud provider to provision a cloud-based load balancer (e.g., an ELB in AWS) and ensures it forwards traffic to the appropriate pods.

    - Persistent Volume Controller: Handles persistent storage volumes.
        e.g., When a pod requests storage (via Persistent Volume Claims), the Persistent Volume Controller creates, attaches, and mounts the required storage in the cloud (like an AWS EBS or Azure Disk).


<br>
<br>

<img src="https://drive.google.com/uc?export=view&id=1Rd6rNU_hoMvp6npP3j6rp9JfN3Ek22lo" width="570" height="450">

This above image shows the kubernetes architecture.

<br>
<br>

**2 - Worker Node**

A worker node is a virtual machine or physical machine that runs your containerized applications. It is responsible for running the container inside the pod.

```वर्कर नोड का काम आपके एप्लीकेशन को कंटेनर के अंदर रन करने का होता है```

What does a worker node do?

A worker node is responsible for:
  - Running the actual application(pod) defined by the user.
  - Ensuring pods are running healthy and up-to-date.
  - Communicating with contorl plane to receive tasks and updates.

**Components of a worker node**:

- **Pod**: A pod is a smallest deployable unit. ```OR``` A pod is a group of one or more containers with shared storage and network resources. ```OR``` A pod is your running application.
  
<br>

- **Kubelet**: Kubelet is the component of worker node that is responsible for managing the pods and communicating with control plane. Ensures the node runs the right pods and reports back to the control plane.

    ```Kubelet simple pod को manage करने के लिए होता है. जब control plane से api server kubelet को command देता है तब kubelet pod को create, update, delete जैसे operations करने के लिए होता है.```

    The Kubelet receives instructions from the API Server (in the control plane) and ensures that the pods are running according to the desired state (as defined by the user).

<br>

- **Kube-Proxy**: Kube-proxy is the component in the worker node with responsible for managing the networking in the cantainer inside the pod. It manages networking to make sure your pods can communicate with each other and the outside world.

    ```Kube-proxy pod के अंदर containers की networking को manage करता है.```

    When you expose pods using a service, kube-proxy creates network rules to send traffic to the backend pods.

    e.g., ```Suppose एक pod के 2 replicas बने हुए हैं उसमे load balancer feature enable है, तो यहाँ kube-proxy 50% trafix replica 1 को और 50% traffic replica 2 को भेजने के लिए responsible होगा.```

<br>

- **Container Runtime**: It the component of worker node which is responsible for running container on the worker node. Populer container runtiem includes (Docker, containerd, CRI-O).

    ```Container Runtime simply docker image को किसी भी container registry से pull करता है उसका container create करता है और उसको worker node पर run कर देता है.```

    When a pod is scheduled to run on a node, the container runtime pulls the container image (for example, from Docker Hub), creates the container, and runs it on the node.

<br>
<br>

**How the Worker Node Fits into the Kubernetes Workflow**

Let’s take a closer look at the process from when a user deploys an application to when it runs on a worker node.

- **User Sends a Request**:
  
    You (the user) define an application (e.g., a web app) that you want to run on the Kubernetes cluster. You create a YAML file describing the desired state of the app, including things like the number of replicas (copies), the container image to use, and the resources (CPU, memory) required.

- **API Server Receives the Request**:

    The API Server in the control plane receives this request and stores it in etcd, which is a key-value store that holds the desired state of the entire cluster.

- **Scheduler Decides Where to Run the Pods**:

    The Scheduler looks at the available worker nodes and decides which node(s) to assign the pod to, based on available resources (CPU, memory) and other constraints (e.g., affinity rules).

- **Kubelet on the Worker Node Takes Action**:

    Once the scheduler assigns a pod to a specific worker node, the Kubelet on that worker node receives the instruction from the API Server. The Kubelet ensures that the container specified in the pod definition is created and running.

- **Container Runtime Runs the Container**:

    The Container Runtime (e.g., Docker) on the worker node pulls the container image from a container registry (like Docker Hub or a private registry). It then creates and starts the container on the worker node.

- **Kube-Proxy Handles Networking**:

    The Kube-Proxy sets up the necessary networking rules so that the pod can communicate with other pods and services in the cluster. For example, if the pod needs to serve a web application, the Kube-Proxy ensures that external traffic can reach the pod.

- **Pod Runs on the Worker Node**:

    Now, the pod (which is essentially a wrapper for one or more containers) is up and running on the worker node. The pod will stay on this node unless it crashes or gets terminated (or the node itself has issues). If something goes wrong, Kubernetes will automatically try to restart the pod or reschedule it on another node.
