# Network Policies in Kubernetes

Network Policies are like firewall rules in kubernetes which controls the communication between the pods. 

```Network policies containers के बीच मैं network को manage करती है जैसे की अगर cluster मैं 3 pods हैं, Frontend, Backend, Database. तो by default ये तीनो आपस मैं एक दूसरे से connect कर सकते हैं| लेकिन हम चाहते हैं की सिर्फ Backend pod ही database pod से connect करे तो ये हम network policies के through rules define करके कर सकते हैं|```

Network Policies are especially useful in production environments for securing traffic flows between pods and protecting sensitive applications or data.

### What are Network Policies?

In kubernetes:
- **Pods** are allowed to talk to each other by default (no restrictions).
- **Network** Policies allow you to restrict this default behavior by defining rules about which pods can communicate with each other or with external networks.
- You create Network Policies using YAML configuration files, which define which pods can send or receive traffic and under what conditions.

### Key Concepts in Network Policies

Before diving into examples, let’s understand some key concepts in Network Policies.

- **Pod Selector**

  The Pod Selector is used to specify which pods a Network Policy applies to. You select pods based on labels (labels are just identifiers like ```app: frontend``` or ```role: database``` that you attach to your pods).

  For example:
  - You have a ```frontend``` pod and a ```database``` pod.
  - You want to create a network policy that only affects the ```database``` pod.
 
  To do this, you would use a pod selector with the label ```role: database``` in your policy. This means only the database pod will follow the rules in this network policy.

  Example:

  ```
    podSelector:
      matchLabels:
        role: database
  ```

  In this case, only the pods labeled with ```role: database``` will be affected by the policy. Other pods with different labels won’t be affected.

- **Namespace Selector**

  A Namespace Selector lets you control communication between different namespaces. In Kubernetes, namespaces are like separate areas within your cluster, often used for different projects or environments (e.g., ```dev```, ```test```, ```prod```).

  Let’s say you have:

  - ```frontend``` pods in a namespace called ```dev```.
  - ```database``` pods in a namespace called ```prod```.

  If you want the ```dev``` namespace pods to talk to ```prod``` namespace pods, you can create a rule that allows ```dev``` namespace pods to communicate with ```prod``` namespace pods.

  Example:

  ```
    namespaceSelector:
      matchLabels:
        project: dev
  ```

  Here, only the namespaces labeled with project: dev will be allowed to communicate with the selected pods.

- **Policy Types: Ingress and Egress**

  Network policies have two main policy types:
  - **Ingress**: Controls incoming traffic to a pod (like doors where data can come in).
  - **Egress**: Controls outgoing traffic from a pod (like doors where data goes out).

  Ingress rules control who can talk to the pod, while Egress rules control who the pod can talk to.

  If a network policy only has Ingress rules, it only restricts incoming communication to the pod; outgoing communication is still open unless you add Egress rules.

  ```
    policyTypes:
    - Ingress
    - Egress
  ```

  This example means the policy will control both incoming and outgoing traffic for the selected pods.

- **Ingress Rules (Incoming Traffic Rules)**

  Ingress Rules define which other pods or resources can send traffic to your pod. Each rule specifies:
  - **From**: Where the incoming traffic is allowed to come from (specific pods, IP ranges, or namespaces).
  - **Ports**: Which port numbers can be used to connect to the pod.

  Imagine you have a database pod and want to allow only frontend pods to connect to it on port 5432 (a common database port). You would set up an Ingress rule like this:

  ```
    ingress:
      - from:
        - podSelector:
            matchLabels:
              app: frontend
        ports:
          - protocol: TCP
            port: 5432
  ```

  This rule means:
  - Only pods with the label ```app: frontend``` can communicate with the ```database``` pod.
  - They can only connect on TCP port 5432.

- **Egress Rules (Outgoing Traffic Rules)**

  Egress Rules control outgoing traffic from the selected pods. Similar to Ingress, you can specify:
  - **To**: Where the outgoing traffic is allowed to go (specific pods, IP ranges, or namespaces).
  - **Ports**: The ports used for outgoing traffic.

  Let’s say your ```database``` pod needs to communicate with an external logging service at a specific IP on port ```1234```. You can create an Egress rule like this:

  ```
    egress:
      - to:
        - ipBlock:
            cidr: 192.168.1.0/24
        ports:
          - protocol: TCP
            port: 1234
  ```

  This rule means:
  - The database pod can only send data to IP addresses in the 192.168.1.0/24 range.
  - It can only use TCP port 1234 to communicate.

- **IP Block**

  The IP Block allows you to specify a range of IP addresses that can communicate with the pod. This is helpful if you want to allow or block certain IPs, such as external services or specific subnets in your network.

  For example:

  ```
    from:
      - ipBlock:
          cidr: 10.0.1.0/24
  ```

  In this example, only IP addresses within the ```10.0.1.0/24``` range are allowed to communicate with the pod.

  You can also specify exceptions within an IP block, which is helpful when you want to block certain IPs in an otherwise allowed range.


### Basic Structure of a Network Policy

A Network Policy has the following structure:

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-some-traffic  # Name of the policy
  namespace: default  # Namespace where the policy is applied
spec:
  podSelector:
    matchLabels:
      app: myapp  # Selects the pods this policy applies to
  policyTypes:
  - Ingress  # Defines incoming traffic rules
  - Egress   # Defines outgoing traffic rules
  ingress:   # Rules for incoming traffic
  - from:
      - podSelector:
          matchLabels:
            app: frontend
  egress:    # Rules for outgoing traffic
  - to:
      - namespaceSelector:
          matchLabels:
            project: anothernamespace
