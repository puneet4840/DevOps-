# Project-1: Simple Node CI Pipeline in GitLab

Is project mein hum Node ka end-to-end project dekhenge. Jisme ek CI pipeline create karenge.


Target ye hoga:
- Ek simple Node.js app banayenge.
- uske liye GitLab CI/CD pipeline likhenge.
- jisme Build + Test + Artifact generate hoga.

Runner ke liye hum Shared Runner use karenge (jo already GitLab server pe hota hai).

<br>
<br>

### Step-1: GitLab me Naya Project banao

- GitLab login karo.
- Click: New Project
- Select:
  - Create blank project.
- Project Name do:
```
sample-node-cicd-project
```

- Visibility:
  - Private ya Public — koi bhi chalega.
- Create project.

Done.

<br>

### Step-2: Repository me Code add karein

Ab hum ek simple Node.js project banayenge.

Apne local system mein ek folder banao ```sample-node-ci-project```.

- Create new file:
```
package.json
```
- Content paste karo:
```
{
    "name":"sample-ci",
    "version": "1.0.0",
    "scripts": {
        "test": "echo 'All test passed' && exit 0"
    },
    "dependencies": {
        "express": "^4.18.2"
    }
}
```

Ye ```package.json``` file tumhare node project ki metadata file hoti hai jiske ander project ki information hoti hai.

- Ab ek aur file banao.
```
app.js
```
- Content paste karo:
```
console.log("Hello from GitLab CI Project!");
```

<br>

**Abhi tak humne kya kiya?**:
- Project banana.
- Code add kiya.
- Ye ek chota node.js app hai.

<br>
<br>

### Step-3: ```.gitlab-ci.yml``` file banao

Ab local system mein ```.gitlab-ci.yml``` file banao. Ye hi CI pipeline hai.

Aur yeh content daalo:
```
stages:
  - build
  - test
  - package

build_job:
  stage: build
  image: node:18
  script:
    - echo "Installing dependencies..."
    - npm install
  artifacts:
    paths:
      - node_modules/
    expire_in: 1 week

test_job:
  stage: test
  image: node:18
  script:
    - echo "Running tests..."
    - npm test
  dependencies:
    - build_job

package_job:
  stage: package
  image: node:18
  script:
    - echo "Packaging application..."
    - mkdir output
    - cp app.js output/
  artifacts:
    paths:
      - output/
    expire_in: 1 week
```

<br>
<br>

### Step-4: Code ko GitLab par push kardo

Ab tum code ko GitLab par push kardo.

Pehle git remote add karo SSH ke though. Maine alag se SSH add karne ka bataya hua hai wha se add karlo.

Command:
```
git status
git branch main
git checkout main
git add .
git commit -m "your message"
git remote add origin git@gitlab.com:gitlab-learning3255052/sample-node-cicd-project.git
git push origin main
```

<br>
<br>

### Step-5: Pipeline Automatically Start Ho Jayegi

Jaise hi code local se GitLab par push hoga to turant pipeline start ho jayegi.

Check karne ke liye:
- Left menu → CI/CD.
- Click: Pipelines.
- Tum dekho ge ek pipeline run ho rahi hai.

Stages:
```
build → test → package
```

<br>
<br>

## Ab hum complete end-to-end samjhte hain.

<br>

### Sabse Pehle — Big Picture

GitLab CI pipeline ka kaam hota hai:
- job define karna.
- har job me commands run karwana.
- environment provide karna.
- output collect karna.

Runner sirf ek machine hoti hai.

But wo machine kis environment me job chalaye?
- Node installed ho?
- Java installed ho?
- Python installed ho?

Har job ko alag requirement hoti hai.

Isi ke liye use hota hai: ```image```.

<br>

### ```image```: — Yeh kya hota hai?

Runner machine kuch bhi ho sakti hai:
- Linux.
- macOS.
- VM.
- Cloud Server.

But container ke andar:
- ✔ same OS.
- ✔ same tools.
- ✔ same version.
- ✔ isolated environment.

