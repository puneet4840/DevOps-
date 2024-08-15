# Process Monitoring

## 1 - ps. 2 - top. 3 - htop. 4 - atop

### ps command

ps (Process Status) command is used to display imformation about current running processes in the system. When we use only ps without any options, it will display the running processes in your current terminal.

syntax
```
ps [option]
```

<br>

### What is a Process?

A process is a program on your system. When we run any application in our system, Operating System creates a process for that application becuase a process is an identity of an applicaion. An application is identified by the os by its process.

<br>

### Commands 

- **Display running process in your current terminal**
```
ps 
```
Output

<img src="https://github.com/user-attachments/assets/4366ab9f-a76f-4881-8bb4-f78ec7d20656" width="400" height="95" >

```
- PID: Process Id
- TTY: Terminal associated with the process.
- Time: The amount of CPU time a process has consumed. It means how long a process is being running.
- CMD: The command that was used to start the process.
```

<br>

- **Display all processes running in your system**
```
ps -A
```

<br>

- **Display all processes in full format**
  It display all process in long format.

```
ps -Af
```
Output

<img src="https://github.com/user-attachments/assets/376e5acf-3321-4c30-bc55-df8b9b3d3aba" width="700" height="150" >

```
- UID: User Id. It identifies which user is running the process.
- PID: Process Id. A unique identifier for the process.
- PPID: Parent Process Id. This shows which process started the current process.
- C: CPU Usage. This shows the percentage of cpu time used by the process.
- STIME: Start time of process. Indicates when the process was started.
- TTY: Terminal Type. Indicates the terminal from which the process was started.
- CMD: The command that was used to start the process.
```

<br>

- **Display process for all user in user-oriented format including which are not associated with your terminal**
```
ps aux
```
```
a: Display process for all users.
u: Display process in user-oriented format.
x: Display process that are not attached to your terminal. This includes background processes.
```

<br>

- **Filter the process**

We can use pipe symbol with ps to use ps output with other command input.

It display all process starting from page by page.
```
ps aux | more
```
<br>

It display all process run by user puneet.
```
ps aux | grep puneet
```

It display process belong to nginx server.
```
ps aux | grep nginx
```

<br>

- **To see the process by username**
```
ps -u puneet
```

- **List a process with tree structure**
```
ps axjf
```

<br>
<br>
<br>

## top

top command display the real-time view of process running in your system

Syntax
```
top
```
Output

<img src="https://github.com/user-attachments/assets/3016f17c-72d5-49c0-bf99-1bab52b8faa5" width="700" height="230" >

- **Interacting with top command**

You can interact with the top command using various keyboard shortcuts:

```
- q: Quit 'top'

- k: kill a process. You can kill a process by pressing key and type pid.

- P: sort the processes by CPU usage.

- M: sort the processes by Memory usage.

```
