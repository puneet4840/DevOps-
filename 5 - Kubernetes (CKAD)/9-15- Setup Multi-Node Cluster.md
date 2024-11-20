# Setup Multi-Node kubernetes cluster using Kubeadm

We’re going to set up a multi-node Kubernetes cluster using Azure Virtual Machines (VMs) and kubeadm, which is a tool to easily set up Kubernetes clusters. We'll have one Control Plane (Master) and two Worker Nodes.

Usually, We use self-managed kubernetes cluster from cloud providers like AKS, EKS, GKE. These are created and managed by cloud providers. We can not manage the control-plane on it. 

So, In this lab we are going to create a kubernetes cluster using using azure vms and kubeadm tool. We will create 3 vms seperately and join them to work as a kubernetes cluster. This setup will be called kubernetes cluster when it has all the componenets like api server, scheduler, etcd, container-runtime. We will setup each k8s service on one of the vm which will make it master node. Then we will join the other two vms those will work as worker nodes.

Let's first understand what is **Kubeadm**.

### What is Kubeadm?

Kubeadm is a command-line tool for setting up Kubernetes cluster quickly and efficiently. It helps you set up a Kubernetes control plane (master node) and join worker nodes to the cluster with minimal configuration.

**Kubeadm Workflow Overview**

Kubeadm works in two main steps:

- **Initialize the Control Plane**:
  - kubeadm init sets up a master node by installing the required control plane components.
  - It generates a configuration file, cryptographic certificates, and a token to add worker nodes.

- **Join Worker Nodes**:
  - kubeadm join adds worker nodes to the cluster using the token and configuration provided by the init step.

<br>
<br>
<hr>

## Setup of a Multi-Node Kubernetes Cluster Using Azure VMs and Kubeadm.

This guide explains how to create a multi-node Kubernetes cluster using 3 Azure VMs (1 control plane node and 2 worker nodes) with kubeadm. The instructions cover all steps from VM creation to cluster setup.

### What are We Building?


