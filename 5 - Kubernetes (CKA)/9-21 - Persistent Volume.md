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

