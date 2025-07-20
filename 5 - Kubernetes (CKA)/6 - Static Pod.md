# Static pod in kubernetes

We know that scheduler schedule the pods on the worker nodes if new pod is going to be created. So, In general control plane components are responsible to create a pod on worker node. 

Control plane components run as a pod inside master node. So these important components are running as a pod. So who is responsible for these pods. I mean who is managing these pods. Here comes the concept of static pod.

### What is Static Pod?

Static pod is the component of control plane that is not managed by the schedular. Schedular is not respondible for these type of pods. So **Kubelet** component on the control plane is managing these important pods. The main task of static pod is make sure control plane components should be always up and running.

- ```Static Pod ek aisa pod hota hai jo kubelet directly run karta hai, bina kube-apiserver ke involvement ke.```
- ```Ye pod kubernetes control plane (like Deployment, ReplicaSet, Scheduler) se manage nahi hota.```
- ```Sirf kubelet hi is pod ko manage karta hai.```

We can say that static pod is the yaml manifest which are present in ```/etc/kubernetes/manifests/```.

A static pod in Kubernetes is a type of pod that is directly managed by the Kubernetes kubelet on a specific node rather than by the Kubernetes control plane (like the API server, controller manager, etc.). Unlike regular pods, which are created by controllers like Deployments or DaemonSets, static pods are managed by the kubelet itself. 

Static pods differ from other Kubernetes objects because:

- **They are not managed by the API server**: The kubelet directly manages the lifecycle of static pods on each node.
- **The kubelet only reads static pod configurations**: The kubelet checks the pod configuration file on the node’s filesystem and uses it to create and manage the pod.

<br>

### Static Pod ka use kab hota hai?
- Jab cluster boot ho raha ho (especially control plane nodes).
- Etcd, kube-apiserver, kube-scheduler jaise core components ko run karne ke liye.
- Jab tumhe kisi pod ko forcefully run karna ho bina cluster config ke.

<br>

### Why use static pod?

Static pods are typically used for running critical system components or tasks on a node where you need them to always run, even if the control plane is down. Here are some common use cases:

- **Node-specific monitoring**: Run a logging or monitoring tool directly on each node.
- **Critical services must always be running on a specific node**: You might want to ensure that certain services are always running on a given node, even if the Kubernetes control plane is unavailable.

Static pods ensure that essential components on a node continue to run even if the control plane is temporarily down, making them useful for node-specific tasks that don’t need to be scheduled across the whole cluster.

<br>

### How Static Pods Work

- **Configuration File**: Static pods are defined by YAML configuration files located on each node. Typically, these files are stored in a directory like ```/etc/kubernetes/manifests/```.

- **Kubelet Reads Configurations**: The kubelet regularly scans this directory for configuration files. When it finds a new pod configuration file, it creates the pod on the node.

- **Direct Management**: The kubelet manages the static pod directly, restarting it if it fails.

- **No API Server Representation**: Static pods do not have an API object managed by the Kubernetes API server. However, a mirror pod is automatically created in the API server for informational purposes, allowing users to view the pod status via kubectl.

<br>

### Example (LAB): Creating a Static Pod

Let’s say you want to run an Nginx web server as a static pod on a node to serve a simple webpage.

- **Write the Configuration File**: Create a file called static-nginx-pod.yaml with the following content:

  ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: static-nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
  ```

  - This configuration defines a pod named ```static-nginx```.
  - The pod has a container running the ```nginx:latest``` image, which will serve HTTP requests on port 80.

- **Save the File on the Node**: Save this file in the directory ```/etc/kubernetes/manifests/``` on the node where you want to run the pod. This directory is where the kubelet looks for static pod configurations.

- **Kubelet Creates the Pod**: The kubelet on that node reads the file, creates the ```static-nginx``` pod, and keeps it running. If the pod crashes, the kubelet will restart it.

- **View the Pod**: Even though this pod isn’t managed by the Kubernetes API, you can still see it using kubectl commands because of the mirror pod created in the API server:

  ```kubectl get pods -o wide```

  You should see the s```tatic-nginx``` pod listed, showing it’s running on the node.

- **Deleting the Pod**: To delete the static pod, simply delete the ```static-nginx-pod.yaml``` file from ```/etc/kubernetes/manifests/```. The kubelet will notice the file is gone and will stop the pod.


<br>
<br>

## Kya Control Plane ke Components Static Pods hote hain?

Haan, almost har case mein (especially kubeadm) control plane ke ye components static pods hote hain:
- kube-apiserver.
- kube-controller-manager.
- kube-scheduler.
- etcd (agar cluster ke andar hosted hai).

Ye sabhi static pod ke roop mein chalte hain.

<br>

**Static Pod hone ka matlab kya hai inke liye?**

"Static Pod" ka matlab:
- Inka YAML manifest file stored hota hai ek specific path pe:
```
/etc/kubernetes/manifests/
```
- In files ko kubelet read karta hai, aur bina API server ke directly ye pods create kar deta hai.
- In pods ka scheduler ya controller se koi lena dena nahi hota.

<br>

**Ek example: kube-apiserver ka static pod kaise hota hai?**

File path:
```
/etc/kubernetes/manifests/kube-apiserver.yaml
```

Isme likha hota hai pod definition:
```
apiVersion: v1
kind: Pod
metadata:
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - name: kube-apiserver
    image: k8s.gcr.io/kube-apiserver:v1.29.0
    command:
    - kube-apiserver
    - --advertise-address=192.168.0.100
    - --etcd-servers=https://127.0.0.1:2379
    ...
