# Error: Unable to connect to cluster

<br>

### Pehle samjhte hain — ye error aakhir hota kya hai?

```Error: Unable to connect to cluster``` ka matlab hai ki ```kubectl``` client, API Server se connect nhi kar pa rha hai.

Jab hum ```kubectl``` command chalate hain — jaise:
```
kubectl get pods
```

toh ```kubectl``` ek client hai jo Kubernetes API Server se baat karta hai. ```kubectl``` cluster ke API Server ko HTTPs request bhejta hai, fir API Server ka response aata hai.

Kubernetes cluster ke saare operations (pods banana, delete karna, get karna, describe karna, etc.) sab kuch API Server ke through hota hai.

Ab agar ```kubectl``` API Server tak connect nahi kar pa raha, toh wo ye error deta hai:
```
Error: Unable to connect to the server: dial tcp <IP>:<Port>: connect: connection refused
```

ya phir simplified version:
```
Error: Unable to connect to the cluster
```

Simple shabdo mein:
- API Server ko ```kubectl``` ki HTTPs request nhi pahunch pa rhi hai.

“Unable to connect to the cluster” ka matlab hai ki kubectl client aur Kubernetes API server ke beech connection break hai —
ya to config galat hai, ya network down hai, ya cluster hi unavailable hai.
Troubleshoot karne ke liye systematically config, context, endpoint, network, aur credentials sab check karo.


<br>
<br>

### Ye error kab aata hai?

Ye error tab aata hai jab client (kubectl) ko cluster ki configuration, network connection, ya authentication mein problem hoti hai.

Let’s break it down:

<br>

**1. Kubeconfig file galat ya missing hai**:

Kubectl ko ye pata hona chahiye ki kis cluster se connect karna hai. Ye info stored hoti hai ```~/.kube/config``` file mein (default location).

Agar:
- ye file missing hai.
- ya uske andar galat cluster name / server URL likha hai.
- ya current context set nahi hai.

toh kubectl connect nahi kar paayega.

<br>

**2. API Server down hai ya reachable nahi hai**:

Agar cluster ka API Server crash ho gaya hai, ya uske pod nahi chal rahe, ya uska network unreachable hai (for example control plane IP change ho gaya), toh connection fail ho jaata hai.

<br>

**3. Network ya firewall issue**:

Agar aapke laptop/VM se API Server ke IP aur port (usually 6443) pe traffic block hai, ya DNS resolve nahi kar raha, toh connection establish nahi hota.

<br>

**4. Cluster credentials expire ho gaye ya invalid hain**:

Kubeconfig ke andar token, certificate, ya credentials hote hain. Agar wo expire ho gaye, revoke kar diye gaye, ya service account delete ho gaya, toh kubectl connect nahi kar paata.

<br>

**5. Wrong context selected**:

Agar aapke paas multiple clusters hain (dev, prod, staging) aur aapka current context kisi invalid cluster pe point kar raha hai, toh bhi ye error aayega.

<br>

**6. Cluster provisioning incomplete hai**:

Agar cluster abhi bana hi nahi ya partially bana hai (jaise control plane ready nahi hua), tab bhi API Server se connection nahi banega.

<br>
<br>

### Step-by-step troubleshooting approach

Chalo ab dekhte hain kaise systematically is problem ko troubleshoot karte hain.

**Step 1: Check current context and cluster info**:

```
kubectl config view
kubectl config get-contexts
kubectl config current-context
```

Check karo ki ```current-context``` sahi hai ya nahi.

Example output:
```
CURRENT   NAME             CLUSTER          AUTHINFO           NAMESPACE
*         dev-cluster      dev-cluster      dev-user
          prod-cluster     prod-cluster     prod-user
```

Agar current context galat hai:
```
kubectl config use-context dev-cluster
```

<br>

**Step 2: Check cluster endpoint**:

```
kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}'
```

Ye command batayegi ki kubectl kis API server pe connect karne ki koshish kar raha hai. Matlab API Server ki IP kya hai.

Example Output:
```
https://192.168.56.100:6443
```

Ab is IP ko ping karo:
```
ping 192.168.56.100
```

Agar ping nahi ho raha → network ya firewall issue.

<br>

**Step 3: Check API Server port**

Try:
```
telnet 192.168.56.100 6443
```

ya

```
curl -k https://192.168.56.100:6443/healthz
```

Expected output:
```
ok
```

Agar “connection refused” ya “timed out” aata hai → API Server down hai ya firewall block kar raha hai.

<br>

**Step 4: Check kubeconfig file path**:

Default path hota hai:
```
~/.kube/config
```

Agar custom location pe hai to specify karo:
```
kubectl --kubeconfig=/path/to/your/config get nodes
```

<br>

**Step 5: Verify credentials**:

Run:
```
kubectl config view --minify
```

Dekho certificate aur user credentials valid lag rahe hain ya nahi. Agar certificate expire ho gaya hai to renew karo.

<br>

**Step 6: Control plane pods check karo (agar cluster access hai)**:

Agar ye managed cluster nahi hai (jaise Minikube, kubeadm), toh master node pe jaake check karo:
```
sudo kubectl get pods -n kube-system
```

API Server pod ka status “Running” hona chahiye.

Agar ```CrashLoopBackOff``` hai → logs dekho:
```
sudo kubectl logs -n kube-system kube-apiserver-<node-name>
```

<br>

**Step 7: DNS issue check karo**:

Kabhi-kabhi kubeconfig mein ```https://cluster.local:6443``` likha hota hai, aur DNS usko resolve nahi kar paata.

Is case mein manually ```/etc/hosts``` mein entry karke ya correct IP use karke fix kar sakte ho.

<br>
<br>

### Common Fix Summary

| Problem Type        | Symptom                              | Fix                              |
| ------------------- | ------------------------------------ | -------------------------------- |
| Missing kubeconfig  | “no configuration has been provided” | Add correct kubeconfig path      |
| Wrong context       | “unable to connect to server”        | Set correct context              |
| API Server down     | “connection refused”                 | Restart kube-apiserver / kubelet |
| Network issue       | “connection timed out”               | Fix firewall, routing, VPN       |
| Expired credentials | “unauthorized”                       | Renew token or cert              |
| DNS issue           | “host not found”                     | Fix DNS or use IP                |


