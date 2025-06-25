# set -e command

This ```set -e``` command is used to exit the shell script immediately if any command gets falied in your script.

```जब भी command कोई shell script मैं fail हो जाती है, तो ये set -e command तुरंत ही उस shell script को exit कर देती है|```

Agar script mein koi bhi command fail ho jaati hai (yaani exit code 0 ke alawa kuch bhi return karti hai), to script turant wahin ruk jaayegi — uske baad ka koi bhi command execute nahi hoga.

Syntax:
```
set -e
```

We write this command after the she-band line in shell script.

<br>

**By Default Shell Ka Behavior**

Normally, agar aap ek script likhte ho bina ```set -e``` ke, to:
```
#!/bin/bash

echo "Start"
false
echo "Still running"
```

Output:
```
Start
Still running
```

Explanation:
- ```false``` command fail hoti hai (exit code 1).
- Phir bhi script Still running print kar deti hai.
- Yaani script fail ke baad bhi chali jaati hai.

<br>

**set -e Enable Karne Par Behavior**:

```
#!/bin/bash
set -e

echo "Start"
false
echo "This will never run"
```

Output:
```
Start
```

Explanation:
- ```false``` command fail hui (exit code 1).
- Shell ne dekha ```set -e``` active hai, to script turant exit ho gayi.
- "This will never run" kabhi execute nahi hua.
