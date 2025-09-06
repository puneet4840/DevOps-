# Stateful Set in Kubernetes

StatefulSet kubernetes main ek controller hota hai jo stateful application (pods) ko manage karne ke liye hota hai.

Stateful Set samjhne se pehle Stateful application ko samjhte hain.

<br>

### Stateful Application VS Stateless Application

**Pehle "State" ka matlab samajho**:

State ka matlab hota hai data ya information jo ek application ya system ke andar store ho rahi hai, aur jo future mein reuse hoti hai.

Simple words mein — agar ek application apne pichle kaam ya user ke actions ko yaad rakhti hai, to wo Stateful hai. Agar wo kuch bhi yaad nahi rakhti, to wo Stateless hai.

Example for better clarity:
- Tum WhatsApp kholo aur ek message bhejo. Agar tum app band kar do aur dubara kholo, tumhare purane messages abhi bhi wahan hote hain → iska matlab hai ki app ne tumhari state (messages) yaad rakhi.
- Ab ek aur example lo — tum ek IRCTC website kholte ho aur ek seat select karte ho. Agar tum page refresh kar do aur seat selection khatam ho jaye, to iska matlab hai ki wo system ne tumhari state nahi rakhi (Stateless hai).

<br>

**Stateful Applications kya hoti hain?**:
- Stateful applications wo hoti hain jo user/system ke purane data ya actions ko yaad rakhti hain aur future requests me ussi state ka use karti hain.
- Inme ek request dusri request se dependent hoti hai, kyunki application user ki history ya session maintain karti hai.

Feature:
- Keeps memory of past requests – Application tumhari activities/data ko store karke rakhti hai.
- Difficult to scale – Kyunki state manage karna padta hai. Agar replica banate ho to ensure karna padta hai ki sab replicas ke paas same data ho.
- Dependency on storage – Persistent data storage chahiye hota hai jaise database, volume ya disk.

Real-World Examples:
- Databases (MySQL, PostgreSQL, MongoDB) → Ye apne andar data store karke rakhte hain, aur queries ke liye hamesha wahi data use hota hai.
- Messaging Apps (WhatsApp, Telegram) → Tumhare purane chats, contacts, messages sab save hote hain.
- E-commerce Sites (Amazon, Flipkart) → Tumhari cart, wishlist, aur order history save hoti hai.
- Online Banking → Tumhara account balance aur transaction history stored hota hai.

<br>

**Stateless Applications kya hoti hain?**:
- Stateless applications wo hoti hain jo user ya system ke purane actions/data ko store nahi karti.
- Inme har ek request independent hoti hai, aur ek request ka dusri request se koi lena dena nahi hota.
- Server ko fark nahi padta ki tum pehle kya kar chuke ho, wo har baar tumhari request ko nayi fresh request ke tarah treat karta hai.

Features:
- No memory of previous request – Har request independent hoti hai.
- Easy to scale – Kyunki koi state ya data store nahi karna hota, tum jitne chahe replicas bana lo, sab ek jaise kaam karenge.
- Failure resistant – Agar ek server down ho jaye, dusra server bina issue ke request handle kar lega.
- Lightweight – State manage karne ki responsibility nahi hoti.
- Data store alag hota hai – Agar data chahiye to external database, cache, ya storage se liya jata hai.

Real-World Examples:
- Web servers (NGINX, Apache) → Bas HTTP request ko process karte hain aur response dete hain.
- REST APIs → Har request ke saath data bhejna padta hai (jaise authentication token), kyunki server yaad nahi rakhta ki tum pehle login the.
- Static websites → Jaise tum ek blog padho, usko fark nahi padta ki tum kaun ho aur tumne pehle kya padha.

<br>

**Ek Real-Life End-to-End Example**:

Maan lo tum ek E-commerce application bana rahe ho (Amazon jaisi).
- Tumhari frontend web app (React/Angular + NGINX) → Stateless hai.
  - User request karega, HTML/CSS/JS serve hoga, session store nahi hota.
    
- Tumhara backend API (Node.js, Spring Boot, etc.) → Mostly Stateless hota hai.
  - Har request ke saath user ka JWT token aata hai, server us token se validate karke fresh response bhejta hai.

