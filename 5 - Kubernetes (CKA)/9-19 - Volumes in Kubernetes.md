# Volumes in Kubernetes

### What is Volume?

Volume is the directory with the data in it.

```Volume एक directory है जिसके अंदर data stored है|```

```सूपपोसे आपके लैपटॉप मैं एक फोल्डर बना हुआ है जिसमे कुछ फाइल्स है, तो फोल्डर एक वॉल्यूम होगा|```


<br>

### What is Kubernetes Volume?

Kubernetes volume is a storage space or a directory which you attach to a container and container data is stored in that volume becuase if the container gets stopped or restarted then its data would be available to container.

Kubernetes Volume ek folder hota hai, jo pod ke andar containers ke liye accessible hota hai, jisme tum data save kar sakte ho:
- Ye folder kabhi node ke disk pe ho sakta hai, kabhi cloud storage pe, kabhi network storage pe.
- Ek hi pod ke andar jitne bhi containers hain, sab same volume ko share kar sakte hain.

```Kubernetes में Volume एक storage space or एक directory है जो persistent storage provide करता है, मतलब container के लिए permanent storage provide करता है , ताकि तुम्हारे pod के containers अपना डेटा```:
- ```Crash के बाद भी बचा सकें|```
- ```Multiple containers के बीच share कर सकें|```

<br>

### Why do we need volumes in kubernetes?

```सबसे पहले समझो कि Volumes की ज़रूरत ही क्यों पड़ती है?```

```जब तुम Kubernetes में कोई Pod रन करते हो, उसमें containers चलते हैं| Containers के अंदर जो file system होता है, वो temporary होता है| इसका मतलब है की जैसे ही pod या container terminate होता है या restart होता है तो उसके अंदर का data delete हो जाता है|```

Matlab:
- Tumhara container jab chal raha hai, tab uske andar ka data tum use kar sakte ho — files create kar sakte ho, modify kar sakte ho.
- Par jaise hi container restart hota hai ya tum container ko delete karte ho, uska pura file-system chala jata hai.
- Saara data loss ho jata hai.

For example:
- ```तुम एक container में कोई फाइल /data/test.txt create करते हो।```
- ```Container crash हुआ → फाइल गई।```
- ```Container recreate हुआ → खाली filesystem मिली।```

```इसका मतलब है जब भी container या pod restart होते हैं तो उसके अंदर का data delete हो जाता है| Production workloads में ऐसा कभी acceptable नहीं है।```

```Volume container के data को permanently store करने का काम करते हैं|```

```तो volume की help से हम container के data को container के outside store करते हैं जिससे container का data delete होने पर भी container का data available रहता है|```

```Volume एक storage space ya directory होता है जिसे हम container से attach करते हैं जिससे container का data उस volume में जाकर permanently store हो जाता है| फिर अगर container start भी होता है तो volume से data उस container को मिल जाता है|```

<br>

### POD and Volume relation

- Volume is defined at Pod level, not Container level.
  - Jab hum kehte hain “Volume is defined at Pod level,” iska matlab:
    -  Pod ke andar jitne bhi containers hain, sabhi containers ek hi volume ko dekh sakte hain.
    -  Volume Pod ke lifetime ke sath attach rehta hai, chahe containers andar crash ya recreate ho jaayein.
    -  Tum volume ko Pod ke spec mein define karte ho, na ki har container ke andar alag se.
    -  Agar tum volume Pod level par define nahi karoge, toh containers apas mein data share nahi kar paayenge.
    -  Agar volume container level par hota, toh woh sirf ussi container mein limited rehta.”
   
<br>

### Types of Volume in Kubernetes

- emptyDir.
- hostPath.
- ConfigMap and Secret.
- PersistentVolume (PV) and PersistentVolumeClaim (PVC).
- Cloud Volumes.

<br>

### 1 - emptyDir

emptyDir ek Kubernetes ka built-in volume type hai, jo ek khaali folder (directory) provide karta hai jab Pod start hota hai.

Jis node par pod chal rha hota hai usi node par ek empty directory us pod ke liye create ho jate jab pod run hota hai aur usi directory main pod container ka data store hota hai.

Jaise hi Pod schedule hota hai aur uska node par koi container run hona start karta hai, Kubernetes us Pod ke liye ek empty directory bana deta hai.

Jaise hi pod delete hota hai, turant hi node par directory main se data bhi delete ho jata hai, ye ek temporary mounting hoti hai.

**Kab Banta Hai EmptyDir?**
- Jab Pod start hota hai.
- Agar Pod run hi nahi hua, toh emptyDir bhi nahi banta.

**EmptyDir Ka Data Kahan Store Hota Hai?**
- Node ke local disk par store hota hai.
- Matlab:
  - Tumhare cluster ka jo node hai jahan Pod run ho raha hai → usi node ke file system main ek empty directory ban jaati hai.
  - Agar Pod migrate ho gaya dusre node par, woh data nahi jayega uske saath.
 
**EmptyDir Kyu Use Karte Hain?**
- Temporary data store karne ke liye use karte hain.
  
- Pod ke andar do containers hain jo ek hi data share karna chahte hain.
- Tum emptyDir use karte ho taaki:
  - Ek container data likhe.
  - Dusra container wohi data padh le.

- Temporary calculations, intermediate files ke liye.
- Jaise tum program ke beech mein kuch temp files bana rahe ho, par long-term store nahi karna chahte.

Kul mila ke temporary data store karne ke liye emptyDir volume ka use karte hain.


**EmptyDir Ka Lifecycle**
- Container restart hota hai  -->  emptyDir ka Data safe rehta hai.
- Pod delete hota hai  -->   Data chala jaata hai.
- Pod migrate hota hai dusre node par   -->   Data nahi jata uske saath.

