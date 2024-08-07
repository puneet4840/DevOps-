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

![image](https://github.com/user-attachments/assets/879fdd56-0690-4a4b-9e22-e81fb115ee41)

### Structure of Linux Commands:

A linux command has mainly three parts: **Command Name + Options + Arguments**.

e.g., **cat** **abc.txt**  , here cat = command name, abc.txt = argument.

e.g., **cat** **-n** **abc.txt**   , here cat = command name, -n = option, abc.txt = argument. -n is the short option, we can give --number also.

![image](https://github.com/user-attachments/assets/9584c60f-2242-48b8-b6dc-643ecc13ecad)

**NOTE**: We can write multiple options and arguments in a single command. Options are written using - in any command.

e.g., **cat** **ncal** **2024** **-w** **-M**  OR  **cat** **ncal** **2024** **-wM**

<br>
<br>

### Get documentation of any command using CLI:

**man** -> It means _Mannual Pages_. This command gives you the complete details of any command you use in linux.

Suppose we do not know what cat command does. So we can se its documentation using man command.

e.g., **man cat**


![image](https://github.com/user-attachments/assets/4c9a942f-63db-4d03-bb05-5bad257c6ba7)

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


3: **ls -h**: It list all files and folder in human readable size. The size of files and folders is written in human readable language like kb, mb and gb.

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

1 - **mkdir [directory_name]**: This command is used to create directory or multiple directories.

2 - **mkdir -p [directory_name/directory_name]**: This command create nested directory. It means we can create a directory inside a directory.


**Create File**

**touch [file_name]**: This command is used to create file or change files timestamp of existing file. It means if we use touch command on an existing file, it change the time of file to when it was last accessed.
