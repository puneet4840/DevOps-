# Shell Scriting / Bash Scripting

### What is Shell?

A shell is the command-line interface that allow user to interact with operating system. It interprets and execute the commands that user input.

### Types of Shell

There are several types of shell available:

1 - **Bash (Bourne Again SHell)**

2 - **Zsh**

3 - **PowerShell**

4 - **sh (Bourne SHell)**

But **Bash** is the most common shell used by the people.

<br>

### What is Shell Scripting?

Shell Scripting is the practise of writing scripts using the shell's command language to automate tasks.

It is kind of a programming language in we write the series of commands.

A shell script is the text file that contains a series of commands to perform a task to be executed by shell.

<br>

### What is shell type in my linux?

You can see your shell type using the command in shell: _**echo $0**_.

<br>

### Our First Program in shell scripting.

This is Hello World Program that will print Hello World. Create a file with .sh extension and give it execute permission.

  ```
  #!/bin/bash

  echo "Hello, World!"

  ```

Lets understand it.

- The first line of the shell script begin with "she-bang" (#!) followed by the full path where the shell interpreter is located. This shebang line tells the operating system which interpreter to use to parse the script.
- Usually # sysmbol is used to treat a command as comment. But using shebang it is not interpreted as comment.

**Run Your Script**

Three methods to run shell scripts:

- ./script_name
- /path/script_name
- bash script_name

e.g.,

- ./myscript.sh
- /home/puneet/Scripts/myscript.sh
- bash myscript.sh

**Stop Your Script**

- "Ctrl + c" to terminate.
- "Ctrl + z" to stop.

<br>

### Comments in Shell Scripting

Two types we can write comments in shell script:

- Using #.

  e.g.,

  ```
  #This is comment.
  ```

- Multi-Line comment using <<.

  e.g.,

  ```
  <<comment
  This is comment
  ...
  End of comment
  comment
  
  ```

<br>

### Variables in Shell Script

A variable is a container to hold some data.

- A variable name could be an integer, filename or some shell command itself.
- A variable could contain any alphabet (a-z,A-Z) or any digit (0-9) or an underscore (_).

**Note**

- A variable name must start with an alphabet or underscore.
- It can never start with a number.

**Vaild variable names**

```
ABC
ab
_AB_3
AV232
```

**Invalid variable names**

- We can not use integer or any special character at the beginnig of variable.

```
2AN
2_an
!ABC
$ABC
&abc

```

**Defining Variables-**

Syntax: 
```
variable_name=<data>
```

e.g., 
```
name="Puneet"
age=24

echo "My name is $name and age is $age."
```

**Accessing Variables-**

We can access variables using **$** just before variable name.

e.g., Accessing user defined variables.
```
name="Puneet"
age=24

echo "My name is $name and age is $age."
```

e.g., Accessing Shell Commands as variable
```
host=$(hostname)

echo "My hostname is $host."
echo "Today's date is $(date)."
```

<br>

### String Operation in Shell Script

String operation includes get string length, index, sub-string extraction, etc.

**Count the length of string**

To get the string length we use ${#string_name}.

e.g.,
```
#!/bin/bash

myVar="Puneet"
echo "Length of $myVar string is ${#myVar}"
```

```
Output: Length of puneet string is 6
```

**Make chracter in string Uppercase**

To make all characters in a string in uppercase, we use ${string_name^^}

e.g.,
```
#!/bin/bash

myVar="Puneet"
echo "Upper Case is ${myVar^^}"
```

```
Output: Upper Case is PUNEET
```

**Make character in string Lowercase**

To make all character in a string in lowercase, we use ${string_name,,}

e.g.,
```
#!/bin/bash

myVar="PUNEET"
echo "Lower case is ${myVar,,}"
```

```
Output: Lower case is puneet
```

**Replace a word in string**

To replace a word with another word in string, we use ${string_name/old_word/new_word}

e.g., Here we are replacing Puneet with Buddy.
```
#!/bin/bash

myVar="Hi Puneet"
echo "Replaced word is ${myVar/Puneet/Buddy}"
```

```
Output: Replaced word is Hi Buddy
```

**Slicing a String**

To pick a small part from a string, we use ${string_name:start_char_index:lenght_of_string}. By default string starts with 0 index.

e.g., Here we are pincking Puneet from string.
```
#!/bin/bash

myVar="Hi Puneet"
echo "After slicing ${myVar:3:6}"
```

```
Output: After slicing Puneet
```

<br>

### Get input from a user

To get any input from user, we use read command. In the second example we used -p which means we can directly use string instructions with read command.

e.g.,
```
#!/bin/bash

echo "Enter your name-"
read name
echo "Your name is $name"
```
OR
```
#!/bin/bash

read -p "Enter your name: " name
echo "Your name is $name."
```

```
Output: Enter you name:
        Your name is Puneet.
```
