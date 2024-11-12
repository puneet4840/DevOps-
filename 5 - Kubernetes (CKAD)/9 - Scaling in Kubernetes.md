# Scaling in Kubernetes

Scaling in kubernetes is the automatically incresing or decresing the resources to handle the different amount of workloads or traffic.

### Why Do We Need Scaling?

- **Handle Traffic Spikes**: When there’s a sudden increase in demand, scaling allows more pods or nodes to handle the load.

- **Save Resources and Cost**: During low-traffic times, scaling down helps reduce resource usage and cost.

- **Improve Reliability**: More instances of a pod make sure that if one pod fails, others are available to keep the application running.


### Types of Scaling in Kubernetes

Kubernetes offers three main types of scaling:

  - **Horizontal Pod Autoscaling (HPA)**: This scales the number of pods up or down.

  - **Vertical Pod Autoscaling (VPA)**: This adjusts the resources (CPU and memory) of a single pod.

  - **Cluster Autoscaling**: This scales the entire cluster by adding or removing nodes (VMs or physical machines).


### Horizontal Pod Autoscaling (HPA)

Horizontal Pod Autoscaling (HPA) is about adding or removing pods on a node based on demand.

When the load is high, HPA creates more pods to handle the workload. When the load drops, it reduces the number of pods. 

**Example Scenario**

  Imagine you have a shopping website that runs on 2 pods. During a sale, traffic increases, and 2 pods are not enough to handle all the customer requests. HPA automatically increases the number of pods to, say 10, So the website can handle the extra load. When the sale ends, HPA reduces the number of pods back to 2 to save the resources.

**How HPA Works**

  - HPA continously monitors pod metrics like **CPU usage**, **Memory usage** or custom metrics like request rate.
  - If a metric (e.g., CPU usage) exceeds a set threshold (like 80%), HPA will add more pods.
  - If usage falls below a certain level (like 20%), it will remove pods.

**Setting up HPA**

We can setup HPA by using command or declarative way (using yaml).

  - **Commands to Set Up HPA**:

    ```kubectl autoscale deployment my-deployment --cpu-percent=80 --min=2 --max=10```

    - ```--cpu-percent=80```: HPA will add more pods if CPU usage goes above 80%.
    - ```--min=2 --max=10```: It will maintain a minimum of 2 pods and a maximum of 10.

  - **YAML file to configure HPA in Kubernetes**:

    ```
      apiVersion: autoscaling/v2
      kind: HorizontalPodAutoscaler
        metadata:
          name: example-hpa
      spec:
        scaleTargetRef:
          apiVersion: apps/v1
          kind: Deployment
          name: my-deployment  # The deployment to be scaled
        minReplicas: 2         # Minimum number of pods
        maxReplicas: 10        # Maximum number of pods
        metrics:
        - type: Resource
          resource:
            name: cpu
            target:
              type: Utilization
              averageUtilization: 80  # Target: 80% CPU usage
    ```

    Explaination:

      - minReplicas: Kubernetes won’t go below 2 pods.
      - maxReplicas: Kubernetes can go up to 10 pods.
      - averageUtilization: When the CPU utilization across pods goes above 80%, HPA will add more pods.

<br>

### Vertical Pod Autoscaling (VPA)

Vertical Pod Autoscaling (VPA) adjusts the resources(CPU and Memory) allocated to each pod. It does not increase or decrease the number of pods. 

This is useful when each pod’s workload varies over time, needing more or less CPU and memory.

**Example Scenario**

Suppose you have data proccessing application that someties requires a lot of memory to process a large file, but at other times it only needs a little. So VPA can increase the moemory for this pod when needed and decrease it afterwards.

**How VPA Works**

  - VPA monitors each pod’s resource usage (CPU and memory).
  - If a pod’s resource usage exceeds its allocated limits, VPA increases the pod’s limits.
  - If a pod is consistently underutilizing its allocated resources, VPA reduces the limits to save resources.

**Setting Up VPA**

VPA requires a bit of setup and a custom YAML file. Here’s an example:

```
  apiVersion: autoscaling.k8s.io/v1
  kind: VerticalPodAutoscaler
    metadata:
      name: my-vpa
  spec:
    targetRef:
      apiVersion: "apps/v1"
      kind: Deployment
      name: my-deployment
    updatePolicy:
      updateMode: "Auto"  # Options: Auto, Off, Initial
```

Explaination:
- ```updateMode: "Auto"```: Auto mode will automatically adjust resources for the pods.
      
<br>

### Cluster Autoscaling

To scale the kubernetes cluster nodes, we use **Cluster Autoscaling**.

Cluster Autoscaling adjusts the number of nodes in your cluster. When there’s a high demand, it adds more nodes; when demand decreases, it reduces nodes. It works at the infrastructure level, adding or removing nodes (VMs or physical servers) as required. 

