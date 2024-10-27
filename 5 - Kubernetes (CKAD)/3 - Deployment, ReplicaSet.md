### What is Deployment?

Deployment is the process in kubernetes which is responsible for controlling the behavior of a pod.

```OR```

Deployment is the process that is used to manage your pods. Because deployment file has the specification related to the pod.

```Deployment actually kubernetes cluster को Auto - Healing, Auto - Scaling जैसे features provide करता है क्युकी एक deployment YAML file मैं Pod के बारे मैं Auto - Healing, Auto - Scaling, कोनसी container image use करनी है, कोनसे port पर container run करना है. ये सारी information deployment YAML file मैं लिखी होती है.```

```जैसे हम चाहते हैं की Node मैं pod के 2 replica होने चाइये. तो इस specification को हम deployment.yaml file मैं mention कर देंगे फिर replica-set 2 pods बना देगा.```

A **Deployment** in Kubernetes is a way to define the desired state of an application. It manages how your application is run, updated, and scaled, automating the creation and management of application instances.

<br>

**Note**: The standard rule is we only create the deployment then pod is created after the deployment automatically. We don't need to create a pod itself using yaml file. We only create deployment.

<br>

**e.g.,** Sample deployment.yaml file nginx application.
```
# deployment.yaml
apiVersion: apps/v1             # The API version for the Deployment resource
kind: Deployment                # This is a Deployment object
metadata:
  name: nginx-deployment         # The name of the Deployment
spec:
  replicas: 3                   # Number of Pods we want running at any given time
  selector:
    matchLabels:
      app: nginx                # Label selector to find and manage Pods
  template:
    metadata:
      labels:
        app: nginx              # Label assigned to each Pod
    spec:
      containers:
      - name: nginx
        image: nginx:latest     # The Docker image for our web server
        ports:
        - containerPort: 80     # The port Nginx will listen on inside the container

```

**Explaination of each section of YAML file**:

- ```# deployment.yaml```

    This line is a comment that shows the filename. Comments are only meant for humans reading the file and are ignored by Kubernetes.

- ```apiVersion: apps/v1```

    The **apiVersion** field defines which version of the Kubernetes API is used to create this Deployment. The API version can change over time as Kubernetes improves, so we specify apps/v1 here to use the most current Deployment API.

- ```kind: Deployment```

    The **kind** field tells Kubernetes what type of resource we are creating. In this case, Deployment means Kubernetes will treat this as a Deployment object. Other options could be Pod, Service, etc., but Deployment is used to manage multiple identical Pods.

- ```metadata:```
       ```name: nginx-deployment```

    The metadata section contains identifying information about the resource. Here, we specify a name nginx-deployment. This name is how Kubernetes identifies this Deployment among all other resources. Names help us manage and refer to resources easily.

- ```spec:```
       ```replicas: 3```

<br>

### Difference between Container, Pod and Deployment.

- **Container**: ```हम containers बनाते हैं तो command लिखकर बनाते हैं जैसे "docker run -itd -p 3000:3000 image_name .", जो की docker tool का use करके create हैं. Container सिर्फ एक runtime environment है.```

- **Pods**: ```जब kubernetes market मैं आया तो kubernetes ने decide  किया की हम container बनाने के लिए enterprise model को use करें इसका मतलब है की container बनाने के लिए हम command का use न करके एक file के अंदर वही सब लिख लेते हैं जो container बनाने के लिए docker मैं commands लिखते हैं. तो pod एक running specification होता है ```

- **Deployment**: ```Kubernetes ने pod तो बना लिया अब pod को Auto-Heal, Auto-Scale कैसे किया जाये. तो यहाँ deployment process का use किया जाता है. एक deployment.yaml file बनाई जाती है, जिसमे pods की specification और Auto-Scaling के बारे मैं लिखा होता है. तो deployment यहाँ replica set के साथ मिलकर auto - scaling करता है. ```

<br>

### What is Replica-Set?

A replica set is a controller in the kubernetes that make sure the specified number of pods should be running in your kubernetes cluster.

```यह एक controller होता है को kubernetes cluster की actual state को desired state बनाने का काम करता है. जो configuration deployment.yaml file मैं लिखी जाती है, उसी desired state को replica-set cluster के अंदर maintain करता है.```

A **ReplicaSet** in Kubernetes ensures a specified number of Pods (instances of your application) are running at any time.

**Features of ReplicaSet**

- **Maintains Pod Count**: If you specify that three Pods should be running, the ReplicaSet will create new ones if any go down.

- **Part of Deployment**: Usually, you don’t manage a ReplicaSet directly. When you create a Deployment, it automatically creates and manages the ReplicaSet for you.
