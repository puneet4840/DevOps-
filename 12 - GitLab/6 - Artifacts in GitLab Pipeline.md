# Artifacts in GitLab Pipeline

<br>

### Artifacts kya hote hain?

Pipeline se generate hui output files ko artifacts bolte hain.

<br>

Soch lo tum ek CI/CD pipeline chala rahe ho.
- Tumne code build kiya.
- Kuch output files bani (jaise .jar, .zip, test reports, logs, screenshots, YAML, JSON, HTML, etc.).
- Pipeline ke next stages ko in files ki zarurat hai.

ya

- Tum manually download karke verify karna chahte ho.

Bas ye jo files pipeline run ke baad store hoti hain, unhe **GitLab mein Artifacts** bola jaata hai.

Simply bolu toh:
- Artifacts = Pipeline se generate hui output files jo GitLab temporarily store karta hai.

<br>
<br>

### Artifacts Kaha Use Hote Hain?

Artifacts mainly use hote hain:

**1 - Build Output Store Karne Ke Liye**:

Jaise:
- build/ folder.
- compiled code.
- docker image tar files.

**2 - Testing Reports Store Karne Ke Liye**:

Jaise:
- JUnit reports.
- coverage reports.
- screenshots.

**3 - Logs Store Karne Ke Liye**:

Jaise:
- debug logs.
- error logs.

**4 - Next Stage Ko Data Dene Ke Liye**:

Jaise:
- Build stage output → Deploy stage ko chahiye.


<br>
<br>

### Real-world Simple Example

Man lo pipeline mein 3 stages hain:
```
build → test → deploy
```

Build stage ek file banata hai:
```
app.jar
```

Test stage ko isi jar file ko chala ke test karna hai.

Deploy stage bhi isi jar ko deploy karega.

Agar artifacts na ho, toh build stage ke baad file kahaan gayi? 🤷‍♂️ LOST!

Isiliye artifacts use hote hain.

<br>
<br>

### Basic Syntax of Artifact in GitLab

Artifact banane ka basic syntax:
```

job_name:
  artifacts:
    name: <string>
    paths:
      - <file_or_directory_path>
    exclude:
      - <glob_pattern>
    when: <on_success | on_failure | always>
    expire_in: <duration>
```

Explanation:
- ```job_name```: Ye job ka naam hota hai, jo job artifact generate karti hai.
- ```artifact```: Ye artifact block hota hai, jaha artifact shuru hota hai.
- ```name: <string>```: Ye artifact ka naam hota hai, matlab kis naam se artifact available rahega.
- ```paths:```: Ye artifact ka path hota hai, yaha pe wo path dena hai jaha pe tum artifact ko store karna chate ho aur gitlab server pe upload karna chte ho.
- ```exclude```: Jo jo chiz artifact mein se nikal deni hai, matlab rakhni nhi hai artifact ke ander, vo yaha ayega.paths me included cheezon me se kuch ko remove karne ke liye.
- ```when```: Artifact kab gitlab server par upload hoga. Isme 3 options hote hain ```<on_success | on_failure | always>```, lekin default ```on_success``` hota hai.
- ```expires_in```: Artifacts gitlab server par kitne time tak rakhe jayenge, isme options hote hain ```minutes, hours, days, weeks```.

<br>

**Basic Example**:

```
build_app:
  stage: build
  script:
    - mvn package
  artifacts:
    paths:
      - target/app.jar
    expire_in: 1 week
```
Iska Matlab:
- ```target/app.jar``` ko GitLab server par artifact ke form mein store karega.
- Tum pipeline page par jaake download bhi kar sakte ho.
- 1 week baad file auto-delete ho jayegi.

<br>
<br>

### GitLab ke path ko samjho

GitLab CI/CD pipeline jab chalti hai to jo output files banti hain (jaise logs, build files, packages, test reports), unko pipeline complete hone ke baad downloadable banana hota hai.

Isi ke liye hum use karte hain:
```
artifacts:
  paths:
```

Yahaan paths batata hai:
- “Kaunsi files / folders ko artifact bana kar GitLab server pe upload karna hai”.

Iska matlab hai ki jo bhi path hum path section mein denge usi path pe data ko gitlab artifact ki tarah gitlab server par store karta hai fir hum ui mein jakar artifacts ko download kar sakte hain.

<br>

 ### Sabse bada confusion — Path dena kahan se hota hai?

 **Rule #1 — Path ALWAYS hota hai project root directory ke hisaab se**:

 Matlab:
 - Jo repo clone hota hai.
 - Jahan ```.gitlab-ci.yml``` rakha hota hai.
 - Wahi project root hota hai.
 - Aur job ussi root se run hoti hai (isliye relative path wahi se count hota hai).

<br>

**Example 1 — Simple file artifact**:

Agar project root mein output.txt hai:
```
project/
 ├── .gitlab-ci.yml
 ├── app.py
 └── output.txt
```

To CI file:
```
build_job:
  script:
    - python app.py > output.txt
  artifacts:
    paths:
      - output.txt
```

GitLab ```output.txt``` ko artifact bana dega aur gitlab server par upload kar dega.

Yaha jo bhi chiz hum path ke ander dete hain jaise uper example mein ```output.txt``` wo chiz gitlab, gitlab server par upload karta hai aur vo path project ke root mein bhi available hona chaiye. Tabhi gitlab artifact wha store kar payega aur server par upload kar payega.

Jaise koi command run karne ke baad dynamically project ke root mein ek folder create karti hai aur usme data store karti hai to wo hum path mein denge to usko gitlab server pe upload kar dega, lekin run karne se phle wo path project ke root mein na ho to bhi koi error nhi ayegi kyuki command us folder ko run time par project ke root mein create karega.

