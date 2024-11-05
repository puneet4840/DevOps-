# DaemonSet in Kubernetes

A DaemonSet is a controller in kubernetes which make sure that a special type of pod runs on every node in the cluster.

```DaemonSet एक controller होता है जो make sure करता है की एक special pod हर node पर run करे|```

```DaemonSer ऐसे pod रन करता है जो सभी nodes पर हो जैसे की Logging Agent, Monitoring Agent. Logging Agent node के logs collect करेगा और Monitoring Agent CPU और Memory के metrics collect करेगा| तो ऐसा काम जो हमको सभी nodes पर करना है इसके लिए हम DaemonSer का use करते हैं|```

Sometimes, we have tasks that need to be done on every single node in our cluster for this purpose we create a DaemonSet on cluster which run that specified pod on each node of cluster.

### Why Do We Use DaemonSets?

Sometimes, we have tasks that need to be done on every single node in our cluster. For example:

- **Collect Logs**: You want to collect logs from every node so you can see what’s happening everywhere. For that we create DaemonSet for logging agents. Logging agent pod will run on every cluster for collecting logs.

- **Monitor Health**: You want to check the health or performance of each node (like CPU usage or memory). For that we create a DaemonSet for monitoring agent that will run on every node.

- **Manage Networking**: You might need tools that help with network routing or managing connections.

A DaemonSet ensures that such tools are automatically placed on every node.

<br>

### How DaemonSets Work?

- **Pods on Each Node**: When you create a DaemonSet, Kubernetes automatically starts one pod on every node.
- **New Nodes**: If you add a new node to the cluster, Kubernetes will automatically run the DaemonSet’s pod on that new node.
- **Removed Nodes**: If a node is removed, the DaemonSet’s pod is also stopped there.

<br>

### Example (Lab): Using DaemonSets for Logging

**Scenario: Centralized Logging in a Company**

**Problem**:

Imagine you are running an e-commerce website. Your website is hosted on a Kubernetes cluster with multiple nodes. Each node handles a part of the traffic and runs different parts of your application (like user services, order services, payment processing, etc.).

You need to:
- Collect logs from all the nodes.
- Centralize these logs in one place to easily monitor and debug your application.

**Solution**:

Use a DaemonSet to run a logging agent on every node. This logging agent will:

- Collect logs from all containers running on the node.
- Send these logs to a central log storage system (like Elasticsearch or a cloud logging service).

**Step-by-Step Example Using Fluentd**

**Fluentd** is a popular open-source log collector that you can use with a DaemonSet.

- **Fluentd Overview**:
  - Collects logs from applications.
  - Filters and processes them.
  - Sends them to a central location (like Elasticsearch).

- **Sends them to a central location (like Elasticsearch)**:
  
  Here’s how you can deploy Fluentd using a DaemonSet in Kubernetes.

  YAML File for Fluentd DaemonSet

  ```
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: fluentd
      namespace: kube-system  # Fluentd runs on all nodes, so we use the system namespace.
      labels:
        k8s-app: fluentd-logging
    spec:
      selector:
        matchLabels:
          k8s-app: fluentd-logging
      template:
        metadata:
          labels:
            k8s-app: fluentd-logging
        spec:
          tolerations:  # Ensures it can run on all nodes, even the master node.
          - key: node-role.kubernetes.io/master
            effect: NoSchedule
          containers:
          - name: fluentd
            image: fluent/fluentd:latest
            env:
            - name: FLUENT_ELASTICSEARCH_HOST
              value: "elasticsearch-service"  # Name of your Elasticsearch service.
            - name: FLUENT_ELASTICSEARCH_PORT
              value: "9200"  # Elasticsearch port.
            volumeMounts:
            - name: varlog
              mountPath: /var/log
            - name: varlibdockercontainers
              mountPath: /var/lib/docker/containers
              readOnly: true
          volumes:
          - name: varlog
            hostPath:
              path: /var/log
          - name: varlibdockercontainers
            hostPath:
              path: /var/lib/docker/containers
  ```

  Explaination of YAML:
  - DaemonSet: Ensures that Fluentd runs on every node.
  - Namespace: We use kube-system so Fluentd operates as part of the system-level tasks.
    
  - Containers:
    - Fluentd is the logging agent.
    - It reads logs from ```/var/log``` (where system logs are stored) and ```/var/lib/docker/containers``` (where container logs are stored).

  - Environment Variables:
    - FLUENT_ELASTICSEARCH_HOST and FLUENT_ELASTICSEARCH_PORT point Fluentd to where it should send the logs (Elasticsearch in this case).
   
  - Volumes:
    - Fluentd accesses logs from specific paths on the host machine.

- **Deploy the DaemonSet**:
  
  Save the above YAML to a file, say ```fluentd-daemonset.yaml```, and run:

  ```
    kubectl apply -f fluentd-daemonset.yaml
  ```

  Kubernetes will:
  - Deploy a Fluentd pod on every node.
  - Fluentd will start collecting logs from the node and its containers.
  - Send logs to your central Elasticsearch.

- **What Happens in the Background**

  - Fluentd Starts: On each node, Fluentd reads logs from ```/var/log``` and ```/var/lib/docker/containers```.
  - Log Collection: It gathers logs from system services and all containers running on the node.
  - Log Processing: Fluentd can filter or modify the logs as needed (e.g., remove sensitive data, format logs).
  - Log Shipping: Fluentd sends the processed logs to the central logging service, such as Elasticsearch.
