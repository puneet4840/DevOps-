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


<br>
<br>

# Cronjob in Kubernetes

A **Cron job** is a way to run the specific tasks automatically at specific times, dates, or intervals, much like the traditional cron jobs in Linux.

**Why Use a CronJob?**

- Perform routine maintenance tasks, like cleaning up logs or temporary files.
- Backup your database regularly.
- Run reports at the end of every day.
- Send emails or notifications on a schedule.

**How Does a CronJob Work?**

A CronJob manages the execution of Jobs in Kubernetes. A Job is a one-time task that runs to completion. A CronJob schedules and runs these jobs at specified times.

**Key Concepts**

- **Schedule**: Defines when the job should run. It uses cron syntax (e.g., */5 * * * * for every 5 minutes).
- **Job Template**: Specifies what the job will do when it runs.
- **Concurrency Policy**: Controls how jobs run if the previous job is still running.
- **Starting Deadline**: How long Kubernetes should wait before aborting a job that couldn’t start on time.
- **History Limits**: How many successful or failed job instances Kubernetes should keep.

**Cron Syntax**

```
* * * * *
| | | | |
| | | | +---- Day of the week (0 - 7) (Sunday is 0 or 7)
| | | +------ Month (1 - 12)
| | +-------- Day of the month (1 - 31)
| +---------- Hour (0 - 23)
+------------ Minute (0 - 59)

```

Examples:

- ```*/5 * * * *``` – Every 5 minutes.
- ```0 0 * * *``` – Every day at midnight.
- ```0 9 * * 1``` – Every Monday at 9 AM.

<br>

### Example(LAB): Database Backup

Let’s create a CronJob that backs up a database every night at midnight. Automates daily backups of a PostgreSQL database. Backup files on the host machine’s /mnt/backups directory.

```
apiVersion: batch/v1
kind: CronJob
metadata:
  name: db-backup
spec:
  schedule: "0 0 * * *"  # Every day at midnight
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: backup
            image: postgres:13
            env:
            - name: PGHOST
              value: your-db-host
            - name: PGUSER
              value: your-db-user
            - name: PGPASSWORD
              value: your-db-password
            - name: PGDATABASE
              value: your-database
            command:
            - /bin/sh
            - -c
            - pg_dumpall -h $PGHOST -U $PGUSER > /backups/db-$(date +\%Y-\%m-\%d).sql
          restartPolicy: OnFailure
          volumes:
          - name: backup-volume
            hostPath:
              path: /mnt/backups
          volumeMounts:
          - name: backup-volume
            mountPath: /backups

```

Explanation:
- schedule: Runs at midnight daily.
- PostgreSQL container: Runs the ```pg_dumpall``` command to back up the database.
- Volumes: Saves the backup to ```/mnt/backups``` on the host machine.

**Applying the CronJob**

- Save the above YAML as ```cronjob.yaml```.

- Apply it using:

  ```kubectl apply -f cronjob.yaml```

- Check the status of the CronJob:

  ```kubectl get cronjob```

- View logs of a completed job:

  ```kubectl get jobs```

- Then, view the logs of a specific job (replace JOB_NAME with the actual job name):

  ```kubectl logs job/JOB_NAME```


**What Happens During Execution?**

- **Midnight Trigger**:

  - At midnight each day, Kubernetes triggers this CronJob.

- **Job Creation**:

  - A Job is created based on the defined template.

- **Pod Execution**:

  - A Pod is launched running the ```postgres:13``` container.
  - The ```pg_dumpall``` command runs, connecting to the specified database using the provided environment variables.
 
- **Backup Storage**:

  - The backup is saved to ```/backups/db-YYYY-MM-DD.sql``` within the container.
  - This directory is mapped to ```/mnt/backups``` on the host, ensuring the backup persists outside the container.
 
- **Restart on Failure:**

  - If the job fails, Kubernetes will retry it based on the ```OnFailure``` policy.
 

**Example Output**

If today is ```November 3, 2024```, the backup file will be named ```db-2024-11-03.sql``` and stored in ```/mnt/backups``` on the host machine.
