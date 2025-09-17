# Hooks in Git

Git hooks ka matlab hai ki files ko commit karne se pehle, ya commit karne ke baad, remote par push karne se pehle ya push karne ke baad, aap kuch internal checks laga sakte ho isi ko hooks bolte hain.

To ye kaam ek script ke though hota hai jo ```.git/hooks``` folder main hoti hai. Tum is folder main jaake apni ek script likhte ho, aur action perform karne par script run ho jati hai.

Git Hook ek aisi custom script hai jo Git ke lifecycle events (commit, push, merge, receive, etc.) ke pehle ya baad automatically run hoti hai.

Example:

Suppose aapne ek python main ek calculator application banai ```calc.py```, aapne commit karne se phele ek hook laga rakha hai ki syntax thik hoga tabhi commit ho sakte hai varna commit fail e.g., **pre-commit-hook**, aur apne ```calc.py``` file main kuch syntax galat likh diya to pre-commit hook fail ho jayega kyuki syntax galat hai aur aapki file commit nahi hogi.

<br>

### Git Hook Kya Hai?

- Git by default ek version control tool hai. Lekin Git sirf code track karta hai.
- Kabhi-kabhi tum chahte ho ki kuch kaam automatically ho jaaye jab tum Git ka koi action perform karo.
- Jaise:
  - Tum commit karne ja rahe ho → pehle code lint ho jaaye.
  - Tum push karne ja rahe ho → pehle tests run ho jaaye.
  - Tum merge karte ho → dependencies install ho jaaye.

Ye sab manually har bar karna boring hai. Isliye Git ne ek hooks mechanism diya: tum apni script likho, Git woh automatically chalaye.

<br>

To:
- Git Hook ek script hota hai jo Git ke kisi specific event par automatically run hota hai (jaise commit, push, merge).
- Iska purpose hai automation (repetitive kaam khud ho), quality control (bad code/secret commit na ho), aur policy enforcement (message/branch rules).
- Ye har repo ke ```.git/hooks``` folder me stored hota hai.
- Ye local machine par bhi ho sakta hai (client-side hook) ya server par (server-side hook).

Example: Tum pre-commit hook lagao jo Python ka lint/test run kare. Agar fail ho to commit abort ho jaye.

<br>
<br>

### Git Hook kyu use karte hain?

- **Automation**: repetitive kaam automate karna.
- **Quality Control**: commit/push hone se pehle quality gate laga do.
- **Security**: secret ya risky code commit hone se pehle check karna.
- **Consistency**: poori team ek hi standard follow kare.
- **DevOps**: hooks se deployment trigger karna.

<br>
<br>

### Kaise use Hoti Hai? (Mechanism)

- Jab tum ```git init``` karte ho to har repo me ```.git/hooks``` folder banta hai.
- Is folder me kuch sample hook files hoti hain (jaise ```pre-commit.sample```). Ye sample files disabled hoti hain (naam me .sample hota hai).
- Tum ```.sample``` hata do ya fir ek nayi file bana lo aur apni script likho (Bash, Python, etc.) aur file ko executable permission de do.
- Jab woh event hota hai (commit/push/merge), Git woh script run kar deta hai.

Path example:
```
myproject/
├── .git/
│   ├── hooks/
│   │   ├── pre-commit.sample
│   │   ├── pre-push.sample
│   │   └── ...
└── calc.py
```

Steps:
- ```.git/hooks``` me jao.
- File banao jaise ```pre-commit```.
- Script likho.
- ```chmod +x pre-commit``` (file ko execute permission do).
- Ab har ```git commit``` par script automatically run hogi.

<br>
<br>

### Types of Hooks

**1 - Client-side hooks**:

Ye hooks tumhare local repo me chalte hain.

Important hooks example:
- ```pre-commit``` (commit hone se pehle).
- ```prepare-commit-msg``` (message editor khulne se pehle).
- ```commit-msg``` (message finalize hone par).
- ```post-commit``` (commit hone ke baad).
- ```pre-push``` (push hone se pehle).
- ```post-merge``` (merge ke baad).

<br>

**2 - Server-side hooks**:

Ye hooks remote Git server par chalte hain (self-hosted Git, GitLab, Bitbucket Server).

Jab koi push ya receive hota hai tab run hote hain.

Impoetant hooks example:
- ```pre-receive```.
- ```update```.
- ```post-receive```.

GitHub.com pe custom server hooks nahi hoti, lekin “branch protection rules” aur “GitHub Actions” se similar hooks wala effect milta hai.

<br>
<br>

### Important Hooks + Use Case Table

| Hook                      | Kab chalti hai                    | Typical Use             |
| ------------------------- | --------------------------------- | ----------------------- |
| **pre-commit**            | `git commit` se pehle             | Lint/test, style check  |
| **commit-msg**            | Commit message finalize hone par  | Commit message policy   |
| **post-commit**           | Commit hone ke baad               | Notifications/log       |
| **pre-push**              | `git push` se pehle               | Tests, secret scan      |
| **post-merge**            | Merge hone ke baad                | Dependencies install    |
| **pre-receive** (server)  | Remote push receive hone se pehle | Reject direct main push |
| **post-receive** (server) | Remote push hone ke baad          | Deploy ya notify        |

<br>
<br>

### Git Hooks vs Tools

Aajkal developers directly ```.git/hooks``` me script nahi likhte. Iske liye aur bhi tools ka use karte hain.

Popular tools hain:
- **pre-commit** (Python package) – ek framework jo hooks manage karta hai, easy config ```.pre-commit-config.yaml``` me.
- **Husky** (JavaScript projects) – same purpose.

Ye tools hooks ko easily install aur share karne dete hain taaki poori team me same rules lagein.

<br>
<br>

### Limitations
- User hooks ko bypass kar sakta hai ```--no-verify``` option se.
- Remote hooks sirf apne customr Git server par possible hain, GitHub.com par nahi.

<br>
<br>

### Example-1: Pre-Commit Hook (Python)

Pre-Commit hook ka matlab commit hone se pehle ```.git/hooks``` ke ander ```pre-commit``` wali script run hogi.

Project: ```calc.py``` – tum Python developer ho aur tumne ek calculator application banai hai.

Tum chahte ho:
- Jab bhi koi commit kare, python files ki code quality check ho jaye (automatically flake8 linting chale).
- Linting: Code ka syntax check karna correct hai ki nahi, iske liye python main flake8 library hoti hai.
- Agar fail ho to commit cancel ho jaye.

Example ```calc.py```:
```
my_function()
  a = 5
  b = 6

  return c
```


Steps:
- ```.git/hooks``` folder main jake ```pre-commit``` naam se file banao aur usko executable permission dedo.
```
cd myproject/.git/hooks
touch pre-commit
chmod +x pre-commit
```

- ```pre-commit``` file me likho:
```
files=$(git diff --cached --name-only --diff-filter=ACM | grep `\.py$`)

flake8 $files
```

Ab jab tum:
```
git add calc.py
git commit -m "Added new function"
```
- Agar code ok hai → commit ho jayega.
- Agar lint error hai → commit cancel ho jayega aur linting error dega.

<br>
<br>

### Example-2: Pre-push Hook (Python tests)

Tum chahte ho push hone se pehle pytest run ho:

```.git/hooks/pre-push```:

Example: ```pre-push```
```
#!/bin/bash
echo "Running tests before push..."
pytest ../tests

if [ $? -ne 0 ]; then
  echo "Tests failed. Push aborted."
  exit 1
fi
```

Ab koi bhi git push kare to tests run ho kar pass hone chahiye.


