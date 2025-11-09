# Error: CrashLoopBackOff

<br>

CrashLoopBackOff ka matlab hai: “Container baar-baar crash kar raha hai".

<br>

### Pehle samjho — “CrashLoopBackOff” ka matlab kya hai?

Iska matlab hai ki container baar baar crash ho rha hai, Ye error tab aata hai jab container start hota hai → crash karta hai → dobara start hota hai → phir crash karta hai...

aur Kubernetes ne ye pattern detect kar liya hai, to wo restart attempts ke beech delay (backoff) lagata hai.

Matlab:
- Kubernetes keh raha hota hai — “Container baar-baar crash kar raha hai, main ab retry slow kar dunga.”

<br>
<br>

### Kubernetes mein kya ho raha hota hai?
- Scheduler ne pod ko ek node par assign kar diya.
- Kubelet ne container runtime (containerd / Docker) ko bola: “Container start karo.”
- Container start hota hai.
- Lekin kuch seconds baad exit ho jaata hai (exit code ≠ 0).
- Kubelet notice karta hai → “container exited unexpectedly.”
- Policy restartPolicy: Always ya OnFailure hoti hai → so kubelet restart karta hai.
- Agar ye pattern bar-bar hota hai → Kubelet retry karte hue delay lagata hai (exponential backoff).
- Is state ko Kubernetes bolta hai → **CrashLoopBackOff**.

<br>
<br>

### Error message kaisa dikhta hai?
```
kubectl get pods
```

```
NAME             READY   STATUS             RESTARTS   AGE
myapp-pod        0/1     CrashLoopBackOff   5          3m
```

Yaani container baar-baar crash hua aur 5 times restart hua.

<br>
<br>

### Ye error kab aata hai?

Ye error tab aata hai jab:
- Container start to hota hai, par kuch error se exit ho jaata hai.
- Application ke andar kuch galat hai (code, config, dependency, env var, etc.)
- Ya command/script jo container start karta hai, wo fail ho jaata hai.

To ye application-level problem hoti hai, na ki Kubernetes-level.

<br>
<br>

### Root Causes

Ab chalo har ek root cause deep mein samjhte hain examples ke saath

**1. Application crash ho raha hai**:

Sabse common reason — app start hoti hai aur turant crash kar jaati hai.

Example:
```
containers:
- name: myapp
  image: python:3.9
  command: ["python", "/app/server.py"]
```

Agar server.py mein error hai (e.g., port already in use, missing file, import error), to container exit ho jaayega with non-zero code.

Iska matlab hai ki code mein error hai isliye container crash ho rha hai.

Error Example:
```
Error: ModuleNotFoundError: No module named 'flask'
```

Fix:
- Application code aur dependencies check karo.
- Locally test karo ki ```docker run``` se image properly chal rahi hai ya nahi.

<br>

**2. Wrong command or entrypoint**:

Agar tum pod spec mein ya fir dockerfile mein galat command likh dete ho jo exit ho jaati hai, container immediately crash karega.

Example:
```
containers:
- name: busybox
  image: busybox
  command: ["ls", "/nonexistent-dir"]
```

Ye command file nahi milegi → exit code 1 → CrashLoopBackOff.

Fix:
- Command ko sahi karo ya script ke andar error handling daalo.

<br>

**3. ConfigMap / Secret missing ya incorrect**:

Agar container start hone ke liye environment variables chahiye aur wo missing hain (ConfigMap ya Secret galat hai), to app fail kar sakti hai.

Example:
```
envFrom:
- configMapRef:
    name: myconfig
```

Agar ```myconfig``` exist nahi karta, to pod crash ho sakta hai.

Fix:
- ```kubectl get configmap``` se check karo, aur ensure karo ki config values sahi hain.

<br>

**4. Database ya external dependency unavailable**:

Application start hone ke time DB connection test karti hai — agar DB reachable nahi hai → crash.

Error logs:
```
Error: could not connect to Postgres at db:5432
```

Fix:
- Check karo ki DB service running hai.
- App mein retry mechanism daalo.
- Pod readiness probe use karo taaki app ready hone se pehle traffic na mile.

<br>

**5. Port conflict ya already in use**:

Agar container 8080 port bind karna chaahta hai, par wo port pehle se use mein hai (by another process in same pod / sidecar), to app crash ho jaati hai.

Fix:
- Port mapping aur service definitions check karo.

<br>

**6. OutOfMemory (OOMKilled)**:

Agar node ke paas kam memory hai aur tumhara app zyada consume karti hai → kernel process ko kill kar deta hai.

Check karo:
```
kubectl describe pod <pod-name>
```

Output:
```
State:       Terminated
Reason:      OOMKilled
```

Fix:
- Memory limits badhao:
```
resources:
  requests:
    memory: "128Mi"
  limits:
    memory: "512Mi"
```

- App ke memory usage optimize karo.

<br>

**7. File permission issue / missing mount**:

Agar container kisi file ko likhne ki koshish karta hai par wo path read-only hai, to crash kar jaata hai.

Example:
```
PermissionError: [Errno 13] Permission denied: '/data/logs'
```

Fix:
- PVC ya emptyDir volume sahi path pe mount karo aur permissions fix karo.

<br>
<br>

### Troubleshooting Step-by-Step

**Step 1: Pod status check karo**:
```
kubectl get pods
```
Output:
```
myapp     0/1     CrashLoopBackOff   6 (30s ago)   10m
```

<br>

**Step 2: Describe pod**:
```
kubectl describe pod myapp
```
Output:
```
Last State:     Terminated
Reason:         Error
Exit Code:      1
Started:        Sat, 09 Nov 2025 23:35:22 +0530
Finished:       Sat, 09 Nov 2025 23:35:24 +0530
Restart Count:  6
```

Ye part sabse important hai — Exit Code aur Reason batata hai ki container kyun crash hua.

<br>

**Step 3: Logs check karo (most crucial step)**:
```
kubectl logs myapp --previous
```
(```--previous``` flag latest crashed container ke logs dikhata hai)

Example:
```
Traceback (most recent call last):
  File "/app/server.py", line 12, in <module>
    connect_db()
ConnectionRefusedError: [Errno 111] Connection refused
```

Boom 💥 — ye hi crash ka reason hai.