- Tumhara database (MySQL, MongoDB, Redis) → Stateful hai.
  - User ki cart, order history, transactions sab wahan save hota hai. Agar database down ho jaye to state lose ho sakti hai.
 
<br>
<br>

### Kubernetes main StatefulSet ki jarurat kyu padi

We know that ki agar humko kubernetes main koi application deploy karni ho to hum deployment create karte hain aur deployement create karne se pods ke ander application run ho jati hai, agar humko isi application ko higly available banana ho to to hum deployment main replicas de dete hain jisse usi application ke aur pods create ho jate hain.

Suppose karo ki tumne nginx server kubernetes par deploy kiya aur vo pods ke ander run ho rha hai, agar isko highly available banana ho to tum iske 3 ya 4 pods run kar doge to jyada traffic ko handle kar lenge.

Normally, deployment main agar ek hi application ke multiple pods hain, to un pods pe jo traffic distribute hota hai vo service randomly distribute karti hai, jaise pehli request pod-1 aa gyi fir dusri request pod-3 fir tisri request pod-1 pe to ese traffic distribute hota hai.

Ab samjho:

Toh imagine karo, hum Kubernetes cluster mein ek MySQL database run kar rahe hain. Simple start: Hum ek single Pod create karte hain MySQL ke liye. Yeh Pod ek container hai jisme MySQL server chal raha hai. Ab, agar hum isko highly available banana chahte hain, matlab agar ek Pod crash ho jaaye toh service down na ho, toh hum replicas add karte hain. Replicas matlab multiple copies of the same Pod – jaise 3 ya 5 Pods MySQL ke.

Agar MYSQL ka sirf ek hi pod hai aur vo tumne deployment ke through run kiya hai to koi problem nahi hai, lekin agar tumne deployement ke thorugh MYSQL ke multiple replicas bana diye to isme ek problem shuru ho jati hai Aur isi problem ko deal karne ke liye Stateful set ka concept kubernetes main introduce kiya gaya.

Kya Problem Hui:

Suppose hum ek e-commerce app ke liye MySQL use kar rahe hain. Aur humne isko highly available banane ke liye MYSQL ke 5 replicas run kar diye. Ab humare paas 5 pods main alag-alag MYSQL database run ho rha hai jo deployment se replica banake run kiya hai. Pod-1 mein data save ho jaata hai, jaise "```order_id```: ```101```, ```user```: ```A```, ```item```: ```Phone```". Ab, User B usi order ko check karta hai (read request), lekin Kubernetes ki service is request ko Pod-2 pe bhej deti hai. Pod-2 mein yeh data nahi hai kyuki uska storage alag hai! Toh User B ko error milta hai ya wrong data. "```No such order found```". Yeh inconsistency hai matlab ek pod ke paas alag data, dusre pod ke paas alag data.

To yaha kya hua ki deployement se stateful application jaise database usko humne scale kiya, lekin scale karne se data isme consistent nahi rha. Jisse humara application bekar ho gya.

To yaha pe humne ye seekha ki, stateful applications jaise databases ko hum deployment se run to kar sakte hain lekin unko scale nahi kar sakte kyuki scale karne par un application main data sync nahi ho pata hai.

To StatefulSet ke concept ne isi problem ko solve kiya. Aage hum dekhenge ki statefulset ne is problem ko kaise solve kiya.

Example:
- Agar hum ek Deployment use karein toh wo pods randomly banata hai, randomly delete karta hai, aur pod ke naam bhi change ho jaate hain. Ye stateless applications ke liye perfect hai jaise nginx, apache, node.js web apps etc.
  
- Lekin agar hum ek Database cluster run kar rahe hain (MySQL, MongoDB, Cassandra, Kafka), toh humein chahiye ki:
  - Har pod ka naam permanent ho.
  - Har pod ka apna storage ho jo delete na ho.
  - Pods ek order mein start/stop ho.
  - Har pod ko ek unique DNS entry mile jisse wo cluster mein apna role play kar sake.
Aur yahi kaam StatefulSet karta hai.

<br>
<br>

### Stateful Set uper wali problem ko kaise solve karte hain

