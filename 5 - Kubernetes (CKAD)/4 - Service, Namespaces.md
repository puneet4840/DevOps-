# Service in Kubernetes

Servce is the process in kubernetes which helps us to access the application inside the pod within the cluster or outside the cluster.

```Service kubernetes के अंदर एक process होती है जिसकी वजह से हम kubernetes cluster के अंदर deployed application को access करते हैं.```

In kubernetes setup, each Pod has its own Ip Address, But since pods are temporary and their ip can be change when a pod restarts. We need a stable way to talk to them. A **Service** provides a stable ip address and name that stays same even if the pods themselves changes. 

<br>

### Why do we need Services?

Imagine you have miltiple pods running the same part of your application like one is running front-end part and one other pod is running a database part. If a users request comes in, it should go to any one these pods. Here why services are useful:

- **Consistent Access**: Service make sure that your application should have a fixed ip address to use, so you don't need to track which pod is currently available.

- **Load Balancing**: When you have multiple pods doing the same job, a service spreads incoming traffic evenly across them. This helps balance the load, so no single pod get overwhelmed.

- **Inside and Outside Communication**: Service controls whether a part of your app can be accessed only by other parts within the cluster or users on the internet.

<br>

### What happen when we do not use Service?

```Suppose we made a deployment with 3 replicas. तो ऐसे मैं 3 pods बन जायेंगे और उनके पास Pod Ip Address होंगे| हमारे पास एक testing team है जो उन application को test करना चाहती है| उसके लिए हमने 3 testers को pods के Ip Address दे दिए| अगर कोई Pod fail हो जाता है तो Replica Set की auto-scaling feature की वजह से वह pod फिर से create कर देगा और उस Pod पर एक नया Ip address आ जायेगा| अगर tester पुराने Ip address से pod को access करेगा तो वह pod access नहीं हो पायेगा kyuki उस pod को नया ip address मिल गया है| ऐसे मैं हमको जो नया Ip address जो create हुआ है उसको tester को देना होगा फिर वह pod access हो पायेगा|```

```तो pod के fail होने पर Ip address change होते रहेंगे| तो ये problem kubernetes service को use करके solve करता है| होता ये है की service create करने पर pod को हम service की ip address से access करते हैं और service pod को उसके selector के through network maintain करता है अगर pod delete भी हो गया तो उस pod का selector same रहेगा और service उस नए pod पर network maintain करता रहेगा| Service एक Ip provide करता है उस Ip से हम pod के अंदर application को access कर पाते हैं```

<br>

### Types of Serives:

Kubernetes has three types of services but mst common are top three services:-

