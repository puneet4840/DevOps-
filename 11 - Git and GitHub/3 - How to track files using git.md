# Track files using git commands

Git main files ko track karne ke liye humko commands ka use karna hota hai.

<br>

### Commands

Basics commands are:
- ```git init```.
- ```git status```.
- ```git add <file_name>/git add .```
- ```git commit -m "<commit message>```"

<br>
<br>

**1 - git init**:

- Is command ka naam ```git initialize``` hota hai.
- Ye command working directory ke ander ek empty git repository create karti hai.

Matlab ye command tumhari working directory ke ander ek ```.git``` folder ko create kar deti hai, Jis bhi directory main ```.git``` folder hota hai us directory ko hum ```Git Repository``` kehte hain.

Isko hum empty git repository isliye kehte hain kyuki ```.git``` folder ke ander ek bhi commit store nhi hota hai isliye empty git repository kehte hain.

Syntax:
```
git init
```

Example:
```
git init
```

<br>

**2 - git status**:

Ye command tumhari working directory ki files ka status dekhne ke liye hoti hai, jaise ki file untracked hai, modified hai ya commited hain.

- Jab working directory main koi nayi file create hoti hai aur uska hum status dekhte hain to uska status ```untracked file``` hota hai.
- Jab file ko ```git add <file_name>``` command se staging area main dala jata hai to us file ka status ```Changes to be committed``` ho jata hai.

Syntax:
```
git status
```

Example:
```
git status
```

<br>

**3 - git add <file_name> or git add .**

Ye command file ko staging area main leke jane ke liye hoti hai. Jaha hum ye decide karte hain ki file ko commit karna hai ya nhi.

Syntax:
- Agar ek file ko staging area main dalna hai to:
```
git add <file_name>
```

- Agar ek saath sabhi files ko staging area main dalna hai to:
```
git add .
```

<br>

**4 - git commit -m "<user message>"**

Ye command file ko staging area se commit karne ke liye hoti hai. Commit karte time humko message main likha hota hai ki kya commit kar rahe ho.

Syntax:
```
git commit -m "<user message>"
```
- ```- m```: Iska matlab message hota hai

Example:
```
git commit -m "first commit"
```

<br>
<br>

## Example LAB: Track files using git

**Step-1: Create a python file in working directory.**

Tum Python file likhte ho ```calc.py```:
```
def add(a,b):
    return a+b
print(add(2,3))
```

Yeh abhi file Working Directory me hai. 

<br>

**Step-2: Check status of file**:

Jab ```git status``` command run karoge to ye untracked hogi, kyuki ye file abhi staging area main nhi gyi hai aur commit nhi hui hai:

Example:
```
git status
```
Output:
```
Untracked files:
  calc.py
```

Matlab abhi ye file Git ne track karna start nhi ki hai.

<br>

**Step-3: File ko staging area main leke jao**:

Ab file ko staging area main leke jao, below command ko use karke:

Example:
```
git add <calc.py>
```

<br>

**Step-4: Fir se file ka status check karo**:

File ko staging area main daalne ke baad fir se file ka status check karo.

Example:
```
git status
```
Output:
```
Changes to be committed:
  new file: calc.py
```

<br>

**Step-5: File ko commit karo**:

Ab staging area se file ko commit kardo.

Example:
```
git commit -m "Initial addition program"
```
Output:
```
[master cb335c9] Initial addition program
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 calc.py
```

Ab file commit ho chuki hai, iska matlab file ko git ab track kar rha hai.


