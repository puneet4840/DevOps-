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

