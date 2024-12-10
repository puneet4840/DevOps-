# Taints and Toleration

```Suppose आपके पास एक ऐसी application है, जो GPU का use करके चलती है और उस application को run करने के लिए आपको machine पर GPU available होना चाइये| और हम उस एप्लीकेशन को कुबेरनेटेस पर डेप्लॉय करना चाहते है. तो kubernetes के node पर भी GPU available होना चाइये और Suppose Kubernetes cluster है जिसमे 1 master node है और 2 worker node है. तो हम ये ही चाहेंगे को हमारा application का pod जिस node पर GPU है उस node पर ही run होना चाइये और बाकी normal pods उस GPU वाले node पर रन नहीं होने चाइये. तो इस चीज़ को हम taints & toleration से acheive करते हैं|```

In Kubernetes, taints and tolerations work together to control which pods can be scheduled to which nodes in a cluster. 


### What is Taint?

A taint is a special setting applied to a node to indicate that certain pods should not be scheduled on that particular node. When you apply a taint to a node, you’re essentially saying, "Don’t allow pods here unless they have permission."

If you want to restrict who can enter a room, you can put a “No Entry” sign on it. In Kubernetes, these “No Entry” signs are called taints.

For example:

  - You have a room (node) in the house reserved only for studying (database work).
  - You put up a “No Entry – Study Only” sign (a taint) on that room.
  - Now, only people (pods) who have permission to study (work as a database) can go into that room.

```
OR
```

- A taint is like a restriction you put on a node to keep certain pods off it.
- If a node is tainted, only pods that “tolerate” that taint can be scheduled on it.
- For example, let’s say you want to reserve a node for database-only pods. You add a taint to that node.

It is like a key-valur pair on the node.

**Taint Components**

A taint has three components:

  - **Key**: Identifies the type of taint (e.g., key=dedicated).
  
  - **Value**: Adds more context to the key (e.g., dedicated=database).
  
  - **Effect**: Specifies the action to take when a pod doesn't tolerate the taint:
  
    - **NoSchedule**: Pods without a matching toleration won’t be scheduled on this node.
    - **PreferNoSchedule**: Kubernetes tries to avoid scheduling pods here, but it’s not a strict rule.
    - **NoExecute**: If a pod without a matching toleration is already on the node, it will be evicted.

**Example of Applying a Taint**

Let’s say you have a node that you want to reserve for database workloads only. You might add a taint to it as follows:

```kubectl taint nodes <node-name> dedicated=database:NoSchedule```

This command adds a taint to the node named <node-name>, with the key dedicated, value database, and effect NoSchedule. This means that only pods with a matching toleration will be able to run on this node.

<br>

### What are Tolerations?

A toleration is like a permission slip that a pod has to run on a tainted node. If a pod has a matching toleration, it’s allowed to ignore the taint and be scheduled on that node.

Tolerations are like permission badges.

Now, if someone needs to enter that room despite the “No Entry” sign, they need a **permission badge** that says they’re allowed to be there. In Kubernetes, these badges are called **tolerations**.

**Toleration Components**

Similar to taints, tolerations have a key, value, and effect. They should match the taint components on the node for the pod to be scheduled there.

**Example of Adding a Toleration**

If you want a pod to be able to tolerate the taint we added earlier (```dedicated=database:NoSchedule```), you add a toleration to the pod’s specification:

```
apiVersion: v1
kind: Pod
metadata:
  name: my-database-pod
spec:
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: "database"
    effect: "NoSchedule"
  containers:
  - name: my-container
    image: my-database-image
```

Here:
  - key: ```"dedicated"``` matches the taint’s key.
  - value: ```"database"``` matches the taint’s value.
  - effect: ```"NoSchedule"``` matches the taint’s effect.

Now, the pod my-database-pod is allowed to be scheduled on the node with the taint ```dedicated=database:NoSchedule```.

<br>

###  How Taints and Tolerations Work Together

  - **Taints** prevent pods from being scheduled on certain nodes.
  - **Tolerations** allow specific pods to bypass the taints.

  If a node has a taint and a pod doesn’t have a corresponding toleration, Kubernetes won’t schedule the pod on that node. However, if the pod has a toleration that matches the node's taint, Kubernetes allows it to be scheduled there.

