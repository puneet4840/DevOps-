# Branching Strategies in Git

Branching strategy ek tarah se multiple branches banane ka tarika hai jisme hum alag purpose ke liye seperate branch rakhte hain.

Branching strategy ka matlab hai:
- “Team ya project ke andar kaise alag-alag branches banayi jayengi, unka naam kya hoga, unka purpose kya hoga aur unhe kab merge karna hai.”

Ye ek policy hai jisse:
- Developers ko pata hota hai kaunsi branch par kaam karna hai.
- Code stable rehta hai.
- Release aur bugfix properly hota hai.
- Conflicts aur confusion kam hote hain.

Example:

Jab ek developer ya ek chhoti team project kar rahi hoti hai to:
- Kaun sa code stable hai?
- Kaun sa code development me hai?
- Kaunsa code production me deploy ho raha hai?
- Kaunsa code urgent bug fix ke liye hai?
- Ye sab decide karna mushkil ho sakta hai.

Branching Strategy ek techinique hai jo batata hai:
- Har branch kis purpose ke liye hai.
- Kaun si branch se kaun si branch banegi.
- Kaun si branch kab merge hogi aur kaun se rules follow karne hain.
- Release aur deployment ka flow kaisa hoga.

Without strategy → har developer apni marzi se branch banata hai, merge karta hai, result = unstable code + mess.

<br>
<br>

### Branching Strategy Ki Need Kyun Hai?

Ese samjho jaise abhi apke project main sirf ek branch hai ```main```, to:
- Multiple developers ek hi repo me kaam karte hai, to saare commit bhi ``` main``` branch main honge. Sab developers alag features ya bugs par kaam karte hai. Agar sab “main” branch par hi directly push karenge to code toot sakta hai, unstable ho sakta hai, code ke ander kaafi bug aa sakte hain. Release ke time par agar code unstable rahega to deployment ke baad application thik se work nhi karegi ya fir application down bhi ho sakti hai.

To branching strategy ke bina code karne par ye saari problems aa sakti hain.

Isliye ek predefined branching model hota hai jise sab follow karte hai.

<br>
<br>

### Common Branching Strategies (Industry Standard)

4 bahut popular pattern hain:
- Feature Branching.
- Git Flow.
- GitHub Flow.
- Trunk Based Development.

<br>

**1 - Feature Branching**:

Isme kya hota hai ki tumhari paas ek ```main``` branch hoti hai (production code). Agar application main koi feature add karna hai ya fir application main koi bug fix karna hai to directly ```main``` branch se ek ```feature``` ya ```bugfix``` branch create karte hain aur jab feature ya bug complete ho jaye to pull request create karke ```main``` mein merge kar do.

<br>
<br>

**2 - Git Flow (Most Structured)**:

Vincent Driessen ne 2010 me “Git Flow” propose kiya tha. Us samay bahut si teams ek hi ```master``` branch par develop kar rahi thi. Problem:
- Kabhi production code bhi toot jata tha.
- Naye features test nahi ho paate the.
- Urgent fixes karte time purana code kharab ho jata tha.

Git Flow ne ek clear, disciplined branching model diya. Jisme har branch ka ek role hai.

Isme multiple long-lived branches hoti hai, jaise:
- ```main```: Production-ready code hota hai.
- ```develop```: Development code ke liye hoti hai.
- ```feature/```: Application main koi feature add karne ke liye hoti hai, isko develop se banate ho (naye features ke liye).
- ```release/```: Code ko server pe deploy karne ke liye hoti hai, develop se banate ho release preparation ke liye.
- ```hotfix/```: Agar live application main koi issue aa jaye to urgent issue ko fix karne ke liye banate hain, isko ```main``` branch se banate ho urgent production fix ke liye.

Uper diye hue branches ko detail main samjhte hain.

**2.1 - main branch – Production-ready code**:

Kya hai:
- Ye woh branch hai jisme always stable, tested, production-ready code hota hai.
- Git Flow me purana naam “master” tha, ab inclusive language ke liye “main” use hota hai.

Kyu hai:
- Production deploy ka single source of truth hota hai, matlab ek hi branch hoti hai jisme production par chal rhe application ka safe code hota hai.
- Kisi bhi time koi bhi deploy kare toh safe ho.

Kaise kaam karti hai:
- Normal development ```main``` me nahi hota.
- Sirf ```release/``` branch merge hone par ya ```hotfix/``` merge hone par update hota hai.

Example:
- Tumhari python app v1.0 production me chal rahi hai.
- ```main``` branch par tumhare paas:
```
calc.py (add(), subtract() functions)
```

Users ko ye code live mil raha hai. Tum direct main par kuch nahi karte, taaki production hamesha safe ho.

<br>
<br>

