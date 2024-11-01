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

  <img src="https://drive.google.com/uc?export=view&id=1BS91cKgU8ehENzEpLQmpEdXoibEmDNIl">

  **Why do we need ClusterIP?**

  Imagine you have an application with multiple components (like a frontend and a backend) running in different pods. The frontend needs to talk to the backend to get data. Without a stable IP address, it would be hard for the frontend to reliably find the backend pod if it restarts or moves to a different node. A ClusterIP Service provides a fixed IP and DNS name for the backend so that the frontend can always reach it, even if the backend moves or scales up/down.

  
