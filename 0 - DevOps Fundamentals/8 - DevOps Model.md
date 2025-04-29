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

<br>

### DevOps Lifecycle

There are 5 phases in DevOps lifecycle:

- Continuous Development.
- Continuous Integration.
- Contibuous Testing.
- Continuous Deployment.
- Continuous Monitoring.

Development -> Integration -> Testing -> Deployment -> Monitoring.

Continuous means automation. It means when developer commit code into shared repostory then build, test, deploy and monitoring steps run using CI/CD pipeline.

- **Continuous Development**:
  - Continuous Development is the process in which team plan then write the code.
  - Team plan their work in tools like Jira or Azure Boards. Once the plan is clear, developers start writing code.
  - Developers is phase main apne work ko agile tools ke through plan karte hai fir usko code karte hain, lagataar naye naye features, bug fixes, improvements ka code likhte hain.
  - Code likhne ke baad usko version control system (GitHub, GitLab) me dalte hain.
  - Saath hi naye features ka planning bhi hota rehta hai.
    
  - Continuous Development phase ke ander Plan and Develop phase hote hain.
    - Plan:
      - Sabse pehle project ke features aur requirements plan karte hain.
      - Kya banana hai, kya fix karna hai, naye changes kya honge.
      - Agile methodology follow hoti hai — sprint, backlog, user stories.
      - Tools: Jira, Trello, Azure Boards
    - Develop:
      - Developers code likhte hain.
      - Code ko version control system (VCS) me dalte hain — taaki code track ho sake.
      - Tools: Git, GitHub, GitLab, Bitbucket
      - Branching Strategy: master/main, develop, feature branches
     
- **Continuous Integration**:
  - Continuous Integration is the proces in which developer merge their code into central repository and a build pipeline autmatically triggers that build the code and generate the artifacts.
  - Jab bhi koi developer code likh ke central repository main merge karta hai, turant:
    - Code qualiity check hoti.
    - Build banti hai.
    - Build ke baad uske artifact ko store karaya jata hai.
   
  - Continuous Integration can be explained mainly in 4 stages in DevOps. They are as follows:
    - Getting the SourceCode from SCM.
    - Building the code.
    - Code quality review.
    - Storing the build artifacts.
   
  - Code Quality Checks in Continuous Integration:
    - In Continuous Integration (CI), code quality checks typically happen both before and after the build process, depending on the specific checks and the CI pipeline configuration.
    - Many code quality checks happen before the build to catch issues early, like Static Code Analysis (Linting), Security Scanning.
    - Some code quality checks happen after the build to evaluate the compiled software or to perform more complex analyses that require the built artifact. Testing like, Code Coverage Analysis, SonarQube/SonarCloud Analysis, Dynamic Analysis.
   
- **Continuous Testing**:
  - Continuous Testing is the process in which testing of product is done on each stage start from develop goes till deployment.
  - Continuous Testing means automated testing is integrated at every stage of the software delivery pipeline — from development to deployment — so that quality is continuously validated, and feedback is given immediately.
  - Continuous Testing is an essential DevOps practice where automated tests are performed at every step of the development and delivery process — from the time the developer writes the code to the moment it's deployed to production (and even after that).
    
  - So yes — testing is not just a final step. It happens throughout the DevOps lifecycle, including:
    - During development (unit tests).
    - After code is committed (build + integration tests).
    - Before deployment (acceptance, performance, security tests).
    - After deployment (smoke tests, monitoring, alerts).
   
  - The goal is to reduce risk, catch bugs early, and ensure high-quality software is delivered faster.
 
  Continuous Testing in Each DevOps Stage:
  - Development Stage:
    - Tests Involved:
      - Unit Tests – Test individual functions or components.
      - Static Code Analysis – Tools like SonarQube check code quality, security, and maintainability.
    - How it's done:
      - Developer writes code and tests together.
      - On every save or commit, tests run automatically (locally or via pre-commit hooks).
    - Goal: Catch issues before pushing to shared repository.
     
  - Build Stage (CI/CD):
    - Tests Involved:
      - Unit Tests – Re-run after build to verify logic.
      - Build Validation Tests – Does the code compile? Are dependencies correct.
      - Security Scans – Tools like Snyk or SonarQube scan for known vulnerabilities.
    - How it's done:
      - CI server (like Jenkins, GitHub Actions) builds the code and runs tests automatically.
      - Failures stop the pipeline early.
    - Goal: Ensure build is stable and secure.
   
  - Testing/Staging Stage:
    - Tests Involved:
      - System Tests – End-to-end testing across the entire app.
      - UI Tests – Automated frontend testing (e.g., Selenium, Cypress).
      - Performance Tests – Check speed and load capacity.
      - Security Tests – Vulnerability scanning, penetration testing.
      - Regression Tests – Ensure existing features are not broken.
    - How it's done:
      - Test suite is run on a staging environment that mirrors production.
      - Results are auto-reported back to the team.
    - Goal: Validate business logic, user experience, security, and non-functional requirements.
   
  - Deployment Stage (Release):
    - Tests Involved:
      - Smoke Tests – Basic functionality check after deployment.
      - Canary Tests – Deploy to small subset of users and test.
      - Monitoring-based Alerts – Real-time logs and behavior analysis.
    - How it's done:
      - After code goes live, test scripts run to confirm the app is working.
      - Monitoring tools check app behavior (e.g., latency, errors, downtime).
    - Goal: Ensure smooth release without introducing critical issues.
   
  - Post-Deployment Monitoring (Production):
    - Tests Involved:
      - Real User Monitoring (RUM) – How users are experiencing the app.
      - Synthetic Monitoring – Simulated user tests run periodically.
      - Alerting – Auto-notification on performance or functional issues.
    - Goal: Detect live issues quickly and trigger rollback if needed.
   
  Continuous Testing ka Flow:

  | Stage                        | Testing Type                        | Kab hoti hai?                                        |
| ---------------------------- | ----------------------------------- | ---------------------------------------------------- |
| **Code Commit**              | Unit Testing                        | Jab developer code commit karta hai                  |
| **Build Banate waqt**        | Static Code Analysis + Unit Testing | Build banate hi code analysis aur test run hote hain |
| **Post Build**               | Integration Testing, API Testing    | Jab build successful hota hai                        |
| **Pre-Deployment (Staging)** | UI Testing, Performance Testing     | Jab application deploy hone wali hoti hai            |
| **Production ke baad**       | Smoke Testing, Monitoring           | Deploy hone ke turant baad                           |
