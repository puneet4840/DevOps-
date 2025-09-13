# Intoduction to Git and Github

<br>

### What is Git?

Git ek distributed version control system hai, jo ki software development de dauran code main hue changes ko track karta hai.

Git ek distributed version control system (DVCS) hai. Iska matlab hai ki yeh aisa tool hai jo tumhare code ka history (jaise code main konsi line code kya code change hua hai) track karta.

Ye ek esa system hai jiski help se hum apni files ko track kar sakte hain ki kya chages hue aur kab changes aur kisne changes kiye.

Yaha:
- “```Version control```” ka matlab hai kisi file, folder ya project ke har ek change ka record rakhna. Jise kya add hua, kya remove hua, etc.

Example:

Jaise tum ek python file edit karte ho to Git bata sakta hai ki:
- Kaunse line pe change hua,
- Kisne change kiya,
- Kab kiya,
- Kya message diya change ka.

<br>

- “```Distributed```” ka matlab hai ki har developer ke paas poore repository ka local copy hota hai (history ke saath).

Example:

Suppose tumne local system main python project banaya aur GitHub pe push kar diya, Ab tumhari ek team hai jo is project par kaam karegi aur naye features add karegi, team ko kaam karne ke liye project code chaiye hota hai, To team ke members GitHub se project code ko apne apne local systems par copy kar sakte hain poori history ke saath, aur is project pe kaam kar sakte hain. Isi ko hum distributed bolte hai. Matlab tumhari team ke sab members ke paas poore repo ki local copy with full history hoti hai.

Matlab agar GitHub down bhi ho jaye to bhi tum apne laptop se poore project ki purani history dekh sakte ho, naye branch bana sakte ho, commits kar sakte ho.

Aur isi way main alag alag developers projects pe kaam karte hain.

<br>
<br>

**Example of Git**: 

Suppose tum ek python developer ho, aur tumne ek ```two number ko add karne ki python``` file likhi, jaise:
```
num1=10
num2=20

addition = num1+num2
```

Tumne git ka use karke is file ko commit kiya, to git usi moment pe is file ki history apne paas save kar lega, jaise:
- Is file main kya kya chiz likhi hui.
- Ye file kisne commit ki hai.

Is type ki chiz apne pass store kar lega, aur is commit ko ek hash number de dega jisse jis time pe ye file git main save hui hai usme kya kya likha tha.

Suppose ab tumne usi file main two numbers ko subtract karne ka code likh diya jaise:

```
subtraction = num2-num1
```

Complete file esi hogi:
```
num1=10
num2=20

addition = num1+num2

subtraction = num2-num1
```

Fir se tumne is file ko commit kar diya, to git yaha jo is file main changes hye hain unko apne paas store kar lega, Jaise ye subtraction wala code jo tumne add kiya hai iske liye ek alag se commit number banakar apne save karlega jisse ye pta lagega ki is particular moment par file main kya subtraction wali line add hui.

<br>

### Git kya track karta hai?

Git basically teen main chizen track karta hai:

**Files ke content me changes**:
- Kaunsi line add hui, kaunsi remove hui.
- Pure project ka snapshot ek history me store hota hai.

**File-level operations**:
- Nayi file add hui.
- Koi file delete hui.
- Koi file rename hui.
- Koi file move hui.

**Branches & merges**:
- Tumne nayi branch banayi.
- Merge kiya.
- Conflict resolve kiya.

<br>
<br>

### What is GitHub?

GitHub ek cloud-based hosting platform hai jaha tum git repositories ko store, manage aur share kar sakte ho.

GitHub ek website hai jaha pe tum apni local repositories ko store karte ho aur team ke saath us repository ko share karte ho.

GitHub ek server hai jaha hum code push karte hain aur koi aur dusra waha se code pull karta hai.

- Git ek tool hai (local machine par chalta hai).
- GitHub ek service hai (internet pe host hoti hai).

Jaise tumhare paas code hai to tum Git se version control karoge. Aur GitHub par tum use store karke team members ke sath collaborate karoge.