```

Observations:
- Ye ek normal pod jaisa lagta hai, par isse koi deployment, replicaSet, ya scheduler control nahi karta.
- Ye pod bas is file ke hone ki wajah se bana hai.
- Agar tum ye file delete kar doge to pod bhi turant delete ho jaayega.
- Agar file edit karoge to kubelet auto reload karke naye config ke saath pod dubara bana dega.


**Ye files kaha milti hain?**
```
/etc/kubernetes/manifests/
├── etcd.yaml
├── kube-apiserver.yaml
├── kube-controller-manager.yaml
├── kube-scheduler.yaml
```

Ye folder kubelet ke config mein defined hota hai with this flag, matlab kubelet ki configuration file main ye path likha hota hai jisse kubelet in pods yamls ki location se fetch karke khud se pod run kar deta hai.
```
--pod-manifest-path=/etc/kubernetes/manifests/
```

<br>

**Kya fayda hota hai control plane components ko static pod ke roop mein run karne ka?**
- Kube-apiserver ko pehle se run kar sakte hain bina scheduler/controller ke.
- Highly available and auto-recovered hote hain — kubelet ensure karta hai ki pod hamesha chale.
- Minimal dependency — no etcd needed initially.
- Bootstrapping ke liye perfect — cluster start hote hi ye pods turant up ho jaate hain.
- System level control — high privilege pods hain ye.

<br>
<br>

## Kya AKS cluster main control plane ke components static pod hi hote hain.

**Pehle samjho: kubeadm vs AKS kya farq hai?**:
| 🔧 kubeadm                                      | ☁️ AKS (Azure Kubernetes Service)                     |
| ----------------------------------------------- | ----------------------------------------------------- |
| Tum khud control plane setup karte ho           | Microsoft tumhare liye control plane manage karta hai |
| Tumhare master node pe components run hote hain | Control plane Azure ke managed infra pe hota hai      |
| Static pods `/etc/kubernetes/manifests/` mein   | Tumhe dikhai hi nahi dete                             |
| Full control tumhare paas                       | Control plane par koi access nahi                     |

<br>

**AKS Cluster mein control plane components static pods ke form mein hote hain?**

**Nahi** — tumhare AKS cluster mein control plane ke components static pod ke form mein nahi hote jo tum dekh sako.

Reason:
- AKS ek "managed Kubernetes service" hai.
- Isme control plane Microsoft ke control mein hota hai, aur ye completely abstracted hota hai tumse.
- Tumhare paas sirf worker nodes ka access hota hai.
- Tumhe ```kube-apiserver```, ```etcd```, ```scheduler```, ```controller-manager``` ka na to pod dikhai deta hai, na unki config.

Lekin internally kya hota hai?
- Internally, Azure bhi kubelet-based nodes use karta hai aur kahi na kahi static pod mechanism use hota hoga control plane banane ke liye.
- Lekin Microsoft ne us portion ko tumse hide kar diya hai as part of "managed service".

<br>

**To static pods sirf kubeadm clusters mein kyu dikhte hain?**

Kyunki:
- kubeadm ek tool hai jiski help se tum poora kubernetes cluster banate ho, aur ye koi managed service nahi jisme control plane ke components hide rahenge, isme complete kubernetes cluster ka control tumhare paas hota hai.
- Tumne kubelet ko configure kiya hai ```--pod-manifest-path=/etc/kubernetes/manifests/```.
- Tumne khud ```kube-apiserver.yaml```, ```etcd.yaml``` waghara waha rakhe hain.
- Isliye kubelet unhe padhta hai aur pods banata hai — isliye wo dikhai dete hain:
```
kubectl get pods -n kube-system
```

<br>

**AKS mein kubectl get pods -n kube-system karoge to kya milega?**

Tumhe sirf ye dikhai denge:
- ```coredns```.
- ```kube-proxy```.
- ```azure-ip-masq-agent```.
- ```metrics-server```.
- ```csi-```... type pods.
- ```cluster-autoscaler``` (agar enabled hai).

Tumhe ```kube-apiserver```, ```etcd```, ```kube-scheduler```, ```controller-manager``` nahi dikhai denge.

Kyun?
- Kyunki wo Microsoft ke infra pe chalte hain, aur tumhare cluster ke scope mein nahi hote.

<br>
<br>

### Mirror Pods

When the kubelet creates a static pod, it also creates a mirror pod in the Kubernetes API. This mirror pod allows you to see the static pod’s status using ```kubectl```, even though the pod isn’t actually managed by the API server.

For example, when you run ```kubectl get pods```, you’ll see the static pod listed, but it will have a special annotation marking it as a mirror pod.


### Real-Life Use Case: Running a Monitoring Agent as a Static Pod
