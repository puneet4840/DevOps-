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

