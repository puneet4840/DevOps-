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

**Overwrite the Output**:

```अगर > symbol से पहले कोई number नहीं लिखा है तो इसको हम 1 मानते है. यह 1 बताता है की command का output overwrite करना है| इसका मतलब है की इस symbol को (2>) use करने से file का old data delete हो जायेगा और command का output, file मैं store हो जायेगा|```

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

**Overwrite the Error**:

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

