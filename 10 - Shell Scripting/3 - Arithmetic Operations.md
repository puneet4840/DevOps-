# Shell Scripting Part-3

### Get input from a User

To get an input from a user, we use ```read``` instruction.

Syntax:
```
read <variable-name>
```

Example-1:
```
read name
echo "Your name is ${name}"

read age
echo "Your age is ${age}"
```

<br>

**To use instruction direclty inside read instruction**

```इसका मतलब है की directly read command को use करने पर user को कोई message नहीं दीखता की क्या input देना है, उसके लिए echo मैं उसे message लिखो लेकिन यहाँ हम read command मैं ही user को एक message भी दे सकते हैं की क्या input करना है|```

Syntax:
```
read -p <your-instruction> <variable-name>
```

Example-1: Get Name from user
```
read -p "Enter Your Name: " name
echo "Your name is ${name}"
```

Example-2:
```
read -p "Enter Your name here: " name
read -p "Enter you age here:  " age

echo "Your name is ${name} and age is ${age}"
```

<br>
<br>

### Arithmetic Operations

Arithmetic Operations are mathemetical operations which includes Addition, Substraction, Multiplication and Division. 

**Arithmetic Operators in Shell Scripting**

| Operator | Description                             | Example  |
| :------- | :-------------------------------------- | :------- |
| `+`      | Addition                                | `3 + 2`  |
| `-`      | Subtraction                             | `5 - 1`  |
| `*`      | Multiplication                          | `4 * 3`  |
| `/`      | Division                                | `8 / 2`  |
| `%`      | Modulus (remainder)                     | `5 % 2`  |
| `**`     | Exponentiation (in newer bash versions) | `2 ** 3` |


<br>

There are two methods to perform arithmetics operations:
- Using Let Command.
- Using (( )).

Syntax using let:
```
let variable-name=value operator value
```

Syntax using (( )):
```
variable-name=$((valur operator value))
```

<br>

**Addition**

Example:
```
a=10
b=2

let sum=a+b
echo "Sum using Let is: $sum"

echo "Sum using (( )) is:  $((10+2))"
```
Output:
```
Sum using Let is: 12
Sum using (( )) is: 12
```

<br>

**Substractions**

Example:
```
a=10
b=2

let sub=a-b
echo "Sub using let is:  $sub"

echo "Sub using (( )) is:  $((a-b))"
```
Output:
```
Sub using let is: 8
Sub using (( )) is: 8
```

<br>

**Multiplication**

Example:
```
a=10
b=2

let mul=a*b
echo "Multiplication usin let is:  ${mul}"

echo "Multiplication using (( )) is:  $((a*b))"
```
Output:
```
Multiplication using let is:  20
Miltiplication using $(( )) is:  20
```

<br>

**Division**

Example:
```
a=10
b=2

let div=a/b
echo "Multiplication using let is:  ${div}"

echo "Multiplication using (( )) is:  ${a/b}"
```
Output:
```
Division using let is:  5
Division using (( )) is: 5
```

<br>
<br>

### Conditional Statements

Conditional statements are used to execute a particular block of code if the condition is true otherwise skips the block of code if condition is false.

Conditional statements are decision making statements.

```Conditional Statements आपको ये decide करने की power देते हैं की कोई command या code block कब execute होगा और कब नहीं|```

Inka use aap decision making ke liye karte ho:
- Agar condition true hai → kuch karo.
- Agar false hai → kuch aur karo.

<br>

**Types of Conditional Statements**:

In Bash/shell scripting, the commonly used conditional statements are:
- if statement.
- if-else statement.
- if-elif-else statement.
- nested if statements.
- case statement (switch alternative).

<br>

**Conditional Expressions and Tests**

Conditions inside these statements can test:
- String values.
- Numeric values.
- File properties.
- Command exit status.

They typically use:
- ```[ ]``` (test command).
- ```[[ ]]``` (advanced Bash test).
- ```(( ))``` (for arithmetic).

<br>

**Operators in shell scripting**

