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
