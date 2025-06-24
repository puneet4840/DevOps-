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

