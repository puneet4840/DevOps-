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

### How to work with Persistent Volume and Persistent Volume Claim

Kubernetes mein PV/PVC use karne ka process roughly 5 steps mein hota hai:
- Step 1 → Decide Storage Backend.
- Step 2 → Create PersistentVolume (PV) (static provisioning case).
- Step 3 → Create PersistentVolumeClaim (PVC).
- Step 4 → Pod mein PVC ko volume ke through use karna.
- Step 5 → Clean-up / Delete if needed.

**Step 1 – Decide Storage Backend**:

Sabse pehle tumhe decide karna hai. Kaun sa storage backend use karna hai?:
- NFS?
- AWS EBS?
- Azure Disk?
- Local Disk?

Example:
- Tumhare paas NFS server hai → file storage.
- Ya tum AWS pe ho → EBS.
- Local disk use karni hai → local backend.

Yahi decide karega tumhara PV ka config kaise hoga.


**Step 2 – Create PersistentVolume (PV)**:

Ab tum PV ka YAML banaoge.

(Note: Dynamic provisioning mein yeh step tumhe manually nahi karna padta, StorageClass sambhalta hai.)

PV YAML mein define karte ho:
- capacity.
- accessModes.
- storage backend details.
- reclaimPolicy.

Example PV (NFS):
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    path: /exports/data
    server: 10.10.10.20
```

Commands:
```
kubectl apply -f pv.yaml
```
Check karo:
```
kubectl get pv
```

**Step 3 – Create PersistentVolumeClaim (PVC)**:

Ab tum PV ko claim karne ke liye PVC banaoge. Iska matlab ab tum PV ko ye bataoge ki kitni storage tumahare pod ko chaiye.

PVC YAML mein define karte ho:
- kitni storage chahiye (e.g. 5Gi).
- kaunse accessModes chahiye.
- agar specific storageClass use karna hai toh woh.

Example PVC:
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
```

Commands:
```
kubectl apply -f pvc.yaml
```
Check karo:
```
kubectl get pvc
```

**Binding Process**:

Binding process is to connect PVC with PV. Yaha pe kubernetes tumhare PVC ko PV se match karta hai agar match successful hua to in dono ko automatically connect kar deta hai.

Agar tumhara PVC aur PV match ho gaya:
- capacity ≥ PVC request (Kya storage ki capacity request ki hui capacity se jyada hai ya equal hai, If yes then check 1 passed).
- accessModes match (PV aur PVC ke acces modes same hone chiye).
- selector match (if any).

Sab kuch thik match hone par Kubernetes automatically bind kar deta hai.

Dekho:
```
kubectl describe pvc my-pvc
```

Status Bound hona chahiye.






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

<br>

**Access Mode**:

Access Mode define karta hai ki Persistent Volume ko kaun, kitne pods, aur kis tarah se access kar sakte hain.

Matlab:
- Ek pod use kare ya multiple pods.
- Read kare ya read-write kare.
- Same node pe access ho ya cluster ke kahin se bhi.

Kubernetes mein 3 primary access modes hote hain:
- ReadWriteOnce (RWO).
- ReadOnlyMany (ROX).
- ReadWriteMany (RWX).

Aur kuch storage plugin allow karte hain ek 4th mode:
- ReadWriteOncePod (RWO-Pod).

1. ReadWriteOnce (RWO):
- Allows all pods on a single node to mount the volume in read-write mode.
- Ek baar main Ek hi node pe ek pod ya multiple pods read aur write kar sakte hai.
- Ek time pe ek node pe attached rahega.

Example:

Maan lo tumhara PV definition:
```
spec:
  accessModes:
    - ReadWriteOnce
```

PVC banate ho:
```
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
```

- Agar tumhara pod Node1 pe scheduled hai, toh woh PV use karega.
- Agar pod Node2 pe chala jaata hai, toh volume wahan attach nahi hoga, tab tak detach nahi hota Node1 se.

2. ReadOnlyMany (ROX):

“Multiple nodes aur multiple pods ek hi time pe PV ko sirf read kar sakte hain.”

- Sab pods read-only access kar sakte hai.
- Write allowed nahi hai.
- Cluster ke kisi bhi node se access possible.

3. ReadWriteMany (RWX):

