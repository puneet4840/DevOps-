# Error: ImagePullBackOff

<br>

```“ImagePullBackOff”``` ka matlab hai Kubernetes, docker image ko container registry se pull nahi kar pa raha, lekin baar baar pull karne ka retry karta hai.

<br>

### Pehle basic samjho — “ImagePullBackOff” ka matlab kya hai?

Kubernetes mein jab koi Pod create hota hai, toh kubelet (jo worker node par chal raha hai) har container ke liye ye steps follow karta hai:
- Scheduler ne pod ko ek node assign kar diya.
- Ab kubelet container runtime (jaise containerd, Docker) ko bolta hai — “ye image pull kar ke container bana de.”
- Agar image pull fail ho jaata hai, to kubelet dubara try karta hai (backoff retry mechanism).
- Har baar failure ke baad retry delay badhta jaata hai (2s, 4s, 8s, 16s, …).
- Is state ko Kubernetes bolta hai → ```ImagePullBackOff```.
- matlab — “Image pull karne ki koshish hui, fail hui, ab retry backoff chal raha hai.”

<br>
<br>

### Ye error kab aata hai?

Ye tab aata hai jab kubelet docker image ko container registry (Docker Hub, ECR, GCR, ACR, etc.) se pull nahi kar paata.

Matlab problem image pull stage mein hai — pod schedule ho gaya hai, par container start nahi ho pa raha.

Example:
```
kubectl get pods
```
Output:
```
NAME          READY   STATUS             RESTARTS   AGE
nginx-test    0/1     ImagePullBackOff   0          2m
```

<br>
<br>

### Backoff Mechanism Internals

Kubernetes retries image pull with exponential backoff:

| Attempt | Delay            |
| ------- | ---------------- |
| 1st     | ~2 sec           |
| 2nd     | ~4 sec           |
| 3rd     | ~8 sec           |
| 4th     | ~16 sec          |
| ...     | up to ~5 minutes |

Ye reason hai ki describe mein “Back-off pulling image” message dikhai deta hai. Backoff time badhta rehta hai jab tak pod delete ya image fix nahi hoti.

<br>
<br>

### Common Root Causes (Detailed)

Chalo ab dekhte hain ye error kyun aata hai.

**1. Image name galat likha hua hai**:

Sabse common reason — yaml file mein image ka naam ya tag wrong hai.

Example:
```
containers:
- name: nginx
  image: nginx:lattest   # ❌ wrong tag (typo)
```

Described Output:
```
Failed to pull image "nginx:lattest": not found
```

Fix:

Correct tag likho:
```
image: nginx:latest
```

<br>

**2. Image registry unreachable (network/DNS issue)**:

Agar container runtime, registry tak reach nahi kar pa rha hai, DNS resolve nhi ho rha hai, ya firewall block kar rha hai, to image pull fail ho jata hai.

Error Example:
```
Failed to pull image "nginx:latest": dial tcp: lookup registry-1.docker.io: no such host
```

Fix:

- Node se ping/curl test karo:
```
curl -v https://registry-1.docker.io
```

<br>

**3. Private image registry (credentials missing)**:

Agar image private registry (e.g. AWS ECR, GCR, Harbor, DockerHub private repo) se hai, aur credentials configured nahi hain → kubelet access deny kar deta hai.

Error:
```
Failed to pull image "myrepo/nginx:latest": unauthorized: authentication required
```

Fix:
- Image Pull secret create karo:

DockerHub Example:
```
kubectl create secret docker-registry regcred \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=<username> \
  --docker-password=<password> \
  --docker-email=<email>
```

Phir pod spec mein reference do:
```
spec:
  imagePullSecrets:
  - name: regcred
```

<br>

**4. Wrong imagePullPolicy**:

Agar ```imagePullPolicy: Always``` hai aur node ke paas wo image cache mein nahi hai, aur registry unreachable hai → pull fail karega.

Fix:

Set:
```
imagePullPolicy: IfNotPresent
```

Yaani agar image pehle se node pe hai, toh dobara pull mat karo.

<br>

**5. Rate limit (Docker Hub pull rate exceeded)**:

Docker Hub free users ke liye rate limit hoti hai (200 pulls/6 hours per IP).

Agar limit cross ho gayi → pull fail.

Error:
```
toomanyrequests: You have reached your pull rate limit.
```

Fix:
- DockerHub login karke auth token use karo (create image pull secret).
- Ya mirror registry (Harbor, ECR, etc.) use karo.

<br>

**6. Registry certificate / TLS issue**:

Agar private registry HTTPS ke saath chal rahi hai aur cert invalid hai, toh kubelet TLS handshake fail karega.

Error:
```
x509: certificate signed by unknown authority
```

Fix:
- Node ke ```/etc/docker/certs.d/<registry-domain>/ca.crt``` mein CA cert add karo.
- Docker / containerd restart karo.

<br>

**7. Image tag missing**:

Agar image ke end mein tag nahi diya, toh default :latest assume karta hai.

Aur agar latest tag registry mein nahi hai → fail.

Fix:

Always specific tag use karo:
```
image: nginx:1.27
```

<br>
<br>

### Step-by-Step Debugging Approach

Ab chalo dekhte hain practical debugging flow, jise real cluster mein use karte hain.

**Step 1: Check pod status**:
```
kubectl get pods
```
Output:
```
NAME        READY   STATUS             RESTARTS   AGE
myapp       0/1     ImagePullBackOff   0          2m
```

<br>

**Step 2: Describe the pod (events dekho)**:
```
kubectl describe pod myapp
```
Example Output:
```
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  2m                 default-scheduler  Successfully assigned default/myapp to node1
  Normal   Pulling    2m                 kubelet, node1     Pulling image "myrepo/nginx:latest"
  Warning  Failed     2m                 kubelet, node1     Failed to pull image "myrepo/nginx:latest": rpc error: code = Unknown desc = Error response from daemon: pull access denied
  Warning  Failed     2m                 kubelet, node1     Error: ErrImagePull
  Normal   BackOff    1m                 kubelet, node1     Back-off pulling image "myrepo/nginx:latest"
  Warning  Failed     1m                 kubelet, node1     Error: ImagePullBackOff
```

Ye “Message” lines sabse important hain — ye bata rahi hain actual root cause.

<br>

**Step 3: Check node logs (for deeper issue)**:

SSH into that node:
```
journalctl -u kubelet -f
```

Yahan real pull failure reason milega (network, cert, auth, etc.).

<br>

**Step 4: Try manual pull (node se)**:

```
sudo crictl pull nginx:latest
# or if Docker runtime
sudo docker pull nginx:latest
```
Agar yahan bhi fail hota hai → registry ya network problem confirm.

<br>
<br>

### Quick Fix Summary

| Root Cause        | Example Error          | Fix                    |
| ----------------- | ---------------------- | ---------------------- |
| Wrong image name  | image not found        | Correct image/tag      |
| Private registry  | unauthorized           | Add imagePullSecret    |
| Network/DNS issue | lookup failed          | Fix DNS / proxy        |
| TLS error         | x509 unknown authority | Add registry CA cert   |
| Rate limit        | too many requests      | Use authenticated pull |
| Pull policy       | Always + offline       | Use IfNotPresent       |
