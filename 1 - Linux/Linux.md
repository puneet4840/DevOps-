# Linux

### What is Linux?

Just like Windows, IOS, and MacOS, Linux is an operating system. In fact, one of the most popular operating system in planet. An operating system is a software that manages all of the hardware resources associated with your computer.

### History of Linux-

In 1969, Dennis Richie and Ken Thompson made an free operating system called **UNICS** (**U**nified **I**nformation and **C**omputing **S**ervices).

They both made changes in UNICS and in 1975 they launched (UNIX V6) operating system which was more popular at that time. Therefore, UNIX was free and open source then many companies made their own version of UNIX which was paid and costly.

Some UNIX versions:

      |--> IBM-ATX

      |--> Sun Solaris
      
      |--> Mac OS

      |--> HP-UX

In 1991, a student _Linus Trovald_ saw that companies made the UNIX OS paid. Then _Linus Trovald_ inspired from UNIX OS, write the code from scratch and made an operating system for his project that is called **_Linux_**.

Basically Linux is a kernal not an operating system.

### What is Kernal?

A kernal is a program or application in your operating system that allows applications to use hardware resources(CPU, Memory, RAM).

e.g., 

1 - When you open web browser, we know that web browser need RAM, CPU and storage to run smoothly. So Kernel provides all needed hardware resources to Web Browser.

2 - When you open Web Browser and Music Player simultaneously, the kernel allocates CPU time to both so they can run together without crashing.

3 - If your browser needs more memory to open more tabs, the kernel manages this request by allocating more RAM, ensuring the system doesn't run out of memory.


### Types of Linux

When we talk about different types of Linux, we are actually referring **Linux Distributions**. There are multiple Linux Distribution like, Debian, Ubuntu, RHEL. These all operating systems built on top of Linux Kernel, bundled with various application, tools and configuration.

### File System Hierarchy in Linux

<img src="https://github.com/user-attachments/assets/879fdd56-0690-4a4b-9e22-e81fb115ee41" width="500" height="530">

### Structure of Linux Commands:

A linux command has mainly three parts: **Command Name + Options + Arguments**.

e.g., 
```
cat abc.txt  , here cat = command name, abc.txt = argument.
```

e.g., 
```
cat -n abc.txt   , here cat = command name, -n = option, abc.txt = argument. -n is the short option, we can give --number also.
```

<img src="https://github.com/user-attachments/assets/9584c60f-2242-48b8-b6dc-643ecc13ecad" width="500" height="200">

**NOTE**: We can write multiple options and arguments in a single command. Options are written using - in any command.

e.g., 
```
cat ncal 2024 -w -M

OR

cat ncal 2024 -wM
```

<br>
<br>

### Get documentation of any command using CLI:

**man** -> It means _Mannual Pages_. This command gives you the complete details of any command you use in linux.

Suppose we do not know what cat command does. So we can se its documentation using man command.

e.g., 
```
man cat
```

<img src="https://github.com/user-attachments/assets/4c9a942f-63db-4d03-bb05-5bad257c6ba7" width="600" height="320">

In the above picture we can see the docs of cat command.


### List Files and Folders:

**ls** -> It means _list_. This command list all files and folders in the directory.

Syntax:

