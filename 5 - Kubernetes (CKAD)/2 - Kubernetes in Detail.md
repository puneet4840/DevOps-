### How does Kubernetes works - step by step.

- Step 1: **User Sends a Request to the Cluster**
      Imagine you want to deploy a web application. You write a **configuration file** (usually a YAML file) that defines:
          - What container image your application will use.
          - How many instances (pods) you want running.
          - Any other settings like storage, networking, etc.

    You then submit this configuration to the **Kubernetes API Server** thorough kubectl cli, which is the entry point of the Kubernetes Control Plane.


- Step 2: **API Server in the Control Plane**

  The **API Server** is the component that receives user requests. It acts as a bridge between users and the internal workings of the cluster.
    - When you submit the configuration file, the API Server stores the desired state (what you want to happen) in a database called **etcd**.


- Step 3: **Scheduler**

  Next, the **Scheduler** comes into play. Its job is to look at the current state of the cluster and decide on which **worker nodes** to run your application. The scheduler finds the most suitable node by considering:

    - Available resources (CPU, memory, etc.).
    - Where it makes sense to place your application for load balancing.
