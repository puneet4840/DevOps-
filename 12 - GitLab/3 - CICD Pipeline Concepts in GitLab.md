# CI/CD pipeline concepts in GitLab

<br>

### Pehle Problem Samjho (Automation Kyu?)

Software development lifecycle mein daily yeh hota hai:
- Developer code likhta hai.
- Code commit/push karta hai.
- Test chalane chahiye.
- Build banana chahiye.
- Security check hona chahiye.
- Deploy hona chahiye.
- Logs/Reports generate hone chahiye.

Agar yeh sab manual karoge:
- ❌ slow.
- ❌ error-prone.
- ❌ repeat work.
- ❌ dependency issues.
- ❌ delay.

Isliye industry ne concept banaya:

**CI/CD**
- **CI = Continuous Integration**.
- **CD = Continuous Delivery / Deployment**.

Aur GitLab bola:
- “Main pura CI/CD automation handle karunga.”

Yani tum sirf code push karo baaki sab pipeline sambhalegi.

Iska matlab hai ki GitLab CI/CD pipeline banane ki feature deta hai. Aur hum ab ye hi samjhenge ki GitLab mein CI/CD pipeline kaise banate hain aur manage karte hain.

<br>
<br>

### GitLab Pipeline Ki Foundation (GitLab mein CI/CD pipeline kaise banate hain)

GitLab mein CI/CD pipeline banae ke liye humko ek ```.gitlab-ci.yml``` file project yani repository mein create karni hoti hai.

Jaise hi ye file create hoti hai tumhare project mein automatically pipeline ke options enable ho jate hain.

<br>

Pipeline ka control center ek file hoti hai:
```
.gitlab-ci.yml
```

- Ye file YAML format mein hoti hai.
- Project ke root folder me hoti hai.
- Isi file me tum likhte ho:
  - kya karna hai.
  - kab karna hai.
  - kaise karna hai.

matlab stages aur jobs likhte ho.

Jab tum code push karte ho ya code commit karte ho:

GitLab check karta hai:

👉 repo me ```.gitlab-ci.yml``` file hai?

- Agar hai → pipeline automatically run ho jayegi.
- Agar nahi → koi pipeline nahi run hogi.

Yahi se sab start hota hai.

<br>
<br>

### Pipeline Ka Basic Structure

GitLab pipeline ke andar:
- Stages.
- Jobs.
- Runners.

hote hain aur sab milke kaam karte hain.

Hierarchy samjho:
```
Pipeline
   ├── Stages
   │     ├── Jobs
   │     └── Jobs
   └── Stages
         ├── Jobs
```

Ek simple example:

```.gitlab-ci.yml```:
```
stages:
  - build
  - test
  - deploy

build_job:
  stage: build
  script:
    - echo "Building the app"

test_job:
  stage: test
  script:
    - echo "Running tests"

deploy_job:
  stage: deploy
  script:
    - echo "Deploying app"
```

<br>

**Create a simple pipeline**:

Apne project ke root folder mein ek ```.gitlab-ci.yml``` file create karo.

Example:
```
my_project
|- app.py
|- .gitlab-ci.yml
```

<img src="https://drive.google.com/uc?export=view&id=1QqPntxivEQ-fuYxf5ellY9GppXWzHPaf" width="650" height="820">

<br>

```.gitlab-ci.yaml```
```
stages:
- build
- test
- deploy

build_app:
  stage: build
  script:
    - echo "Building app..."

run_tests:
  stage: test
  script:
    - echo "Running tests..."

deploy_app:
  stage: deploy
  script:
    - echo "Deploying app..."
```

Explanation:

Stages: Is block ko hum stages bolte hain.
```
stages:
- build
- test
- deploy
```

Jobs: Is block ko hum job bolte hain.
```
build_app:
  stage: build
  script:
    - echo "Building app..."
```

**Note**:
- GitLab CI pipeline mein sabse pehle humko stages define karni hoti hain matlab jo jo stages humko pipeline mein banani hain vo pehle hi likhi hongi jaise uper hum stages block likha hua hai, jiske ander 3 stages jaise build, test, deploy likhi hua hain.
- Fir ek-ek karke in stages mein job define karni hai, Jaise:
  - ```build_app``` ye ek job hai iska naam hum kuch bhi de sakte hain, fir is job ke ander humko same stage provide karni hoti hai jo hum stages mein likhi hui hai, jaise ```build_app``` job mein humne ```stage: build``` likhi hai ese, iska naam bhi same hona chaiye, nhi to error aayega.
  - Fir job mein vo actions ya steps likh denge jo humko perform karvane hain.
 
Ye hi GitLab CI pipeline ka basic structure hota hai.

<br>
<br>

### Stages kya hota hai?

Stage pipeline ka ek logical phase hota hai. 

Example:
- Build stage.
- Test stage.
- Scan stage.
- Deploy stage.

GitLab pipeline mein yeh sequence me chalte hain. Ek stage complete hota hai → tab next start hota hai.

<br>

**GitLab me stage kaise define karte hain?**:

```.gitlab-ci.yml``` YAML file me:
```
stages:
  - build
  - test
  - deploy
```

Iska matlab:
- pehle build phase run hoga.
- phir test phase.
- phir deploy phase.

Order fix hota hai matlab ek ke baad ek run hote hain.

Flow:
```
build → test → deploy
```

Agar test stage fail ho gayi to deploy stage kabhi start hi nahi hoga.

<br>

**Important Fact**:
- Ek stage ke andar multiple jobs parallel chal sakti hain.

Lekin 

Stages sequential chalte hain.

<br>
<br>

### JOBS kya hoti hain

Job wo task hai jo actual actions perform karta hai.

Har job ek kaam karta hai, Jaise:
- docker build karo.
- code scan karo.
- deploy server par karo.
- package create karo.

<br>

**Job define kaise karte hain?**:
```
job_name:
  stage: stage_name
  script:
    - command1
    - command2
```

Example:

Two test jobs:
```
unit_tests:
  stage: test
  script:
    - echo "Running unit tests"

integration_tests:
  stage: test
  script:
    - echo "Running integration tests"
```

In dono mein stage same hai, iske matlab:
- Ye jobs parallel chalenge.

Aur jab dono complete ho jayein tabhi next stage start hoga.

<br>
<br>

### RUNNERS kya hote hain

**GitLab Runner**:

GitLab Runner basically ek machine hoti hai jo tumhari pipeline ko run kari hai aur job execute karti hai.
- Linux / Windows / Mac.
- Docker based.
- Kubernetes based.

<br>

**Types of Runners in GitLab**:
 
 Gitlab mein 4 type ke runners hote hain:
 - Shared Runner.
   - GitLab ke common runners.
     
 - Project Runner.
   - Jo sirf ek project use kare.
  
 - Group Runner.
   - ek group ke sab projects use kare.
     
 - Self-Hosted Runner.
   - Tumhari khud ki machine/server jo pipeline ko run kare.
  