“Multiple pods across multiple nodes read aur write dono kar sakte hain.”

- Sab pods ek saath read aur write kar sakte hain.
- Cluster ke kahin se bhi access possible.


4. ReadWriteOncePod (RWO-Pod):

“Ek pod ke sath hi attach rahega, even agar woh pod same node pe restart ho.”

- Single pod only.
- Agar woh pod terminate ho gaya, tabhi doosra pod us PV ko use kar sakta hai.
- Same node pe restart hone pe bhi allowed hai.

Example:
```
spec:
  accessModes:
    - ReadWriteOncePod
```

<br>

**Storage Backend**:

Storage backend wo system ya service hai jahan actual data store hota hai.

PV ya PVC to Kubernetes ke objects hain. Wo sirf abstraction hain. Real storage to backend pe hoti hai — jaise NFS server, AWS EBS, Azure Disk, GCE Persistent Disk, ya koi SAN/NAS.

Kubernetes PV sirf yeh batata hai:
- Kahan data pada hai.
- Kitni space hai.
- Kaise access karna hai.

Actual storage backend pe hi physically exist karti hai.

Types of Storage Backend:
- Block Storage.
- File Storage (Shared File Systems).
- Object Storage.
- Local Disk.

1. Block Storage:

Block storage mein data blocks mein store hota hai — bilkul ek hard disk ki tarah. Iska matlab cloud provider ki disk attach karna.

- Ek volume ek time pe ek node ko attach hota hai (mostly RWO).
- Bahut fast performance deta hai.
- Suitable for databases, single-node workloads.

Example:
- Microsoft Azure ki disk attach karna.
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: azure-disk
spec:
  capacity:
    storage: 30Gi
  accessModes:
    - ReadWriteOnce
  azureDisk:
    diskName: mydisk
    diskURI: /subscriptions/.../resourceGroups/.../providers/Microsoft.Compute/disks/mydisk
```

2. File Storage (Shared File Systems):

File-level access deta hai – bilkul jaise Windows ke shared folder ya Linux ka NFS mount.

- Directories, files ki tarah manage hota hai.

Example:
- NFS (Network File System).
- Azure Files.

3. Object Storage:

Data objects ke form mein store hota hai – jaise file, metadata, aur unique ID.

- Block aur file storage se different.

Examples: S3, Azure Blob, GCS
- Azure Blob direct PV nahi banta. Apps Azure SDK ke through integrate karte hain.
- AWS S3 tum direct mount nahi kar sakte PV ke form mein. Apps jaise Minio use kar sakte hain S3 ke storage ko PV ke jaisa expose karne ke liye.

<br>

**Recliam Policy**

Reclaim Policy yeh decide karti hai ki PV ka kya hoga jab PVC delete ho jaye.

Maan lo tumhara pod delete ho gaya, PVC delete ho gayi. Ab Kubernetes ko decide karna padta hai:
- PV ko delete kare?
- PV ko free kare reuse ke liye?
- Ya data wahan hi chhoda rahe?

Isi ko kehte hain reclaim policy.

Kubernetes mein Available Reclaim Policies:
- Retain.
- Delete.

1. Retain Policy:

“Data ko wahi rakho, manually clean ya reuse karo.”

- PVC delete hoti hai → PV Released state mein chala jata hai.
- Kubernetes PV ko automatically kisi naye PVC ko bind nahi karega.
- Admin ko manually PV ko delete ya clean karna padta hai.

Example:

Maan lo tumhara PV:
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-retain
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  nfs:
    path: /exports/data
    server: 10.10.10.20
```

PVC delete hoti hai:
- PV ab Released state mein hai.
- Lekin data wahan pada hai.
- Tum use manually clean kar sakte ho.
- Ya PV ko naye claim ke liye manually reuse kar sakte ho.

2. Delete Policy:

“PVC delete ho jaaye toh PV aur data automatically delete ho jaaye.”

- PVC delete hoti hai → Kubernetes backend storage ko bhi delete kar deta hai.
- No manual work required.

Example:

Tumhara PV:
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-delete
spec:
  capacity:
    storage: 20Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Delete
  gcePersistentDisk:
    pdName: my-disk
    fsType: ext4
```

PVC delete hoti hai:
- PV delete ho jaata hai.
- Google Cloud disk physically delete ho jaati hai.

