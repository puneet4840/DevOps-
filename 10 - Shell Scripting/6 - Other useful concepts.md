# Useful concepts

### Sleep command

Sleep command is used to pause the execution of the shell script.

```अगर आपको shell script के execution को कुछ time के लिए pause करना है, तो हम sleep command का use करेंगे|```

**Syntax**:
```
sleep DURATION
```
Exaplnation:
- ```DURATION``` ek number hota hai jisme aap specify karte ho kitni der ke liye pause chahiye. Default duration seconds hota hai.
- Aap time units bhi de sakte ho:
  - ```s``` = seconds (default hota hai agar kuch nahi diya).
  - ```m``` = minutes.
  - ```h``` = hours.
  - ```d``` = days.

**Example-1: 5 seconds ke liye rukna**
```
echo "Starting..."
sleep 5
echo "5 seconds later..."
```
Output:
```
Starting...
[5 seconds pause]
5 seconds later...
```

**Example-2: 1 minute ke liye rukna**
```
echo "Wait for 1 minute"
sleep 1m
echo "Time's up!"
```

<br>
<br>

### Exit command

Exit command is used to stop or terminate the shell script.

Shell script mein exit command ka use script ko terminate (band) karne ke liye kiya jata hai. Jab script exit command tak pahuchti hai, to uske baad ka koi bhi code execute nahi hota.

Iske saath aap ek numerical value (called "exit status" or "exit code") bhi return kar sakte ho jo system ya doosri scripts ko batata hai ki script successfully chali ya koi error aaya.

<br>

**Syntax**:
```
exit 
```
OR
```
exit [exit_status]  # optional
```
Explanation:
- ```exit_status``` = Ek number hota hai 0 se 255 ke beech main (0 to 255), jisse hum batate hain ki script kis state mein terminate hui:
  - ```0``` → Success.
  - ```1–255``` → Failure ya specific error codes.
 
- Agar aap exit ke status code main kuch bhi specify nahi karte ho, to default exit status pichhle command ka exit status hota hai.

<br>

**Example-1: Simple Script Using exit**:
```
echo "Script started"
exit 0
echo "This will not print"
```
Output:
```
Script started
```
Explanation:
- ```exit 0``` ke baad koi bhi command run nahi hoti.
- ```0``` batata hai ki script successfully complete hui.

**Example-2: Error Handling with exit, Checking if a file exists**
```
filename="myfile.txt"

if [ ! -f "$filename" ]; then
  echo "Error: $filename not found!"
  exit 1
fi

echo "$filename found, continuing..."
```
Explanation:
- Agar file exist nahi karti, to script ```exit 1``` se terminate ho jaati hai. ```1``` indicates an error.

<br>

**Note**:
- Agar aap ```exit``` command function ke andar likhte ho, to poori script wahin terminate ho jaati hai — function se nahi, balki script se exit hota hai.
- Agar aap ```exit``` ko kisi loop ke andar likh do, to poora script exit ho jaata hai, sirf loop nahi.

<br>
<br>

### $? variable in shell scripting

```$?``` **kya hota hai?**

```$?``` ek special built-in shell variable hai jo last executed command ka exit status ya return code store karta hai.

```जब कोई script या command run होती है उसका last exit status $? variable में स्टोर जाता होता है.```

<br>

**$? ka kaam kya hai?**:
- ```अगर $? के अंदर 0 store है तो इसका मतलब success है command सही चली|```
- Non-zero (jaise 1, 2, 127 etc.) → failure ya error (command mein kuch problem hui).

Ye value aap use kar sakte ho:
- Decision making mein (if condition).
- Logging/debugging.
- Retry mechanism.
- Script termination (exit) ke basis par.

<br>

**Example-1: Basic Example**
```
echo "Hello"
echo $?
```
Output:
```
Hello
0
```

**Example-2: Failure Case**
```
ls /folder/that/does/not/exist
echo $?
```
Output:
```
ls: cannot access '/folder/that/does/not/exist': No such file or directory
2
```
Explanation:
- ```ls``` command fail ho gayi kyunki path galat tha.
- Shell ne uska exit status ```2``` return kiya.
- Yeh value ```$?``` variable mein store ho gayi.

**Practical Example – Error Check in Script**:
```
cp myfile.txt /some/location/

if [ $? -ne 0 ]; then
  echo "Copy failed!"
  exit 1
else
  echo "File copied successfully!"
fi
```
Explanation:
- Agar ```cp``` command fail ho jaati hai to ```$?``` non-zero hota hai.
- Is basis par script error ya success ka message deta hai.

**Practical Example: Connectivity check script**:
```
#!/bin/bash


# This script will check connectivity to website

read -p "Enter the website you want to check connectivity: " web

ping -c 1 $web

if [[ $? -eq 0 ]]
then
        echo "Website successfully connected"
else
        echo "No Connectivity!!!"
        exit 1

fi
```

<br>

**How $? Works Internally?**:
- Shell har command ke execution ke baad uska exit status internally memory mein store karta hai.
- Jab aap echo ```$?``` likhte ho, to shell last stored value ko output karta hai.
- Lekin dhyan rahe: ```$?``` sirf last command ka result deta hai. Uske baad koi bhi aur command run karoge to wo value overwrite ho jaayegi.

**Example: Multiple Commands mein $? ka usage**
```
ls wrong_dir
echo "First status: $?"

date
echo "Second status: $?"
```
Output:
```
ls: cannot access 'wrong_dir': No such file or directory
First status: 2
Second status: 0
```
ExplanationL:
- ```ls``` fail hua – status 2.
- ```date``` success hua – status 0.
- ```$?``` ne dono ke alag-alag status correctly diya.

<br>

**Tip – set -e and $?**:

Jab aap script mein ```set -e``` likh dete ho, to script automatically exit ho jaati hai jab bhi kisi command ka exit status ```$? != 0``` hota hai.

Example:
```
#!/bin/bash
set -e

ls /wrong/path
echo "This won't run"
```

Is case mein ```$?``` check karne ki zarurat nahi – script khud terminate ho jaayegi.
