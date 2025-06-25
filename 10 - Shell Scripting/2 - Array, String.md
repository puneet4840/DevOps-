# Shell Scripting Part-2

### Arrays in Shell Scripting

Array is a variable that is used to store multiple values. 

Each value in an array is identified by an index number, starting from ```0```. Values are space seperated in array.

Arrays are a fundamental data structure in shell scripting that allow you to store multiple values in a single variable.

Values in the array can be of different data types.

```Array एक ऐसा variable होता है जो एक time पर एक से ज़्यादा values store कर सकता है| Shell scripting में array का index 0 से स्टार्ट होता है| Array मैं values space-seperated होती हैं|```

Syntax:
```
<array_name>=(value1 value2 valeu3 ...)
```

Example:
```
myArray=(1 20 30.5 "Puneet" "Hello buddy!")
```
Values are space-seperated in array.

<br>

**Defining an Array**:

Syntax:
```
array_name=(value1 value2 value3 ...)
```

Example:
```
fruits=("apple" "banana" "cherry" "mango")
```

This creates an array named ```fruits``` with 4 elements:
- fruits[0] = apple.
- fruits[1] = banana.
- fruits[2] = cherry.
- fruits[3] = mango.

<br>

**Accessing Array Elements**:

Syntax:
```
${array_name[index_value]}
```

Example-1:
```
echo "${frutis[0]}"
```
Output: ```apple```

Example-2:
```
#!/bin/bash

elements=(1 20 30.5 "Puneet" "Hey Buddy!")

echo "Value at 2nd position ${elements[2]}"

echo "Value at 4th position ${elements[4]}"
```

Output:
```
Value at 2nd position 30.5

Value at 4th position Hey Buddy!
```

<br>

**Print All Elements in Array**

Syntax:
```
${array_name[*]}
```

Example-1:

Print all values in array
```
echo ${myArray[*]}
```

Example-2:
```
#!/bin/bash

# Print all values in array

myArray=(1 20 30.5 "Puneet")

echo "All values o array are: ${myArray[*]}"
```

<br>

**Length of Array**

Syntax
```
${#array_name[*]}
```

Example-1:
```
echo "${#myArray[*]}"
```

Example-2:
```
#!/bin/bash

# Length of the Array
myArray=(1 20 30.5 "Puneet")

echo "${#myArray[*]}"
```

<br>

**Slice the Array**

Slicing the array means to retrieve the values from start of index to end of the index. e.g., the values start from 3rd index to 5th index.

Syntax:
```
"${array_name[*]:start_index:number of values}"
```
Here,
- number of values means ```की start index से कितनी values तुम slice करना चाहते हो, जैसे की अगर 2 values करनी हैं तो 2 लिखेंगे, अगर 4 values slice करनी है तो 4 लिखेंगे. यहाँ index नहीं लिखी जाती है|```

Example-1:
```
echo "${myArray[*]:2:2}"
```
```2:2``` means that from the 2nd index take next 2 values.

Example-2:
```
#!/bin/bash

# Slice the array

myArray=(1 20 30.5 "Puneet" "Hey Buddy!")

echo "Sliced Values from 1st index to 3rd index are: ${myArray[*]:1:3}"
```

<br>
<br>

### String in Shell Scripting

String is a variable which stores the sequence of characters.

OR

String is the sequence of characters enclosed within single quotes (' '), double quotes (" "), or sometimes no quotes. In shell scripting, strings can contain letters, numbers, symbols, and whitespace.

```String एक ऐसी value होती है जो characters का sequence होता है - जैसे```:\
```
"hello world"
'DevOps'
ThisIsAString123
```

Shell ke liye, jab aap koi variable banate ho:
```
name="Puneet"
```
To ```name``` ek string variable hota hai, aur ```"Puneet"``` uski value hoti hai.

NOTE: ```Bash में by default सारे variables string होते हैं - जब तक आप उन्हें explicitly math या integer context में न ले जाएँ.```

<br>

**Defining a string**

Syntax:
```
Way-1: Without Quotes:

greeting=Hello


Way-2: With Single Quotes:

greeting=hello


Way-3: With Double Quotes

name="Puneet"
greeting="Hello $name, How are you!"
```

Note:
- ```String को double quotes मैं define करने पर string मैं variable use कर सकते हैं और command को भी use कर सकते हैं, लेकिन single और Without quotes वाली स्ट्रिंग मैं ऐसा नहीं कर सकते|```
- Always use double-quotes string.

Example:
```
name="Puneet"

age="25"
```

<br>

**Length of String**

Syntax:
```
${#<string-name>}
```

Example-1:
```
name="Puneet"
echo "Length of string is:  ${#name}"
```
OutPut:
```
Length of string is: 6
```

Example-2:
```
#!/bin/bash

myString="Hey Puneet, How are you!"
echo "Length of ${myString} is:  ${#myString}"
```
OutPut:
```
Length of Hey Puneet, How are you! is: 24
```

<br>

**Convert String into Upper Case**

To convert string into upper case letters, use ```^^``` (quotes) sign just after the string name.

Syntax:
```
${string-name^^}
```

Example-1:
```
myString="Hey Puneet, How are you!"
echo "Upper Case string is:  ${myString^^}"
```
Output:
```
Upper Case string is:  HEY PUNEET, HOW ARE YOU!
```

<br>

**Convert String into Lower Case**

To convert string into lower case letters, use ```,,``` sign just after the string name.

Syntax:
```
${string-name,,}
```

Example-1:
```
myString="Hey Puneet, How are you!"
echo "Lower Case string is:  ${myString,,}"
```
Output:
```
Lower Case string is:  hey puneet, how are you!
```

<br>

**Replace the string**

```Replace the string का मतलब है की एक word को दूसरे word से replace करना|```

Syntax:
```
${string-name/जिस वर्ड को replace करना चाहते हो/जिस वर्ड से replace करना चाहते हो }

${string-name/actual word in string/word you want to replace}
```

Example-1:
```
greeting="Hey Buddy!"
echo "Replace String is:  ${greeting/Buddy/Puneet}"
```
Output:
```
Replaces String is: Hey Puneet
```
Buddy has been replaced by Puneet.

<br>

**Slicing the String**

Slicing means retrieve a part from the string.

Syntax:
```
${string-name:start index of sliced string:length of the sliced string}
```
Note: ```String को slice करने के लिए पहले जहा से string slice करनी होती है वो index value लेनी है दूसरा जहा तक की string हमको चाइये उतनी length हम दे देंगे|```

Example-1:
```
myString="Hey Puneet, How are you!"

# Slice the word Puneet from above string

echo "Sliced string is:  ${myString:4:6}"
```
Output:
```
Sliced string is:  Puneet
```

Note: ```Uper string मैं Puneet word 4th index से शुरू हो रहा है और इसकी length 6 है|```