When you use the cluod Kubernetes cluster like **AKS**, **AWS** and **GCP**. You can use the scale the node on this cluster because cloud helps you proviosn the as many vms you want.

**Why Cluster Autoscaling is Important**

Imagine HPA is set up to scale pods between 2 and 20. If the nodes don’t have enough resources for 20 pods, the new pods won’t be created. Cluster Autoscaler solves this by adding more nodes when needed and removing them when they’re no longer needed.

**How Cluster Autoscaling Works**

  - Cluster Autoscaler watches for **unschedulable pods**—pods that can’t be placed because there aren’t enough resources on existing nodes.
  - If such pods are found, Cluster Autoscaler adds more nodes to the cluster.
  - When there are nodes with very low usage for a long time, Cluster Autoscaler removes those nodes to save resources.


<br>

### Putting It All Together: An Example Flow

- **Initial State**: You deploy an application with an HPA, VPA, and Cluster Autoscaler configured. Initially, there are 2 pods running on 2 nodes.

- **Traffic Spike**: Suddenly, there’s a traffic spike.
  - **HPA** detects high CPU usage and scales up to 10 pods.
  - Since the cluster doesn’t have enough nodes, **Cluster Autoscaler** adds 2 more nodes to accommodate the new pods.

- **Resource Adjustment**: Some of the new pods start using a lot of memory.
  - **VPA** detects this and increases the memory limit for those pods to handle the load better.
    
- **Traffic Drop**: After some time, traffic drops.
  - **HPA** scales the pods back down to 2.
  - **Cluster Autoscaler** removes the 2 extra nodes that are no longer needed.

- **Low Resource Usage**: If the remaining pods are using less CPU and memory, **VPA** might scale their resource allocation down to save even more on resources.

<br>

### Example (LAB): AutoScaling a nodejs web application with Kubernetes HPA

**Example Scenario**

In this example, We have a Node.js web application deployed on Kuberenetes cluster on a node with 1 replica.

**Prerequisite**

  - Metric-server should be installed on cluster.

- **Step 1: Create a Kubernetes Deployment**

  We’ll create a Kubernetes Deployment for the Node.js application.

  - Create a Deployment YAML File (```deployment.yaml```):

    ```
      apiVersion: apps/v1
      kind: Deployment
        metadata:
          name: hpa-demo
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: hpa-demo
        template:
          metadata:
            labels:
              app: hpa-demo
          spec:
            containers:
            - name: hpa-demo
              image: yourusername/hpa-demo:v1  # Replace with your image name
              resources:
                requests:
                  cpu: "100m"     # Minimum CPU needed
                limits:
                c  pu: "500m"     # Maximum CPU allowed
              ports:
              - containerPort: 8080
    ```

  - Step:2 - Apply the Deployment:
  
    ```kubectl apply -f deployment.yaml```

  - Step:3 - Verify the Deployment:

    ```kubectl get pods```

- **Step 2: Expose the Deployment with a Service**

  To access the application, expose it using a Kubernetes Service.

  - Create a Service YAML File (service.yaml):

    ```
      apiVersion: v1
      kind: Service
        metadata:
          name: hpa-demo-service
      spec:
        selector:
          app: hpa-demo
        ports:
        - protocol: TCP
          port: 80
          targetPort: 8080
        type: LoadBalancer
    ```

  - Apply the Service:

    ```kubectl apply -f service.yaml```

  - Get the Service IP:
 
    ```kubectl get svc hpa-demo-service```

    You’ll see an external IP for your service

- **Step 3: Configure HPA for the Deployment**

  Now that the deployment and service are set up, let’s configure HPA to automatically scale the pods based on CPU usage.

  - Create an HPA YAML File (hpa.yaml):

    ```
      apiVersion: autoscaling/v2
      kind: HorizontalPodAutoscaler
        metadata:
          name: hpa-demo
      spec:
        scaleTargetRef:
          apiVersion: apps/v1
          kind: Deployment
          name: hpa-demo
        minReplicas: 1
        maxReplicas: 10
        metrics:
        - type: Resource
          resource:
            name: cpu
            target:
              type: Utilization
              averageUtilization: 50   # Target CPU usage at 50%
    ```

  - Apply the HPA Configuration:

    ```kubectl apply -f hpa.yaml```

  - Verify the HPA:

    ```kubectl get hpa```

    You should see the HPA configuration with the minimum and maximum replica limits and the CPU target.

<br>
<br>

### Example (LAB): Autoscaling a Data Processing Application with Kubernetes VPA

  **Example Scenario**

  In this scenario, we have a data-processing application that occasionally requires more memory and CPU. Instead of setting fixed requests and limits, we want Kubernetes to dynamically adjust these based on real-time usage patterns, ensuring that we don’t under- or over-provision resources.

  **Prerequisites**:

  - Metrics Server needs to be installed on your cluster, as it provides the resource usage data that VPA uses.

