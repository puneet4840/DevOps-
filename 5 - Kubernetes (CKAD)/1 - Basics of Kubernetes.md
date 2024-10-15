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

<br>

**1 - Master Node (Control Plane)**

A master node is a virtual machine that controls and manage the worker nodes in a cluster. It is responsible for scheduling the tasks and monitoring the state of the cluster.

<br>
<br>

<img src="https://drive.google.com/uc?export=view&id=1DjsEmGrDtIY1Ct-cc8N4gRRo15lUZdZf" alt="kuberetes architecture.png" width="570" height="340">

<br>
<br>

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



<img src="https://drive.google.com/uc?export=view&id=1Rd6rNU_hoMvp6npP3j6rp9JfN3Ek22lo" width="570" height="450">

This above image shows the kubernetes architecture.