**Problem Kya thi**:
- Jab hum database kubernetes main deployment ke through deploy karte hain, agar database ka ek singl pod run ho rha hai to koi problem nhi hai, Agar database ke multiple pods deployment ke through run ho rahe hain to yaha problem hoti hai ki data sync nahi ho pata hai; Jaise - Suppose hum ek e-commerce app ke liye MySQL use kar rahe hain. Aur humne isko highly available banane ke liye MYSQL ke 5 replicas run kar diye. Ab humare paas 5 pods main alag-alag MYSQL database run ho rha hai jo deployment se replica banake run kiya hai. Pod-1 mein data save ho jaata hai, jaise "```order_id```: ```101```, ```user```: ```A```, ```item```: ```Phone```". Ab, User B usi order ko check karta hai (read request), lekin Kubernetes ki service is request ko Pod-2 pe bhej deti hai. Pod-2 mein yeh data nahi hai kyuki uska storage alag hai! Toh User B ko error milta hai ya wrong data. "```No such order found```". Yeh inconsistency hai matlab ek pod ke paas alag data, dusre pod ke paas alag data.

Isi probelem ko StatefulSet solve karta hai.

StatefulSet isko solve karta hai by providing ordered and predictable management of pods. Yeh ensure karta hai ki har pod ka ek unique aur stable identity ho, jo pod restart ya scale karne par bhi nahi badalta. Isse application khud apne data ko sync kar sake.

Kubernetes team ne isko introduce kiya tha version 1.5 mein (around 2016-2017), taaki databases aur clustered apps ko cloud-native banaya ja sake bina traditional VMs ki zaroorat ke. Ab, yeh production mein widely used hai, jaise MySQL clusters, Cassandra, Elasticsearch, etc.

StatefulSet ke paanch main pillars hain jo problem solve karte hain:

**1 - Stable aur Unique Pod Identity (Ordinals aur Naming)**:

Yeh sabse important feature hai. Deployment mein pods ke names random hote hain, lekin StatefulSet mein pods ko sequential ordinals diye jaate hain matlab ek order main pod ko rakha jata hai jaise: mysql-0, mysql-1, mysql-2, mysql-3, mysql-4 (for 5 replicas). Yeh names sticky hote hain; matlab agar pod mysql-1 crash ho jaye, to naya pod bhi mysql-1 hi naam se restart hoga, na ki koi naya random naam.

Kyun helpful? Kyunki stateful apps mein pods ko ek dusre se communicate karna padta hai. MySQL mein, pods ka master-slave architecture setup karte hain, jisko MySql cluster bhi bolte hain, jahaan mysql-0 master hota hai, aur baaki pods slaves hote hain. Slaves pods master pod se connect karte hain using stable hostname jaise "```mysql-0.mysql-service.default.svc.cluster.local```". Agar is setup main pod ka naam badal jaye (jaise Deployment mein badal jata hai), to master-slave ke beech main connection break ho jayega, aur ye architecture fail ho jayega.

Aapke scenario mein: Ek user A cluster pe data write request behjta hai jo write request mysql-0 pod pe aati hai. Replication architecture se yeh data mysql-1 pod, mysql-2 pod, etc. pe sync ho jata hai. Jab User B read karta hai, service request kisi bhi pod pe bhej sakti hai, lekin data sab pods mein same hoga kyunki replication architeture hai stable identities ki wajah se.

Replication Architecture: Isme ek pod master pod hota hai, aur baaki pods slave pods hote hain, Master pod baaki slave pods se connected rehta hai. To jab bhi write request database main aati hai to vo Master pod par aati hai, aur vo data slave pods main sync ho jata hai, Aur jab read request aati hai to kisi bhi pod par aa sakti hai, data pehle hi sabhi pods main sync ho chuka hai to data kisi bhi pod se read kiya ja sakta hai, yaha pe data inconsistency nahi hogi.

<br>

**2 - Persistent Storage with VolumeClaimTemplates**:

Deployment mein storage ephemeral hota hai (matlab pod delete hone par pod ka data gayab), lekin StatefulSet mein hum ```PersistentVolumeClaims (PVCs)``` use karte hain jo pod ke data ko permanently store karta hai storage main.

