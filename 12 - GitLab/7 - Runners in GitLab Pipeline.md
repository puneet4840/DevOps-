# Runners in GitLab Pipeline

<br>

### Sabse Pehle – GitLab Runner Kya Hota Hai?

Socho tumne GitLab mein CI/CD pipeline likhi:
```
.gitlab-ci.yml
```

Is file mein tumne likha:
- build kaise hoga.
- test kaise chalenge.
- deploy kaise hoga.

Lekin ye saare commands execute kaun karega?

GitLab khud toh sirf UI aur repo deta hai.

**Runner hi wo machine hoti hai jo tumhare CI/CD jobs ko actually run karti hai**.

<br>
<br>

### Runner Ka Role Pipeline Mein

Flow kuch aisa hota hai:
- Tum push karte ho code.
- Pipeline trigger hoti hai.
- Jobs create hoti hain.
- Runner job uthata hai.
- Job execute karta hai.
- Output GitLab UI mein dikhta hai.

<br>
<br>

### Types of GitLab Runners

GitLab mein mainly 2 types ke runner hote hain:

**1 - Instance Runner (Shared Runner)**:

Instance Runner vo runner hota hai jo GitLab khud provide karta hai as SaaS. Gitlab ne apne khud ke instances host kiye hue hain jagah jagah, jab bhi hum instance runner ka use karke CI/CD pipeline run karte hain to gitlab ke host kiye hue runners pe pipeline run hoti hai.

- Ye runners sab projects ke liye available.
- GitLab.com pe default milte hain.
- Managed by GitLab.

Example:

Tum free GitLab.com use kar rahe ho
- bina kuch install kiye pipeline chal jati hai.
- kyunki Shared Runner already enabled hai.

Suitable for:
- small projects.
- learning.
- quick builds.

<br>

**2 - Self-Hosted Runners (Project/Group Runners)**:

Tum apni khud ke server ya machines ko use karte ho gitlab pipelines run karne ke liye. Isme tum apni machine par gitlab ka diya hua ek tool gitlab-runner install karte ho aur gitlab ke saath usko register karte ho.

Register hone ke baad tumhari gitlab ki pipelines self-hosted runners par run karti hain.

- Sirf tumhare project/group ke liye.
- Full control hota hai.

Suitable for:
- companies.
- private infra.
- secure environment.
- heavy workloads.
- custom tools.

<br>
<br>

### Runner Install Kaha Ho Sakta Hai?

Runner kisi bhi machine par install ho sakta hai:
- Linux server.
- Windows machine.
- macOS.
- Docker container.
- Kubernetes cluster.
- Cloud VM (AWS, GCP, Azure).

Matlab jahan command line chale wahaan Runner install ho sakta hai.

<br>
<br>

### Runner Actually Kaise Kaam Karta Hai?

Chalo pura flow dekhte hain.

**Step 1 — Tum pipeline define karte ho**:
```
build_job:
  stage: build
  script:
    - echo "Building app..."
```

**Step 2 — Runner register hota hai GitLab ke saath**:

Wo GitLab ko bolta hai:
- "Bhai koi job ho toh mujhe dena".

**Step 3 — Job queue me jaati hai**:

Runner check karta hai:
- free hoon?
- tags match ho rahe hain?
- access allowed hai?

**Step 4 — Runner job execute karta hai**:
- Repo runner pe clone hota hai.
- script commands run hoti hain.
- result upload hota hai.

<br>
<br>

### Runner Executors

Runner different tareeke se jobs run kar sakta hai.

Executer matlab ek environment jaha job run hogi.

**Common Executors**:

**1 - Shell Executor**:

Job directly host machine ke shell par run hoti hai.

Example:
- Ubuntu server.
- job bash shell me chalegi.

<br>

**2 - Docker Executor**:

Job host machine ke docker container mein run hogi. Har job ke liye docker container create hota hai. To us docker container ke ander commands run hoti hain.

Example:
```
image: node:18
script:
  - npm install
  - npm test
```

<br>

**3 - Kubernetes Executor**:

Job kubernetes cluster ke pod mein run hogi.

<br>
<br>

### Runner Tags — Yeh Kya Hota Hai?

Jab hum ek self-hosted runner create karte hain usko gitlab ke saath register karte hain to humko gitlab ui mein runner ko ek tag dena hota hai.

Is tag ka matlab hota hai ki jis job ke paas runner jesa same tag hoga vo hi us runner pe run hogi.

Example:

Tumne ek self-hosted runner ko tag diya ```dev```.

Ek CI pipeline banai aur uski job mein same tag de diya:
```
stages:
  - build
  - test


build_job:
  stage: build
  script:
    - echo "Hey Buddy building"
  tags:
    - dev

test_job:
  stage: test
  script:
    - echo "Testing..."
```

Ab uper example mein humne sirf build_job ko tag diya hai lekin test_job ki koi tag nhi diya hai, to self-hosted runner sirf build_job ko execute karega kyuki usko humne ```dev``` tag diya hai.

Iska matlab hai ki jis job ke paas, runner ke jesa matching tag hota hai to runner usi job ko execute karta hai.