<br>

**Example 2 — Folder ko artifact banana**:

Maan lo project ke root folder mein ek folder hai:
```
dist/
```

To likho:
```
artifacts:
  paths:
    - dist/
```

Saara folder gitlab server par upload ho jayega.

<br>

**Rule #2 - Path relative hota hai repo ke andar — absolute path mat do**

Yeh mat likhna path mein kabhi:
```
/home/gitlab-runner/project/dist
```
Work nahi karega.

<br>

**Example 3 — Sub-folder ke andar file**:

Structure:
```
project/
 ├── src/
 │   └── app.log
 └── .gitlab-ci.yml
```

YAML:
```
artifacts:
  paths:
    - src/app.log
```

<br>

**Multiple files kaise den?**:

Example:
```
artifacts:
  paths:
    - dist/
    - logs/app.log
    - report.json
```

Glob Pattern bhi chalta hai.

Example — sab ```.log``` files:
```
artifacts:
  paths:
    - logs/*.log
```

Ya sab JSON files:
```
artifacts:
  paths:
    - **/*.json
```

<br>
<br>

### Example — Real CI Job

```
build:
  stage: build
  script:
    - mkdir build
    - echo "build done" > build/result.txt
  artifacts:
    paths:
      - build/
    expire_in: 1 week
```

Artifacts download ho sakte hain:
- Pipeline page pe.
- Job detail page pe.

<br>
<br>

### Golden Rules — Jo yaad rakho

**Rule 1**:
- Path repo root ke hisaab se hota hai.

**Rule 2**:
- Jo file job finish hone pe available hogi, sirf wohi artifact ban sakti hai.

<br>
<br>

### Common Mistakes:

**Mistake 1 — File wrong path pe**:
```
script:
  - mkdir out
  - echo hi > out/a.txt

artifacts:
  paths:
    - build/a.txt   # ❌ Wrong
```

Correct:
```
  - out/a.txt
```

<br>
<br>

### Ek advanced real-world DevOps example

Suppose Node app build:
```
npm install
npm run build
```

Output folder: ```build/```

CI:
```
build_job:
  stage: build
  script:
    - npm install
    - npm run build
  artifacts:
    paths:
      - build/
    expire_in: 2 weeks
```

<br>
<br>

### Important: Artifacts Temporary Hote Hain

Artifacts gitlab server par permanently save nahi hote unless:
- manually download karo.
- ya ```expire_in``` increase karo.

Default expiry ```30 days``` hota hai. Matlab 30 days tak last gitlab server par artifacts pade rahenge.

Example with Test Reports:

Suppose tum Selenium tests run karte ho aur screenshots/report generate hoti hai:
```
run_tests:
  stage: test
  script:
    - ./run_tests.sh
  artifacts:
    paths:
      - reports/
      - screenshots/
    expire_in: 3 days
    when: always
```

```when: always``` ka matlab Chahe job pass ho ya fail 👉 artifacts phir bhi save honge. Yeh bahut useful hota hai debugging ke liye.

<br>
<br>

### Artifacts Forwarding (Next Stage Ko Dena)

Normally gitlab ki pipeline mein artifacts sabhi jobs ke liye available rehte hain, jaise first job se kuch artifact generate kiye to vi pipeline ki sabhi job ke liye available rahenge matlab koi si job un artifacts ko use kar sakti hai.

Lekin aap chate ho ki test stage ko sirf build stage ke artifacts hi mile baaki kisi job ka artifact na mile, to aap ```dependencies``` ka use karoge.

Ab maan lo:

Stage 1 → Build
```
build:
  stage: build
  script:
    - npm install
    - npm run build
  artifacts:
    paths:
      - dist/
```

Stage 2 → Test
```
test:
  stage: test
  script:
    - npm test
  dependencies:
    - build
```

Yahaan:
- ```dependencies``` ensure karta hai ki sirf build job ke artifacts test job ko mile. ```dependencies``` mein apko stage ka naam dena hota hai.

Agar Dependencies na do toh?
- Tab GitLab pichle saare jobs ke artifacts de sakta hai, jo shayad tumhe na chahiye.

<br>
<br>

### Artifact Expiry Detail Mein

Tum set kar sakte ho:
- minutes.
- hours.
- days.
- weeks.

Example:
```
expire_in: 1 hour
expire_in: 2 days
expire_in: 3 weeks
expire_in: never
```

```never``` use karo toh storage khatam ho sakta hai kyuki iska matlab hai ki artifact kabhi delete hi nhi hoga.

<br>
<br>

### Artifacts size limit?

By default:
```
100 MB per job
```
Lekin self-hosted admins iska limit change kar sakte hain. Kyuki self-hosted agents pe apne according storage use kar sakte hain artifacts store karne ke liye.

<br>
<br>

### GitLab UI Mein Artifacts Kaise Dikhenge?

Pipeline → Job → Artifacts section

Wahan tum:
- download kar sakte ho.
- inspect kar sakte ho.
- expire time dekh sakte ho.

<br>
<br>

### Real-world DevOps Use Case

Tum ek Docker image build karte ho:

Build Stage:
```
build_image:
  stage: build
  script:
    - docker build -t app:latest .
    - docker save app:latest -o app.tar
  artifacts:
    paths:
      - app.tar
    expire_in: 2 days
```

Deploy Stage:
```
deploy:
  stage: deploy
  script:
    - docker load -i app.tar
    - docker run -d app:latest
  dependencies:
    - build_image
```

Yahaan:
- Docker image file artifact ban gayi.
- Deploy stage ne use reload karke run kiya.

**Edge Case — Fail hone par bhi save karo**:
```
artifacts:
  when: always
```
