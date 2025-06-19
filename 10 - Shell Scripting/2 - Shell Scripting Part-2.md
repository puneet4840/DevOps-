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
