# Variables in GitLab pipeline

<br>

### Variable Hote Kya Hai?

Variable = ek value jo tum storage me rakhte ho aur pipeline me use karte ho.

Example:
```
DB_PASSWORD=MySecret123
```

Phir pipeline me:
```
echo $DB_PASSWORD
```

Matlab:
- Ek jagah define karo.
- Kahin bhi use karo.

<br>

**Sabse IMPORTANT baat**

Variables mostly secrets / configs rakhne ke liye use hote hain, Jaise:
- Passwords.
- API keys.
- Cloud credentials.
- Environment names.
- Build configs.

Aur kyun?
- Kyuki secrets aur configs ko code me likhna unsafe hota hai.

Example (galat tareeka):
```
script:
  - mysql -u root -pMyPassword
```

Secrets ko direct code mein use karne se ye public ho sakte hai, islye variable mein securly use karna chaiye.

<br>
<br>

### Types of Variables in GitLab

GitLab me broadly do tarah ke variables hote hain:

**1 - User-Defined Variable**:

In variables ko tum define karte ho aur ye pipeline mein available hote hain.

Ye secrets ya configs ke liye hote hain.

Example: Database Password

Variable:
```
DB_PASSWORD = supersecret
```

YAML:
```
deploy:
  stage: deploy
  script:
    - mysql -uroot -p$DB_PASSWORD
```

<br>

**2 - Built-in CI Variables (Auto-Provided)**:

Ye variables GitLab automatically deta hai. Tumko ye define nhi karne hote directly use karne hote hain.

Example:

| Variable           | Meaning         |
| ------------------ | --------------- |
| CI_PROJECT_NAME    | Project ka naam |
| CI_COMMIT_REF_NAME | Branch name     |
| CI_PIPELINE_ID     | Pipeline ID     |
| CI_JOB_NAME        | Job ka naam     |
| CI_COMMIT_SHA      | Commit hash     |

Tum inhe directly use kar sakte ho.

Example:
```
script:
  - echo $CI_COMMIT_REF_NAME
```
Output:
```
main
```

<br>
<br>

### User-Defined Variables kaise-kaise define karte hain

<br>

**1 - YAML file mein Global Variables define karna (Inline Variables)**:

Tum directly ```.gitlab-ci.yml``` me bhi variables define kar sakte ho. Jinko Inline Variables bhi bola jata hai.

Example ```.gitlab-ci.yml```:
```
stages:
  - build

# Global variables are available to all jobs
variables:
  NODE_ENV: production
  APP_VERSION: "1.0.0"

build_job:
  stage: build
  script:
    - echo $NODE_ENV and $APP_VERSION
```

<br>

**2 - GitLab UI mein variable define karna**:

Hum GitLab ke UI mein variables defin ekar sakte hain. Ye sabse zyada used method hai.

📍 Path:

Project → Settings → CI/CD → Variables

Wahan Add Variable click karo.

Example:
```
Key   = DB_PASSWORD
Value = s3cr3t@123
```

Options:
- Mask (logs me hidden). 
- Protect (sirf protected branches me).

UI ke through variables create karne par unko mask bhi kar sakte hain matlab logs in variables ki value hidden rehti hai. Aur protected branch mein bhi use kar sakte hain.

Use in YAML:
```
deploy:
  stage: deploy
  script:
    - echo $DB_PASSWORD
```

Use case:
- DB credentials.
- API keys.
- App configs.

Benefit:
- Secure.
- Centralized.
- GUI based (non-dev bhi manage kar sakta).