StatefulSet YAML mein ek ```volumeClaimTemplates``` section hota hai jo har pod ke liye automatically ek unique PVC create karta hai—jaise ```mysql-0-pvc```, ```mysql-1-pvc```, etc. Yeh PVCs PersistentVolumes (PVs) se bind hote hain, jo cloud storage jaise Azure Storage, Google PD, ya local disks se backed hote hain.

Result? Pod restart ya delete hone par bhi data persist karta hai. Scaling down karne par PVC delete nahi hota (manual delete karna padta hai), aur scaling up par naya PVC banega.

MySQL example: Har pod ka apna data directory PVC pe stored hota hai. Lekin replication architecture se, master pod (mysql-0) changes ko slaves pe push karta hai, jisse har PVC ka data eventually consistent ho jata hai. Bina iske, jaise Deployment mein, har pod ka storage alag rehta, no sync.

<br>

**3 - Ordered Deployment aur Scaling**:

Deployment mein replicas parallel mein start hote hain matlab ek saath multiple pods restart hote hain, lekin StatefulSet mein sabhi pods ordered way main restart hote hai. Pods ordinal sequence mein create hote hain: pehle mysql-0 pod create hoga, fir mysql-1, aur aise hi baaki pods create hote hain. Scaling up (replicas 3 se 5) mein mysql-3 aur mysql-4 pods add honge after previous ones ready.

Scaling down bhi ordered: Highest ordinal se shuru, jaise mysql-4 pod delete pehle hoga, fir mysql-3 delete hoga. Yeh ensure karta hai ki app ko time mile setup karne ka—jaise MySQL mein new slave ko master se sync karne ka time mile.

Problem solve: Aapke case mein, agar unordered hota, to slave pods master pod ke run hone se pehle master pod se connect karne ka try karte aur connection fail ho jata. Ordered way se, master pod pehle ready hota, fir slave pods master pod se smoothly connect hote hain, data sync ke saath.

<br>

**4 - Headless Services for Peer Discovery**:

Normal Services load balance karte hain, lekin StatefulSet ke saath hum Headless Service use karte hain (clusterIP: None). Yeh DNS records create karta hai har pod ke liye, bina load balancing ke. Pods ek dusre ko discover kar sakte hain using DNS queries.

Example: MySQL pods "mysql.default.svc.cluster.local" query karke sab pods ke IPs paa sakte hain. Isse clustering possible—Galera Cluster ya MySQL Group Replication mein nodes ek dusre se sync rehte hain.

<br>
<br>

### Components of StatefulSet

There are multiple components of StatefulSet.

**1 - Stable Pod Identity (Fixed naming converntion)**:

StatefulSet har pod ko ek fixed aur predictable name deta hai. Pod ke naam ke saath ek ordinal index attach hota hai.

Format:
```
<statefulset-name>-<ordinal>
```

Example:

Agar StatefulSet ka naam mysql hai aur replicas = 3 hai toh pods banenge:
- ```mysql-0```.
- ```mysql-1```.
- ```mysql-2```.

Kyu Hai:
- Kubernetes mein jab hum normal Deployment use karte the (ya ReplicaSet), usmein pods ka behavior kuch aisa hota tha:
  - Pods ephemeral hote hain, matlab agar ek pod delete ho gaya toh naya pod aayega lekin uska naam, IP address, aur identity change ho jayegi.
  - Pod ka naam random suffix ke saath hota hai, jaise:
    - ```nginx-deployment-7d8d6f5b8b-v2x6c```.
    - ```nginx-deployment-7d8d6f5b8b-kkh2m```.
  - Agar pod terminate ho jaaye aur naya aata hai, uska naam aur IP different hoga.

Ye behavior stateless applications (jaise web server, API service) ke liye to sahi hai kyunki unko fark nahi padta kaunsa pod aa raha hai — unka kaam load balancer (Service) ke through hota hai.

Lekin stateful applications (jaise MySQL, Cassandra, Kafka, Zookeeper) ke liye problem ban jaata hai, kyunki:
- Inhe ek stable storage chahiye jo restart ke baad bhi persist ho.
- Inhe ek stable network identity (naam, hostname, IP) chahiye, taki cluster ke dusre members unhe recognize kar saken.