- **ClusterIP (Default)**

  ClusterIP is the default service created when we create the Kubernetes cluster. Cluster Ip is used for the internal communication between pods within the cluster. It exposes the application on an internal clsuter ip. When pod is created then application is not accessible from outside the cluster.

  A ClusterIp service is a type of service in kubernetes that gives an application (running inside the pod) a stable internal ip address. This ip is only accessible within the cluster. This means that other application or pods in the cluster can access it, but it hidden from the outside world.

  <img src="https://drive.google.com/uc?export=view&id=1BS91cKgU8ehENzEpLQmpEdXoibEmDNIl" width="700" height="430">

  **Why do we need ClusterIP?**

  Imagine you have an application with multiple components (like a frontend and a backend) running in different pods. The frontend needs to talk to the backend to get data. Without a stable IP address, it would be hard for the frontend to reliably find the backend pod if it restarts or moves to a different node. A ClusterIP Service provides a fixed IP and DNS name for the backend so that the frontend can always reach it, even if the backend moves or scales up/down.

  **How does a Cluster Ip works?**

    - Pod Creation: First, you create a pod running your application (e.g., a backend application).
      
    - Service Creation: You create a ClusterIP Service for the pod. Kubernetes assigns it an internal IP address (called the Cluster IP), and this IP doesn’t change, even if the pod itself changes.
      
    - DNS Name Assignment: Kubernetes also assigns a DNS name to this service. Now, other pods can access your application by using this DNS name or the IP address.
      
    - Internal Routing: When another pod in the cluster tries to access the application using the ClusterIP, Kubernetes will route the request to the right pod(s).

  **Example of ClusterIp Service**

  Let’s say you have a simple application with two parts:

    - Frontend: Shows a web page to users.
    - Backend: Provides data to the frontend.

  Here’s how you’d set up a ClusterIP Service to let the frontend talk to the backend:

    - Step 1: Create the Backend Pod.
      First, you define and create a backend pod.

      ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: backend
          labels:
            app: backend
        spec:
          containers:
          - name: backend
            image: my-backend-image:latest
            ports:
            - containerPort: 8080

      ```

      In this case, the backend pod is running on port 8080.

    - Step 2: Create a ClusterIP Service for the Backend.

      Next, you create a ClusterIP Service to give this backend pod a stable IP and DNS name.

      ```
        apiVersion: v1
        kind: Service
        metadata:
          name: backend-service
        spec:
          selector:
            app: backend  # This service will route traffic to pods with this label
          ports:
            - protocol: TCP
            port: 80        # Port on the service
            targetPort: 8080 # Port on the backend container
          type: ClusterIP

      ```

      Here’s what’s happening in this YAML file:

      - ```selector```: The service will route traffic to any pod with the label app: backend.
      - ```port```: The service is exposed on port 80 (clients will use this port).
      - ```targetPort```: Inside the pod, the backend container is actually running on port 8080.

      When you create this service, Kubernetes will:

      1 - Assign it a ClusterIP (an internal-only IP).

      2 - Give it a DNS name based on the service name (backend-service).

      3 - Route any requests to backend-service on port 80 to the backend pod on port 8080.

    - Step 3: Access the Backend Service from the Frontend Pod

      Now, let’s assume you have a frontend pod that needs to get data from the backend. The frontend can reach the backend using the DNS name backend-service (or the ClusterIP).

      In the frontend application code, you would make a request to http://backend-service:80 to connect to the backend service.

<br>

- **NodePort**

  A NodePort Service allows you to access an application running inside the Kubernetes cluster using Ip Address of any worker node and a fixed port (called the NodePort). This port remains same across all the worker nodes, making it easy to access the app from outside the cluster.

  ```NodePort service के through हम application को worker node की Ip address और उसके एक port जिसको हम NodePort कहते हैं, उसपर access करते हैं.```

  NodePort service is good for testing and simple external access, but not for large-scale production. If you want to test your app locally and want to see it from your browser so you can use NodePort service.

  **What problem does NodePort solves?**

  Imagine you have an app running in Kubernetes, like a small website. By default, Kubernetes applications are only accessible inside the cluster. But sometimes, we want to make these apps available outside the cluster. A NodePort is a solution for this because it allows access from outside by opening a port called NodePort on each worker node.

  **How does NodePort works?**

    - When you create a NodePort service, kubernetes assigns a port from a specific range (30000 - 32767) to your service.
    - This port, called **NodePort** is opened on every node in the cluster, allowing traffic from outside the cluster to reach the service.
    - Traffic that comes to a node's IP address on this NodePort is forwarded to the pods in the cluster.

  **Example (LAB): Deploying a Simple Web Application Using NodePort**

  Let's go through a simple example to understand how to set up a NodePort service and access an application.

    - **Create a deployment with 3 replicas:**

        Create the deployment YAML file named nginx-deployment.yaml:

        ```
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: my-nginx-deployment
          spec:
            replicas: 3                       # Number of replicas
            selector:
              matchLabels:
                app: my-nginx-app
            template:  
              metadata:
                labels:
                  app: my-nginx-app           # Label to identify pods
              spec:
                containers:
                - name: nginx
                  image: nginx:latest          # Using the latest NGINX image
                  ports:
                  - containerPort: 8080        # Port where NGINX listens inside the pod

        ```

        In this configuration:
          - replicas: 3 tells Kubernetes to keep 3 replicas (3 pods) running.
          - app: my-nginx-app is a label that we’ll use to link this Deployment to a Service.

    - **Deploy the Deployment**:
      
        Run the following command in your terminal to create the Deployment:
      
        ```kubectl apply -f nginx-deployment.yaml```

    - **Verify the Deployment**:

        Use this command to check if the pods are running:

        ```kubectl get deployments```
        ```kubectl get pods```

    - **Create the NodePort Service**

      Now, let’s expose the Deployment with a NodePort Service. This will open a specific port on each node in your cluster, allowing access to the NGINX web server from outside.

      Create a ```nginx-service.yaml``` YAML File for the NodePort Service
      
        ```
          apiVersion: v1
          kind: Service
          metadata:
            name: my-nginx-service
          spec:
            type: NodePort                       # NodePort to expose it outside the cluster
            selector:
              app: my-nginx-app                  # Selects the pods with this label
            ports:
            - protocol: TCP
              port: 80                         # Internal service port
              targetPort: 8080                 # Port where the pod’s container listens
              nodePort: 30008                  # External port (must be between 30000 and 32767)

        ```

        Explanation:

        - ```type: NodePort``` tells Kubernetes to create a NodePort Service.
        - ```port: 80``` is the internal port for the Service.
        - ```targetPort: 8080``` is the port on the pod’s container (where NGINX is listening).
        - ```nodePort: 30008``` is the external port that Kubernetes will open on each node to access the app from outside.

    - **Deploy the Service**:

      Run the following command to create the NodePort Service:

      ```kubectl apply -f nginx-service.yaml```

    - **Verify the Service**:

      ```kubectl get services```

      You should see ```my-nginx-service``` with Type as ```NodePort```, and it should list the nodePort as ```30008```.

    - **Access the Application**:

      Now, we can access the NGINX web server from outside the cluster.

      - Get the Node’s IP Address:

        ```kubectl get nodes -o wide```

        Let’s say the IP address of one of your nodes is ```10.0.0.5```.

        You can access the NGINX web server by navigating to the following URL in a browser or using curl:

        ```curl http://10.0.0.5:30008```

        This will display the default NGINX welcome page if everything is set up correctly.


    - **How Kubernetes manage NodePort traffic**

      When you send a request to ```http://10.0.0.5:30008```, here’s how Kubernetes handles it:

      - Node Port Mapping: The NodePort Service listens on port 30008 of every node in the cluster.
      - Routing to Pod: Kubernetes receives the request on port 30008 and forwards it to the nginx pod running on port 8080 (using the ClusterIP service internally).
      - Response Handling: The pod processes the request and sends the response back through the same route.
      
