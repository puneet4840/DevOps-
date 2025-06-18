# Shell Scripting

### What is Shell?

A Shell is a program that provides an interface to the user to use the operating system services.

OR

A Shell is a program that takes commands from the keyboard and gives them to the operating system to perform actions.

OR

A shell is a command-line interface (CLI) program that allows users to interact with an operating system by entering commands. It acts as a middleman between the user and the operating system kernel.
- You type a command, the shell interprets it, and passes it to the OS to execute.
- It also displays the output of that command back to you.

```Shell एक program होता है जो user को operating system के kernal के साथ interact करवाता है| इसका मतलब है की user CLI Interface पर एक command लिखता है, इस command को CLI operating system के kernal तक पहुँचता है और kernal का output user को दिखता है|```

<br>

### What is Shell Script?

A shell script is a text file with ```.sh``` extension in which we write shell commands in it.

A shell script is essentially a text file containing a sequence of shell commands. Instead of typing each command manually, you can write them all in a script and execute them together. It’s a way to automate tasks on a system.

```Shell script एक text फाइल होती है जिसमे आप multiple shell commands लिखते हो, और इस file को execute करते हो जिससे script के अंदर लिखी हुई commands एक-एक करके run होती है|```

**File Extension**:

Shell scripts ka extension hota hai: ```.sh```. 


### What is Shell Scripting?

```Shell scripting एक तरह की programming होती है, जिसमे आप shell commands को sequence में लिखते हो एक file के अंदर ताकि वो सभी commands automatically चल सकें.```


### Why Shell Scripting?

```हम shell scripting को कोई भी task automate करने के लिए use करते हैं|```

```Normally जब हम linux मैं काम करते हैं तो commands के through करते हैं तो linux terminal पर एक बार मैं एक ही command का use करते हैं, तो अगर हमको कोई task automate करना है मतलब खुद  से कोई task complete करना है तो उसके लिए हम shell script लिखते हैं, जिसमे हम वही linux की commands को sequence मैं लिख देते हैं और script file को run कर देते हैं| फिर script file को run करने पर वो script मैं लिखी हुई commands एक-एक करके run होने लगती हैं जिससे वो task automatically complete हो जाता है बिना बार-बार commands run किये|```


### Types of Shell

There are multiple types of shell in linux:

**sh (Bourne Shell)**:
- Developer: It is developed Stephen Bourne (AT&T Bell Labs).
- It was the default shell in early Unix systems.
- Simple, reliable, and portable.
- Key Features:
  - Supports basic scripting constructs: loops, conditions, variables.
  - Highly portable across different Unix systems.
- Executable path: ```/bin/sh```.
 
**Bash (Bourne Again Shell)**:
- Developer: GNU Project.
- It is the enhancement and replacement for Bourne Shell.
- Most widely used shell today in Linux distributions.
- Supports:
  - Command history.
  - Auto-completion.
  - Scripting improvements.
  - Arithmetic operations.
  - Job control.
- Executable path: ```/bin/bash```.

**C Shell (csh)**:
- Developer: Bill Joy (University of California, Berkeley).
- Syntax resembles C programming language.
- Introduced features like:
  - Aliases.
  - Command history.
  - Job control.
- Executable path: ```/bin/csh```.

**Korn Shell (ksh)**:
- Developer: David Korn (AT&T Bell Labs).
- Combines features of both Bourne Shell and C Shell.
- Offers:
  - Improved scripting capabilities.
  - Better arithmetic operations.
  - Command history.
  - Aliases.
 - Executable path: ```/bin/ksh```.

**Z Shell (zsh)**:
-  Highly powerful and customizable shell.
-  Combines features from Bash, ksh, and csh.
-  Supports:
  - Plugin systems.
  - Theme support (like ```oh-my-zsh```).
  - Advanced tab-completion.
  - Extended globbing patterns.
  - Better history management.
- Executable path: ```/bin/zsh```.

<br>
<br>

### Write multiple commands and run at once.

