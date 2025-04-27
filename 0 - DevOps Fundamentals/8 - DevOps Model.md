# DevOps

DevOps is the combination of two words: Development and Operations.

DevOps is the software development approach in which Development and Operations teams work together and deliver high quality software.

### History of DevOps

Toh bhai scene aisa tha…

2000 ke pehle software banana ek slow aur tough process tha. Tab software Waterfall model se banate the, ya kabhi incremental, kabhi spiral. Problem ye thi ki client apni requirements bata ke chale jaata tha, aur final product dekhne aata tha ek do saal baad. 

Jab product aata toh client bolta — "Yaar ye toh mujhe chahiye hi nahi tha!" Aur fir poora system dobara banana padta. Ye problem itni badi ho gayi ki 2001 mein kuch developers ne baith ke ek manifesto banaya — Agile Manifesto.

Unka kehna tha:
- Software jaldi deliver karo.
- Changes ko accept karo.
- Client ke saath continuous collaboration karo.
- Working software pe focus karo, documentation ke bharose mat raho.

Bas, fir Agile aaya.

<br>

**Agile Ne Problem Kya Solve Ki?**

Ab tumhari team short sprints mein kaam karne lagi. 2 hafte mein ek feature banta, uska demo hota, client feedback deta, usse agle sprint mein sudhar kar lete. Badiya chal raha tha bhai — delivery fast, client happy, development team satisfied.

Par ab ek naya problem aaya…

Agile sirf development tak hi tha.

Product bana toh rahe the, lekin jab usko production pe daalne ki baari aati, toh kuch problems hoti.
- Deployment manual tha.
- Dedicated Ops team karti thi.
- Manually deployment slow hota tha.
- Downtime ka dar.
- Dev aur Ops ki ladayi hoti thi jaise "Yeh code tumne galat likha hai", "Mere machine pe toh chal raha tha", "Server down kyu hua?" ye sab hota tha.

Agile ke process mein toh development fast ho gayi thi, par deployment slow aur risky thi. Production pe code daalne mein din lagte, testing environment alag hota, production alag. Aur sabse badi baat — Dev aur Ops dono alag alag team hoti thi.

Is divide ki wajah se product jaldi release nahi ho paata. Testing alag, deployment alag, monitoring alag. Failures badhne lagte hain. Downtime badhne lagta hai. Customer naraz hote hain.

<br>

**Rise of DevOps**

Phir ek din Ek conference hoti hai 2009 mein. Us conference main **Patrick Debois** ne kaha:

```“Agar hum Development aur Operations ki team ko ek hi team bana dein? Dono ek dusre ke tools seekhein, ek dusre ke processes samjhein, automation karein, aur milke product deliver karein?”```

Sab sochne lagte hain, “Yeh toh accha idea hai!” Aur yahin se janm hota hai DevOps ka. Dev + Ops = **DevOps**

Agile ne development culture badla. DevOps ne deployment aur operations culture badla.

DevOps ne kaha:
- Development aur Operations ek team banegi.
- Har kaam automate hoga — build se leke deployment tak.
- Har code commit pe automatic testing, build, deployment hoga.
- Monitoring aur feedback bhi automated hoga.
- Sab log ek hi goal pe kaam karenge — reliable aur fast product delivery.

Yani Agile ne feature banana fast kiya. DevOps ne feature ko safe, fast aur reliable tarike se client tak pohchana fast kiya.

<br>

### How does deployment happens before DevOps?

DevOps se phele deployment ka kaam **Operations Team** ka hota tha. Aur woh deployment ek **manual ya semi-automated process** hota tha.

**Kaise?**

- Dev team apna final code ek ZIP ya WAR file bana ke ops ko de deti thi.
- Ops team usse leke production server pe daalti thi.
- Manual steps likhe hote the ek Word doc mein:
  - Server pe login karo.
  - Backup lo.
  - Service stop karo.
  - Nayi file daalo.
  - Database migrate karo (SQL scripts run).
  - Service start karo.
  - Check karo sab sahi chal raha hai ya nahi.
- Agar kuch galat ho gaya, to manual rollback.

**Kaun karta tha?**

- Dedicated Operations Engineers.
- Kabhi kabhi Senior Developers (agar chhoti company hoti).
- Kabhi kabhi manually testing wale bhi server pe login karke testing karte the.

Aur har deployment pe tension hoti:
- Downtime hoga.
- Agar raat 2 baje kuch fail hua to kaun uthega?.
- Database corrupt ho gaya to?

**Agile Mein Deployment Phase tha na?**

Agile ke SDLC mein "Deployment" aur "Maintenance" phase hote hain. Lekin woh phase bhi kaafi manual aur separate team driven hota tha.

Agile ke process mein bas yeh likha tha:
- Sprint complete hua.
- Feature ready hai.
- Ab deploy karo.

Lekin kaise deploy karna hai? Kis tool se? Kaun karega? Kitna automated hoga? Iska koi structured process nahi tha. Bas company pe depend karta tha:
- Manual karte.
- Bash scripts likhte.
- Kabhi Jenkins laga ke bas build karte — lekin deploy fir bhi manual.

Monitoring bhi manual:
- Server pe jaake logs dekh lo.
- CPU/Memory check kar lo.
- Koi issue aaya to production team ko phone karo.

**Phir DevOps Ne Kya Badla?**

DevOps ne kaha:
- Manual deployment hatao.
- Deployment bhi Agile ke sprint ke saath integrate karo.
- CI/CD pipeline banao — jahan code push hone ke baad:
  - Build automatic ho.
  - Automated testing chale.
  - Automated deployment ho.
  - Monitoring automatically ho.
  - Rollback ke plans bane hue ho.
- Infrastructure as Code laao — taaki servers bhi code ke jaisa deploy ho.
- Downtime zero karo.
