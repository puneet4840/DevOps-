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