We can write multiple commands sperated by semi-colon(;) and it can be run as a single command.

Syntax:
```
command-1;command-2
```

Example:
```
date;who
```

It will give ouput of current date and current user.

<br>

### Check shell type in you linux machine.

You can check which type of shell your linux is currently using by below command.

Example:
```
echo $SHELL
```

Output: ```/bin/bash```

<br>

### Write Your First Shell Script

```Shell script लिखने के लिए हमको एक file बनानी होती है जिसका extension .sh होता है. और उस file को execute permission देनी होती है| फिर उस file के अंदर हम linux की commands लिखते हैं| जिसको collectively shell script बोला जाता है| ```

```Shell script की अंदर सबसे पहली चीज़ जो हम लिखते हैं वो she-bang लाइन होती है| फिर इसके बाद अपनी script लिखते हैं|```

Example:
```
#!/bin/bash      #She-bang 
```

**What is She-Bang?**

The shebang line is the very first line in a script file that tells the operating system which interpreter to use to execute the script.

It starts with the characters:
```
#!
```

(called "shebang" or "hash-bang" because of the ```#``` and ```!``` characters), followed immediately (without any spaces) by the absolute path of the interpreter program which is the path of shell.

```She-Bang shell script की सबसे पहली line होती है जो operating system को यह बताती है की script को execute करने के लिए कौन से shell का use करना है|```

```क्युकी ऊपर हमने कुछ shell के बारे मैं पढ़ा था जो अलग-अलग type के थे, तो उनमे से कोनसा shell इस script को run करने के लिए use करना है ये हमको she-bang line को लिखकर operating system को बताना होता है| फिर operating system फिर उसी shell से इस script को run करता है|``` 

**Syntax of a Shebang Line**:

```
#!/path/to/interpreter
```

**Example for a Bash script**:

```
#!/bin/bash
```

When you run this script, the operating system will use ```/bin/bash``` to interpret and execute the commands inside the script.

**How does Operating System handles it internally?**

Jab aap koi script execute karte ho directly terminal se (jaise ```./script.sh```), to:
- Linux OS script file ke first line ko read karta hai.
- Wo line agar ```#!``` se start hoti hai, to OS samajh jaata hai ki:
  - "Is script ko kaunse interpreter ke through chalana hai."
- OS us interpreter program ko call karta hai (jaise ```/bin/bash```, ```/usr/bin/python```).
- Interpreter baaki script ka code line-by-line execute karta hai.

NOTE: Bina Shebang ke, agar aap script ko ```./``` ke saath run karoge, to aapko "command not found" ya syntax error mil sakta hai, ya OS default shell use karega (jo mismatch ho sakti hai).


<br>

### First Shell Script

This is a hello world script. It will print hello world.

first-script.sh
```
#!/bin/bash

echo "Hello World"
```

Output: Hello World

### Run Your Script

Three methods to run your script:

- ./script_name
- /path/to/script
- bash script_name

Example:
- ./first-script.sh
- /home/puneet/first-script.sh
- bash first-script.sh

### Stop the Script

- ```ctrl + c``` to terminate.
- ```ctrl + z``` to stop.

<br>

### Comment in Shell Scripting

Comments are not interpreted by shell.

We can write comments in shell scripting in two ways:
- Single line comment.
- Multi-line comment.

**Single Line Comment**:

We can write single line comment using ```#``` symbol before any line.

Example:
```
#!/bin/bash

# This is a single line comment.
```

**Multi Line Comment**:

We can write multi line comment using below syntax.

Syntax:
```
<<comment

write your multi line comment here

comment
```

Example:
```
<<comment

This is
your
multi line comment.

comment
```

<br>

### Variables in Shell Scripting

A variable is a container to hold some data.

A variable could contain any alphabet (a-z,A-Z) or any digit (0-9) or an underscore (_).

Note:
- A variable name must start with an alphabet or underscore.
- It can never start with a number.
- ```=``` ke aage ya peeche koi space nahi hota.
- Shell scripting mein sabhi variables by default string (text) hote hai.