- **Step 1: Install the Vertical Pod Autoscaler (VPA) on the Cluster**

    Vertical Pod Autoscaler is not installed by default, so you need to install it as an add-on.

    - Download the VPA YAML Configuration:

      ```wget https://github.com/kubernetes/autoscaler/releases/download/v0.12.0/vpa-v0.12.0.yaml```

    - Apply the VPA Configuration:
 
      ```kubectl apply -f vpa-v0.12.0.yaml```

    - Verify VPA Components:

      Ensure the VPA components (recommender, updater, and admission-controller) are up and running.

      ```kubectl get pods -n kube-system | grep vpa```

- **Step 2: Create a Sample Deployment (Data Processor)**

  We’ll create a sample deployment that simulates a data-processing workload. It will use a Python script that randomly consumes CPU and memory to mimic varying workload demands.

  - Create the Application Code (data_processor.py):

    ```
      # data_processor.py
      import time
      import random

      def process_data():
        print("Processing data...")
        # Random CPU and memory load simulation
        load = [i ** 2 for i in range(10**5)]
        time.sleep(random.uniform(0.1, 0.5))

      while True:
        process_data()
    ```

    Suppose this above python application is dockerized and docker images is stored at docker hub.

- **Step 3: Create a Kubernetes Deployment:**

  Now, let’s create a Kubernetes Deployment for our data-processing application.

  ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: data-processor
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: data-processor
      template:
        metadata:
          labels:
            app: data-processor
        spec:
          containers:
          - name: data-processor
            image: yourusername/vpa-data-processor:v1  # Replace with your image
            resources:
              requests:
                cpu: "50m"
                memory: "128Mi"
              limits:
                cpu: "500m"
                memory: "512Mi"
  ```

  - Apply the deployment:

    ```kubectl apply -f deployment.yaml```

- **Step 4: Set Up the VPA for the Deployment**

  Now that we have the deployment set up, let’s configure VPA to monitor and adjust its resource requests automatically.

  - Create a VPA Configuration:

    Create a YAML file for VPA.

    ```
      apiVersion: autoscaling.k8s.io/v1
      kind: VerticalPodAutoscaler
        metadata:
          name: vpa-data-processor
      spec:
        targetRef:
          apiVersion: "apps/v1"
          kind:       Deployment
          name:       data-processor
        updatePolicy:
          updateMode: "Auto"  # Automatically adjust requests
    ```

    This configuration tells VPA to:

    - Monitor the resource usage of the data-processor deployment.
    - Automatically adjust the CPU and memory requests as needed.

  - Apply the VPA Configuration:

    ```kubectl apply -f vpa.yaml```

  - Verify VPA Setup:

    ```kubectl get vpa```

  You should see vpa-data-processor listed, and after some time, it will show recommendations for CPU and memory requests.

- **Step 5: Generate Load and Monitor VPA Behavior**

  To see VPA in action, we’ll generate some load on the application.

  - Check the Initial Pod Resource Usage:

    ```kubectl top pods```

    This command will display the current CPU and memory usage of the pods.

  - Observe VPA Recommendations:

    ```kubectl describe vpa vpa-data-processor```

    This will show the recommended CPU and memory requests that VPA calculates based on the pod’s usage over time.

  - Watch for Changes:

    If updateMode is set to Auto, VPA will automatically adjust the requests based on observed usage. As load varies, VPA may increase or decrease the requests for CPU and memory.


- **Step 6: Scale Up and See VPA Adjustments**

  Let’s simulate a scenario where we increase the workload to observe VPA in action.

  - Increase the Number of Replicas:

    Scale up the deployment to increase the number of running pods:

    ```kubectl scale deployment data-processor --replicas=5```

  - Generate Heavy Load:

    With more replicas, the overall resource usage will increase. VPA will monitor each pod and adjust its CPU and memory requests accordingly.

  - Observe the VPA Recommendations and Pod Adjustments:
 
    Run the following commands to watch VPA and the pod’s resource requests over time:

    ```kubectl get vpa -w```

    ```kubectl describe vpa vpa-data-processor```

    Over time, VPA should adjust each pod’s requests to match its usage. This prevents pods from overusing resources, which can affect other applications on the same cluster.

This setup helps applications run efficiently by allocating just the right amount of resources, reducing costs, and improving performance by automatically adjusting resource requests based on actual usage.

<br>
<br>

### Exmaple(LAB): Cluster Auto-Scaler: Web Application with Variable Traffic

**Example Scenario**

Imagine you're managing a web application with varying traffic patterns. During peak hours, you need more compute power (nodes), but during off-peak hours, some of these resources go unused. We’ll use the Cluster Autoscaler to dynamically scale the number of nodes in the cluster, adding more when needed and removing excess nodes during low usage.

**Prerequisites**

- **Kubernetes Cluster**: Access to a Kubernetes cluster (preferably in a cloud environment like AWS EKS, Google GKE, or Azure AKS), since Cluster Autoscaler primarily works with cloud providers.
- **Kubectl**: Kubernetes command-line tool.
- **Cluster Autoscaler Installed**: Some cloud providers have built-in support for Cluster Autoscaler.

- **Step 1: Enable Node Autoscaling for Your Cloud Provider**

  Before deploying the Cluster Autoscaler, configure your node pool to allow autoscaling in your cloud provider’s control panel. Here’s a basic overview for popular cloud providers:

  - Azure AKS:
    - In the Azure portal, go to Kubernetes services > select your AKS cluster.
    - Under Node pools, set the Minimum and Maximum node count.
   
  Note: The minimum and maximum settings tell the Cluster Autoscaler how far it can scale up or down.

- **Step 2: Deploy the Cluster Autoscaler**

  Once autoscaling is enabled on your node pool, you can deploy the Cluster Autoscaler in your Kubernetes cluster.

  - Download the Cluster Autoscaler YAML:

    Get the appropriate version of Cluster Autoscaler. Replace <kubernetes_version> with your actual Kubernetes version (e.g., 1.29.0):

    ```wget https://raw.githubusercontent.com/kubernetes/autoscaler/cluster-autoscaler-<kubernetes_version>/cluster-autoscaler/deploy/cluster-autoscaler-autodiscover.yaml```

  - Edit the Cluster Autoscaler Deployment:

    Open the downloaded YAML file and edit the following sections:

    - Set the required cloud provider. For example:

      ```
        command:
          - ./cluster-autoscaler
          - --cloud-provider=aws # or gke, azure
          - --namespace=kube-system
          - --nodes=<MIN_NODES>:<MAX_NODES>:<NODE_GROUP_NAME>
      ```

      - Replace <MIN_NODES>, <MAX_NODES>, and <NODE_GROUP_NAME> with your settings:
        - <MIN_NODES>: Minimum number of nodes.
        - <MAX_NODES>: Maximum number of nodes.
        - <NODE_GROUP_NAME>: Name of your node group in the cloud provider.

      - Add --balance-similar-node-groups=true and --skip-nodes-with-local-storage=false for smoother scaling:

        ```- --balance-similar-node-groups=true```
        
        ```- --skip-nodes-with-local-storage=false```

      - Apply the YAML File:

        Once the file is edited, apply it to your cluster.

        ```kubectl apply -f cluster-autoscaler-autodiscover.yaml```

      - Verify Cluster Autoscaler Deployment:

        Check that the Cluster Autoscaler pod is running in the kube-system namespace:

        ```kubectl get pods -n kube-system | grep cluster-autoscaler```

