# Groups and Projects in GitLab

Gitlab mein Groups aur Projects ek tarah se architecture hai Gitlab ka matlab group aur project ye batate hain ki git mein apne code ko kaise store karna hai.

Jaise GitHub mein hum organization ke ander ek repository create karte the, jiske ander code rakhte the, Lekin Gitlab mein thoda alaga hai.

GitLab mein pehle hum ek group create karte hain fir us group ke ander hum project banate hain fir us project ke ander humara code hota hai.

Jaise github mein repository hota hai jaha code store hota hai waise hi gitlab mein hum repository ko project kehte hain. 

<br>
<br>

### Sabse Pehle: Big Picture Samjho

GitLab aur GitHub — dono mein ek basic hierarchy hoti hai:

**GitLab**:
```
Group  →  Subgroup (optional)  →  Project → Code
```

**GitHub**:
```
Organization  →  Repository → Code
```

Yani:
- GitLab = zyada layered structure.
- GitHub = comparatively simple structure

Jaise GitHub mein code ko host karne ke liye humko ek repository create karni hai hai, Vaise hi GitLab mein code ko host karne ke liye group create karna hota hai, fir group ke ander project create karna hota hai fir project ke ander code ko store karna hota hai.

GitLab mein repository ka naam project kar diya hai.

GitHub mein repository bolte hain aur GitLab mein usko Project bolte hain.

Aur yeh difference hi GitLab ko enterprises aur DevOps teams ke liye powerful banata hai.

<br>
<br>

### GitLab Groups — Kya Hote Hain?

GitLab Group = Ek folder jaisa logical container jisme tum multiple projects aur sub-groups ko organize kar sakte ho.

Isko ese samjho jaise Azure mein resources ko organize karne ke liye Reource Group banate hain vaise hi GitLab mein repositories yaani Projects ko organize karne ke liye Group banate hain.

Example:
```
Root Group
   ├── Subgroup
   │     ├── Subgroup
   │     │     └── Project
   └── Project
```

Ek group = Folder.

Ek Project = Repository.

<br>

**Group kya provide karta hai?**
- ✔ Central permissions
- ✔ Shared CI settings
- ✔ Shared variables
- ✔ Issue boards
- ✔ Members management
- ✔ Billing
- ✔ Analytics
- ✔ Integration controls

<br>
<br>

### GitLab Project — Kya Hai?

Project = jahan code hota hai (same like GitHub repo).

But GitLab Project ke paas extra cheezein hoti hain:
- ✔ Repository
- ✔ CI/CD
- ✔ Issue tracker
- ✔ Merge Requests
- ✔ Wiki
- ✔ Security scan
- ✔ Registry
- ✔ Releases
- ✔ Boards
- ✔ Environments
- ✔ Analytics

<br>
<br>

### Inheritance & Permissions

GitLab Groups — PERMISSION FLOW

Permissions auto cascade:
```
Group → Subgroup → Project
```

Example:

Tum group me user ko Developer role dete ho → Woh automatically sab subgroups/projects me Developer hota hai.