Isliye StatefulSet main har pod ko ek ordinal-index mil jati hai, Ordinal-index ka matlab hai ki 0 se start hona fir 1, fir2 ese, Ye index kabhi change nahi hota. Pod ke naam ke aage ye ordinal-index lagi hoti hai, Iska ye fayda hai ki agar ```mysql-0``` pod crash hoke restart hua to uski naam wahi same rahega ```mysql-0```. Jab pod ka naam same rahega to pod ko DNS name bhi same milega, aur pod same hi persistent volume se attach ho jayega. Jisse cluster main other pod is ```mysql-0``` pod se easily fir se connect kar payenge.

Isliye pod ki identity statble hona jaruri hai.

<br>

**2 - Persistent Storage (Stable Disk per Pod)**:

StatefulSet automatically Persistent Volume Claims (PVCs) create karta hai, jisse har pod ke paas apna ek alag permanent storage ho.

Example:
- Pod ```mysql-0``` → PVC ```data-mysql-0```.
- Pod ```mysql-1``` → PVC ```data-mysql-1```.

Ye PVCs pod delete hone ke baad bhi rehte hain. Matlab data safe rehta hai.

Kyu Hai:

Sabse pehle, ek normal pod ki storage ka behavior samajhte hain:
- Agar tum ek pod create karte ho, aur tumne us pod ko koi volume attach nahi ki hai, to vo pod crash/restart hone par uska saara data delete ho jayega. Matlab ye ephemeral storage hai, jo stateless apps ke liye to theek hai (jaise web server ke logs ya temporary cache), lekin stateful apps ke liye bilkul kaam ka nahi.

Stateful apps ko kya chahiye?
- Persistent storage jo pod ke marne ke baad bhi bachi rahe.
- Har pod ka apna dedicated storage ho, jo usi pod ke saath linked rahe.

StatefulSet ek extra feature deta hai jo Deployment mein nahi hai, jo hai ```VolumeClaimTemplates```.
- Tum ```volumeClaimTemplates``` define karte ho.
- Kubernetes har pod ke liye automatically ek unique PVC banata hai.

Example: Agar tum 3 replicas banate ho aur ```volumeClaimTemplates``` define karte ho, to:
- Pod ```mysql-0``` ke liye PVC banega: ```mysql-storage-mysql-0```.
- Pod ```mysql-1``` ke liye PVC banega: ```mysql-storage-mysql-1```.
- Pod ```mysql-2``` ke liye PVC banega: ```mysql-storage-mysql-2```.

Ye PVCs ek baar ban gaye to chahe pod delete/recreate ho, PVC wahi rehta hai. Matlab data survive karta hai.

Stable pod identity + Persistent storage dono milke stateful apps ko reliable banate hain:
- Pod ```mysql-0``` hamesha apne PVC ```(mysql-storage-mysql-0)``` ke saath hi map rahega.
- Agar ```mysql-0``` delete hua aur recreate hua, to wo apne purane data ko apne PVC se wapas le aayega.

Matlab pod ki identity aur uske storage ki identity permanent aur linked hoti hai.

Socho agar database pod crash ho jaaye aur data temporary storage pe ho, toh saara data khatam. Ye acceptable nahi hai. PVC ensure karta hai ki pod ke sath ek fixed disk attached ho aur data kabhi na lost ho.

<br>

**3 - Ordered Pod Creation & Deletion**:

StatefulSet pods ko ek strict order mein create aur delete karta hai.

- Create karte time → Pehle ```mysql-0```, phir ```mysql-1```, phir ```mysql-2``` create honge.
- Delete karte time → Sabse last pod pehle delete hoga (```mysql-2```), phir ```mysql-1```, aur finally ```mysql-0```.

Kyu Hai:

Ye ordered pod creation aur deletion isliye jaruri hai kyuki stateful apps me dependencies hoti hain (pehle ek node ready hona chahiye, tab hi dusra connect kar sakta hai).

