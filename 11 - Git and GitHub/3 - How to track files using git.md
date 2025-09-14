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
