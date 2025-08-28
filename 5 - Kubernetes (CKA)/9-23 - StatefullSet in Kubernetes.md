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