<br>

- **Load Balancer**

  A Load Balancer service in the kubernetes helps exposes your application to the internet, means allowing people outside your kubernetes cluster to access it. Think you have given your app a public address so anyone can reach it.

  It also spreads the incoming traffic across multiple copies (replicas) of your application.

  ```Load Balancer service, kubernetes cluster के अंदर created application को internet पर expose करती है, जिससे एक public Ip के through लोग application को access कर सकें और Load Balancer, application के replica (pods) पर incoming traffic load को distribute भी करती है.```

  **Why use a Load Balancer Service?**

  When you deploy an application in kubernetes, you often create multiple replicas to handle traffic. But by default, these replicas are not directly accessible from outside the cluster. So we use the Load Balancer service. Below are the following reasons:

  - **Public IP**: A Load Balancer service gives your app a public ip address to make it accessible from anywhere on the internet.
  - **Distributes Traffic**: A Load Balancer distributes traffic across multiple replicas so the app runs smoothly and scales with demand.
  - **Service Discovery**: It is a process that Load Balancer automatically detect pods using its labels and selector to distribute traffic on newly created pod.
 
      ```Suppose एक pod fail हुआ और auto - healing की वजह से वह फिर से create हुआ , Auto - healing के बाद उस pod को एक नया Ip Address मिल जाता है, तो Load Balancer उस fail हुए pod को कैसे पेहचंगे और traffic route करेगा क्युकी उस pod को तो नया Ip assign हो गया है| तो यहाँ Service Discovery concept आता है| होता यह है की Load Balancer pods पर traffic route उसके ip address से न करके बल्कि उसके labels एंड selector से करता है| Labels और Selector हर pod पर same रहते हैं| यही Service Discovery का concept है|```


  **How does a Load Balancer service works?**

    - **Application Deployment in Kubernetes**:
        - First, we deploy our application in Kubernetes, often as a Deployment with several replicas.
        - These replicas are separate copies of the application, running in different pods to make sure our application can handle more traffic and recover quickly if one pod fails.

    - **Creating the LoadBalancer Service in Cluster**:
        - Next, we create a LoadBalancer service in Kubernetes and associate it with the application.
          
        - This LoadBalancer service is configured to expose our application to the outside world by creating a public IP address.
          
        - In the LoadBalancer service configuration, we specify:
            - The **targetPort**, which is the port inside the application pods where the app listens for requests (like port 80 for an NGINX server).
            - The **service port** (often the same as the targetPort), which is the port that people will access from outside.
            - A selector to match and connect to our application’s pods.

    - **Kubernetes Requests an External Load Balancer**
        - After we create the LoadBalancer service, Kubernetes talks to the cloud provider where the cluster is hosted (like AWS, Azure, or Google Cloud).
     
        - Kubernetes tells the cloud provider to set up an **external load balancer** that will give our application a **public IP** address.
     

    - **Cloud Provider Creates the Load Balancer and Assigns an IP**
        - The cloud provider then creates an external load balancer (outside the Kubernetes cluster).
     
        - This load balancer is assigned a public IP address, which is the address people will use to access the application.
     
        - The cloud provider then connects this load balancer to our Kubernetes cluster.
     
    - **LoadBalancer Service Connects to Application Pods**
        - Kubernetes sets up the LoadBalancer service with the public IP address provided by the cloud provider.
     
        - The LoadBalancer service knows which pods to connect to by looking at the selector labels we defined (e.g., app: my-app). This selector helps the LoadBalancer find and connect to all the replicas of our application.
     
        - Internally, the LoadBalancer service spreads out the incoming requests across all available replicas (pods) of the application.
     
    - **Traffic Flow: Request to Application**
        - When someone visits the public IP address of the LoadBalancer (e.g., http://<public-ip>):
            - The request reaches the cloud provider’s external load balancer.
            - The external load balancer forwards the request to the LoadBalancer service inside the Kubernetes cluster.
            - The LoadBalancer service then distributes the request to one of the available application pods based on its selector.
            - The pod responds, sending the response back along the same route to the user.

    - **Handling Increased Load or Scaling**
        - If we increase the number of replicas, the LoadBalancer service will automatically start sending traffic to the new replicas.
          
        - Likewise, if one pod fails, the LoadBalancer service will reroute traffic to the remaining healthy pods, ensuring the application stays accessible.

<br>

  **Example (LAB): Deploying a Simple Nginx Web Application Using LoadBalancer**

  - **Create a Deployment for Your App using** ```nginx-deployment.yaml```:

    ```
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: nginx-deployment
      spec:
        replicas: 3                            # Creates 3 replicas
        selector:
          matchLabels:
            app: nginx-app
        template:
          metadata:
            labels:
              app: nginx-app                   # Label for identifying replicas
          spec:
            containers:
            - name: nginx
              image: nginx:latest              # Uses the latest NGINX image
              ports:
              - containerPort: 80              # NGINX listens on port 80 inside each pod
    ```

    Explanation of the Deployment YAML:

      - replicas: 3 means three copies of the NGINX server will run in the cluster.
      - selector & labels allow the service to know which pods to connect to (we’ll use this in the next step).
      - containerPort: 80 is the port where NGINX listens for incoming traffic.

    To apply this file, run:

      ```kubectl apply -f nginx-deployment.yaml```

    This command creates the deployment with three NGINX pods.

  - **Create a LoadBalancer Service**

    Now, let’s create a LoadBalancer service that will give our NGINX app a public IP and distribute traffic across the replicas.

    Service File (nginx-loadbalancer-service.yaml):
    ```
      apiVersion: v1
      kind: Service
      metadata:
        name: nginx-loadbalancer
      spec:
        type: LoadBalancer                     # Exposes the service to the internet
        selector:
          app: nginx-app                       # Connects to pods with this label
        ports:
        - protocol: TCP
          port: 80                             # External port for the service
          targetPort: 80  
    ```

    Explanation of the Service YAML:

      - type: LoadBalancer tells Kubernetes to set up an external IP for this service.
      - selector: app: nginx-app connects the service to our NGINX pods using the label.
      - port: 80 is the port on the LoadBalancer’s IP that users will access.
      - targetPort: 80 directs the traffic to port 80 inside each NGINX pod.

    To create this service, run:

      ```kubectl apply -f nginx-loadbalancer-service.yaml```

  - **Check the External IP Address**

    Once the LoadBalancer service is created, Kubernetes will work with the cloud provider to set up a public IP address. You can check if the IP address is ready by running:

      ```kubectl get svc nginx-loadbalancer```

    You’ll see output similar to this:

      ```
        NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)        AGE
        nginx-loadbalancer   LoadBalancer   10.96.95.215     52.23.145.198    80:31005/TCP   2m

      ```

    The EXTERNAL-IP (in this case, 52.23.145.198) is your app’s public IP.


  - **Access the App Using the External IP**

    You can access the NGINX web server using the external IP:

      ```http://52.23.145.198```

    Or, using curl in your terminal:

      ```curl http://52.23.145.198```


<br>
<br>

# Namespace in Kubernetes

Namespace is a concept in Kubernetes which is used to divide the cluster resources into groups.

```Namespace, एक Azure resource group की तरह है. जैसे हम azure मैं resources को अलग-अलग groups मैं divide कर देता है वैसे ही namespace के through हम kubernetes मैं resources को अलग अलग groups मैं divide कर देते हैं.```

In Kubernetes, namespaces help you separate and organize different environments (like development, testing, and production) or different teams’ work inside one Kubernetes cluster.


**Why use Namespace?**

- **Keep Things Organized**: Just like different folders on your computer for different projects, namespaces let you organize resources like pods, services, and other components.
- **Manage Resources**: Kubernetes lets you set resource limits per namespace, so you can control how much memory or CPU a project or team can use.
- **Control Access**: You can set permissions per namespace, meaning you can control who can see or modify resources within a namespace.

**How namespace works in kubernetes?**

Each resource (like a Pod or Service) that you create in Kubernetes exists in a namespace. If you don’t specify a namespace, Kubernetes puts it in the **default** namespace.

  - **Default Namespaces in Kubernetes**:
      - Kubernetes clusters come with a few predefined namespaces:
          - **default**: This is the main, general-purpose namespace where resources go if no other namespace is specified.
          - **kube-system**: Used by Kubernetes itself to hold components that make the cluster work (like controllers and network management).
          - **kube-public**: This is rarely used, but it’s accessible by everyone in the cluster. It’s meant for resources that need to be public.

**Creating a Namespace**

To create a namespace we can create in two ways:

1 - **Using kubectl commands**:

  ```kubectl create namespace my-namespace```

2 - **Using Yaml files**:

  ```
    apiVersion: v1
    kind: Namespace
    metadata:
      name: my-namespace
  ```

  Save this as my-namespace.yaml, then run:

  ```kubectl apply -f my-namespace.yaml```

  This creates a new namespace called my-namespace where you can now create resources.


**Working Within a Namespace**

When creating resources in Kubernetes (like deployment or services), you can specify which namespace they belong to. There are two main ways to do this:

  - **Using the -n flag**:

    ```kubectl create -f deployment.yaml -n my-namespace```

  - **Setting the namespace in the YAML file**:

    ```
      apiVersion: v1
      kind: Deployment
      metadata:
        name: my-pod
        namespace: my-namespace
    ```

**Listing and Accessing Resources in a Namespace**

  - To see all namespaces in the cluster:

    ```kubectl get namespaces```

  - To list resources within a specific namespace, use the -n flag:

    ```kubectl get pods -n my-namespace```

  - To see all resources across all namespaces:

    ```kubectl get all -A```
