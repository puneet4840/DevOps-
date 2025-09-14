# Restore deleted file using git


Agar apne galti se apna project folder ya koi file delete kar diya jo git ke through track ho rha tha, usko hum restore kar sakte hain.

### Command

- ```git restore```.


<br>


### git restore

```git restore``` command delete file ya folder last commit pe restore karne ke kaam aati hai.

Syntax:
```
git restore <file_name or folder_name>
```

Example:

Suppose apke working directory main ```add.py``` file bani hui hai, isko git track bhi kar rha hai aur aap is file ko delete kar dete ho to isko ```git restore``` command se restore kar sakte hain.

```
git restore add.py
```

- For directory:
```
git restore projects
```
