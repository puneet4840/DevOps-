# Function in Shell Scripting

Function is a reusable block of code within a script that performs a specific task. Instead of writing the same code repeatedly, you can write it once in a function and call it whenever needed.

```Function एक block होता है जिसमे आप एक specific task के लिए code लिखते हो और उसको जब चाहो call कर सकते हो multiple times| अगर आपको एक ही code को बार लिखना है तो उसका सबसे अच्छा तरीका है की एक function बना दो और उसको call करलो जहा भी code फिर से लिखना है|```

### Define a function

Syntax:
```
function_name() {
    # code block
}
```

Example:
```
greet_user() {
    echo "Hello, This is a function"
}
```

<br>

### Call a function

Simply write the function_name to call a function.

Syntax:
```
function_name
```

Example-1:
```
greet_user
```

Example-2: Complete function example
```
greet_user() {
    echo "Hello Puneet, This is a function here."
}

greet_user
```
Output:
```
Hello, THis is a function
```

<br>

### Functions ke andar Variables use karna

We can define and use variables inside the function.

Example:
```
print_name() {
    name="Puneet"
    echo "Your name is $name."
}

print_name
```
Output:
```
Your name is Puneet.
```

<br>

### Function mein Arguments Dena (Positional Parameters)

Jab aap function call karte ho aur uske saath kuch values (data) pass karte ho, unhe arguments kehte hain. Ye arguments function ke andar use kiye ja sakte hain jaise ki aap script ke arguments use karte ho (```$1```, ```$2```, etc.).

**Arguments inside the function**:

```Function के अंदर arguments ```$1```, ```$2```, ```$3``` इस तरीके से डिफाइन किये जाते हैं|``` 

```अगर हमको function के अंदर कोई value देनी है किसी task के लिए तो उस value को हम function call मैं pass करेंगे|```

```अगर हम funtion call मैं एक value दे रहे हैं तो वो function के अंदर $1 से access होगा, अगर दूसरा function मैं दूसरा value दे रहे हैं तो $2 से access होगा. Function के अंदर arguments को $ और argument number से access किया जाता है|```

```$<argument_number>```

Syntax:
```
function_name() {
    echo $1
    echo $2
    .
    .
    echo $n
}
```
In above syntax I have just print the arguments passed to function but you can use these arguments in any way but the way to access these arguments is using ```$<argument_number>```.

Function ke andar:
- ```$1``` = pehla argument.
- ```$2``` = dusra argument.
- ```$@``` = sabhi arguments (array jaisa).
- ```$#``` = total number of arguments.

<br>

**Passing values to function call**:

```Function के अंदर arguments को use करने के लिए पहले उन arguments को हमको function call मैं देना होगा, तब वो function मैं pass होती है|```

Syntax:
```
function_name arg1 arg2 ...
```
<br>

Example: Passing name and age to function
```
myfun() {

    echo "Your name is: $1"
    echo "Your age is $2"
}

myfun Puneet 25
```
Output:
```
Your name is Puneet
Your age is 25
```