Suppose ```mysql``` ka cluster hai, To pehle master pod ready hona chiaye jo ```mysql-0``` hoga, fir slave pods create hone chiaye jo master pod se connect karenge. Agar stateful set ye ordered creation aur deletion follow nahi karenge jo koi bhi pod kabhi bhi create hoga jisse slave pod pehle create hoga to master slave ke beech main connectivity problem hogi, aur cluster inconsistent ho jaayega.

Agar scale down karte waqt random pod delete ho jaaye (jaise leader ya primary node), to system unstable ho sakta hai. Ordered deletion ensure karta hai ki sabse last wale pods pehle delete ho, jisse system safe rahe.


<br>

**4 - Stable Network Identity (DNS Records with Headless Service)**:

StatefulSet ke sath ek Headless Service use hota hai. Is service ke through har pod ko ek stable DNS record milta hai.

Example: Agar StatefulSet ka naam ```mysql``` aur service ka naam bhi ```mysql``` hai toh:
- ```mysql-0.mysql.default.svc.cluster.local```.
- ```mysql-1.mysql.default.svc.cluster.local```.
- ```mysql-2.mysql.default.svc.cluster.local```.

Kyu Hai:

Database cluster mein har node ko ek doosre se connect karna hota hai. Agar pod ke naam aur IP bar bar badalte rahenge toh connection break ho jaayega. Stable DNS ensure karta hai ki har node hamesha ek hi naam se accessible ho.

Kaise hota hai.

Sabse pehle normal pod networking samajhte hain:
- Kubernetes mein har pod ko ek IP address milta hai.
- Ye IP address ephemeral hota hai (jaise ghar ka temporary phone number). Agar pod delete/restart ho jaye to uska IP badal jaata hai.
- Agar hum Deployment use karte hain, to pods ka naam bhi random hota hai, aur IP bhi change hota hai.

Matlab pod ki identity fixed nahi hoti.

Ab stateless apps (web server, API) ke liye to fark nahi padta kyunki wo Service (ClusterIP/LoadBalancer) ke peeche chhup jaate hain. Service random pod ko traffic bhejta hai.

Lekin stateful/distributed apps ke liye yahi sabse badi problem hai:
- Inhe fixed aur stable network identity chahiye.
- Example: Mysql cluster mein ```mysql-0``` ko hamesha ```mysql-0``` hi rehna chahiye, taki baaki pods usse recognize kar saken.

Problem Without Stable Network Identity:
- Agar stable identity na ho to:
  - Pod restart ke baad naya IP aayega → purane cluster members confuse ho jaayenge.
  - Pod ka naam random hoga → koi bhi deterministic way nahi hai usko recognize karne ka.
  - Peer-to-peer communication (jaise Raft, Gossip protocols) fail ho jaayega.
 
Solution: Headless Service + DNS Records:

StatefulSet is problem ko solve karta hai Headless Service ke sath.

Headless Service Kya Hai?
- Headless vo service hoti hai jiske paas koi ip nhi hoti. Headless service create karte time hum clusterIP main Nonde dete hain.
- Normally, Kubernetes Service ek ClusterIP banata hai jo load-balancing karta hai.
- Lekin Headless Service mein tum explicitly likhte ho:
```
clusterIP: None
```

Matlab is service ka apna IP nahi hota. Ye sirf DNS ka kaam karega, load-balancing nahi karega.

Headless Service har pod ka individual DNS record banata hai.

Stable DNS Record for Each Pod:
- Har StatefulSet pod ka ek deterministic DNS ban jaata hai:
```
<pod-name>.<headless-service-name>.<namespace>.svc.cluster.local
```

Example: Agar tumne ek StatefulSet banaya mysql naam ka, jisme service mysql hai aur namespace default:
- Pod mysql-0 ka DNS hoga:
```
mysql-0.mysql.default.svc.cluster.local
```
- Pod mysql-1 ka DNS hoga:
```
mysql-1.mysql.default.svc.cluster.local
```
- Pod mysql-2 ka DNS hoga:
```
mysql-2.mysql.default.svc.cluster.local
```

Ye DNS records predictable aur permanent hote hain. Agar pod delete ho jaye aur wapas aaye, fir bhi uska DNS wahi rehta hai.

Cluster ke dusre pods hamesha ek pod ko uske DNS naam se access karte hain, jo kabhi badalta nahi.