**2.2 - develop branch – Next release integration code**:

Kya hai:
- Ye branch ek integration playground hai.
- Saare naye features aur bugfixes yahan aake merge hote hain.
- Jab ```develop``` stable ho jata hai, usse ```release/``` branch banti hai aur phir ```main``` me merge hoti hai.

Kyu hai:
- ```main``` ko stable rakhne ke liye.
- Ek jagah pe saare nayi features test kar sakein bina production ko todhe.

Kaise kaam karti hai:
- Tum har feature ```develop``` se branch karte ho.
- Feature complete hone par develop me merge kar dete ho.
- Deploy nahi hota, sirf integration/test environment me hota hai.

Example:

```develop``` branch par tum abhi ek naya feature multiply() bana rahe ho. Abhi incomplete hai. Tumhare testers integration server pe ```develop``` ka code chala ke check kar rahe hai. Production me abhi purana code hai (main).

<br>
<br>

**2.3 - feature/ branches – Naye features ya bugfixes**:

Kya hai:
- Ye short-lived branches hoti hain jo ```develop``` se banti hain.
- Har feature/bugfix apni alag branch me develop hota hai.
- Complete hone par ```develop``` me merge hoti hai (na ki main me directly).

Kyu hai:
- Har feature isolated ho.
- Team members parallel kaam kar sakein bina conflict ke.
- PR aur code review easily ho sake.

Kaise kaam karti hai:
- Tum ```develop``` se branch banate ho.
- Tum is branch me code likhte ho.
- Tum commit karte ho, test karte ho.
- Complete hone par ```develop``` me merge kar dete ho.

Example:
- Tum feature/multiply-function bana rahe ho.
- Is branch me sirf multiply() ka code hai.
- Jab complete hota hai toh ```develop``` me merge kar diya.

<br>
<br>

**2.4 - release/ branches – Release preparation ke liye**:

Kya hai:
- Ye branch ```develop``` se banai jati hai jab tum decide karte ho ki ab naye features add nahi karne, sirf release ki preparation karni hai.
- Yahan sirf bug fixes, version bump, documentation hota hai.
- Jab release ready hoti hai, ye branch ```main``` me merge hoti hai aur phir ```develop``` me bhi back-merge hoti hai.

Kyu hai:
- Production me deploy hone se pehle ek “freezing” zone ho.
- Taaki develop me naye features chalte rahe aur tum release ko alag se finalize kar sako.

Example:
- Tumhare develop par add(), subtract(), multiply() complete hai.
- Tum decide karte ho v1.1 release karni hai.
- Tum release/1.1.0 banate ho aur version bump karte ho __version__ = "1.1.0".
- Test karte ho.
- Jab sab ok hota hai toh ```main``` me merge karte ho, tag lagate ho v1.1.0.
- ```Develop``` me bhi merge karte ho taaki ```develop``` ka state main ke saath sync ho.

<br>
<br>

**2.5 - hotfix/ branches – Urgent production fix ke liye**:

Kya hai:
- Ye branch directly ```main``` se banai jati hai jab production me urgent bug ya security issue aa jata hai.
- Yahan tum quickly fix karte ho aur phir main + develop me merge karte ho.

Kyu hai:
- Kabhi production me koi critical bug aa jaye to tum release cycle ka wait nahi kar sakte.
- Tum direct production code ko patch karte ho bina develop ke chhed-chaad kiye.

Example:
- Production me v1.1 chal raha hai (main branch).
- Users report karte hai add() crash ho raha hai jab None pass karte ho.
- Tum turant ```hotfix/add-none-fix``` banate ho ```main``` se, fix karte ho, ```main``` me merge karte ho, ```develop``` me merge karte ho. Deploy kar dete ho.


Flow:
- ```feature``` branch ```develop``` se start hoti hai.
- Feature complete → ```develop``` me merge hota hai.
- Jab release ready → ```release``` branch banate ho develop se.
- Release test hone ke baad → ```main``` + ```develop``` dono me merge kar dete ho.
- Urgent fix → ```hotfix``` branch ```main``` se → fix merge back to ```develop```.

<br>

Example naming:
- ```feature/login-api```.
- ```release/1.2.0```.
- ```hotfix/critical-bug```.

<br>
<br>

**3 - GitHub Flow (Lightweight)**:

- Sirf main branch hoti hai (production).
- Har feature ya bug ke liye ek short-lived branch banao, pull request karo, review + test, phir merge karo main me.
- Direct deployment main se hota hai (continuous deployment).

<br>
<br>

### Naming Conventions – why important

Consistent naming se sabko pata hota hai kis branch ka kya kaam hai:
- ```feature/login-api```.
- ```bugfix/null-pointer```.
- ```release/2.1.0```.
- ```hotfix/security-issue```.
