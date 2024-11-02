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
      
