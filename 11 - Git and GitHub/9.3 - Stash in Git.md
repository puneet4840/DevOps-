# Git Stash

<br>


### Git Stash kya hai?

Git Stash ek temporary storage area hai jaha tum apne current working directory aur staging area ke uncommitted changes ko “stash” (yaani chipka) sakte ho, taki tum apna kaam temporarily save karke kisi aur branch ya task par switch kar sako — bina commit kiye.

Soch lo:
- Tum ek feature par kaam kar rahe ho, code half-done hai.
- Achaanak urgent bug aata hai, tumhe turant master branch me switch karke fix karna hai.
- Tum apna incomplete code commit nahi karna chahte (kyunki wo repo dirty karega).
- Tum ```git stash``` kar dete ho.
- Tumhari working directory clean ho jati hai (jaise koi change tha hi nahi).
- Tum branch switch karke bug fix kar sakte ho.
- Baad me tum wapas aake apne changes ```git stash pop``` karke la sakte ho.

Ye hi hai Git Stash ka magic.

<br>
<br>

### Components Involved in Stash
- **Working Directory** – jahan tum code edit karte ho.
- **Staging Area (Index)** – jahan tumne git add karke files staged ki hoti hain.
- **Stash Stac**k – Git ek hidden stack maintain karta hai jisme tumhare stashes store hote hain. (Har stash ek commit pair hota hai internally.)
- **HEAD** – jahan se tum branch ki current commit ko dekh rahe ho.

<br>
<br>

### Basic Commands of Stash

- ```git stash```.
- ```git stash save "message"```.
- ```git stash list```.
- ```git stash show```.
- ```git stash apply```.
- ```git stash pop```.
- ```git stash drop```.
- ```git stash clear```.

<br>
<br>

### Step by Step Example

**Scenario**:

Tum ```feature-xyz``` branch par kaam kar rahe ho:
```
git checkout feature-xyz
```

Tumne kuch changes kiye:
```
modified: app.py
new file: utils/helper.py
```

Ab tum commit nahi karna chahte, par master me urgent bug fix karna hai.

**Step 1: Stash Changes**:
```
git stash
```
Iske baad:
- Tumhari working directory clean ho jayegi (jaise koi change nahi tha).
- Tumhare changes stash stack me chale jayenge.

**Step 2: List Stashes**:
```
git stash list
```
Output:
```
stash@{0}: WIP on feature-xyz: 9fceb02 Add initial app structure
```

Ye tumhara stash hai. Har stash ek index se identified hota hai.

**Step 3: Switch Branch & Do Work**:
```
git checkout master
# fix bug here
git commit -am "Fix urgent bug"
```

**Step 4: Wapas apne feature par jao aur Stash Lagao**:
```
git checkout feature-xyz
git stash pop
```
Iske baad tumhare stashed changes wapas aa jayenge aur stash stack se remove ho jayenge.

<br>
<br>

### Breakdown of Commands

1 - ```git stash```:
- Default stash banata hai (both staged + unstaged changes save karta hai).

2 - ```git stash save "message"```:
- Custom message ke saath stash save karta hai:
```
git stash save "WIP: implementing new API"
```

3 - ```git stash list```:
- Saare stashes dikhata hai:
```
stash@{0}: On feature-xyz: WIP implementing new API
stash@{1}: On master: WIP updating readme
```

4 - ```git stash show```:
- Stash me kya changes hai dikhata hai:
```
git stash show stash@{0}
```

5 - ```git stash apply```:
- Stash ko apply karta hai par stash stack me entry rakhta hai, matlab stash ko wapas se original location par le aata hai:
```
git stash apply stash@{1}
```

6 - ```git stash pop```:
- Stash ko apply karta hai aur stack se remove bhi karta hai:
```
git stash pop stash@{0}
```

7 - ```git stash drop```:
- Stash ko manually delete karta hai:
```
git stash drop stash@{0}
```

8 - ```git stash clear```:
- Saare stashes delete kar deta hai:
```
git stash clear
```

<br>
<br>

### Stashing with Untracked Files

By default, untracked (new) files stash nahi hoti. Tumhe ```-u``` ya ```--include-untracked``` flag lagana padta hai:

```
git stash push -u -m "WIP with untracked files"
```

<br>
<br>

### Real-Life Example

Imagine tum Docker aur Python ke saath kaam kar rahe ho. Tumhari directory me hai:
```
app.py (modified)
Dockerfile (modified)
debug.log (new untracked)
```

Tum chahte ho:
- Abhi sab stash ho jaye (including untracked files).
- Wapas aake apply karoge.

Command:
```
git stash push -u -m "WIP before switching to hotfix"
```

Ab sab clean ho gaya. Tum bug fix karlo. Phir:
```
git stash pop
```

Sab wapas aa gaya.

<br>
<br>

### Important Tips
- Stash temporary hai. Agar clear kar diya to changes chale jayenge.
- Stash internally ek commit pair hota hai (ek for index, ek for working tree).
- Stash ka best use tab hota hai jab tum half-done work ko temporary save karna chahte ho bina commit kiye.
- Tum alag branch me bhi stash apply kar sakte ho (useful when moving WIP from one branch to another).