### When to Use Taints and Tolerations

  - **Dedicated Nodes**: Use taints to reserve nodes for specific types of work, like databases or high-priority applications.
  - **Separating Workloads**: Use them to prevent regular apps from running on nodes reserved for testing or other purposes.


<br>
<br>

### Example (LAB)- Taints and Tolerations

  Imagine you have a Kubernetes cluster with three nodes, but only one of them has a GPU. You want only GPU applications to run on this node, keeping non-GPU workloads on the other nodes.

  Our steps will involve:
    - **Adding a taint** to the GPU node to mark it for GPU-only workloads.
    - **Creating a GPU-based pod with a toleration** to allow it to be scheduled on the GPU node.
    - **Deploying a non-GPU application** to verify that it doesn’t run on the GPU node.

<br>

**Setp-by-Step**

- **Check Your Nodes**

  First, check the nodes in your cluster to identify the one with a GPU:

  ```kubectl get nodes -o wide```

  Assume the output is something like this:

  ```
    NAME       STATUS   ROLES    AGE   VERSION
    node1      Ready    <none>   20d   v1.25.0
    node2      Ready    <none>   20d   v1.25.0
    node3      Ready    <none>   20d   v1.25.0  # This node has the GPU
  ```
  Here, node3 has the GPU, so we’ll reserve it for GPU workloads.

- **Add a Taint to the GPU Node**

  Now, let’s add a taint to node3 so only GPU workloads can be scheduled there.

  ```kubectl taint nodes node3 gpu=true:NoSchedule```

  Explanation:
    - gpu=true: This taint marks the node for GPU workloads.
    - NoSchedule: This effect prevents non-GPU workloads from being scheduled on this node.

