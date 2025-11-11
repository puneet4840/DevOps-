# Error: Node Not Ready

Ye error tab aata hai jab tumhara Kubernetes cluster ka ek node unhealthy ho jata hai aur scheduler us par pods schedule nahi kar pata.

<br>

### Basic — “Node Not Ready” ka matlab kya hai?

Kubernetes cluster mein master aur worker nodes milke ek cluster banate hain, Kubernetes me har node (worker/master) ka ek status hota hai, jo control plane (specifically ```kube-controller-manager``` aur ```kubelet```) monitor karte hain.

Tum check karte ho:
```
kubectl get nodes
```
Output me dikhta hai:
```
NAME           STATUS     ROLES    AGE     VERSION
node1          Ready      <none>   12d     v1.30.0
node2          NotReady   <none>   12d     v1.30.0
```

Yahan “NotReady” ka matlab hai:
- Control plane ne last few heartbeats me us node se response nahi liya,
ya node unhealthy state me hai.


<br>
<br>

### Kaun decide karta hai “Ready” ya “NotReady”?

Ye check kubelet aur apiserver ke beech ke heartbeats ke basis par hota hai.
- Har node me kubelet chalta hai.
- Kubelet periodically (default har 10 second me) apiserver ko apni health bhejta hai (heartbeat).
- Agar apiserver ko 40s (default ```--node-monitor-grace-period```) tak response nahi milta, to wo node ko **NotReady** mark kar deta hai.

Normal condition:
```
kubectl describe node node1 | grep -A2 Conditions
```
Output:
```
Ready = True
MemoryPressure = False
DiskPressure = False
NetworkUnavailable = False
```

Problematic condition:
```
Ready = False
```

Matlab node unhealthy hai — ya to network down, ya kubelet dead.

<br>
<br>

### Kab aur Kyu “Node Not Ready” error aata hai?

**1. Kubelet service band ho gayi**:
- Kubelet hi wo agent hai jo node ko register karta hai aur status bhejta hai.
- Agar kubelet crash ho gaya, disable ho gaya ya hung ho gaya → node heartbeat nahi bhejega isliye node ka status → “NotReady” ho jata hai.

<br>

**2. Network issue (apiserver <-> node)**:
- Agar apiserver aur node ke beech connectivity nahi hai — (e.g., firewall block, VPC route issue, network plugin crash) to node unreachable lagta hai → “NotReady”.

<br>

**3. Disk full / inode pressure**:
- Agar ```/var/lib/kubelet``` ya ```/var/log``` bhar gaya, to kubelet apna state report nahi kar pata → “NotReady”.

<br>

**4. Memory / CPU pressure**:
- Agar node heavily overloaded hai, to kubelet, scheduler ko report karta hai: ```MemoryPressure=True``` → pods evict hone lagte hain aur kabhi kabhi node temporary “NotReady” dikhta hai.

<br>

**5. CNI plugin fail**:
- Agar calico/flannel/weave jaisa network plugin crash ho gaya, to node apne network condition report nahi kar pata → NotReady.

<br>

**6. Cloud node unhealthy**:
- Agar tum cloud environment me ho (EKS/GKE/AKS), aur instance khud AWS/GCP me terminate ho gaya ya stuck hai → node unreachable.

<br>
<br>

### Kaise diagnose karein (Step-by-step investigation)

**Step 1: Node status check karo**:
```
kubectl get nodes
```
Dekho kaunsa node “NotReady” hai.

<br>

**Step 2: Describe node for reason**:
```
kubectl describe node <node-name>
```
Output me jaake dhyan do:
```
Conditions:
  Type             Status  LastHeartbeatTime
  Ready            False   ...
  NetworkUnavailable  True
  MemoryPressure      True
```

Ye bata dega ki reason kya hai — NetworkUnavailable, DiskPressure, ya KubeletDead.

<br>

**Step 3: Kubelet service check on node**:
```
sudo systemctl status kubelet
```
Agar down hai:
```
sudo systemctl restart kubelet
```
Phir ```journalctl -u kubelet -f``` se logs dekho.


<br>

**Step 4: Disk aur Memory pressure check**:
```
df -h
free -m
```
Agar disk full hai, ```/var/lib/kubelet``` ya ```/var/log``` clean karo.

<br>

**Step 5: Network connectivity check**:

Node se apiserver tak ping karo:
```
curl -k https://<apiserver>:6443/healthz
```
Agar unreachable hai → network ya DNS problem hai.

<br>

**Step 6: CNI plugin logs check karo**:
```
kubectl -n kube-system get pods | grep calico
kubectl -n kube-system logs <cni-pod-name>
```
Agar yahan error hai → CNI crash hua hai.

<br>

**Step 7: Check cloud provider / instance status**:

EKS, GKE, AKS ya self-hosted VM me jaake verify karo ki node running hai ya terminate state me nahi gaya.

<br>
<br>

### Common Fixes (depending on root cause)

| Problem                 | Fix Command / Solution                                                       |
| ----------------------- | ---------------------------------------------------------------------------- |
| Kubelet crash           | `sudo systemctl restart kubelet`                                             |
| Disk full               | Clear `/var/log`, `/var/lib/docker`                                          |
| Network plugin down     | Restart CNI pods: `kubectl -n kube-system delete pod -l k8s-app=calico-node` |
| Node unreachable        | Check VPC routes / firewall                                                  |
| Certificate expired     | Renew kubelet certs and restart service                                      |
| Node permanently broken | `kubectl delete node <node-name>` and rejoin node via kubeadm                |
