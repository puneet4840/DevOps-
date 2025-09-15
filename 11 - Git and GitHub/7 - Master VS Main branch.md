# Master VS Main branch

- Git ke ander default branch ka naam ```master``` hota hai.
- GitHub ke ander default branch ka naam ```main``` hota hai.

<br>

### Pahle kya hota tha – “master” default branch

Git jab 2005 me Linus Torvalds ne banaya tha, tab se default branch ka naam ```master``` hi hota tha. Matlab jab tum ```git init``` karte the ya Git me naya repo banate the, to automatically ```master``` branch create hoti thi.

Is branch ka kaam hota tha **main line of development** ya **stable code** rakhna.

Teams is master branch ko production ya release ke liye use karti thi.

<br>

### 2020 ke baad kya change hua – “main” default branch

- June 2020 me GitHub aur bahut saari open source communities ne decide kiya ki “master” shabd ko replace kiya jaye.
- Reason: “Master/slave” terminology ka historic connotation tha (slavery se linked).

Ab:
- GitHub par naya repository banate ho → default branch ```main``` hoti hai.
- Local Git (v2.28 se) bhi allow karta hai ki tum default branch ka naam ```main``` set kar sako.

<br>

### Technical difference

Technically master aur main me koi functional difference nahi hai. Dono:
- Ek hi tarah ke branch pointers hai.
- Ek hi tarah commits ko point karte hai.
- Ek hi commands (```git checkout```, ```git merge```, etc.) lagte hai.

Matlab:
- ```git checkout master``` vs ```git checkout main``` – same behavior, bas naam alag hai.
- Merge, rebase, push, pull — sab same kaam karte hai.

<br>

### Naming ka impact

Impact sirf:
- **Team policies** par: CI/CD pipelines ya scripts jo specifically master naam expect karte the, unme changes karne padte hai.
- **Remote repo sync** par: Agar GitHub par main hai aur tumhare local me master hai to tumhe rename karke push karna padta hai.

Example:
```
# Local branch master hai
git branch -m master main  # rename to main
git push -u origin main
```

Phir GitHub par default branch main set karni hoti hai.

<br>

### Default branch rename karne ka tariqa

Git v2.28 se tum global config set kar sakte ho:
```
git config --global init.defaultBranch main
```

Ab jab tum ```git init``` karoge to default branch ```main``` banegi.

Agar tumhare paas purani repo hai jisme ```master``` hai, to rename kar sakte ho:
```
git branch -m master main          # rename branch locally
git push -u origin main            # push new branch to remote
git push origin --delete master    # delete old branch on remote (optional)
```

Phir GitHub me “Settings → Branches” me default branch ```main``` set karo.

<br>

### Real-world workflow example

Tum ek Python project bana rahe ho:
- Purani repo me ```master``` branch hai → ye production code hai.
- Tumne naya repo banaya GitHub par → default branch ```main``` hai.

Tumhare team members ```git clone``` karte hai to unko ```main``` milega.

Tum jab pipeline banate ho to ```main``` specify karna padta hai (jaise GitHub Actions ya Jenkins job me).

Isliye sirf naam change hota hai, kaam wahi rehta hai.

<br>

### Best practices

- Naye repo banate ho to default branch ```main``` rakho (ye hi ab industry standard hai).
- Purane repos jisme ```master``` hai unhe migrate karne se pehle:
  - Pipelines aur scripts update karo.
  - Team ko communicate karo.
- Branch ka naam kuch bhi ho sakta hai (```production```, ```trunk```, etc.), bas consistent rakhna hai.