- **Create a GPU-Based Pod with a Toleration**

    Now, let’s create a GPU-based application pod that can tolerate the taint on node3.

    Create a YAML file named gpu-pod.yaml:

      ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: gpu-app
        spec:
          containers:
          - name: gpu-container
            image: nvidia/cuda:11.0-base   # Sample GPU-based image
            resources:
              limits:
                nvidia.com/gpu: 1          # Request 1 GPU
            command: ["nvidia-smi"]        # Run nvidia-smi to check GPU details
          tolerations:
          - key: "gpu"
            operator: "Equal"
            value: "true"
            effect: "NoSchedule"

      ```
    Explaination:
    - ```tolerations``` section: This pod has a toleration that matches the gpu=true:NoSchedule taint on node3, allowing it to be scheduled there.
    - ```resources.limits``` section: Specifies the pod requires a GPU (```nvidia.com/gpu: 1```).
    - ```nvidia/cuda:11.0-base image```: A sample GPU-based image that can run GPU workloads (```requires NVIDIA runtime```).

- **Deploy the GPU-Based Pod**

    Apply the YAML file to create the GPU-based pod:

    ```kubectl apply -f gpu-pod.yaml```

    Kubernetes will schedule this pod on **node3** since it has the right toleration and requests a GPU.

- **Verify the Pod is Running on Node3**

  Check where your gpu-app pod is scheduled:

  ```kubectl get pods -o wide```

  Expected output:

  ```
    NAME        READY   STATUS    NODE
    gpu-app     1/1     Running   node3
  ```

  The **gpu-app** pod should be running on **node3** because it has a matching toleration and requires a GPU.

- **Try to Deploy a Non-GPU Pod Without Toleration**

  Let’s try deploying a non-GPU application and see if it gets scheduled on node3.

  Create a YAML file named ```web-pod.yaml```:

    	```
        apiVersion: v1
        kind: Pod
        metadata:
          name: web-app
        spec:
          containers:
          - name: web-container
            image: nginx  # Non-GPU-based container image
      ```

    Apply this pod:

    ```kubectl apply -f web-pod.yaml```

    Since web-app doesn’t have the right toleration, Kubernetes will not schedule it on node3. Instead, it will be scheduled on one of the other nodes.

    To confirm, check where the **web-app** pod is running:

    ```kubectl get pod -o wide```

    Expected output:

    ```
      NAME        READY   STATUS    NODE
      gpu-app     1/1     Running   node3
      web-app     1/1     Running   node1  (or node2)
    ```

    
<br>
<br>
<br>

# Node Affinity in Kubernetes

Node Affinity is the feature of kubernetes which is used to schedule pods on nodes.

Node affinity is a way to tell kubernetes scheduler that these pods need to run on those particular nodes based on labels assigned to those nodes.

```Suppose kubernetes cluster मैं 2 worker nodes हैं| एक node पर HDD memory है और दूसरे node पर SSD memory है| तो हम कुछ pods को SSD memory वाले pods पर run करना चाहते है| तो उन pods को SSD memory वाले pods पर रन करने के लिए Node Affinity feature के through हम scheduler को बताते है की इन pods को इन nodes पर run करना है|```

Node affinity is a way to define where you want or require your pods to run based on labels assigned to nodes. It’s like saying, “I prefer my workload to run on a node with a certain characteristic,” or “I require it to be on a specific type of node.” Node affinity uses labels on nodes and helps ensure that pods are scheduled on nodes with specific properties, like SSD storage or GPUs, or in particular zones for regulatory or geographic reasons.

### Node Affinity Explained

Node affinity allows you to add rules to a pod that guide the scheduler on where (on which nodes) the pod should run. Node affinity is based on labels that are attached to nodes.

For example, if you want a pod to run on nodes with a label like disktype=ssd, you would use node affinity to make this happen. Node affinity works with **preferences** or **requirements**:
  - **Preferred**: Pods can run on other nodes if the preferred node is unavailable.
  - **Required**: Pods will only run if the required node is available.


### How Node Affinity Works: Example

Suppose you have a Kubernetes cluster with two nodes, and each node has different resources. One node has a label ```disktype=ssd```, indicating it has SSD storage. The other node has a label ```disktype=hdd```, indicating it has an HDD.

Now, let’s say you have a workload (a pod) that needs fast storage. You could use node affinity to make sure the pod runs on the node with ```disktype=ssd```.

Here’s how you’d set up the node affinity:

  - **Label the Node**: First, make sure the node has the correct label. For example:

      ```kubectl label nodes <node-name> disktype=ssd```

  - **Specify Node Affinity in the Pod Configuration**: In the pod configuration YAML file, you would specify the node affinity like this:

      ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: ssd-storage-pod
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: disktype
                    operator: In
                    values:
                    - ssd
          containers:
          - name: my-container
            image: my-container-image
      ```

      In this YAML example:

    - ```requiredDuringSchedulingIgnoredDuringExecution``` means the pod must be scheduled on a node that matches this requirement. If no node with ```disktype=ssd``` is available, the pod will not be scheduled.
   
    - ```matchExpressions``` defines the conditions, where the key is ```disktype```, the operator is ```In```, and the values array contains ssd. This combination specifies that the pod should only be scheduled on nodes with the label ```disktype=ssd```.

### Types of Node Affinity

In Kubernetes, there are two main types of node affinity:

  - ```requiredDuringSchedulingIgnoredDuringExecution```: This is a hard rule. The pod will only be scheduled on nodes that meet the criteria. If there are no matching nodes, the pod will remain unscheduled until one becomes available.

  - ```preferredDuringSchedulingIgnoredDuringExecution```: This is a soft rule. The pod prefers to be scheduled on nodes that meet the criteria, but if there aren’t any, it will be scheduled on another node. This is useful when you’d like the pod to run on specific nodes if possible, but it’s not essential.

### Why Use Node Affinity?

  Node affinity provides more flexibility and control over workload distribution compared to the older nodeSelector feature, which allowed pods to specify nodes by label but only with hard rules. Node affinity’s combination of required and preferred rules gives you options to define strict requirements or softer preferences.
  
  - **Optimization**: Helps ensure the pod runs on nodes with the right resources (like SSDs for databases).
  - **Flexibility**: You can set rules to make sure workloads end up on the right nodes without affecting other workloads in the cluster.


<br>
<br>

### Difference between Node Affinity and Taints and Tolerations (Which is better?)

**Recap on Node Affinity**

