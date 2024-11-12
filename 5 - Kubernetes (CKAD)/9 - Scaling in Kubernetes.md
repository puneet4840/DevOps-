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
