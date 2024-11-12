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