Node affinity is a way to define where you want or require your pods to run based on labels assigned to nodes. It’s like saying, “I prefer my workload to run on a node with a certain characteristic,” or “I require it to be on a specific type of node.” Node affinity uses labels on nodes and helps ensure that pods are scheduled on nodes with specific properties, like SSD storage or GPUs, or in particular zones for regulatory or geographic reasons.

For example, if you want a pod to run on nodes with a label like disktype=ssd, you would use node affinity to make this happen. Node affinity works with preferences or requirements:

  - **Preferred**: Pods can run on other nodes if the preferred node is unavailable.
  - **Required**: Pods will only run if the required node is available.

<br>

**What are Taints and Tolerations?**

Taints and tolerations, on the other hand, serve a different purpose. They are used to **restrict where pods are scheduled** by "tainting" nodes, which is like marking them as undesirable for most workloads. Taints are placed on nodes to signal that **only certain pods can tolerate them**. If a node has a taint, only pods with a matching toleration will be allowed to run on that node. This feature is often used to isolate special-purpose nodes or protect critical nodes from being overloaded.

  - **Taints** are key-value pairs with an effect like ```NoSchedule```, ```PreferNoSchedule```, or ```NoExecute```:

    - **NoSchedule**: No pod can be scheduled on this node unless it has a matching toleration.
    - **PreferNoSchedule**: Tries to avoid scheduling pods on this node unless no other option is available.
    - **NoExecute**: Not only prevents new pods without tolerations from being scheduled but also evicts existing pods that lack a matching toleration.
   
  Taints and tolerations are often used to keep general-purpose workloads off specialized nodes (like GPU nodes or nodes with limited resources). For example, you might taint a node with key=special-purpose, effect=NoSchedule, to indicate that only certain workloads can run on it.

  
**Key Differences Between Node Affinity and Taints/Tolerations**

- **Intent**:
    - Node Affinity: Used to guide where you want specific pods to run.
    - Taints/Tolerations: Used to restrict certain nodes so that only pods with a matching toleration can run on them.

- **Flexibility**:
    - Node Affinity: Flexible for assigning specific characteristics or requirements, like hardware or location preferences.
    - Taints/Tolerations: Ideal for marking certain nodes as “off-limits” for most workloads unless they can tolerate the conditions.

- **Behavior**:
    - Node Affinity: Works with preferred or required rules, making it possible to “softly” guide pod placement.
    - Taints/Tolerations: Harder restrictions where only specific pods are allowed on tainted nodes based on matching tolerations.

**When to Use Node Affinity vs. Taints/Tolerations**

  - **Use Node Affinity** when:
      - You want to “prefer” or “require” your workload to run on nodes with certain characteristics (like fast storage, GPUs, or being in a particular zone).
      - You’re okay with “guiding” Kubernetes on where pods should go but don’t need a strict restriction.
      - For example, if you have a node with label disktype=ssd and want your pod to prefer it, use node affinity.

  - **Use Taints and Tolerations** when:
      - You need to strictly limit certain nodes to only specific pods.
      - You want to keep general workloads off special-purpose nodes (like GPU nodes, critical infrastructure nodes, or nodes with limited resources).
      - For example, if you have a GPU node and don’t want regular workloads on it, you’d taint it with key=gpu, effect=NoSchedule and only allow pods with a matching toleration to run there.


**Which is Better and Why?**

Both node affinity and taints/tolerations are essential, and the choice depends on your scheduling needs:

  - Node Affinity is better if your goal is to “prefer” or “require” pods to run on nodes with specific characteristics, without strict restrictions. This makes it more flexible and suitable for many general-purpose workloads.

  - Taints and Tolerations are better if your goal is to completely “block” or restrict nodes to only certain workloads. This is often necessary in specialized environments, like ensuring only specific workloads run on nodes with expensive resources (like GPUs) or protecting critical nodes from general workloads.


**Using Node Affinity and Taints/Tolerations Together**

Many Kubernetes setups use both node affinity and taints/tolerations together to balance flexibility with strict control:

  - **Node Affinity to Guide Pod Placement**: You can use node affinity to guide pods towards specific nodes. For example, if you have nodes labeled for different geographical zones, you can use node affinity to prefer those nodes for specific workloads.

  - **Taints to Restrict Node Access**: If you want to strictly protect certain nodes (like high-performance or limited-resource nodes), you can use taints with NoSchedule to ensure only specific pods are allowed to run there.


