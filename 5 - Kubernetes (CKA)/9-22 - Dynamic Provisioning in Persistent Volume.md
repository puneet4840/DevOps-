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

Storage Class is a kubernetes object that is used to register the register the details of cloud storage backend in your cluster.

In storage class we give the information about the CSI Driver, type of storage, etc. That information is needed for kubernetes to register the storage backend in cluster.

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

Storage Class is a kubernetes object that is used to register the register the details of cloud storage backend in your cluster.

In storage class we give the information about the CSI Driver, type of storage, etc. That information is needed for kubernetes to register the storage backend in cluster.

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
- Tum dynamic provisioning use karna chahte ho.

Below are the steps:


### Step 1 → Azure CSI Driver Cluster Mein Deploy Karo

Pehle check karo tumhara Azure Disk CSI driver enabled hai ya nahi.

AKS clusters (latest) mein mostly driver pehle se installed hota hai. Par agar tum manually install karna chahte ho, to ye deploy karna padta hai:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/azuredisk-csi-driver/master/deploy/install-driver.yaml
```

Ye 2 cheezein deploy karega:
- Controller plugin (deployment).
- Node plugin (daemonset).

### Step 2 → StorageClass Create Karo

Ab tumhe StorageClass banana hai. Ye batata hai:
- Provisioner kaun hai? → disk.csi.azure.com.
- Disk ka SKU (Standard_LRS, Premium_LRS, UltraSSD_LRS, etc.).
- Kaunse resource group mein banana hai (optional).


Example StorageClass – Premium SSD:
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: azure-disk-premium
provisioner: disk.csi.azure.com
parameters:
  skuName: Premium_LRS
  kind: Managed
  cachingMode: ReadOnly
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
```

Explanation:
- ```provisioner: disk.csi.azure.com```: batata hai Azure Disk CSI driver use hoga.
- ```skuName: Premium_LRS```: Premium SSD banana hai.
- ```volumeBindingMode: WaitForFirstConsumer```: disk tab create hogi jab pod schedule hoga.
- ```allowVolumeExpansion: true```: disk future mein resize kar sakte ho.

Apply karo:
```
kubectl apply -f sc-azure-disk.yaml
```

Check karo:
```
kubectl get storageclass
```

Ise create karne se plugin azure main ek disk create kar dega.

### Step 3 → PVC Create Karo

We need to define the PVC here.

Example PVC:
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azure-disk-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: azure-disk-premium
  resources:
    requests:
      storage: 10Gi
```

Explanation:
- PVC ko 10Gi disk chahiye. Premium SSD chahiye (jo tumne StorageClass mein define kiya)

Apply karo:
```
kubectl apply -f pvc.yaml
```

Check karo:
```
kubectl get pvc
```

Status pehle Pending dikh sakta hai jab tak pod deploy nahi hota (kyunki tumne WaitForFirstConsumer lagaya hai).

### Step 4 → Pod Deploy Karo jo PVC Use Kare

Ab tumhara pod deploy karo jise ye PVC chahiye.

Example Pod YAML:
```
apiVersion: v1
kind: Pod
metadata:
  name: azure-disk-pod
spec:
  containers:
    - name: myapp
      image: nginx
      volumeMounts:
        - mountPath: "/mnt/azure"
          name: diskstorage
  volumes:
    - name: diskstorage
      persistentVolumeClaim:
        claimName: azure-disk-pvc
```

Pod ke andar tumhara volume mount hoga → /mnt/azure

Apply karo:
```
kubectl apply -f pod.yaml
```

### Step 5 → Azure Disk Create Hota Hai (Automatically)

Jaise hi tumhara pod schedule hota hai:
- Kubernetes dekhta hai ```PVC``` → ```StorageClass``` → ```disk.csi.azure.com```.
- CSI driver ko call karta hai:
  - CreateVolume.
- CSI driver Azure API ko bolta hai:
  - “Creat 10Gi Premium SSD!”.
- Azure tumhare subscription mein disk create kar deta hai:
  - Name: pvc-xxxxxxxxxxx.
  - Size: 10Gi.
  - Type: Premium_LRS.

- Check karo Azure portal mein:
  - Resource group → Disks → New disk created dikhega.
 
### Step 6 → Disk Node Pe Attach Hoti Hai

- Azure tumhari disk AKS node ke VM pe attach kar deta hai:
  - CSI driver ```ControllerPublishVolume``` call karta hai → disk attach hoti hai VM ke ```/dev/sdX``` ya ```/dev/mapper``` pe.
- Phir CSI driver ```NodePublishVolume``` call karta hai → disk file system ke andar mount hoti hai:
  - Tumhare container ke path pe: ```/mnt/azure```.
 
### Step 7 → Pod Use Kar Sakta Hai Storage

Ab tumhare pod ke andar jaake check karo:
```
kubectl exec -it azure-disk-pod -- /bin/bash
```

Dekho:
```
df -h /mnt/azure
```

Output kuch aisa:
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdc        9.8G   33M  9.8G   1% /mnt/azure
```

DONE!!! - Tumhari Azure Disk pod ke andar mounted hai.


### Step 8 → Clean-Up

Agar tum PVC delete karte ho:
```
kubectl delete pvc azure-disk-pvc
```

Aur reclaimPolicy agar Delete hai:
- CSI driver firse Azure ko call karta hai:
  - DeleteVolume.
- Azure tumhari disk delete kar deta hai.

Agar reclaimPolicy Retain hoti:
- Disk Azure mein padhi rahegi.
- Tum manually manage karoge.


