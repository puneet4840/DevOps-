# etcd Backup and Restore for Disaster Recovery

Here, We are going to learn how to take backup of etcd database when kubernetes cluster's control plane goes down or unreachable. Same we will learn how to restore the backup to make kubernetes cluster up and running again in the same configuration it was running when it was healthy.

### What is etcd in Kubernetes?

- **Role of etcd**: In a Kubernetes cluster, etcd is a **key-value database** that stores all of the critical information about the cluster’s state. It is essentially the brain of the Kubernetes cluster.

- **What Does etcd Store?**:

  - All Kubernetes objects: Every resource in the cluster, such as pods, services, deployments, nodes, secrets, and configurations, is stored in etcd.
 
  - Cluster configuration: etcd stores the configuration settings that define how Kubernetes runs and interacts with its components.
 
  - Current state of the cluster: etcd tracks the current state of the cluster, so Kubernetes can manage workloads and enforce desired states.
 
- **Why is etcd Critical?**

  - Single Source of Truth: etcd is the only place where the entire cluster’s state is saved. If etcd fails or is deleted, Kubernetes has no way of knowing the state of the cluster and loses its ability to manage the applications running in the cluster.
 
  - Required for Recovery: Since etcd stores all the configuration and state data, it’s necessary to restore etcd data in case of any disaster (hardware failure, accidental deletion, etc.) to bring the cluster back to a working state.
 
Think of etcd as the control center of the cluster. Losing it would be like losing the entire cluster’s memory—without it, Kubernetes would not be able to keep track of any of its components.

<br>

### Understanding etcd Backup and Why It’s Essential

Since etcd is so critical, **backing it up** is essential for:
- **Disaster Recovery**: If etcd fails, you can restore a backup to get your cluster’s state back to a previous healthy point.
- **Protecting Against Data Loss**: Backups protect against accidental deletions or corruption of data.
- **Ensuring Business Continuity**: For production environments, etcd backups are crucial to maintain application availability and prevent long downtimes.

A **backup** is simply a snapshot of the entire etcd data at a particular moment. If anything goes wrong, you can restore etcd to this snapshot to revert the cluster to the backed-up state.

### How etcd Works in Kubernetes

etcd is a distributed database that stores information in a key-value format. Here’s a simple view of how etcd keeps track of data in a cluster:

- **Keys**: Represent different objects and resources in the cluster, like a pod, service, or node.
- **Values**: Represent the details of each resource, like its configuration and state.

Every time you create a Kubernetes object (like a pod or deployment), Kubernetes stores that object’s data as a key-value pair in etcd. This lets Kubernetes track and manage the state of each object.

### How Do You Access etcd?

To work with etcd directly, we use the **etcdctl** command-line tool, which allows you to:
- Take backups (snapshots) of the etcd database.
- Restore etcd from a snapshot in case of failure.

**etcdctl** connects to the etcd service using specific URLs and certificates. This tool is necessary for managing the etcd database.

<br>

## Step-by-Step Guide to Taking an etcd Backup

Let’s go through a basic workflow to take a backup of etcd. Assume we have a Kubernetes cluster and we want to take a snapshot to ensure we can restore the cluster in case of failure.

### Step 1: Prepare Environment Variables

To take a backup, we need to set up environment variables that help ```etcdctl``` connect to the etcd service securely. These variables specify the **API version**, **CA certificate**, **server certificate**, and **server key** that are necessary for secure communication.

These are typically located on the Kubernetes master node at ```/etc/kubernetes/pki/etcd/```.

- **Set Environment Variables**:

  ```
  export ETCDCTL_API=3  # Specifies the etcd API version (version 3) to use
  export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt  # Path to the CA certificate
  export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt  # Path to the etcd server certificate
  export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key  # Path to the etcd server key
  ```

  Explaination:
  - ETCDCTL_API: This sets the etcd API version, with 3 being the latest version.
  - ETCDCTL_CACERT: The CA certificate verifies the identity of the etcd server.
  - ETCDCTL_CERT: The server certificate authenticates requests to etcd.
  - ETCDCTL_KEY: The server key is paired with the server certificate for secure communication.

- **Why Are These Variables Necessary?**

  - They ensure ```etcdctl``` communicates securely with etcd, which is important since etcd holds sensitive cluster information.
  - They allow the etcd backup and restore process to run with the right access permissions.
 
- **Example Command after Setting Variables**:

  Once set, you can verify the etcd connection using:

  ```
  etcdctl --endpoints=https://127.0.0.1:2379 endpoint health
  ```

  If this command returns “healthy,” you’re connected and ready to take a backup.

### Step 2: Take the Snapshot Backup

Now that ```etcdctl``` is connected to etcd, we can take a snapshot backup. This snapshot will store all the data in etcd, allowing us to recover the cluster state if needed.

- **Snapshot Command**:

  ```
  etcdctl --endpoints=https://127.0.0.1:2379 snapshot save /path/to/backup/etcd-snapshot.db
  ```

  Explaination:

  - ```--endpoints=https://127.0.0.1:2379```: The etcd server’s location, usually localhost (```127.0.0.1```) with port ```2379```.
  - ```snapshot save```: Command to save the snapshot
  - ```/path/to/backup/etcd-snapshot.db```: Path to the snapshot file, where you specify the directory and filename (e.g., ```/var/backups/etcd/etcd-snapshot-2023-11-24.db```).

- **Example Explanation**:

  - Running this command will create a file named ```etcd-snapshot.db``` in the specified path.
  - This snapshot file contains all etcd key-value data, which you can use later for restoration.

- **Why Take a Snapshot?**

  The snapshot preserves the cluster’s current state, making it possible to revert the cluster to this specific point if there’s an issue.

### Step 3: Verify the Snapshot Backup

Once the backup is taken, it’s essential to verify it to ensure the backup file is valid and complete.

- **Snapshot Status Command**:

  ```
  etcdctl --write-out=table snapshot status /path/to/backup/etcd-snapshot.db
  ```

  Explaination:

  - ```--write-out=table```: Outputs the snapshot status in a table format for easy reading.
  - ```snapshot status```: Command to check the snapshot’s status.