<br>
<br>

### Example (LAB): Node Affinity

**Scenario Overview**

Imagine you have a Kubernetes cluster with multiple nodes, and these nodes differ in the types of storage they have. Your application has two components:
- A database that requires high-speed storage (SSD).
- A backend service that doesn’t require SSD and can run on any general-purpose storage (like HDD).

We’ll use node affinity to:

- Label the nodes based on the type of storage they have.
- Set up the database to only run on nodes with SSD storage.
- Allow the backend service to run on any node.

  **Prerequisites**

  - A running Kubernetes cluster with at least two nodes.
  - kubectl command-line tool configured to interact with your cluster.
  - Basic knowledge of using Kubernetes and YAML files.
 

  - **Step 1: Label the Nodes**

    - First, check the nodes in your cluster to get their names:

      ```kubectl get nodes```

      You should see a list of nodes in your cluster. Make note of the names of two nodes to use in this lab.

    - Label one node as disktype=ssd (for the database) and another as disktype=hdd (for the backend service):

      ```kubectl label nodes <ssd-node-name> disktype=ssd```
      ```kubectl label nodes <hdd-node-name> disktype=hdd```

      Replace <ssd-node-name> and <hdd-node-name> with the actual names of your nodes.

    - Verify that the labels have been applied:

      ```kubectl get nodes --show-labels```

      You should see disktype=ssd on one node and disktype=hdd on the other.

  - **Step 2: Create a Pod with Required Node Affinity (Database Pod)**

    Now, we’ll create a database pod that requires SSD storage using required node affinity. This pod will only run on nodes labeled disktype=ssd.

    - Create a file named database-pod.yaml:

      ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: database-pod
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: disktype
                  operator: In
                  values:
                  - ssd
          containers:
          - name: database-container
            image: mysql:5.7
            env:
            - name: MYSQL_ROOT_PASSWORD
              value: "password123"
      ```

      In this YAML:
      - requiredDuringSchedulingIgnoredDuringExecution: Means the pod will only be scheduled on nodes with the label disktype=ssd.
      - key: disktype, operator: In, values: - ssd: This sets up the rule that the pod should only run on nodes labeled with disktype=ssd.

    - Apply this configuration to your cluster:

      ```kubectl apply -f database-pod.yaml```

    - Check if the pod was successfully scheduled on the SSD node:

      ```kubectl get pod database-pod -o wide```

      The output should show the database pod running on the node labeled disktype=ssd. If no such node is available, the pod will remain in a "Pending" state until the node is available.

  - **Step 3: Create a Pod with Preferred Node Affinity (Backend Service Pod)**

    Now, we’ll create a backend service pod that prefers to run on an HDD node but can run on any node if an HDD node is not available.

    - Create a file named backend-pod.yaml:

      ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: backend-pod
        spec:
          affinity:
            nodeAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
              - weight: 1
                preference:
                  matchExpressions:
                  - key: disktype
                    operator: In
                    values:
                    - hdd
          containers:
          - name: backend-container
            image: nginx
      ```

      In this YAML:

      - preferredDuringSchedulingIgnoredDuringExecution: Means the pod prefers to be scheduled on a node with disktype=hdd but can run on other nodes if no such node is available.
      - weight: 1: Sets the preference weight. The scheduler will try to place the pod on an HDD node if possible but doesn’t require it.
     
    - Apply this configuration to your cluster:

      ```kubectl apply -f backend-pod.yaml```

    - Check where the backend pod was scheduled:

      ```kubectl get pod backend-pod -o wide```

      The output should show the backend pod on the node labeled disktype=hdd. If the HDD node is not available, Kubernetes will schedule it on any available node.

  - **Step 4: Verify and Observe Node Affinity in Action**

    Now let’s check that everything is working as expected.

    - Verify Pod Placement:

      Run ```kubectl describe pod database-pod``` and ```kubectl describe pod backend-pod``` to see the detailed information about the nodes each pod was scheduled on. Look for the Node-Affinity section in the output.

    
