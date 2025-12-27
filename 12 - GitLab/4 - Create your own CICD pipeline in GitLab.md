# Create your own CI/CD pipeline in GitLab

Gitlab mein CI/CD pipeline banane ke liye tumko sirf project ke root folder mein ek ```.gitlab-ci.yml``` file banai hai.

Ye hi file tumhari CI/CD pipeline hogi, isi mein tum YAML code likhoge apni pipeline ke liye.

Root folder ka matlab hai ki project mein simply ye file create kar dena.

<br>
<br>

### Create .gitlab-ci.yml file

Tum project ke root folder mein ek ```.gitlab-ci.yml``` file create karlo.

Example:

```
Project
|- app.py
|- Dockfile
|- .gitlab-ci.yml
```

<img src="https://drive.google.com/uc?export=view&id=1QqPntxivEQ-fuYxf5ellY9GppXWzHPaf" width="650" height="820">

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
