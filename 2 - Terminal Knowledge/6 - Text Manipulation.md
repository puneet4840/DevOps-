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

- **Search all line numbers in which 'life' word present in meditation text file.**
```
grep -in 'life' meditation.txt
```

- **Search a word 'life' in multiple files**
```
grep -i 'life' meditation.txt group.txt
```

- **Search a word 'life' in directories and sub-directories**

It will search a word 'life' present in all files present in /home/puneet directory.
```
grep -r 'life' /home/puneet
```

