# Introduction to GitLab

<br>

### GitLab kya hai?

GitLab ek web-based DevOps platform hai, jisme tum:
- Code store kar sakte ho (git repositories ko store kar sakta hai).
- Team ke saath collaborate kar sakte ho.
- Code review kar sakte ho.
- CI/CD pipelines bana sakte ho.
- Deployment automate kar sakte ho.
- Security scan kara sakte ho.
- Project track kar sakte ho.

Matlab GitLab ek esa platform hai jaha pe code store se leke deployment tak sab ho jata hai.

Matlab:

“**Code likho** → **test karo** → **build karo** → **deploy karo** → **monitor karo**”

Sab ek hi jagah — **GitLab**.

<br>
<br>

### Sabse Pehle — Git Samajh Lo

Git ek distributed version control system hai, jo ki software development de dauran code main hue changes ko track karta hai. Git ek distributed version control system (DVCS) hai. Iska matlab hai ki yeh aisa tool hai jo tumhare code ka history (jaise code main konsi line code kya code change hua hai) track karta.

Git kya karta hai?
- Tum local system par code likhte ho.
- Git us code ko track karta hai, code ke alag-alag versions create karta hai har code commit par, iska matlab hai code ka ek snapshop git apne paas store kar leta hai.
- Tum history dekh sakte ho ki konsa code kab likha gya aur kisne likha.
- Changes compare kar sakte ho.
- Mistake ho jaaye to rollback kar sakte ho.

Jaise:
- v1: login page.
- v2: login with OTP.
- v3: UI improved.

Sab record hota hai.

Ab yahi aata hai **GitLab**, tumne local system par code ko to track kar liya lekin team ke saath code share karne ke liye tum GitLab par code ko host karte ho git repository ke ander. Ye to normal feature hai GitLab ka lekin iske baad tum CI/CD pipeline banakar code ko deploy kar sakte ho, security scan kar sakte ho, matlab ek dum complete setup milta hai tumko devops ki lifecycle follow karne ka.

Isliye GitLab ek DevOps tool hai.


<br>
<br>

### Market mein GiHub the to GitLab ki kya jarurat hui

<br>

**Sabse Pehle Samjho — Market Situation Pehle Kaisi Thi?**

Pehle kya hota tha?

Developers ke paas GitHub hota tha:
- Code store karne ke liye.
- PR banane ke liye.
- Open-source projects ke liye.

CI/CD ke liye alag tools lagte the, Jaise:
- Jenkins.
- CircleCI.
- Travis CI.
- Bamboo.

Project management ke liye alag tools:
- Jira.
- Trello.
- Confluence.

Security ke liye alag tools:
- SonarQube.
- WhiteSource.

Matlab:
- Code GitHub par → Build Jenkins par → Tickets Jira par → Wiki Confluence par → Docs Google Drive par.

Sab alag alag jagah

Ye company ke liye:
- Time waste.
- Complex architecture.
- Multiple licenses.
- Security risk
- Tool sprawl.

<br>

**Aur Yahin Par GitLab Enter Hua**

GitLab ne bola:
- “Main tumhari saari DevOps lifecycle ek hi jagah par de deta hoon”.

Yani:
- Code repo.
- CI/CD.
- Security scanning.
- Project management.
- Wiki.
- Container registry.
- Monitoring
- DevSecOps pipeline.

Sab ek platform par, single tool, single dashboard, single workflow. Ye hi sabse bada difference hai.

<br>

**Core Difference — “All-in-One DevOps Platform”**:

GitHub kya tha originally?

👉 Mainly code hosting platform.

Bitbucket kya tha?

👉 Jira ecosystem ka part
(Atlassian suit ka integration).

GitLab kya bana?

👉 Complete DevOps Operating System.


<br>

**GitLab Ka Biggest Differentiator — Built-in CI/CD**:

Pehle CI/CD banane ke liye:
- Jenkins install karo.
- Plugins add karo.
- Slave nodes configure karo.
- Jobs design karo.
- Maintenance karo.

GitLab ne kya kiya?

Bas ek file banao:
```
.gitlab-ci.yml
```

Aur ho gaya CI/CD ready, Zero extra setup.

<br>

**Cost Advantage — Especially Enterprises ke liye**:

Companies ko pasand kyu aaya?

Because:

Multiple Tooling Cost:
- Jira license.
- GitHub enterprise.
- Jenkins admins.
- SonarQube.
- Artifactory.

vs

GitLab:
- Single enterprise subscription.

