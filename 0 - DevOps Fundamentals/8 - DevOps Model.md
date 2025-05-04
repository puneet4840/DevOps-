# DevOps

DevOps is the combination of two words: Development and Operations.

DevOps is the software development approach in which Development and Operations teams work together and deliver high quality software.

## History of DevOps

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

### Agile Ne Problem Kya Solve Ki?

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

### Rise of DevOps

Phir ek din Ek conference hoti hai 2009 mein. Us conference main **Patrick Debois** ne kaha:

```“Agar hum Development aur Operations ki team ko ek hi team bana dein? Dono ek dusre ke tools seekhein, ek dusre ke processes samjhein, automation karein, aur milke product deliver karein?”```

Sab sochne lagte hain, “Yeh toh accha idea hai!” Aur yahin se janm hota hai DevOps ka. Dev + Ops = **DevOps**

Agile ne development culture badla. DevOps ne deployment aur operations culture badla.

**DevOps ne kaha**:
- Development aur Operations ek team banegi.
- Har kaam automate hoga — build se leke deployment tak.
- Har code commit pe automatic testing, build, deployment hoga.
- Monitoring aur feedback bhi automated hoga.
- Sab log ek hi goal pe kaam karenge — reliable aur fast product delivery.

Yani Agile ne feature banana fast kiya. DevOps ne feature ko safe, fast aur reliable tarike se client tak pohchana fast kiya.

<br>
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

<br>

**Kaun karta tha?**

- Dedicated Operations Engineers.
- Kabhi kabhi Senior Developers (agar chhoti company hoti).
- Kabhi kabhi manually testing wale bhi server pe login karke testing karte the.

Aur har deployment pe tension hoti:
- Downtime hoga.
- Agar raat 2 baje kuch fail hua to kaun uthega?.
- Database corrupt ho gaya to?

**Agile Mein Deployment Phase tha na?**

<br>

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

<br>

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

**Ab DevOps Phases Ko Agile Se Relate Karte Hain**

| 📌 DevOps Phase | 🔄 Continuous Process                             | 📖 Kaise Juda Hai                                                                                                                                                                   |
| --------------- | ------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Plan**        | Continuous Development                            | Yahan se continuous development start hota hai. Ham naye features, improvements aur bug fixes plan karte hain. Agile sprints bhi yahin decide hote hain.                            |
| **Develop**     | Continuous Development                            | Developer lagatar code likhte hain. Har naye code ko Git pe commit karke version control me daalte hain. Continuous process hai kyunki ye lagatar hota rehta hai.                   |
| **Build**       | Continuous Integration                            | Jab bhi koi code commit hota hai, automated build process start hota hai. Jenkins ya CI tool build banata hai. Har naye code ke sath ye automatically hota hai — isliye continuous. |
| **Test**        | Continuous Testing                                | Build ke baad turant automated testing hoti hai. Unit test, integration test, functional test sab automate kiye hote hain. Har build pe test chalega — lagatar.                     |
| **Release**     | Continuous Deployment (part of CD)                | Test pass hone ke baad build ko release karne ke liye ready karte hain. Approvals aur versioning handle hoti hai. Release candidate banate hain.                                    |
| **Deploy**      | Continuous Deployment                             | Release ke baad turant automated deployment hota hai. Production ya staging environment me bina rukawat ke deploy hota hai. Har naye code ke liye ye process auto chalta hai.       |
| **Operate**     | Continuous Operations (ye bhi DevOps ka part hai) | Live application ko chalana, scaling, load balancing, server health ka dhyan rakhna. Lagatar chalta rahta hai.                                                                      |
| **Monitor**     | Continuous Monitoring                             | Live system ka health, errors, logs, performance ka real-time monitoring hota hai. Alerts aate hain, dashboard bana hota hai. Ye lagatar 24x7 chalta hai.                           |

<br>
<br>

## DevOps Lifecycle

There are 5 phases in DevOps lifecycle:

- Continuous Development.
- Continuous Integration.
- Contibuous Testing.
- Continuous Deployment.
- Continuous Monitoring.

Development -> Integration -> Testing -> Deployment -> Monitoring.

<br>

<img src="https://drive.google.com/uc?export=view&id=1zsS3XuUzIAVyqgPkkS3sqSsi0YfSQ3KB" height=250 weight=250>

<br>

**What is Continous here?**
Continuous means automation. It means when developer commit code into shared repostory then build, test, deploy and monitoring steps run using CI/CD pipeline.

"Continuous" means that something happens automatically, again and again, without needing people to start it manually.

In DevOps, "Continuous" refers to automated, repeatable workflows that run frequently (on every code change or event) and provide fast feedback.

<br>

### Continuous Development:
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

<br>
     
### Continuous Integration:
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

<br>
   