```

### Examples of Network Policies

**Example 1: Deny All Incoming Traffic**

This Network Policy denies all incoming (Ingress) traffic to a pod. It’s a good starting point for securing an application, as you can then allow only specific traffic that’s needed.

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

Explaination:
- podSelector is empty ({}), which means it applies to all pods in the namespace.
- No ingress rules are specified, so no incoming traffic is allowed.

<br>

**Example 2: Allow Incoming Traffic from Specific Pods**

This Network Policy allows only pods with the label ```app: frontend``` to talk to pods with the label ```app: myapp``` within the same namespace.

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-frontend
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  ingress:
  - from:
      - podSelector:
          matchLabels:
            app: frontend
```

Explaination:
- podSelector selects pods labeled app: myapp
- Ingress rule:
  - from: Allows traffic only from pods with the label app: frontend.
- Other traffic will be denied by default because we haven’t specified additional sources

<br>

**Example 3: Allow Outgoing Traffic to Specific Namespace**

This policy allows pods labeled ```app: backend``` to communicate only with pods in a namespace that has the label ```project: trusted```.

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-egress-to-trusted-namespace
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Egress
  egress:
  - to:
      - namespaceSelector:
          matchLabels:
            project: trusted
```

Explaination:
- podSelector targets pods labeled app: backend.
- Egress rule:
  - to: Restricts outgoing connections to only pods within namespaces labeled project: trusted.

<br>

**Example 4: Allow Incoming Traffic on Specific Port**

This policy allows traffic to pods labeled ```app: database``` only on TCP port ```5432``` (for example, a PostgreSQL database).

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-database-port
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: database
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - protocol: TCP
      port: 5432
```

Explaination:
- podSelector applies this policy to pods labeled app: database.
- Ingress rule:
  - Allows incoming TCP traffic only on port 5432.

<br>
<br>

### Example(LAB): Network Policies for a Microservices Application

To get hands-on experience with Kubernetes Network Policies, let's go through a real-life lab scenario where you'll create and apply network policies in a Kubernetes environment. This example will simulate a simple microservices application setup.

**Scenario**

Suppose you have a Kubernetes cluster running a microservices application with three components:

- **Frontend**: A web application that users can access.
- **Backend**: A service that processes requests from the frontend.
- **Database**: A service where data is stored.

In this lab, we’ll:

- Create separate namespaces for each component.
- Deploy pods for each service.
- Apply network policies to control communication between these services.

- **Step 1: Set Up Namespaces**

  Namespaces logically separate components within the cluster. We'll create three namespaces: ```frontend```, ```backend```, and ```database```.

  - Create the Frontend Namespace:

    ```kubectl create namespace frontend```

  - Create the Backend Namespace:

    ```kubectl create namespace backend```

  - Create the Database Namespace:
 
    ```kubectl create namespace database```

  This setup isolates each component in its own namespace.

<br>

- **Step 2: Deploy Example Pods in Each Namespace**

  Now, let’s deploy pods in each namespace to simulate the application’s components.

  - Deploy Frontend Pod: Create a yaml file ```frontend-pod.yaml```

    ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: frontend
        namespace: frontend
        labels:
          app: frontend
      spec:
        containers:
        - name: frontend
          image: nginx
          ports:
          - containerPort: 80
    ```

    Apply the yaml using below command:

    ```kubectl apply -f frontend-pod.yaml```

  - Deploy Backend Pod: Create a ```backend-pod.yaml```

    ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: backend
        namespace: backend
        labels:
          app: backend
      spec:
        containers:
        - name: backend
          image: nginx
          ports:
          - containerPort: 8080
    ```

    Apply the yaml using below command:

    ```kubectl apply -f backend-pod.yaml```

  - Deploy Database Pod: Create a database-pod.yaml

    ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: database
        namespace: database
        labels:
          app: database
      spec:
        containers:
        - name: database
          image: nginx
        ports:
        - containerPort: 5432
    ```

    Apply the yaml using below command:

    ```kubectl apply -f database-pod.yaml```

  Now you have three pods representing different parts of the application, each running in its own namespace.

<br>

- **Step 3: Allow Frontend to Backend Communication**

  The first network policy will allow traffic only from the frontend namespace to the backend namespace. This is useful because you want your frontend pod to interact with backend, but restrict access to the backend from any other source.

  - Define and Apply Network Policy in Backend Namespace:
 
    ```
      cat <<EOF | kubectl apply -f -
      apiVersion: networking.k8s.io/v1
      kind: NetworkPolicy
      metadata:
        name: allow-frontend-to-backend
        namespace: backend
      spec:
        podSelector:
          matchLabels:
            app: backend
        policyTypes:
        - Ingress
        ingress:
        - from:
          - namespaceSelector:
              matchLabels:
                name: frontend
          ports:
          - protocol: TCP
            port: 8080
      EOF
    ```

    Explanation:
    - podSelector: Targets the backend pod.
    - policyTypes: Specifies that this policy is for Ingress (incoming traffic).
    - ingress: Defines rules for incoming traffic, allowing only the frontend namespace to connect on port 8080.

    With this policy applied, only the frontend pod is allowed to communicate with the backend pod on port 8080.

<br>

- **Step 4: Allow Backend to Database Communication**

  Now, create a network policy that allows the ```backend``` pod to talk to the ```database``` pod, but restricts all other access to the database.

  - Define and Apply Network Policy in Database Namespace:

    ```

    ```cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-backend-to-database
  namespace: database
spec:
  podSelector:
    matchLabels:
      app: database
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          name: backend
    ports:
    - protocol: TCP
      port: 5432
EOF
