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

