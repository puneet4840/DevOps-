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

We’re creating a Kubernetes cluster from scratch using virtual machines where:

- Control Plane (Master) manages the cluster.
- Worker Nodes run the applications (pods).

For example:
- Master (Control Plane): Think of this as the manager
- Worker Nodes: Think of these as the workers who actually do the work.

### What Do You Need?

- **Three Azure Virtual Machines (VMs)**:
  - One for the Master (Control Plane).
  - Two for Worker Nodes.
  - Each VM runs Ubuntu 20.04.

- **Install Kubernetes tools on the VMs**:
  - ```kubeadm```: For setting up the cluster.
  - ```kubelet```: Runs the pods on nodes.
  - ```kubectl```: A command-line tool to manage Kubernetes.

- **Networking**:
  - Open the required ports in Azure for the VMs to communicate.

### Steps to follow

<img src="https://drive.google.com/uc?export=view&id=1mbf0fgd0LD5Mbji-zSHbtqzq1giP2r54" width="450" heigth="650">

### Steps to Set Up the Cluster

**Step-1: Create Virtual Machines (VMs)**

In Azure:
- Create 3 VMs (Ubuntu 20.04) with the following names:
  - Master Node: ```k8s-master```
  - Worker Node 1: ```k8s-worker1```
  - Worker Node 2: ```k8s-worker2```

- Allocate static private IPs to these VMs so they can communicate within the cluster.

<br>

**Step-2: Connect to the VMs**

- Use SSH to log in to the VMs.
  
  Example:

  ```ssh azureuser@<VM_IP>```

  Do this for all three VMs (Master and Workers).

<br>

**Step-3: Disable Swap on Each VM**

Kubernetes doesn’t work with swap enabled:

```
  sudo swapoff -a
  sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```

Explaination:

- What is it?: Disables the swap memory on your machine.
- Why is it needed?
  - Kubernetes requires predictable performance, and swap can introduce delays.
  - The kubelet (Kubernetes node agent) refuses to run if swap is enabled because it assumes all memory allocated to pods is real RAM.

<br>

**Step-4: Enable IPv4 Forwarding and Bridged Traffic on Each VM**

Run these commands on all three VMs (Master and Workers):

```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
```

What it above does:
- Adds and loads kernel modules (overlay, br_netfilter) needed by Kubernetes to manage networking.

```
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
```

What it above does:
- Enables traffic forwarding for both IPv4 and IPv6 and ensures Kubernetes can process bridged traffic.

```
lsmod | grep br_netfilter
lsmod | grep overlay
```

What is above does:
- Verify that the br_netfilter, overlay modules are loaded by running the following commands

```
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward
```

What is above does:
- Verify that the net.bridge.bridge-nf-call-iptables, net.bridge.bridge-nf-call-ip6tables, and net.ipv4.ip_forward system variables are set to 1 in your sysctl config by running the following command

Why these above all steps neede:
- Kubernetes networking requires forwarding and proper handling of bridged traffic to route packets across pods.

<br>

**Step-5: Install Kubernetes Tools on All VMs**

Run these commands on all three VMs (Master and Workers):

- **Install Container Runtime (containerd)**

  Kubernetes needs a container runtime to run pods.

  ```
    curl -LO https://github.com/containerd/containerd/releases/download/v1.7.14/containerd-1.7.14-linux-amd64.tar.gz
    sudo tar Cxzvf /usr/local containerd-1.7.14-linux-amd64.tar.gz
    curl -LO https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
    sudo mkdir -p /usr/local/lib/systemd/system/
    sudo mv containerd.service /usr/local/lib/systemd/system/
    sudo mkdir -p /etc/containerd
    containerd config default | sudo tee /etc/containerd/config.toml
    sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
    sudo systemctl daemon-reload
    sudo systemctl enable --now containerd

    # Check that containerd service is up and running
    systemctl status containerd
  ```

- **Install runc**

  ```
    curl -LO https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64
    sudo install -m 755 runc.amd64 /usr/local/sbin/runc
  ```

- **Install cni plugin**

  ```
    curl -LO https://github.com/containernetworking/plugins/releases/download/v1.5.0/cni-plugins-linux-amd64-v1.5.0.tgz
    sudo mkdir -p /opt/cni/bin
    sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.5.0.tgz
  ```

- **Install kubeadm, kubelet and kubectl**

  ```
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gpg

    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

    sudo apt-get update
    sudo apt-get install -y kubelet=1.29.6-1.1 kubeadm=1.29.6-1.1 kubectl=1.29.6-1.1 --allow-downgrades --allow-change-held-packages
    sudo apt-mark hold kubelet kubeadm kubectl

    kubeadm version
    kubelet --version
    kubectl version --client
  ```

  Note: Note: The reason we are installing 1.29, so that in one of the later task, we can upgrade the cluster to 1.30

- **Configure crictl to work with containerd**

  ```
    sudo crictl config runtime-endpoint unix:///var/run/containerd/containerd.sock
  ```

<br>

**Step-6: Initialize the Master Node**

On the k8s-master VM:
- Run the kubeadm init command:

  ```sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=<MASTER_PRIVATE_IP>```

- After the command runs, you’ll see a message like this:

  ```kubeadm join <MASTER_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>```

  Copy this command! You’ll use it to connect the Worker Nodes.

- Configure kubectl on the Master:

  ```
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
  ```
  
<br>

**Step-7: Install a Network Add-On**

Install Calico for networking (on the Master):

```
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/tigera-operator.yaml

curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/custom-resources.yaml -O

kubectl apply -f custom-resources.yaml
```

<br>

**Step-8: Join Worker Nodes to the Cluster**

- SSH into k8s-worker1 and k8s-worker2.
  
- Run the kubeadm join command copied from the Master on each worker node:

  ```
    sudo kubeadm join <MASTER_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>
  ```

If you forgot to copy the command, you can execute below command on master node to generate the join command again

```kubeadm token create --print-join-command```.

<br>

**Step-9: Validation**

If all the above steps were completed, you should be able to run ```kubectl get nodes``` on the master node, and it should return all the 3 nodes in ready status.

Also, make sure all the pods are up and running by using the command as below:  ```kubectl get pods -A```.


**Note: If your Calico-node pods are not healthy, please perform the below steps**:

- Disabled source/destination checks for master and worker nodes too.

- Configure Security group rules, Bidirectional, all hosts,TCP 179(Attach it to master and worker nodes).

- Update the ds using the command: ```kubectl set env daemonset/calico-node -n calico-system IP_AUTODETECTION_METHOD=interface=ens5``` Where ens5 is your default interface, you can confirm by running ifconfig on all the machines.

- IP_AUTODETECTION_METHOD is set to first-found to let Calico automatically select the appropriate interface on each node.

- Wait for some time or delete the calico-node pods and it should be up and running.

- If you are still facing the issue, you can follow the below workaround.

- Install Calico CNI addon using manifest instead of Operator and CR, and all calico pods will be up and running ```kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml```.

This is not the latest version of calico though(v.3.25). This deploys CNI in kube-system NS.


**Summary**

You’ve successfully Created a multi-node Kubernetes cluster using kubeadm.
