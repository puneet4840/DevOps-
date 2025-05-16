# Write Your Own Dockerfile

Below are the steps to write your own dockerfile from scratch.

**Step-1: Choose a Base Image (FROM)**

- In this First step, we Specifies the base image using ```FROM``` instruction.
- ```FROM``` se hum batate hain ki hum apni image kis base pe banana chahte hain. Ye ek already bani hui image hoti hai — jaise ubuntu, python, node, etc.
- Kyuki hum ek nayi image ground se banane ke bajaye ek existing, tested base image se shuru karte hain.
- Hamesha lightweight image use karne ki koshish karo jaise ```alpine``` or ```slim```.
- ```हमको base image अपने application के accroding choose करनी है, अगर हमारा application python मैं लिखा हुआ है तो python की base image choose करेंगे, अगर node मैं है तो node की, अगर java मैं है opnejdk. ऐसा इसलिए क्युकी उस application के लिए already एक environment मिल जाता है. हमको envrionemnt फिर से install करने की जरुरत नहीं होती|```

Examples:
```
FROM python:3.11-alpine
```

OR

```
FROM node:10-alpine
```

<br>

**Step-2: Set Working Directory**

- In this step