**Types of Variables**:

There are two types of variables in shell:
- User Defined Variables.
- System Defined OR Environment Variables.

**User Defined Variables**:

Variables which are created by user in the script is are user defined variables.

```वो variables जो user खुद define करता है shell script के अंदर, वो user defined variables होते हैं|```

Ye variables:
- Sirf current shell/session ke liye active hote hain. Jab tak shell band nahi hota, tab tak available rehte hain.

User-defined variable ka scope hota hai:
- Sirf us shell ya script tak jahan wo define hua hai.
- Agar aap new terminal open karte ho, to variable fir se define karna padega.

**Defining Variables**:

Syntax:
```
variable_name=<variable_data>
```

Example:
```
name="Puneet"
age=25
```

**Accessing Variables**:

To access the value of a variable, use a ```$``` sign before the variable.

Syntax:
```
$variable_name
```

Example:
```
echo $name
echo $age
```

**Vaild variable names**:

```
ABC
ab
_AB_3
AV232
```

**Invalid variable names**:
- We can not use integer or any special character at the beginnig of variable.

```
2AN
2_an
!ABC
$ABC
&abc
```

<br>

**System-defined (Environment) Variables**:

These variables are predefined by the operating system.

System defined OR Environment variables woh predefined ya exported variables hote hain:
- Jo OS ke through define OR create kiye jate hain.
- Ye variables poore system ya sabhi child processes ke liye accessible hote hain.
- Inka use system configurations, user info, paths, language, terminal settings, etc. ko store karne ke liye hota hai.

Environment variables:
- Global level ke variables hote hain.
- Jab aap koi command run karte ho (jaise bash, python, etc.), to wo bhi in variables ko access kar sakta hai.

**Example of Common Environment Variables**:

| Variable   | Purpose                                 |
| ---------- | --------------------------------------- |
| `$HOME`    | User ka home directory                  |
| `$USER`    | Current logged in username              |
| `$PATH`    | Commands ko search karne ke directories |
| `$SHELL`   | Default shell                           |
| `$PWD`     | Present Working Directory               |
| `$LANG`    | System language setting                 |
| `$EDITOR`  | Default text editor (like vim, nano)    |
| `$LOGNAME` | Login name                              |
| `$UID`     | User ID                                 |
| `$TERM`    | Terminal type                           |

**Accessing Environment Varibales**:

To access these variables simple use ```$``` and variable name.

Syntax:
```
$<variable_name>
```

Example:
```
echo $HOME
echo $USER
echo $SHELL
```

Output:
```
/home/puneet
puneet
/bin/bash
```

**Check All Environment Variables in Linux**:

To check all environment variables present on your linux system use:

```
env

OR

printenv
```

**Environment Variable Banane Ka Tarika**:

Agar aap apna variable environment mein export karna chahte ho (taaki wo child shells mein bhi kaam kare), to ```export``` command ka use karte hain.

Syntax:
```
export varname=value
```

<br>

**NOTE**:

Shell scripting mein sabhi variables by default string (text) hote hai.

Jaise:
```
x=5
y="hello"
```

Shell ```x``` ko bhi string maanta hai, aur ```y``` ko bhi, kyunki shell ke liye sab kuch ek character sequence hota hai.

<br>

**Read Only Variables in Shell Scripting**

We can also create a variable whose value can be changed that is read-only variable.

Syntax:
```
readonly <variable_name>=<variable_data>
```

Example:
```
readonly name="Puneet"
```

<br>

**Exercise**:

```
#!/bin/bash

# This tutorial is for variables in shell script.


echo "Variables"

name="Puneet"
age=25

echo "My name is $name and age is $age"

name="Ram"

echo "My name is $name"


# Envrionment Variables


echo "Machine name is $HOSTNAME and username is $USER"


# Readonly varibales


readonly day="Monday"

echo "Today's day is $day"

day="Tuesday"

echo "Today's day is $day"
```
