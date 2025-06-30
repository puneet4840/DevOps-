# Dynamic Provisioning

**Old Method**:

Pehle kya hota tha ki tum mannualy pehle PV create karte the fir PVC create karte aur inko Bind karke apne pod main use kar lete the.

**New method (modern Kubernetes)**:

Automatic provisioning ka matlab hai – tumhe PV manually create nahi karna padta, Kubernetes tumhare liye automatically storage backend se volume create kar deta hai.

Ab modern Kubernetes mein CSI ka zamana hai.

Cloud providers apna plugin dete hain:
- AWS → EBS CSI.
- GCP → PD CSI.
- Azure → Disk CSI

Automatic Provisioning main cloud provider ki storage provide karta hai. Kubernetes, cloud provider se CSI plugin ke through connect karta hai aur ek storage disk create karne ko bolta hai. Fir cloud provider disk create karke kubernetes ko deta hai aur kubernetes PV main us disk ko register karta hai.

<br>

Old Method:

Maan lo tumhe storage chahiye:

Pehle kya hota tha?
- Tum PV khud likhte ho YAML se aur PV create karte ho.
- Phir PVC likhte ho aur PVC create karte ho.
- Dono ka size match karte ho aur PVC PV se bind ho jata hai.
- Fir POD se volume attach ho jata hai.

Dynamic provisioning ke main kya hota hai?
- Tum bas PVC ki yaml se PVC create kardo.
- Baaki sab Kubernetes sambhal lega:
  - PV banayega.
  - Backend pe volume allocate karega (e.g. AWS EBS create karega).
  - PVC se bind kar dega.
 
Isliye ise dynamic provisioning ya automatic provisioning bolte hain.

<br>
<br>

### Dynamic Provisioning Kaise Kaam Karta Hai?

Kubernetes dynamic provisioning ka kaam StorageClass ke through hota hai.

**StorageClass**:

Storage Class is a kubernetes object that is used to provision the persistent volume from cloud to your pods.

Storage class kubernetes ka object hota hai jise hum yaml ke through create karte hain jo cloud se disk ko register karta hai kubernetes main.

Aur batata hai kaise volume create karna hai.

PVC jab tum likhte ho:
- Usme tum specify kar dete ho storageClassName.
- Kubernetes dekhta hai StorageClass definition ko.
- Woh backend storage plugin yani CSI driver (e.g. AWS EBS driver) ko bolta hai:
  - “Bhai, mujhe 10Gi ka volume bana ke de de!”
 
Backend storage provider:
- Ye CSI provider hota hai matlab ek api jo kubernetes ko cloud se connect karti hai.
- Backend storage cloud par Naya volume allocate karta hai jaise DISK.
- Kubernetes automatically us volume ko PV ke form mein cluster mein register kar deta hai.
- Tumhara PVC us PV se Bound ho jata hai.

Sab kuch automatic hota hai. Bss tumko storgeClass object create karna hota hai.


<br>
<br>

### Dynamic Provisioning ke Components

There are three components that works in dynamic provisioning:
- StorageClass.
- Provisioner (Driver).
- PVC.

**1. StorageClass**:

Storage Class is a kubernetes object that is used to provision the persistent volume from cloud to your pods.

Storage class kubernetes ka object hota hai jise hum yaml ke through create karte hain jo cloud se disk ko register karta hai kubernetes main.

Aur batata hai kaise volume create karna hai.

Isme tum define karte ho:
- Kaunsa storage driver use karna hai.
- Volume type kya hoga (e.g. gp3, io1 AWS mein).
- Encryption on/off.
- Parameters (I/O, performance etc.).
- Reclaim policy.

Example: AWS EBS ke liye StorageClass
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: gp3-sc
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
  fsType: ext4
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```

<br>

**Provisioner (CSI Driver)**

CSI (Container Storage Interface) driver ek standard plugin hai jo Kubernetes ko cloud provider ke saath connect karta hai. 

For every cloud there is a CSI Plugin.

It simply connects cluster with Cloud provider.


1 - CSI Kyu Banaya Gaya?

Pehle kya hota tha?
- Kubernetes ka har storage vendor ke liye alag code likhna padta tha.
- Core Kubernetes mein hi plugins dale hote the.
- Bahut tight coupling ho jati thi:
  - New feature add karne ke liye Kubernetes upgrade karna padta.
  - Vendor independent nahi tha.
 
Is problem ko solve karne ke liye CSI standard introduce hua.
- Kubernetes core se storage logic alag ho gaya.

2 - CSI Driver Ka Kaam Kya Hota Hai?

CSI driver basically ye kaam karta hai:
- CreateVolume → Naya volume banana.
- DeleteVolume → Volume delete karna.
- ControllerPublishVolume → Volume ko node se attach karna.
- NodePublishVolume → Node ke file system mein volume ko mount karna.
- NodeUnpublishVolume → Volume ko unmount karna.
- ExpandVolume → Size badhana.

How it Works:
- Kubernetes driver ko call karta hai:
  - “CreateVolume()”.
- Driver backend pe volume create kar deta hai:
  - e.g. AWS console mein tumhara EBS dikhega.
 
<br>
<br>

## Dynamic Provisioning on Azure – Complete Step-by-Step

Maan lo tumhara cluster Azure Kubernetes Service (AKS) pe hai. Tum chahte ho:
- Tumhare pod ko 10Gi persistent storage mile.
- Tumhe manually PV create nahi karna.
- Tum dynamic provisioning use karna chahte ho
