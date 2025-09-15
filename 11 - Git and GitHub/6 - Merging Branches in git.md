# Merging branches in git

Merging ek process hai jisme ek branch ke code ko dusri branch main mila dete hain, jisse ek hi branch main dono branch ka code aa jaye.

Merge ka matlab hota hai do alag branches ke commits ko ek saath mila dena taaki ek branch ka kaam dusri branch me aa jaye.

Ye process tumhe allow karta hai ki tum ek branch par develop karo aur phir us branch ka kaam “main” ya “master” branch me integrate karo.

Example:

Socho tum ek Python project bana rahe ho:
- ```master``` branch me stable add() function hai.
- ```feature-subtract``` branch me tumne subtract() function banaya hai.

Ab tum chahte ho ki ```feature-subtract``` branch ka code ```master``` branch me bhi aa jaye → iske liye tum merge karoge.

<br>

### Types of merge in git

Git main branches ko merge karte time humare samne 3 types ki conditions aa sakti hain, jaise:
- Fast-Forward Merge.
- 3-way merge.
- Merge conflicts.

<br>

**Fast-Forward merge**:

Apne ```master``` branch se ek ```feature``` branch banai hai, ```feature``` branch banne ke baad agar ```master``` branch main koi commit nahi hua hai, sirf ```feature``` branch main commit hua hai. To jab ```feature``` branch ko ```master``` se merge karenge to isko Fast-Forward merge kehte hain.

Git sirf pointer move kar deta hai.

Diagram:
```
master: A---B
             \
feature:      C---D
```

Example:
- Jaise uper example main ```master``` branch se ek ```feature``` branch banai hai ```B``` commit se. ```Feature``` branch banne ke baad commit sirf ```feature``` branch main hi hui ```C``` aur ```D```, ```master``` branch main koi commit nahi hua hai, To jab ```feature``` ko ```master``` se merge karenge to ye merge Fast-Forward merge hoga.

Fast-forward ke baad:
```
master: A---B---C---D
```

<br>

**3-Way Merge**:

Apne ```master``` branch se ek ```feature``` branch banai hai, Jab ```master``` branch aur ```feature``` branch dono me alag commits aa gaye ho, ```feature``` branch ko ```master``` branch se merge karne par isko 3-Way merge kehte hain.

Jab do branches dono main alag commits ho jaye, to merge karne ki process 3-way merge process hoti hai.

- Git dono ko combine karta hai aur ek naya merge commit banata hai.
- Tum history me dekh sakte ho ki merge kaha hua.

Diagram:
```
master: A---B---E
             \
feature:      C---D
```

Example:
- Uper example main ```master``` branch main ek alag commit ```E``` ho gya hai aur ```feature``` branch main alag commit ```D``` ho gya hai.

<br>

**Merge Conflicts**:

Jab do branches main ek hi file ke ek hi line par alag changes ho, isko merge conflict kehte hain.

Example:

To hota kya hai ki, Apke paas do branches hain ek ```master``` dusri ```develop```, ab apne dono branches ki ek hi file ke ander ek hi jagah par code main changes kar diye. To jab hum ``` develop``` branch ko ```master``` branch ko ek saath merge karenge to merge karte time git ye decide nhi kar payega ki konsi branch ki file ke change usko ```master``` branch main rakhne hain, yaha pe git confuse ho jayega aur ek conflict dega, merge conflict.

Fir tum manually git ko batate ho ki konsa change usko ```master``` branch main rakhna hai. Phir ```git add``` karke ```git commit``` se merge complete karte ho.

Example:

- Add function in ```master``` branch in ```calc.py``` file:
```
add_fun(num1,num2):
  result=num1+num2
  return result

print(add_fun(10,20))
```

- Add function in ```develop``` branch in ```calc.py``` file:
```
add_fun(num1,num2):
  sum=num1+num2
  return sum

print(add_fun(10,20))
```

Uper example mein ```master``` branch ki ```calc.py``` file main result variable likha hua hai, wahi ```develop``` branch ki ```calc.py``` file main usi jagah par tumne sum variable likha hua hai, develop ko master ke saath merge karte time, git ye decide nahi kar payega ki usko result variable master branch main rakhna hai ya sum variable. is situation mein tum manually git ko bataoge ki konsa variable tumko merge karte time master branch ki ```calc.py``` file main rakhna hai.

<br>
<br>

### Command to merge in git

```
git merge <source_branch_name>
```


