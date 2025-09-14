# How Git Works

Git ko install karne ke baad, apni files ko git ke through track karvana hai, iske liye pehle ```git init``` command ke through git ko initialize karna hota hai, jiske baad aage ka tracking process shuru hota hai. Jisme, tumhari files working directory main rehti hain, working directory se tum files ko staging area main leke jaate ho, staging area main files next commit ke liye ready rehti hain. Iske baad tum files ko commit kar dete ho jisse files ki history git repository main store ho jati hai. Is stage main files git ke through track hoti hain.

Git uses Three stage acrhitecture to track the files.

<br>
<br>

### Git Three stage architecture

<img src="https://drive.google.com/uc?export=view&id=1RKKCRWpMcQt6D2kIeXEik96GmDtjfmSV" width="650" height="390">

<br>

Git files ko manage karne ke liye 3 stages ka use karta hai:
- ```working directory```.
- ```staging```.
- ```Git repository```.

Yeh 3 stage milkar decide karte hain ki tumhara code kis state me hai aur Git tumhare changes ko kaise track kar raha hai.

Git ek distributed version control system hai, jo tumhare files ke snapshots matlab history ko save karta hai, jaise files kisne create ki, konsi character add hua, konsi line add hui, konsi line delete hui, kisne file main changes kiye. ye sab ```.git``` folder ke ander save karta hai.

Bina is architecture ke, changes directly ```.git``` folder main save ho jaate, lekin Git tumhe is architecture ke through ye flexibility deta hai taaki tum carefully decide kar sako ki kya-kya files commit karni hai.

<br>

**Stage-1: Working Directory**:

Ye vo folder ya file system ho hota hai jaha tum files aur folder apne system main create karte hi. Ye woh jagah hai jahaan tumhare project ke saare files physically exist karte hain tumhare computer ke disk pe.

Yeh tumhara current working folder hota hai, jahaan tum code editor jaise VS Code mein files open karte ho, edit karte ho, new files create karte ho, delete karte ho, ya kuch bhi changes karte ho.

**Working Directory main 2 cases hote hain**:

**Case-1: New created files in working directory are not tracked by git**:

Ye vo case hai jab aapne working directory main nayi files create ki hain aur vo commit nahi hui hain.

Working directory main new created files untracked hoti hain, iska matlab hai ki git ko ye pta hota hai ki jo file working directory main nayi create hui hain wo kon kon si files hain lekin git ko ye nhi pta hota ki files main kya code likha hua hai.

To simply hum ye hi keh sakte hain ki jab bhi working directory main koi nayi file create hoti hai to vo file untracked rehti hai matlab git files ko track nhi karta hai.

**Case-2: Commited files in working directory are tracked by git**:

Ye vo case hai jab apne working directory ki files ko already commit kiya hua hai aur aap un files main koi changes karte ho.

Agar aapne working directoy main ek file create ki aur usko staging area main le jake commit kar diya, to us file ki history git apne ```.git``` folder main store kar leta hai, Jisse ye file git track karna shuru kar deta hai. 

To file commit karne ke baad, agar us file main aap kuch bhi change karte ho to vo file working directory main modified ho jati hai, iska matlab git ko pta hai ki apne file main kuch add ya delete kiya hai.

Fir aap is file ko staging area main leke jate ho aur commit kar dete ho, to file ki history fir se ```.git``` folder main store ho jati hai.

To iska matlab hai ki jo file commited hain aur vo working directory main bhi hain, un files ko git track karta hai. Aur jab bhi aap un files main kuch change karte ho to git ko pta lag jata ki konsi file main kaha change kiya hai.

<br>

**Stage-2: Staging Area**:

Yeh ek intermediate area hai jahan tum Git ko batate ho: “Mujhe yeh files next commit me daalni hai.”

Staging vo area ya stage hoti hai jaha hum files ko commit karne ke liye ready rakhte hain.

Staging area ek file hoti hai ```.git``` folder ke andar (```index``` file), jo compressed form mein store karti hai tumhare selected changes ko. Jab tum working directory mein edit karte ho, woh changes staging mein nahi jaate automatically – tumhe manually add karna padta hai. Aur important: Staging mein jo version jaata hai, woh us time ka snapshot hota hai, nahi ki current working directory ka. Matlab agar tum add karne ke baad phir edit karte ho, toh staging mein old version rehta hai, jab tak tum dubara add na karo.

Staging area isliye hota hai ki tum ye decide kar sako kon kon si files commit karni hai, Kyuki hum file ko bina staging area main le jaye bhi commit kar sakte hain lekin wha humare paas files ko select karke commit karne ka option nahi hoga. Isliye staging area hota hai ki hum files ko decide kar sake ko konsi file commit karni hai.

- Working directory ke baad files ko staging area main leke aana hota hai aur fir commit karna hota hai.

<br>

**Stage-3: Git Repository**:

Ye vo stage hai jaha par saare commited changes permanently store hote hain.

Yeh tumhare project ka hidden ```.git``` folder hai jisme git changes ko store karke rakhta hai.

```.git``` folder main git apna poora database rakhta hai, jaise:
- commits.
- branches.
- tags.
- file trees.

Jab tum staging area se commit karte ho, Git ek new commit object banata hai jo point karta hai staging ke content pe (trees aur blobs jaise), parent commit pe, author details, timestamp, aur message pe. Yeh sab compressed aur hashed form mein store hota hai objects folder mein. Repository local hota hai, isliye full history tumhare machine pe hai, distributed way mein.

Example:

Suppose apne working directory main ek file create ki, fir usko staging area main leke gaye ye dekhne ke liye ki is file ko commit karna hai ya nhi, fir apne us file ko commit kar diya. To commit karne par file ke ander jo bhi data hai vo ek tarah se git ```.git``` folder main store kar leta hai, jiska matlab hai ki file ab git ke thorugh tack hona start ho chuki hai. Agar file ko commit karne ke baad aap usi file main fir se kuch code likhte ho to to us file main naye changes ko track karne ke liye apko fir se us file ko commit karna padega.

Jab bhi aap file main koi na koi chages karoge to apko us file ko baar baar commit karna padega, jisse jitne bhi changes us file main hue hain vo sabhi git track kare.

<br>

**Commit ka kya matlab hota hai?**:

- Commit ka matlab hai ki file main likhe hue content ko git main store kar dena.
- Commit ka matlab hai ki file ka ek version create kar dena.
- Commit ka matlab hai ki file ko ```.git``` folder main store kar dena.