Matlab:
- emptyDir tied hai Pod ke lifecycle se.
- Pod ke marne par hi data delete hota hai.

<br>

**Kaise Use Karte Hain EmptyDir?**

Example: Pod Spec With emptyDir
```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  volumes:
    - name: cache-volume
      emptyDir: {}
  containers:
    - name: writer
      image: busybox
      command: ["/bin/sh", "-c"]
      args:
        - echo "Hello Puneet!" > /cache/hello.txt;
          sleep 3600
      volumeMounts:
        - mountPath: /cache
          name: cache-volume

    - name: reader
      image: busybox
      command: ["/bin/sh", "-c"]
      args:
        - cat /cache/hello.txt;
          sleep 3600
      volumeMounts:
        - mountPath: /cache
          name: cache-volume
```

Explanation: Is example mein kya ho raha hai?
- Pod mein ek volume define hua → ```cache-volume```.
- Type hai → emptyDir.
- Do containers hain:
  - writer → ```/cache/hello.txt``` file mein likh raha hai → “Hello Puneet!”
  - reader → wahi file read kar raha hai.
 
- Dono containers ne:
```
volumeMounts:
  - mountPath: /cache
    name: cache-volume
```

Isliye:
- Dono same folder ```/cache``` dekh rahe hain.
- Jo ek likhega, dusra padh sakta hai.

**emptyDir Types: Memory vs Disk**

emptyDir ke andar ek optional field hoti hai → ```medium```.

Isme humko do option hote hain ki, Hum data ya to node ki disk main store kar sakte hain ya fir node ki RAM main store kar sakte hain.

Example: Disk-Based (Default)
```
emptyDir: {}
```
- Node ke local disk par store hota hai.

Example: Memory-Based
```
emptyDir:
  medium: Memory
```
- Node ke RAM mein store hota hai.
- Super fast because data RAM mein hai.
- High-speed caching.

<br>
<br>

### 2 - hostPath

hostPath volume type se Node ke file system ke kisi bhi path ko container ke andar mount kar sakte ho.

hostPath ek Kubernetes ka volume type hai jiska matlab hai:
- Tum Kubernetes ke node (host machine) ke filesystem ka koi bhi path container ke andar mount kar sakte ho.

Simple shabdon mein:
- Tumhare node ke file system par jo path hai, use directly container ke andar mount karna Container ka data file system par store ho.
- Container ke andar woh path ek normal folder ke jaise dikhega.

```Host Path क्या करता है की node file system मैं बने हुए folder को container के किसी path पर mount करता है जिससे container के path का data node के folder पर store होता है|```

Tum node ke local folders ko container ke andar use kar sakte ho.

**hostPath Ka Basic Usage**

hostPath ke saath tum define karte ho:
- path → Node ke file system par exact path.
-  type (optional) → Batata hai ki jo path tum specify kar rahe ho woh kya hona chahiye:

| Type              | Matlab                                                |
| ----------------- | ----------------------------------------------------- |
| DirectoryOrCreate | Agar woh directory nahi hai, to create kar do.        |
| Directory         | Directory hona chahiye. Agar nahi mila, error aayega. |
| FileOrCreate      | File create karo agar nahi hai.                       |
| File              | File hona chahiye.                                    |
| Socket            | Unix socket hona chahiye.                             |
| CharDevice        | Character device hona chahiye.                        |
| BlockDevice       | Block device hona chahiye.                            |

<br>

**Example 1 → Simple hostPath Directory Mount**

```
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-demo
spec:
  containers:
    - name: busybox
      image: busybox
      command: ["/bin/sh", "-c", "ls /hostdata; sleep 3600"]
      volumeMounts:
        - mountPath: /hostdata
          name: myhostpath
  volumes:
    - name: myhostpath
      hostPath:
        path: /data
        type: DirectoryOrCreate
```

Explanation: Is example mein kya ho raha hai?
- Tumne ek Pod banaya hai → ```hostpath-demo```.
- Volume define kiya:
  ```
  hostPath:
    path: /data
    type: DirectoryOrCreate
  ```

Matlab:
- Node ke filesystem par ```/data``` folder agar nahi mila → Kubernetes usko create kar dega.

- Container ke andar woh mount ho raha hai → ```/hostdata```.

- Container ke andar tum:
```
ls /hostdata
```
Karke dekh sakte ho kya contents hai.

<br>

**hostPath Kyu Use Karte Hain?**

1 - Diagnostics aur Debugging:
- Tum node ke logs dekhna chahte ho.
- Jaise tum ```/var/log``` ko mount kar lo container ke andar → tum logs analyse kar sakte ho.


2 - Configuration Files:
- Agar tumhare paas node-specific configuration hai → woh container ko dikhana hai.

3 - Local Storage:
- Tum temporary ya permanent storage ke liye node ka koi path use kar sakte ho.
- Pod ko ek node par hi sticky rakhna hai aur host ke local storage ko use karna hai.

4 - Third-Party Applications:
- Bahut saare third-party apps like monitoring tools (Prometheus node exporter, Fluentd, etc.) hostPath use karte hain taaki woh:
  - Node ke logs read kar saken.
  - Node ke metrics collect kar saken.
 
<br>

**Security Ka Concern**

hostPath powerful hai lekin bahut dangerous bhi ho sakta hai.

1 - Host File System Exposure:
- Agar tum ```/``` mount kar doge, pura host file system container ke andar dikhai dega.
- Bada security risk hai.
Example:
```
hostPath:
  path: /
  type: Directory
```
- Container ke andar tum pura host file system dekh sakte ho:
```
ls /
```

2 - Privilege Escalation:
- Agar container ke paas write access hai:
  - Container host par files change kar sakta hai.
  - Malicious code likh sakta hai host ke binaries mein.
