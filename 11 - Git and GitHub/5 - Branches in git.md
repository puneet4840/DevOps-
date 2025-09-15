# Branches in Git

Abhi tak hum git ki default bracnh jo ki ```master``` branch hoti hai, usme kaam kar rhe the.

Lekin git main hum apni khud ki ek branch bhi create kar sakte hain. Usse pehle samjhte hain branch kya hoti hai.

<br>

### Branch kya hoti hai

Branch is an independent line of development.

Branch create karke usme alag code likhe sakte hain.

Ek Git branch ek lightweight pointer hota hai jo kisi specific commit pe point karta hai. Matlab, branch sirf ek reference hai, jaise ek label jo bataata hai "yeh mera current state hai".

Git mein branch ek “pointer” hota hai jo tumhare commits ki ek specific line par khada hota hai. Tum is pointer ko naye direction mein chala sakte ho aur apna alag development flow create kar sakte ho.

Default branch:
- Jab tum naya Git repo banate ho, Git automatically ek default branch banata hai.
- Is branch ka naam ```master``` branch hota hai.

<br>

### Branch ki jarurat kyu hui?

Git me branch banane ka purpose yeh hota hai ki hum main (ya master) branch me directly code change na karein, balki ek alag environment create karke us par apna code likhein aur test karein.

**Example-1**:

Suppose tum ek calculator application bana rhe ho jiska code tumne ```master``` branch main likha hai.

Example ```calc.py```:
```
num1=10
num2=20

print(num1+num2)
```

Tumne calculator application main abhi add karne kaam code likha aur ab tum subtract karna ka code likhna chahte ho, to tum kya karoge ki iske liye ```master``` branch se ek ```subtraction``` naam ki branch create kar loge, jisme ```calc.py``` file ki ek copy ban jayegi. Aur is branch main tum substraction karne ka code likh sakte ho.

Isse add karne wale code main koi problem nahi hogi, aur baad main hum ```master``` branch mai ```substraction``` branch merge kar sakte hain, jisse ```master``` branch main add karne wala aur subtraction karne wala code aa jayega.

Iska fayda ye hai ki pehle se likhe code main koi changes na karte hue hum apna code alag likh sakte hain.

**Example-2**:

Branches allow karti hain isolated development. 

Maan lo tum ek team mein ho – ek developer new login system bana raha hai, doosra payment gateway fix kar raha hai, teesra UI changes. Sab apni apni branch pe kaam karte hain, bina ek dusre ko disturb kiye. Jab ready, merge kar do main mein. Yeh time save karta hai, conflicts reduce karta hai, aur code quality improve karta hai.

<br>
<br>

### Commands to do operations on branch

<br>

- **Create a branch and remain on the current branch**:

Syntax:
```
git branch <new-branch-name>
```

Example:
```
git branch feature/login
```

<br>

- **Create a branch and immediately switch to it**:

To create a new branch and automatically switch to it.

Syntax:
```
git checkout -b <new-branch-name>
```

Example:
```
git checkout -b feature/signup-form
```

<br>

- **Create a branch based on an existing branch**:

To create a new branch based on another existing branch:

Syntax:
```
git branch <new-branch-name> <base-branch-name>
```

Example:
```
git branch develop/new-module develop
```

<br>

- **See total branches in git**:

Example:
```
git branch
```

<br>

- **Delete a branch**:

Syntax:
```
git branch -d <branch-name>
```

Example:
```
git branch -d develop
```

<br>

- **Switching to an existing branch**:

Syntax:
```
git checkout <branch-name>
```

Example:
```
git checkout develop
```

<br>

Alternatively, with newer Git versions:

Syntax:
```
git switch -c <new-branch-name>
```

Example:
```
git switch -c develop
```

