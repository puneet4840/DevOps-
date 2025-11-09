# Error: ConfigMap not updated in the pod

<br>

### Basic Samajh — ConfigMap kya hai aur kaise kaam karta hai?

ConfigMap = Key-value pair configuration data jise pods (containers) environment variables ya files ke roop mein use karte hain.

Example:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_MODE: "production"
  LOG_LEVEL: "debug"
```

Ye ConfigMap tum pod me is tarah mount karte ho:
```
apiVersion: v1
kind: Pod
metadata:
  name: demo-pod
spec:
  containers:
  - name: demo
    image: nginx
    envFrom:
    - configMapRef:
        name: app-config
```

<br>
<br>

### Problem — “ConfigMap updated, but pod not reflecting change”

Tumne ConfigMap edit kiya:
```
kubectl edit configmap app-config
```

Aur value badli:
```
LOG_LEVEL: "error"
```

Ab tum expect karte ho ki pod ke andar LOG_LEVEL automatically update ho jaye... Par jab check karte ho:
```
kubectl exec -it demo-pod -- printenv | grep LOG_LEVEL
```

Output still shows:
```
LOG_LEVEL=debug
```

Matlab ConfigMap update hua, par Pod me reflect nahi hua.

<br>
<br>

### Root Cause — Kubernetes behavior behind the scenes

Iska reason samajhne ke liye ye jaana zaroori hai ki ConfigMap pod ke andar kaise mount hota hai:

**1. Environment Variables ke roop me use kiya gaya ho to**:
- Values container start ke time hi inject hoti hain.
- Pod create hone ke baad ye static ho jaati hain.
- Agar ConfigMap update karo → pod me auto reflect nahi hota.

Conclusion:
- Agar ConfigMap environment variables ke through use ki gayi hai, to pod ko restart ya recreate karna padega taaki naye values load ho sakein.

<br>

**2. Volume Mount ke roop me use kiya gaya ho to**:
- Kubernetes ConfigMap ko ek tmpfs-like directory me mount karta hai.
- Kubelet har kuch seconds me (default ~1 minute ke andar) ConfigMap me changes detect karke auto-refresh karta hai.
- Lekin ye feature kuch conditions me kaam nahi karta (jaise immutable configmap, stale kubelet, ya read-only FS).

Conclusion:
- Agar tumne ConfigMap ko volume mount kiya hai, to theoretically wo auto-refresh hona chahiye, lekin kuch cases me manual restart zaruri ho jata hai.

<br>
<br>

### Difference Between envFrom vs volumeMount Behavior

| ConfigMap Usage Type               | Auto Update Reflects?             | Restart Needed?    |
| ---------------------------------- | --------------------------------- | ------------------ |
| `envFrom:` (environment variables) | ❌ No                              | ✅ Yes              |
| `volumeMounts:` (mounted as files) | ⚠️ Sometimes (auto-refresh delay) | ✅ If not reflected |


