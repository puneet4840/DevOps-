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


