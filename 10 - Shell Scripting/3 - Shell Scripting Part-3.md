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

