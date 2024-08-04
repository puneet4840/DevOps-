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

e.g., **cat** **ncal** **2024** **-w** **-M**

                  OR

**cat** **ncal** **2024** **-wM**

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Get documentation of any command using CLI:

**man** -> It means _Mannual Pages_. This command gives you the complete details of any command you use in linux.

Suppose we do not know what cat command does. So we can se its documentation using man command.

e.g., **man cat**


![image](https://github.com/user-attachments/assets/4c9a942f-63db-4d03-bb05-5bad257c6ba7)

In the above picture we can see the docs of cat command.
