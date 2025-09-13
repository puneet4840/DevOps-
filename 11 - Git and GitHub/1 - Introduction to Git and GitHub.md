# Intoduction to Git and Github

<br>

### What is Git?

Git ek distributed version control system hai, jo ki software development de dauran code main hue changes ko track karta hai.

Git ek distributed version control system (DVCS) hai. Iska matlab hai ki yeh aisa tool hai jo tumhare code ka history (jaise code main konsi line code kya code change hua hai) track karta.

Ye ek esa system hai jiski help se hum apni files ko track kar sakte hain ki kya chages hue aur kab changes aur kisne changes kiye.

**Example**: 

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

Fir se tumne is file ko commit kar diya, to git yaha jo is file main changes hye hain unko apne paas store kar lega, Jaise:
- Kaunsi line add hui, kaunsi remove hui.
- Nayi file add hui.
- Koi file delete hui.
- Koi file rename hui.
- Koi file move hui

Ye saari chize git track karta hai.