1 - String Comparison Operators:

| Operator | Description                  |
| :------- | :--------------------------- |
| `=`      | Equal to                     |
| `!=`     | Not equal to                 |
| `-z`     | String is null (zero length) |
| `-n`     | String is not null           |


2 - Numeric Comparison Operators:

```
Equal: ==
Greater Then: -gt
Less Then: -lt
Greater Then Equals To: -ge
Less Then Equals To: -le
Not Equals to: !=
```

3 - File test operators:

| Operator  | Description                   |
| :-------- | :---------------------------- |
| `-e file` | Checks if file exists         |
| `-f file` | True if it's a regular file   |
| `-d dir`  | True if it's a directory      |
| `-s file` | True if file size is non-zero |
| `-r file` | Readable                      |
| `-w file` | Writable                      |
| `-x file` | Executable                    |

<br>

**Syntax of Conditional Statement**

**1 - if statement**:

```
if [ condition ]
then
  # commands if condition is true
fi
```

Example:
```
age=18
if [ $age -ge 18 ]
then
  echo "You are eligible to vote."
fi
```

<br>

**2 - if-else statement**

```
if [ condition ]
then
  # commands if true
else
  # commands if false
fi
```

Example:
```
read -p "Enter you age:  " age

if [ $age -ge 18]
then
  echo "You are eligible to vote"
else
  echo "You can not vote!!!"
fi
```

<br>

**3 - if-elif-else statement**

This if-elif-else statement is used when you have multiple conditions.

```
if [ condition1 ]
then
  # commands
elif [ condition2 ]
then
  # commands
else
  # commands
fi
```

Example:
```
read -p "Enter you marks: " marks

if [ $marks -ge 90 ]
then
        echo "You are brilliant and have grade A."
elif [ $marks -ge 80 ]
then
        echo "You are good student and have grade B"
elif [ $marks -ge 60 ]
then
        echo "Thik Thik hai, lekin mehnat kar"
else
        echo "Padhle!!!, Tujhe padhne ki jaruat hai"
fi
```

<br>

**Logical Operators**:

Logical operators are used to test multiple conditions. Logical operators allow you to combine multiple test conditions in a single if statement.

```If statement मैं अगर multiple conditions check करनी है तो logical operators का use करेंगे|```

Three logical operators:
- AND (```&&``` , ```-a```):
  - ```अगर दोनों condition TRUE हुई तो ये true होगा और code run हो जायेगा otherwise code run नहीं होगा.```
- OR (```||``` , ```-o```):
  - ```अगर दोनों conditions मैं से एक भी condition TRUE होती है तो ये true होगा और code run हो जायेगा|```
- NOT (```!```):
  - It reverts the condition. ```ये TRUE को false करता है और FALSE को true करता है.```

Note: Logical operators can be used with ```[ ]``` signle square brackets or with double ```[[  ]]``` square brackets for advancements.

<br>

**AND Operator (&&)**:

AND operator is used to check if both conditions in if statement is true.

Syntax:
```
if [[ condition-1 && condition-2 ]]
then
    # execute command if both are true
fi
```

Example:
```
# Example is you can only vote if your age is greater than equal to 18 and you are from india.

read -p "Enter your age: " age
read -p "Enter your country: " country

if [[ $age -ge 18 && $country == 'India' ]]
then
    echo "You can vote."
else
    echo "You can not vote."
fi
```

<br>

**OR operator (||)**:

OR operator is used to check if onw of the two conditions in if statement is true. ```इसका मतलब if statement मैं दो condition मैं से अगर एक भी true होती है तो if condition true होगी और code run हो जायेगा|```

Syntax:
```
if [[ condition-1 || condition-2 ]]
then
    # execute command if one is true
fi
```

Example:
```
# Checking if a character is vowel or not.

read -p "Enter a character only: " char

if [[ $char == 'a' || $char == 'e' || $char == 'i' || $char == 'o' || $char == 'u' ]]
then
        echo "Character is a Vowel."
else
        echo "No Vowel"
fi
```