### Continuous Testing:
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

  Aap jo bata rahe ho:

  - Code build hota hai → QA environment mein deploy hota hai → wahan testing hoti hai.
  - Pipeline ke andar (jaise code commit ke baad ya build ke dauraan) koi testing nahi hai.
    
  - Yeh normal traditional flow hai jisme testing sirf baad mein hoti hai (post-integration ya post-deployment to QA).
  - Matlab aapke pipeline mein Continuous Testing poore flow mein nahi hai, balki sirf ek centralized testing stage hai — jab QA mein deploy hota hai.
  - Aapka jo model hai wo zyada tar old Dev/Test/QA model jaisa hai, jo DevOps ke pure Continuous Testing approach se thoda alag hai.
 
  Problems is Tarah ke Model mein:

  - Developer jab build karta hai to immediate feedback nahi milta.
  - Bugs QA tak jaane ke baad hi milte hain — matlab late defect discovery.
  - Agar QA mein koi badi problem mile to pura cycle wapas repeat hota hai (rebuild, redeploy).
  - Isme nuksan: Zyada time lagta hai bugs fix karne mein aur delay hota hai delivery mein.
 
  Agar Continuous Testing lana ho to kya hona chahiye?

  Agar aap apne project mein Continuous Testing implement karna chahein to ideal pipeline aisi dikhegi:

  | Stage        | Testing                          | Tool Examples        |
  | ------------ | -------------------------------- | -------------------- |
  | Code Commit  | Unit Testing                     | JUnit, pytest        |
  | Build        | Static Code Analysis             | SonarQube            |
  | Post Build   | Integration Testing, API Testing | Postman, RestAssured |
  | Deploy to QA | UI Testing, Performance Testing  | Selenium, JMeter     |

  - Har stage par kuch automated tests lage rahenge.
  - Developer ko jaldi pata chalega ki code tod gaya hai ya nahi.

<br>

### Continuous Deployment:
  - Continuous Deployment is the process of automatically deploying an application into production environment when it has completed testing and the build stages.
  - Jab build test me pass ho jata hai, to turant usko automatically:
    - Staging pe Ya production environment me Deploy kar dete hain.
  - In traditional systems, deployment was done manually by Operations teams, which was slow and risky. But in DevOps, deployment is automated.

  Difference b/w Continuous Delivery and Continuous Deployment:

  - Continuous Delivery: Coninuous Delivery is the process of deploying an application to production server manually. Here manually the build artifacts are deployed to production. Manually means approval before deployment is required. After the approval we click on deploy.
  - Continuous Deployment: Continuous Deployment is the process of deploying an application on production automatically. Here no approval or manual intervention is required.

  In real life scenarios, there are multiple environments such as Dev, QA, UAT and Prod. So seperate pipelines are created there for deployment.

  | Environment | Kya hota hai ye?                                     |
  | ----------- | ---------------------------------------------------- |
  | **Dev**     | Developers yaha naya code test karte hain            |
  | **QA**      | QA team yaha pe testing karti hai (automated/manual) |
  | **UAT**     | Business ya client yaha final check karte hain       |
  | **Prod**    | Live system — jo users use karte hain                |

<br>

### Continuous Monitoring:
- Continuous Monitoring is the process of monitoring the deployed application. After deployment, it’s important to keep an eye on the system’s health.
- Continuous Monitoring involves tracking application performance, infrastructure health, security, and user experience in real time. It provides constant feedback to detect problems and improve future releases.

- Continuous Monitoring means keeping a constant watch on:
  - Your application (Is it working? Is it fast?).
  - Your infrastructure (Are servers healthy? Is memory full?).
  - Your pipelines (Did the deployment break anything?).

**Why Do We Need It?**

In DevOps, we deploy code many times a day. So we can’t rely on users to tell us something is broken.

We need:
- Live data about system health.
- Alerts when something goes wrong.
- Dashboards for visibility.
- Logs and traces for root cause analysis

**What Do We Monitor?**

| Type               | What You Track                               | Example Metrics                         |
| ------------------ | -------------------------------------------- | --------------------------------------- |
| **Application**    | Is the app fast? Any errors? How many users? | Response time, error rate, requests/sec |
| **Infrastructure** | Is the server or container healthy?          | CPU, memory, disk usage, node health    |
| **Logs**           | Any error stack traces? Unexpected behavior? | HTTP 500 errors, Java exceptions        |
| **Network**        | Any packet loss or DNS issues?               | Latency, traffic, dropped connections   |
| **Pipeline**       | Did the build or deploy fail? How often?     | Failed builds, test failures            |
| **Security**       | Who logged in? Was anything unusual?         | Suspicious IPs, audit logs              |

**How It Works (Step-by-Step)**

Let’s say you have a web app deployed in a Kubernetes cluster. Here's how monitoring works behind the scenes:

- Telemetry Agents Collect Data:
  - Agents run on servers, containers, or apps.
  - They collect metrics, logs, and traces.

  Examples:
  - Prometheus scrapes app metrics (/metrics endpoint)
  - Fluentd or Filebeat collects logs.
  - OpenTelemetry collects traces.
 