![image](https://github.com/user-attachments/assets/3ad8712a-66f1-4ea7-ad9d-da6b067d48f6)

Commands:

1: **ls -a**: It list all hidden files and folders.

![image](https://github.com/user-attachments/assets/f3c9f63d-8d70-47ff-8b78-b85efe362d19)


2: **ls -l**: It list all files and folder inside a directory in a long format. It gives all details of files and folders.

![image](https://github.com/user-attachments/assets/a809e669-997c-47fa-917e-d89fbef5a042)


3: **ls -lh**: It list all files and folder in human readable size. The size of files and folders is written in human readable language like kb, mb and gb.

![image](https://github.com/user-attachments/assets/67ff49b4-2c49-4fff-a0b9-75d73a4dae5c)

4: **ls -t**: It list all files and folders according to time. Sort the files and folders with newest first.

![image](https://github.com/user-attachments/assets/6cf82036-a6b2-4e35-a70e-45783acf3bf7)

5: **ls -tr**: Sort the files and folders with oldest first. -r Simple reverse the order.

![image](https://github.com/user-attachments/assets/3ac417d1-a0b5-4112-b827-0a52deb3edc1)

6: **ls [folder_name/]**: It list all files and folders inside a folder without visiting it. In the below image we are seeing what is inside wslg folder without visiting it.

![image](https://github.com/user-attachments/assets/3cdc18d9-71a1-429b-ac31-18de0e4cdb3e)

<br>
<br>

### Directory

**Root Directory (/)**: This forward slash represent root driectory which means there is no directory beyond root.

**Home Directory or User Directory (~)**: This tiddle sign represent home directory of a user. By default we points to home directory when open terminal.

**Relative Path**: Relative path is the path related to present working directory. It start with current working directory.

**Absolute Path**: Absolute path is the complete path form root directory. It start with (/).

**Note**: There are two way to visit a folder. 1- Using Absolute path means we give complete path of a directory starting from root. 2 - Using current working directory meant we can visit a folder which inside our current working directory.

<br>
<br>

### File Management

**Create Directory**

1 - This command is used to create directory or multiple directories.
```
mkdir [directory_name]
```

2 -This command create nested directory. It means we can create a directory inside a directory.
```
mkdir -p [directory_name/directory_name]
```

<br>

**Create File**

Syntax:
```
touch [file_name]
```

This command is used to create file or change files timestamp of existing file. It means if we use touch command on an existing file, it change the time of file to when it was last accessed.

<br>

**Determine File Type**

Syntax: 
```
file [file_name]
```

This file command is used to check which type of file it is. for e.g., If we use file command with a txt file. It will show ASCII text. If we use file command with python file then it wil show python script output.

**Delete a File**

Syntax: 
```
rm [file_name]
```

This command removes the file from a directory.

**Delete a Directory**

Syntax: 
```
rm -r [dir_name]
```

This command removes a directory.

**Copy Files**

1 - If your files are in a different directory.

Syntax: _**cp [/path/to/source_directory/file_name] [path/to/destination_directory/]**_

e.g., cp /home/action/boom.mp4 /home/movies/

2 - Copy all files to destination directory.

Syntax: _**cp [/path/to/source_directory/*] [/path/to/destination_directory/]**_

e.g., cp /home/books/* /home/newbooks/

**Copy Directory and Files**

1 - Copy a directory to another directory.

Syntax: _**cp [/path/to/source_directory/directory_name] [/path/to/destination_directory/]**_

2 - Copy all contents including files and folders into other directory.

Syntax: _**cp -r [/path/to/source_directory/*] [/path/to/destination_directory/]**_

e.g., cp /home/movies/* /home/newmovies/

**Move Files**

1 - Move all files and folder to another directory.

Syntax: _**mv -r [/path/to/source_directory/*] [/path/to/destination_directory/]**_

**Rename File**

Syntax: _**mv [old_file_name] [new_file_name]**_

<br>
<br>

### Nano Text Editor

Nano is a text editor for terminal. It edit and save the file.

Syntax: _**nano [file_name]**_ : This command opens up a file to be edited in the editor.

**Navigation in Nano**

1 - **Ctrl + O**: Save the file or Write the file to disk.

2 - **Ctrl + X**: Exit the editor.

3 - **Ctrl + Up Arrow**: Go to start of the text.

4 - **Ctrl + Down Arrow**: Go to end of the text.

5 - **Ctrl + A**: Go to start of the line.

6 - **Ctrl + E**: Go to End of the line.

7 - **Alt + G**: Go to specific line number.

**Basic Editing in Nano**

1 - **Alt + U**: Undo.

2 - **Ctrl + U**: Paste.

3 - **Ctrl + K**: Cut a line or cut a selected line.

**Search/Replace in Nano**

1 - **Ctrl + W**: To search a word or character in a nano editor.

<br>
<br>

### Append and Overwrite Content into a file.

1 - Overwrite Content into a file.

Syntax: _**>**_: This symbol overwrite content into a file means replaces new content with old content.

e.g., cat a.txt > b.txt

2 - Append Content into a file.

Syntax: _**>>**_: This symbol append the content into a file means add new content with old content.

e.g., cat a.txt >> b.txt

<br>
<br>

### Display limited content of the file.

1 - **Head**: This command display specified number of lines from top of the file. By default it display 10 lines of a file from top.

Syntax: _**head [file_name]**_: It display 10 line of a file from top.

Syntax: _**head -n [file_name]**_: It display n number of line from top of a file.


e.g., head -3 movies.txt , It display 3 lines from top.

<br>

2 - **Tail**: This command display specified number of lines from bottom of the file. By default it display 10 lines of a file from bottom.

Syntax: _**tail [file_name]**_: It display 10 lines of a file from bottom.

Syntax: _**tail -n [file_name]**_: It display n number of line from bottom of the file.

Syntax: _**tail -f [file_name]**_: It display continues changes in the file. If I add some lines then it will show the output continuously.

e.g., tail -3 movies.txt , It display 3 lines from bottom.

<br>

3 - **Less**: This command is used to viewing the content of a file. It shows one page at a time in a same window. 

Syntax: _**less [file_name]**_

<br>
<br>

### Standard Output and Error in Linux

**What is Standard Output?**

The output we get on our terminal screen when we run a command is Standard Output.

1 - **Save Standard Output of a command in a file**

We can save the standard outout of a command in a file using **>** or **>>** symbol. We know that we **>** symbol overwrite into the file and **>>** symbol append the content into the file. So, we can use these symbols after any command to store output.

Syntax: _**[command] > [file_name]**_: It overwrite the output of any command into the file.

Syntax: _**[command] >> [file_name]**_: It append or concatanate the output of any command into the file.

e.g., ls > myfile.txt , It overwrite output of ls command into myfile.txt file.

e.g., ls >> myfile.txt , It append output of ls command into myfile.txt file.

![image](https://github.com/user-attachments/assets/c07686e1-1953-4141-a0bb-2bb54ca2cb9d)

<br>

2 - **Save Standard Error of a command in a file**

We can store the error of any command. If we are using any command, it gives some error then we can save its error into a file as a log. This is way how we can store the log of any script we use in linux into a file. This is done using **2>** or **2>>** symbol.

Syntax: _**[command] 2> [file_name]**_: It overwrite the Standard Error of any command into a file.

Syntax: _**[command] 2>> [file_name]**_: It append or concatanate the Standard Error of any commnd into the file.

Generally we use 2>> symbol to store error as logs.

e.g., cp /movies/* /home/fold1 2>> copy_file.logs

e.g., tail 2>> mylog.logs

e.g., ls -z >> output.txt 2>> erorr.txt , This command store output into output.txt file and error into error.txt file at same time.

<br>
<br>

### Sort content of file

We can sort the content written inside a file using **sort** command. This command simply sort the content with first character of a line.

Syntax: _**[sort] [file_name]**_: It sorts a text file in alphabetical order.

Syntax: _**[sort] -r [file_name]**_: It sorts a text file in reverse alphabetical order.

Syntax: _**[sort] -n [file_name]**_: It sorts a numerical file in ascending order.

e.g., sort fruits.txt

e.g., sort -n integer.txt

<br>
<br>

### Pipe Operator

Pipe operator is used to provide standard  output of one command as the input of another command. It means we combine two commands using pipe operator.

Syntax: _**[command 1 | command2]**_: Here output of command1 is providing to the input of command2 and it is giving combined output.

e.g., Sort the list of files and forlders present in a directory.

ls -lh | sort

e.g., Sort the list of files and folders with maximum 5 file.

ls -lh | sort -k5h | tail -5

e.g., Finding a word pizza in foods.txt file.

cat foods.txt | grep 'pizza'

<br>
<br>

### Grep Command 

Grep command is used to search a text in a file. It is case sensitive.

Syntax: _**[grep] [pattern] [file_name]**_

for examples:

**1** - Search a word life in meditation text file.

grep 'life' meditation

**2** - Search all 'life' word present in meditation text file.

grep -i 'life' meditation

**3** - Search how many count of word 'life' present in meditation text file.

grep -ic 'life' meditation

**4** - Search all line numbers in which 'life' word present in meditation text file.

grep -in 'life' meditation

**5** - Search all word 'tomato' in foods.txt

grep -i 'tomato' meditation

**6** - Search a word 'hello' in all files or folders present in current directory.

grep -r 'hello'

<br>
<br>

### Terminal Shortcuts

1 - Move start and end of terminal (During Command).

Syntax: _**Ctrl + A**_ -> Starting.

Syntax: _**Ctrl + B**_ -> Ending.

2 - Skip word by word Forward and Backward (During Command).

Syntax: _**Alt + B**_ -> Backward.

Syntax: _**Alt + F**_ -> Forward.

3 - Search any command you used earlier.

Syntax: _**Ctrl + R**_.

4 - Clear the written command.

Syntax: _**Ctrl + U**_.

<br>
<br>

### Find command in linux

Find command is used to search Files and Directories in Hierarchy File Structure.

Syntax: _**find [path] [option] [expression]**_

e.g.,

**1** - Find a file name meditation in home/ooo directory.

find /home/ooo -name "meditation"

**2** - We can also give wildcard characters with filename to match the file. 

Wildcard Characters:

**'*'**: It matches any string of characters, including an emoty string.

**?**: It matches any single character.

**[]**: It matches any one of the character inside square bracket. For example [abc] matches 'a', 'b' or 'c'.

Find a file which have .pdf extension in home/ooo directory.

find /home/ooo -name "*.pdf"

**3** - Find a resume in home/ooo directory.

find /home/ooo -name "*Resume*"

We can use i for case insensitive.

find /home/ooo -iname "*resume*"

<br>
<br>

### Permissions in Linux

Permission in linux state that who can access files and directories and how. There are three types of permissions in linux - 1: Read (r), 2: Write (w), 3: Execute (x).

![image](https://github.com/user-attachments/assets/ce8e98fd-96c9-44e1-8da7-64255f34ce0b)

In the above image you can see user, group, other.

User: User is the owner of file. It means who create the file.

Group: When we create a user, a group is created by default with the same name as of user. The user lies in the group. We can add users in the group.

Other: Other is the other user created on our machine. 

Note: - means no permission. 

**Reading the Permission in Linux**

<img src="https://github.com/user-attachments/assets/4587ef50-3f51-41d1-8f80-071e1a994fae" width="600" height="300">

**Directory and Files**

![image](https://github.com/user-attachments/assets/95927fde-a435-489e-84d8-d1c31772c5fa)

In the above image you can see **d** or **-** at the beginning. This **d** indicate that this is directory and **-** indicates that this is file.

<br>
<br>

### Chmod command in linux

Chmod command is used to change the permission of files and directories.

Syntax: _**chmod [mode] [file_name]**_

mode: We can provide three things to mode. 1 - Whom you want to give or remove the permission. 2 - What do you want to do with permission (Give or Remove). 3 - What permission you want to give.

**Types of Mode**:

1 - Symbolic Mode.

2 - Octal Mode.

**Symbolic Mode**

In symbolic mode we make combination of symbols.

Symbols are: 

<img src="https://github.com/user-attachments/assets/4b7b1c5e-b943-4991-b314-0d65323860ac" width="410" height="180"> 
<br>
<img src="https://github.com/user-attachments/assets/0aee0af0-7e8a-4d79-bea8-82708ccbeca6" width="410" height="180"> 
<br>
<img src="https://github.com/user-attachments/assets/880fcb36-ada7-4c31-b836-4ae6ccb97834" width="410" height="180">

e.g.,

<img src="https://github.com/user-attachments/assets/0d8ceec7-b4db-4d09-b413-5486478b73f5" width="500" height="400">

In the above image we can see that we are giving execute permission to user for sameple file.

e.g.,

**1**: Remove execute permission from user for sample file.

chmod u-x sample.txt

**2**: Give execute permission to other users for sample file.

chmod o+x sample.txt

<br>

**Octal Mode**

In octal mode we use numbers to give and remove permissions. There are 0 to 7 number are used in octal mode.

0 -> 000

1 -> 001

2 -> 010

3 -> 011

4 -> 100

5 -> 101

6 -> 110

7 -> 111

Here these three digits represent Read, Write, Execute. Like 010 -> Read(0) Write(1) Execute(0). This means only write permission.

e.g.,

**1**: Give a write permission to user for sample file.

chmod 200 sample.txt

Explanation: Here 200 denotes that 2 means user, 0 means group, 0 means other. 2 for user denotes (010) means write permission only like read(0) write(1) execute(0).
<br>

**2**: Give a read, write permission to user and read permission to group for sample file.

chmod 640 sample.txt.

Explanation: Here 640 denotes that 6 means user, 4 means group, 0 means other. 6 for user denotes (110) means read and write permision only. 4 for group denotes (100) means read permission  only. 0 denotes (000) no permission to other.

<br>
<br>

### su command in linux

su means substitute user. This command is used to switch to another user's account or run commands as a different user.

Syntax: _**su - [username]**_

To exit from user we can type exit or ctrl+d.

e.g., 

**1**: Switch to user puneet from user nginadmin.

su - puneet

**2**: Switch to root user from nginadmin.

su - , but it will require password. Without password we can use **sudo su -**.

<br>
<br>

### chown command in linux

chown command is used to change the file or directory owenership.

Syntax: _**chown [username] [file_name]**_