- **Step 3: Deploy a Test Application with High Resource Demand**

  To test the Cluster Autoscaler, let’s create a deployment that requests more resources than the current node capacity. This will prompt Cluster Autoscaler to add nodes to the cluster.

  - Create a Test Deployment:

    This deployment creates multiple pods with high CPU and memory requests.

    ```
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: high-demand-app
      spec:
        replicas: 10
        selector:
          matchLabels:
            app: high-demand-app
        template:
          metadata:
            labels:
              app: high-demand-app
          spec:
            containers:
            - name: stress-app
              image: vish/stress
              resources:
                requests:
                  cpu: "500m"
                  memory: "500Mi"
              args:
                - "-cpus"
                - "2"
    ```

  - Apply the Deployment:

    ```kubectl apply -f high-demand-deployment.yaml```

    This deployment requests more resources than a single node can handle. If the current nodes are full, Cluster Autoscaler will automatically add more nodes.

- **Step 4: Monitor Cluster Autoscaler Activity**

  - Check Pod Status:

    ```kubectl get pods -o wide```

    You’ll notice that some pods may be in Pending status if there aren’t enough nodes available initially.

  - Watch Cluster Autoscaler Logs:

    Check the logs of the Cluster Autoscaler pod to see its scaling activity.

    ```kubectl -n kube-system logs -f deployment/cluster-autoscaler```

    In the logs, you’ll see messages indicating that Cluster Autoscaler is adding nodes to accommodate the pending pods.


  - Verify Node Scaling:

    ```kubectl get nodes```

    You should see new nodes added to the cluster. The Pending pods should now be scheduled on the newly created nodes.


  This setup demonstrates how Cluster Autoscaler dynamically manages node resources, saving costs by scaling down during low demand and ensuring high availability by scaling up when demand increases. This approach is crucial for production environments with variable traffic, as it helps optimize resource usage and maintain performance.