- Data is Sent to Monitoring Tools:
  - All this raw data is sent to a monitoring platform like:
  - Prometheus (metrics).
  - ELK stack (logs).
  - Jaeger (traces).
  - Datadog / New Relic (all-in-one).
 
- Dashboards Show You the Current Status:
  - You create dashboards in Grafana, Kibana, or Datadog UI.
  - These show:
    - CPU usage.
    - Active users.
    - Errors over time.
    - Slow APIs
   
- Alerts Are Triggered on Thresholds:

  If something bad happens — say:
    - Error rate > 5%.
    - CPU > 90% for 5 minutes.
    - Login from unknown IP.
 
  Then an alert is triggered.

  It can notify you via:
  - Slack.
  - Email.
  - PagerDuty.
  - Microsoft Teams.
 
- You Investigate with Logs/Traces:

  After an alert, you jump into:
  - Logs (via Kibana, Loki).
  - Traces (via Jaeger).
  - K8s monitoring (via Lens, Grafana).

  This helps you understand why something broke.

<br>
<br>

## CI/CD Pipeline

CI/CD = Continuous Integration and Continuous Deployment

CI/CD pipeline is the automated process to build, test and deploy the application server.

CI/CD stands for Continuous Integration and Continuous Delivery/Deployment. It is a DevOps practice that automates the processes of building, testing, and deploying applications to ensure faster, reliable, and more frequent software releases.

CI/CD pipeline ek automated process hai jo software ko build karne, test karne, aur deploy karne ka kaam karti hai — bina manual intervention ke ya kam se kam manual kaam ke sath.

- CI = Continuous Integration
- CD = Continuous Deployment (ya Continuous Delivery)

Dono ko mila ke ek pipeline banate hain.

### CI/CD history

Bahut pehle, ek zamane me software banana manual kaam hota tha.
- Developer apni machine pe code likhta.
- Fir wo code kisi folder me daal ke email kar deta ya pen drive me le jata.
- Deploy karne wala banda manually production server pe le jaake deploy karta.

Problem kya hoti thi?
- Code merge karna mushkil.
- Ek code change dusre ka kaam bigaad deta.
- Deployment me ghanto lagte the.
- Kabhi server down, kabhi dependency missing.
- Bugs live me detect hote.
- Aur fir hoti thi midnight production fix.

Fir developers ne socha —

"Code alag alag kyu likh rahe hain? Sab milke ek repository me daalte hain." Fir Aayi Git / SVN / CVS jisme developers code push karte

Lekin problem ab bhi thi:
- Code push karne ke baad manual build hota tha.
- Test manually chalte the.
- Bug tab milta jab client chillata.

To yaha enter kiya — Continuous Integration (CI):
- "Jab bhi koi developer code kare, turant system usko build aur test kare".

Tools aaye: Jenkins, Bamboo, TeamCity

Ab code push hota:
- Jenkins automatically build karta.
- Unit tests run karta.
- Developer ko mail deta — "bhai tera build pass ho gaya" ya "fail"

Isse fayda hua:
- Code conflicts kam.
- Early bugs milna start.

Par deployment ab bhi manual tha.

Fir industry me ek nayi demand aayi:
- "Har naye feature ko jaldi production tak le jao".

Manual deployment me problem:
- Kaunsa version deploy hua, pata nahi.
- Dependency issues.
- Human error.

CI ke baad automatically build ko Dev, QA, UAT, Prod me deploy karne ka system banaya gaya. 

Deploy hone ke baad health check bhi automatic

Ab:
- Code push hua.
- Build & test automatic.
- Deployment automatic.
- Monitoring automatic.
- Error aaya to automatic rollback

Is pure process ko bola gaya — CI/CD Pipeline.

<br>

### Explanation of Continuous Integration and Continuous Deployment

**CONTINUOUS INTEGRATION (CI)**:

CI is the process where developers merge their code changes (commits) frequently (at least daily) into a shared source code repository (like GitHub). After every merge, an automated process builds the app and runs tests to make sure everything still works.

**How It Works (Step-by-Step)**:
- Developer writes code on a branch (e.g., feature/add-login).
- Developer pushes code to GitHub.
- A CI tool (like Azure DevOps, Jenkins or GitHub Actions) detects the push via a webhook.
- The CI pipeline starts:
  - Pulls the code from Git.
  - Installs dependencies (npm install, pip install, Maven install, etc.).
  - Builds the code (e.g., compiles Java or bundles React).
  - Runs tests (unit tests, linting, etc.).
  - Store the build artifacts in storage or pipeline.

**Continuous Deployment (CD)**:

CD is the process in which build code or build artifacts automatically deployed on the production environment. But in case of Continuous delivery code is deployed on the production with manual approval.
