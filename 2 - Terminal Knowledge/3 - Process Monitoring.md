# Process Monitoring

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

- **Display all processes running in your system**
```
ps -A
```

- **Display all processes in full format**
  It display all process in long format.

```
ps -Af
```
Output

<img src="https://github.com/user-attachments/assets/376e5acf-3321-4c30-bc55-df8b9b3d3aba" width="700" height="170" >
