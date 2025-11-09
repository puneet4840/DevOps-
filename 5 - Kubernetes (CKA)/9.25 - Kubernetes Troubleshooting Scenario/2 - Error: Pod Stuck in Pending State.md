# Error: Pod Stuck in Pending State

<br>

### Pehle samjho — “Pending” ka matlab kya hai?

Kubernetes mein jab hum koi Pod create karte hain (chahe command likh ke ya yaml file ke through), wo ek lifecycle follow karta hai:

| Phase                  | Meaning                                                                 |
| ---------------------- | ----------------------------------------------------------------------- |
| **Pending**            | Pod create ho gaya hai, lekin abhi tak kisi Node par schedule nahi hua. |
| **Running**            | Pod kisi Node par assign ho gaya, aur container start ho gaye.          |
| **Succeeded / Failed** | Pod complete ho gaya ya crash hua.                                      |
| **Unknown**            | Pod state unknown hai (API server se sync issue).                       |

Toh jab pod **Pending** state mein hota hai — iska matlab:
- Scheduler abhi tak pod ko kisi node par assign nahi kar paya.

Matlab — “Pod bana toh gaya, par kahin fit nahi baitha.”

“Pod stuck in Pending state” ka matlab hai scheduler ko pod ke liye suitable node nahi mil raha

<br>

### Ye error kab aata hai?

Kubernetes scheduler jab pod ko kisi node par schedule karta hai, to pod ke liye har node par kuch conditions check karta hai:
- “Kya koi node available hai jahan ye pod run ho sake (CPU, memory, taint-toleration, affinity rules, etc. ke hisaab se)?”

Agar  pod ko koi node nahi milta → pod ```Pending``` mein hi atka rehta hai.

<br>
<br>

### Iske main causes kya hote hain

**1. Cluster mein koi Node available hi nahi hai**:

Example:
```
kubectl get nodes
```
Output:
```
No resources found
```

Matlab cluster ke paas koi worker node hi nahi jahan pod ja sake.

<br>

**2. Node tainted hai (Taints & Tolerations ka mismatch)**:

Agar node pe taint laga hua hai aur pod ke paas uska toleration nahi hai, toh scheduler us node pe pod nahi bhejta.

Example:
```
kubectl describe node <node-name>
```
Output:
```
Taints: node-role.kubernetes.io/master:NoSchedule
```

Pod tab tak pending rahega jab tak uske paas ye toleration nahi hota:
```
tolerations:
- key: "node-role.kubernetes.io/master"
  operator: "Exists"
  effect: "NoSchedule"
```

<br>

**3. Insufficient CPU / Memory resources**:

Agar har node pe resources full hain aur naye pod ke liye jagah nahi hai, toh scheduler “fit” nahi kar paata.

Check with:
```
kubectl describe pod <pod-name>
```
Output mein dekho:
```
0/3 nodes are available: 3 Insufficient cpu.
```

or

```
0/2 nodes are available: 2 Insufficient memory.
```

Matlab sab node busy hain → pending state.

<br>

**4. PersistentVolume (PV) ya PVC unavailable**:

Agar pod ek PersistentVolumeClaim (PVC) use karta hai, aur uska volume bind nahi hua ya available nahi hai, toh pod pending rahega.

Example describe output:
```
Warning  FailedScheduling  10s  default-scheduler  0/3 nodes are available: 3 node(s) had volume node affinity conflict.
```

<br>

**5. Node Selector, Affinity / Anti-Affinity ka mismatch**:

Agar tumne pod spec mein ```nodeSelector```, ```nodeAffinity```, ya ```podAntiAffinity``` set kiya hai aur koi node match nahi kar rahi — pod pending.

Example:
```
nodeSelector:
  disktype: ssd
```

Agar koi node ke paas ```disktype=ssd``` label nahi hai → pending.

<br>

**6. ImagePull issue (rarely shows pending)**:

Kahi cases mein agar scheduler ne pod assign kar diya par container start nahi hua (image pull wait), toh initially pod “Pending” dikhega aur thoda baad “ContainerCreating”.

Describe se pta chalega:
```
Failed to pull image "nginx:latest": ImagePullBackOff
```

<br>

**7. Scheduler itself not working**:

Agar ```kube-scheduler``` pod down hai (kube-system namespace mein), toh naye pods schedule hi nahi honge → sab pending.

Check:
```
kubectl get pods -n kube-system
```
Output:
```
kube-scheduler-master   CrashLoopBackOff
```

<br>
<br>

### Step-by-Step Troubleshooting

Ab dekhte hain kaise systematically diagnose karein.

**Step 1: Pod status check**:
```
kubectl get pods
```
Output:
```
NAME        READY   STATUS    RESTARTS   AGE
nginx-pod   0/1     Pending   0          5m
```

**Step 2: Describe pod**:
```
kubectl describe pod nginx-pod
```

Ye sabse important command hai. Output ke bottom mein “Events” section hoga jahan likha hoga kyun pending hai.

Output Example:
```
Events:
  Type     Reason            Age              From               Message
  ----     ------            ----             ----               -------
  Warning  FailedScheduling  1m (x5 over 2m)  default-scheduler  0/3 nodes are available: 3 node(s) had insufficient memory.
```

Ye batata hai root cause.

**Step 3: Check available nodes**:
```
kubectl get nodes
```

Agar output mein “NotReady” ya “SchedulingDisabled” nodes dikh rahe ho:
```
NAME     STATUS     ROLES           AGE   VERSION
node1    NotReady   <none>          2d    v1.29.3
node2    Ready      <none>          2d    v1.29.3
```

Matlab kuch nodes unhealthy hain → unpe pod nahi schedule ho paayega.

**Step 4: Check node resources**:
```
kubectl describe node node1 | grep -A5 "Allocated resources"
```
Dekho ```CPU``` aur ```Memory``` utilization full toh nahi hai.

**Step 5: Check scheduler**:
```
kubectl get pods -n kube-system | grep scheduler
```

Agar scheduler crash hua hai:
```
kubectl logs -n kube-system kube-scheduler-<node-name>
```

**Step 6: Check taints**:
```
kubectl describe node <node-name> | grep Taints
```

Agar taint NoSchedule hai, toh ya toh toleration lagao, ya taint hatao:
```
kubectl taint nodes <node-name> node-role.kubernetes.io/master:NoSchedule-
```

<br>

**Step 7: Check PV / PVC binding**:
```
kubectl get pvc
kubectl describe pvc <pvc-name>
```
Agar PVC “Pending” hai → Pod bhi pending rahega.

