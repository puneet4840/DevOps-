# Text Manipulation

## grep command

grep command is used to search a text inside a text file.

Syntax:
```
grep [option] <pattern> <file_name>
```

- pattern: String or text you want to search.
- file_name: The file in which you want to search.


e.g.,

- **Search a word _life_ in meditation text file.**
```
grep 'life' meditation.txt
```

- **Search all _life_ word in meditation text file. (-i means Case-Insensitive)**
```
grep -i 'life' meditation.txt
```

- **Search all line numbers in which _life_ word present in meditation text file.**
```
grep -in 'life' meditation.txt
```

- **Search a word _life_ in multiple files**
```
grep -i 'life' meditation.txt group.txt
```

- **Search a word _life_ in directories and sub-directories**

It will search a word 'life' present in all files present in /home/puneet directory.
```
grep -r 'life' /home/puneet
```

<br>
<br>

## sort command

sort command is used to sort the content inside text file.

Syntax: 
```
sort [option] <file_name>
```

e.g.,

- **Sort the content inside file alphabetically**

The default behavior of sort is to sort lines alphabetically.
```
sort fruits.txt
```

- **Sort the content inside file in reverse order**
```
sort -r fruits.txt
```

- **Sort the numerical content inside file numerically**
```
sort -n number.txt
```

