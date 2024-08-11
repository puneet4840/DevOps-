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
