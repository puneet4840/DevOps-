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


