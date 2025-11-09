# Error: Service not Reachable

<br>

### Pehle basic samjho — Kubernetes Service kya karti hai?

Kubernetes me ek Service ka main kaam hai:
- “Pods ke liye stable networking provide karna.”

Kyuki pods ephemeral (temporary) hote hain — restart hone par unka IP change ho jata hai.

Service ek virtual IP (ClusterIP) deti hai jo stable rehta hai aur traffic ko correct pods tak route karta hai.

Example:
```
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 8080
```

Is service ka matlab hai:
- Service IP (ClusterIP) fix rahega.
- Ye IP request ko un pods tak bhejega jinke paas label app=myapp hai.
- Internally kube-proxy aur iptables ke through ye routing hoti hai.

<br>
<br>

### Error “Service not reachable” ka matlab kya hai?

Iska matlab ye hota hai ki:
- Service ki Ip tak koi bhi request nhi pahunch pa rhi hai. Jaise client, Pod, ya koi external request service ip ko reach nhi kar pa rhe hain.

Ya to:
- DNS resolve nahi kar raha (```myapp-service``` → IP),
- ya IP reachable nahi hai,
- ya IP to mil gaya par backend pods tak traffic nahi ja raha.

Basically, kahi na kahi path break hua hai. Service level pe ya network level pe.

<br>
<br>

### Ye error kab aur kaise dikhta hai?

Common Scenarios:

| Case | Example Error                                                              | Context                              |
| ---- | -------------------------------------------------------------------------- | ------------------------------------ |
| 🧩 1 | `curl: (6) Could not resolve host: myapp-service`                          | DNS problem                          |
| 🧩 2 | `curl: (7) Failed to connect to myapp-service port 80: Connection refused` | Service endpoint issue               |
| 🧩 3 | `ping: connect: Network is unreachable`                                    | NetworkPolicy / CNI issue            |
| 🧩 4 | `no endpoints available for service "myapp-service"`                       | Service selectors don’t match pods   |
| 🧩 5 | External access not working                                                | NodePort / LoadBalancer config issue |

<br>
<br>

### Step-by-Step Debugging Flow

Service troubleshooting ek layered debugging process hai. Chalo step-by-step detail me samjhte hain.

**Step 1: Check Service resource exist karta hai ya nahi**:
```
kubectl get svc
```
Output:
```
NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
myapp-service     ClusterIP   10.98.56.42    <none>        80/TCP    10m
```

Agar service missing hai → obviously unreachable.

Fix: YAML apply karo / service recreate karo.

<br>

**Step 2: Check service ka type aur IP**:
```
kubectl describe svc myapp-service
```

Isme check karo:
- Type: ClusterIP / NodePort / LoadBalancer
- ClusterIP: 10.x.x.x
- Selector: app=myapp
- Endpoints: list of pod IPs

Example output:
```
Name:              myapp-service
Type:              ClusterIP
IP:                10.98.56.42
Port:              80/TCP
Endpoints:         10.244.0.23:8080,10.244.0.24:8080
Selector:          app=myapp
```

Agar “Endpoints” empty hai:
```
Endpoints: <none>
```

to iska matlab hai:
- Service ke paas koi backend pod hi nahi hai jisse wo traffic bheje.

Fix:
- Check karo ki pod ke labels service ke selector se match karte hain:
```
kubectl get pods --show-labels
```

Agar pod ka label kuch aur hai (```app=web``` instead of ```app=myapp```), to service usse connect nahi karegi. Correct label add karo ya service selector change karo.

<br>

**Step 3: Check pod running and ready hai kya**:
```
kubectl get pods -l app=myapp
```

Agar pod ```CrashLoopBackOff``` ya ```NotReady``` state me hai, to service request forward nahi karegi (kube-proxy endpoints nahi banata for unready pods).

Fix: Pod troubleshoot karo (logs, describe events, image pull, etc.).

<br>

**Step 4: Check DNS resolution inside cluster**:

Pod ke andar jakar DNS test karo:
```
kubectl run -it --rm dns-test --image=busybox --restart=Never -- nslookup myapp-service
```

Expected:
```
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local
Name:      myapp-service
Address 1: 10.98.56.42
```

Agar error aaye:
```
nslookup: can't resolve 'myapp-service'
```
DNS problem.

Fix:
- CoreDNS running hai kya check karo:
```
kubectl get pods -n kube-system -l k8s-app=kube-dns
```
- Agar crash ho raha hai:
```
kubectl logs -n kube-system <coredns-pod>
```
- CoreDNS configmap verify karo:
```
kubectl -n kube-system get configmap coredns -o yaml
```
- Recreate kar do agar corrupt hai.

<br>

**Step 5: Check ClusterIP connectivity (Kube-proxy issue)**:

Ab service ka IP directly ping / curl karo (from inside cluster):
```
kubectl run -it netshoot --image=nicolaka/netshoot -- bash
curl 10.98.56.42:80
```

Agar ye fail hota hai:
```
curl: (7) Failed to connect to 10.98.56.42 port 80
```

Possible reasons:
- Kube-proxy not running on node.
- iptables/ipvs rules corrupt.
- NetworkPolicy blocking connection.
- Wrong targetPort in service.

Fix:
- Check kube-proxy pod:
```
kubectl get pods -n kube-system -l k8s-app=kube-proxy
```
- iptables rules inspect (advanced):
```
iptables -t nat -L -n | grep myapp-service
```

<br>
<br>

### Typical Root Causes Summary

| Root Cause                   | Description                           | Fix                           |
| ---------------------------- | ------------------------------------- | ----------------------------- |
| ❌ Wrong Selector             | Service backend pods match nahi karte | Match labels properly         |
| ⚙️ Pod not Ready             | Endpoints empty ho jaate hain         | Fix pod readiness             |
| 🧱 DNS failure               | CoreDNS issue                         | Restart CoreDNS               |
| 🔌 Wrong Port mapping        | Service `targetPort` wrong            | Correct port                  |
| 🛑 NetworkPolicy blocking    | Inter-pod blocked                     | Add ingress rules             |
| 🧰 Kube-proxy issue          | Service rules missing                 | Restart kube-proxy daemonset  |
| 🔒 Firewall/SG blocking      | NodePort/LoadBalancer blocked         | Allow correct port            |
| 🧍‍♂️ External traffic issue | Service type mismatch                 | Use NodePort/Ingress properly |

