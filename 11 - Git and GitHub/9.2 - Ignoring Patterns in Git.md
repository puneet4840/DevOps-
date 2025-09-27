# Ignoring Patterns in Git

<br>

### Pehle samjho: “Ignoring Patterns” kya hote hain?

Git by default har file ko track kar sakta hai (jab tum ```git add``` karte ho).

Lekin real-life projects me kuch aise files hote hain jinhe:
- Version control me rakhna nahi chahiye,
- Ya woh auto-generated hote hain,
- Ya woh local configuration hote hain (jaise passwords, API keys, local build output).

Example:
- Compiled code: ```*.class``` (Java), ```*.pyc``` (Python).
- Dependency folders: ```node_modules/```.
- IDE configuration: ```.vscode/``` or ```.idea/```.

Ye sab agar repo me chale jaye to:
- Repo bloat ho jata hai.
- Secrets leak ho sakte hain.
- Team members ke setups alag ho sakte hain.

Isliye Git me ek system hai: **ignoring patterns** — jo ```.gitignore``` file me likhe jate hain.

Ye patterns Git ko bolte hain: “Ye files ya folders ko ignore karo, track mat karo.”

<br>
<br>

```.gitignore``` **file**:
- Ye ek simple text file hoti hai jo tumhare repo ke root me rakhi jati hai.
- Isme tum likhte ho ki kaunse patterns ignore karne hain.
  - Ek pattern = ek line.
  - Tum files, folders, wildcards sab use kar sakte ho.
 
Example ```.gitignore``` file:
```
# Ignore Python cache files
*.pyc

# Ignore node_modules folder
node_modules/

# Ignore log files
*.log

# Ignore a specific file
config/local.env
```

Ab Git ye files kabhi track nahi karega (jab tak wo already tracked na ho).

<br>
<br>

 ### How Git Uses .gitignore

 - Jab tum ```git status``` karoge, ignored files list me nahi aayengi.
 - Agar koi file pehle se track ho rahi hai (Git me add ki ja chuki hai), .gitignore usko retroactively remove nahi karta. Uske liye tumhe ```git rm --cached``` karna hota hai.

<br>
<br>

### Example Step-by-Step

Chalo ek mini Python project lete hain:
```
myproject/
  main.py
  secret.txt
  __pycache__/
  logs/debug.log
```

Hum chahte hain:
- ```__pycache__/``` folder ignore ho.
- ```*.log``` files ignore ho.
- ```secret.txt``` ignore ho.

**Step 1: .gitignore banao**:
```
# Ignore python cache folder
__pycache__/

# Ignore log files
*.log

# Ignore secret file
secret.txt
```

**Step 2: Git repo init karo**:
```
git init
git add .
git commit -m "Initial commit"
```

Ab ```.gitignore``` Git me add ho gaya.

**Step 3: Check git status**:

Agar tum ```logs/debug.log``` add karne ki koshish karoge:
```
git status
```

Output me woh nahi aayega, kyunki Git ignore kar raha hai.


<br>
<br>

### Patterns Syntax (bahut important)

**1 - Simple Filename**:
```
secret.txt
```
- Sirf ```secret.txt``` ignore karega.

**2 - Folder Ignore**:
```
/build/
```
- Root me build folder ignore karega.

```
build/
```
- Kahin bhi ho build folder, ignore karega.

**3 - Wildcards**:
```
*.log
```
- Saare ```.log``` files ignore karega.

```
*.py[cod]
```
- Saare ```.pyc```, ```.pyo```, ```.pyd``` ignore karega.

**4 - Negation**:
```
!important.log
```
- Kiai pattern main aage ! lagae dene se us file ko ignore nhi karega, jaise ```important.log``` file ko track akr lega.

**5 - Subfolders**:
```
docs/*.txt
```
- Sirf ```docs/``` folder me ```.txt``` files ignore karega, baaki jaga nahi.

<br>
<br>

### Already Tracked File Ko Ignore Karna

Agar tumne galti se ```secret.txt``` ko add kar diya aur commit kar diya, ab ```.gitignore``` me add karne se wo auto-ignore nahi hota. Tumhe command se karna padega:
```
git rm --cached secret.txt
```

Phir commit karo:
```
git commit -m "Stop tracking secret.txt"
```

Ab ```.gitignore``` us file ko ignore karega.

<br>

### Important Note
- ```.gitignore``` sirf untracked files pe apply hota hai.
- Agar file pehle se tracked hai to ignore nahi karega jab tak tum usko untrack nahi karte.
