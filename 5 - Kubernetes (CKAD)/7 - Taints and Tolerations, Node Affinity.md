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

    - requiredDuringSchedulingIgnoredDuringExecution: This is a hard rule. The pod will only be scheduled on nodes that meet the criteria. If there are no matching nodes, the pod will remain unscheduled until one becomes available.
