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

Exit command is used to stop the shell script 
