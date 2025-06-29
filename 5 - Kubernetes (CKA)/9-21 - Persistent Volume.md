# Persistent Volume in Kubernetes

Kubernetes mein containers ephemeral yani temporary hote hain. Matlab:
- Agar tumhara Pod delete ho jaye → tumhara data bhi gayab ho jaata hai.
- Jaise:
  - Container crash hua.
  - Pod recreate hua.
  - Node fail hua.

To pod ke ander ka data bhi delete ho jata hai.

e.g., 
- Tum MySQL Pod chala rahe ho.
- Uske andar tumhari database files hain ```/var/lib/mysql``` mein.
- Kisi bhi reason se Pod crash hua → fir se start hua → tumhara pura data gayab.

Toh data persistence zaruri hai.

Data ko persist karne ke aur bhi methods humne dekhe the jaise:

**emptyDir** ya **hostPath** use kar sakte ho, lekin:
- emptyDir → Pod delete hone pe data chala jaata hai.
- hostPath → Node specific hai. Agar Pod dusre node pe chala gaya → data nahi milega.

Isi problem ko solve karte hain:
- PersistentVolume (PV).
- PersistentVolumeClaim (PVC).

<br>
<br>

### PersistentVolume (PV) Kya Hai?

PersistentVolume (PV) ek Kubernetes object hai jo tumhare cluster mein storage resource ko represent karta hai.
- Cluster level pe exist karta hai.

Matlab:
- PV ek storage space hai jo cluster mein registered hota hai taaki Pods use kar saken.

Jaise:
- EBS volume (AWS).
- GCE Persistent Disk.
- NFS share.
- Local disk.
- Azure Disk.

Isko ese samjho:

```Suppose कोई भी storage है जैसे --```
- ```तुम्हारे kubernetes node के अंदर ही disk हो|```.
- ```NFS (Network File System) मतलब अलग मशीन पे स्टोरेज हो| Network के through access कर सकते हो|```.
- ```Cloud Disk, मतलब Azure cloud पे डिस्क हो|```

```तो हम persisten volume बनाकर cluster को ये बताते हैं की हमारे पास ये particular storage available है और तुम इसको use करलो Pods के permanent data को store करने के लिए| तो ये हम persistent volume create करके cluster मैं define करते हैं, लेकिन storage कोई भी हो सकती है जो मैंने बताई|``` 


Tumhare paas kahin bhi storage ho (local, NFS, cloud), tum usko PV ke through Kubernetes cluster main use kar sakte ho. PV physical storage ko represent karta hai, chahe woh local ho ya network ya cloud disk.

<br>
<br>

### Persistent Volume Claim (PVC)

PVC is the storage request from PV.

PVC ek user request hai storage ke liye.

Tumhara Pod direct PV se baat nahi karta. Tumhara Pod PVC ko use karta hai.

PVC ek claim hai:
- “Mujhe 5Gi storage chahiye, ReadWriteOnce mode mein.”

Matlab:
- Tum directly PV ko pod mein nahi lagate.
- Tum PVC create karte ho.
- Kubernetes dekhta hai koi suitable PV mil raha hai kya.
- Agar mil gaya ➔ PVC bind ho jata hai us PV se.
- Pod PVC ka naam use karta hai.

<br>
<br>

### Components of Persistent Volume

Components are:
- Capacity.
- Access Mode.
- Storage Backend.
- Reclaim Policy.


<br>

**Capacity**:

Sabse pehle samajh lo ki capacity ka matlab yahan hai:
- PV ke andar kitni storage space allocate ki gayi hai, jise pods use kar sakte hain.
- Jo storage persistent volume ko attach hai uska size kya hai.

Jaise tum apne laptop mein bolte ho – “Mere paas 500GB ki hard disk hai.” Waise hi Kubernetes mein bolte hain – “Mere PV ki capacity 10Gi hai.”

<br>

Capacity Define Kahan Hoti Hai?:

Jab tum PV ka YAML likhte ho, usmein ek field hoti hai:
```
spec:
  capacity:
    storage: 10Gi
```
- storage: yahan tum likhte ho kitni space allocate karni hai.
- “Gi” ka matlab hai Gibibytes (1024 * 1024 * 1024 bytes).
- Note karo: Kubernetes binary units (Ki, Mi, Gi, Ti) use karta hai. 1Gi = 1024 MiB = 1024 * 1024 KiB.

<br>

Capacity Constraints:

1. Over-provisioning Allowed nahi hai:
- Agar PV ki capacity 10Gi hai.
- Aur tumhara PVC 15Gi maang raha hai.
- Toh Kubernetes woh PV bind nahi karega us PVC se.
- PVC kabhi bhi PV se zyada storage claim nahi kar sakta.

2. Multiple PVCs ka scenario:
- Agar tumhara PV ReadWriteOnce (RWO) mode mein hai, woh ek time pe ek hi pod ko attach ho sakta hai.
- Agar ReadOnlyMany (ROX) ya ReadWriteMany (RWX) mode hai, tab multiple pods access kar sakte hain, lekin storage capacity wahi fixed rahegi.

Maan lo:
- PV ki capacity 10Gi hai.
- 2 PVC bind ho gaye RWX mein, tab bhi total milke 10Gi hi use kar sakte hain, extra nahi.

3. Resizing:
- Kubernetes mein tum PV ki capacity badha bhi sakte ho agar tumhara underlying storage (jaise EBS volume, NFS share) allow kare.

Example:

Pehle PV tha
```
spec:
  capacity:
    storage: 10Gi
```

Tumne PVC resize kiya:
```
spec:
  resources:
    requests:
      storage: 20Gi
```

Agar storage class allow karti hai volume expansion, toh PVC expand ho jayega. Aur PV bhi update ho jayega:
```
status:
  capacity:
    storage: 20Gi
```

