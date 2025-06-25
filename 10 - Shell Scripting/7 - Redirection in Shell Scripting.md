# Redirection in Shell Scripting

Redirection means to save the output or error of a shell command in a file.

```Redirection का मतलब होता है की program या फिर command का output या फिर error किसी file मैं store करना|```

By default:
- ```जब भी आप कोई command terminal पर चलते हो जैसे (ls, echo, date, etc) तो उसका कुछ output screen पर आता है, इस output को हम stdout या फिर Standard Output कहते है|```
- ```अगर terminal पर command चलाने के बाद screen पर कोई error दिखती है, तो उस error को stderr या फिर Standard Error कहते हैं|```

Note:
- Standard output is denoted by ```1```.
- Standard error is denoted by ```2```.

<br>

**Use of redirection**

Redirection ka use karke aap in outputs ya errors ko:
- kisi file mein bhej sakte ho.
- kisi naye file mein overwrite kar sakte ho.
- kisi existing file mein append kar sakte ho.

<br>

### Redirection Symbols

There are two redirection symbols:

- ```>```: It **overwrite** the output or error of a command in file.
- ```>>```: It **append** the output or error of a command in a file.

<br>

```>```:

This is the symbol of overwrite. It used to to overwrite the output or error of a command in a file.

```इस symbol का use करके हम किसी भी command का output या error एक file मैं overwrite करते हैं| Overwrite का मतलब है old data को delete करके new data store करना|```

```इस symbol को use करने से file का old data delete हो जायेगा और command का output या error, file मैं store हो जायेगा|```

<br>

**Overwrite the Output of command**:

```अगर > symbol से पहले कोई number नहीं लिखा है तो इसको हम 1 मानते है. यह 1 बताता है की command का output overwrite करना है| इसका मतलब है की इस symbol को (>) use करने से file का old data delete हो जायेगा और command का output, file मैं store हो जायेगा|```

Syntax:
```
command > file_name
```

Example:
```
echo "Hello" > file.txt
```
Explanation:
- ```इस example मैं हमने echo command का output file.txt नाम की एक file मैं overwrite कर दिया है| अगर हम file को open करके देखेंगे तो file मैं Hello लिखा मिलेगा|```
- Agar ```file.txt``` exist karta hai, to uska pura content delete ho jaayega.
- Naya content "Hello" us file mein likha jaayega.
- Iska matlab hai: overwrite.

<br>

**Overwrite the Error of command**:

```अगर > symbol से पहले 2 लिखा है e.g., (2>). यह 2 बताता है की command का error overwrite करना है| इसका मतलब है की इस symbol (2>) को use करने से file का old data delete हो जायेगा और command का error, file मैं store हो जायेगा|```

Syntax:
```
command 2> file_name
```

Example:
```
ls ./hii 2> file.txt
```
Output:
```
ls: cannot access './hii': No such file or directory
```
Explanation:
- ```इस example मैं हमने ls command का error file.txt नाम की एक file मैं overwrite कर दिया है| अगर हम file को open करके देखेंगे तो file मैं यह ls: cannot access './hii': No such file or directory error लिखा मिलेगा|```

<br>
<br>

```>>```:

This symbol is used to append the output or error of command in a file.

```इस symbol का use करके हम किसी भी command का output या error एक file मैं append करते हैं| Append का मतलब है old data के साथ ही new data file मैं ऐड करना|```

```इस symbol को use करने से file का old data के साथ-साथ command का output या error, file मैं store हो जायेगा|```

<br>

**Append the Output of command**:

```अगर >> symbol से पहले कोई number नहीं लिखा है तो इसको हम 1 मानते है. यह 1 बताता है की command का output append यानी add करना है| इसका मतलब है की इस symbol को (>>) use करने से command का output, file मैं add हो जायेगा|```

Syntax:
```
command >> file_name
```

Example:
```
echo "Hello" >> file.txt
```
Explanation:
- Using this above command will write the output ```Hello``` inside a file called ```file.txt```.
- Old data in ```file.txt``` will remain same and new output which is ```Hello``` will be added next to old data.
- This is called Append.

<br>

**Append the Error of command**:

```अगर >> symbol से पहले 2 लिखा है e.g., (2>). यह 2 बताता है की command का error append करना है| इसका मतलब है की इस symbol (2>>) को use करने से file मैं किसी भी command का error add हो जायेगा|```

Syntax:
```
command 2>> file_name
```

Example:
```
ls ./hii 2>> file.txt
```
Output:
```
ls: cannot access './hii': No such file or directory
```
Explanation:
- ```इस example मैं हमने ls command का error file.txt नाम की एक file मैं append कर दिया है| अगर हम file को open करके देखेंगे तो file मैं यह ls: cannot access './hii': No such file or directory error old data लिखा मिलेगा|```

<br>
<br>

### Merge error into output 2>&1

Linux/Unix environment mein har command ya process ke paas teen streams hoti hain:

| Stream   | Name            | Descriptor No. | Description                                |
| -------- | --------------- | -------------- | ------------------------------------------ |
| `stdin`  | Standard Input  | 0              | Input jahan se aata hai (usually keyboard) |
| `stdout` | Standard Output | 1              | Normal output jahan jaata hai (screen)     |
| `stderr` | Standard Error  | 2              | Error messages jahan jaate hain (screen)   |


- ```stdout``` aur ```stderr``` dono alag-alag streams hoti hain.
- Jab aap koi command run karte ho, to:
  - ```stdout``` ka output screen pe dikhai deta hai (descriptor 1).
  - ```stderr``` ka bhi output screen pe hi dikhai deta hai (descriptor 2).
- Lekin yeh dono internally alag hote hain.

<br>

**Ab Aata Hai 2>&1 – Yeh Kya Karta Hai?**

```2>&1``

Syntax:
```
command > outputfile 2>&1
```

- Pehle aap ```>``` ke through ```stdout``` yani output ko kisi file mein bhej rahe ho.
- Uske baad aap ```2>&1``` likh rahe ho, jo ```stderr``` ko bhi usi file mein merge kar deta hai.

Ye ```command > outputfile 2>&1``` pehle kisi command ke output ko file main overwrite karta hai fir ye ```2>&1``` usi file main same command ke error ko store kar deta hai.

Tabhi error aur output same file main store ho jate hain.

<br>

**Step-by-Step Breakdown of 2>&1**:

Example:
```
command > log.txt 2>&1
```

- command run hoti hai.
- ```>``` symbol ka matlab: stdout (1) ka output ```log.txt``` mein likho.
- ```2>&1``` ka matlab: stderr (2) ko bhi usi jagah redirect karo jahan ```stdout``` ja raha hai.
- Result: Dono output ek hi file (log.txt) mein aa jaate hain

<br>

**Real-Life Use Case – Logging**

Jab aap koi script run karte ho jo production level ka hai (e.g. deployment, backup, cron job), to aap chahte ho ki:
- Har output log ho.
- Agar koi error aaye to wo bhi log mein mile debugging ke liye.

Realistic Example:
```
#!/bin/bash
echo "Backup started..."
tar -czf backup.tar.gz /myfolder > backup.log 2>&1
echo "Backup ended."
```

- Is example mein agar tar command successful hoti hai to output backup.log mein jaata hai.
- Agar error hoti hai (e.g. permission issue), wo bhi usi file mein jaati hai.
- Aapko alag error file dekhne ki zarurat nahi hoti.