Yeh hota hai Docker Executor.

Docker image = pre-built environment

Jaise:
| Image          | Matlab                |
| -------------- | --------------------- |
| node:18        | Node.js v18 installed |
| python:3.11    | Python 3.11 ready     |
| ubuntu:latest  | Basic Linux           |
| maven:3-jdk-11 | Maven + JDK           |

Matlab runner bolega:
- “Mujhe ek fresh container do jisme Node.js installed ho.”

Phir job ke commands us container ke andar run hote hain.

Matlab ```image``` ka matlab hai ki runner mein docker container mein ek container create hota hai aur fir us container ke ander script ke ander likhe sabhi command run hote hain.

**Agar ```image:``` na hota toh?**

Toh runner host machine ka environment use karta.

Problem:
- ❌ Node shayad installed na ho.
- ❌ Version mismatch.
- ❌ Conflicts ho sakte.
- ❌ Shared runner par security risk.



Isliye:
- Har job ka clean environment hota hai.
- predictable hota hai.
- same version always.
- secure hota hai.

<br>

### Ab chalo YAML ko line-by-line samjhte hain

**```stages```: — Pipeline ka flow define karta hai**:
```
stages:
  - build
  - test
  - package
```

Matlab:
- phle build chalega.
- phir test.
- phir package.

order firxed hai.

Job automatically apne stage ke hisaab se run hota hai.

```build_job``` — **Pehla job**:
```
build_job:
  stage: build
```

Matlab:
- ye job ```build``` stage me run hoga.

```image: node:18```:
```
image: node:18
```

Matlab:
- ek Docker container launch hoga.
- jisme Node.js v18 already installed hoga.

Tumhare commands usi container ke andar chalenge.

Jaise:
```
npm install
```
directly chalega — bina setup kiye.

```script```: — **commands jo run hongi**:
```
script:
  - echo "Installing dependencies..."
  - npm install
```

Yeh waise hi hai jaise pehle tum use karte the. Har command ko shell mein run karte the.

Runner yahan kya karega:
- Pehle runner container start karega.
- Fir container mein aapke saare code ko ek specific directory mein "clone" (copy) karta hai. Is directory ko Working Directory kehte hain.
- Fir container ke ander commands ko run karta hai.
- Apko logs show kar deta hai.

```artifacts```: — **output store karna**:
```
artifacts:
  paths:
    - node_modules/
  expire_in: 1 week
```

Matlab:
- Working directory mein ```node_module``` naam ka folder hoga, usko gitlab server par gitlab upload kar dega aur uske hum gitlab portal par artifacts mein jake download kar sakte hain.

Taaki next stage use kar sake.

```test_job``` — **Doosra job**:
```
test_job:
  stage: test
  image: node:18
  script:
    - echo "Running tests..."
    - npm test
  dependencies:
    - build_job
```

Phir se image: node:18

Kyuki test ke liye bhi Node chahiye.

Har job ke liye naya fresh container banta hai. Matlab build ke environment se koi pollution nahi.

```
dependencies:
  - build_job
```

Iska matlab hai ki sirf ```build_job``` ke artifacts hi is job ke paas aaye. Baaki uper se kisi aur job ka artifact nhi chaiye.

```package_job``` — **Final Job**:
```
package_job:
  stage: package
  image: node:18
  script:
    - echo "Packaging application..."
    - mkdir output
    - cp app.js output/
  artifacts:
    paths:
      - output/
    expire_in: 1 week
```

Yeh karta kya hai?
- ek folder banata hai output ke naam se.
- app.js file ko output folder ke ander daal deta hai. Iska matlab ye hai ki tumhari gitlab repository jisko project bolte hain uski files ko container ke ander clone kar deta hai. Fir wha se output mein copy kar rha hai.
- Fir artifact banake gitlab artifact mein output folder ko upload kar deta hai fir hum usko portal se download kar sakte hain.

Tum GitLab UI se download kar sakte ho.

