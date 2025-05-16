# Write Your Own Dockerfile

There are multiple steps we use to write docker file. Steps are:
- Choose a Base Image.
- Set Working Directory.
- Copy files into image.
- Install Dependencies.
- Expose Network Ports.
- Specify default command.

<br>

Below are the steps to write your own dockerfile from scratch.

<br>

**Step-1: Choose a Base Image (FROM)**

- In this First step, we Specifies the base image using ```FROM``` instruction. Firstly, we have to write ```FROM``` instruction in Docerk file.
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

**Step-2: Set Working Directory (WORKDIR)**

- In this step, We have to set the working directory inside the container.
- ```WORKDIR``` se hum container ke andar ek folder set karte hain, jismein baaki ke commands chalenge. Aur application code isi directory main copy hota hai.
- We use this because Taaki saare files ek jagah pe rahein, aur baar baar directory change na karni pade.

Examples:
```
WORKDIR /app
```

OR

```
WORKDIR /usr/app
```

<br>

**Step-3: Copy Files into the Image (COPY)**

- In this step we copy files from our local machine (project directory) into image's file system, when we create docker container from image, so those files can be seen in your container's working directory.
- ```COPY से हम अपने local machine से files या application के code को container के अंदर ले जाते हैं. जो हमने working directory पिछली command मैं सेट की थी उसी path पर ये files store हो जाती हैं.``` 

Syntax:
```
COPY <source_path_on_host> <destination_path_in_container>
```

Example:
```
COPY . /app
```

OR

```
COPY app.py /app
```

<br>

**Step-4: Install Dependencies (RUN)**

- In this step, we have to install the required libraries that our application needs inside image's file system using ```RUN``` instruction. When we create container from image. So, those libraries are automatically installed in the container.
- ```RUN instruction से हम container के अंदर libraries install करते हैं, जो भी हमारे application को run होने के लिए चाइये होती हैं. वैसे तो ये libraries docker image के file system मैं install होती है लेकिन जब हम image से container बनाते हैं तो container बनाने के बाद वो libraries automatically container मैं install हो जाती हैं.```

- Combine commands with && to reduce the number of image layers and make builds faster.

Example:
```
RUN apt-get update && apt-get install -y python3
```

<br>

**Step-5: Expose Network Ports (EXPOSE)**

- We use this ```EXPOSE``` instruction to informs Docker that the container will listen on the specified network port at runtime. But in actual this statement in dockerfile does not expose any port. It is only for documentation purpose.

Example:
```
EXPOSE 8080
```

<br>

**Step-5: Specify Default Command (CMD)**

- In this step we use ```CMD`` to define the default command that runs when a container is started from the image.
- ```ये हम इसलिए लिखते हैं ताकि container start होते ही हमारी app या program चल जाए. क्युकी हमको पता है की जब local machine पर अपने application को run करते हैं तो एक command से run करते हैं. तो वोही same command इस CMD मैं लिखी जाती है जिससे जब container start हो तो उसी command से container के अंदर application भी run हो जाये और हमारा application container के अंदर चल जाये .```

Example:
```
CMD ["python3", "app.py"]
```

- ```जैसे python की file को run करने के लिए हम python file_name का use करते हैं|```


<br>
<br>

# Example (LAB): Containerizing a Simple Python App

**Scenario**: This python app is a simple python code which is returing the current date.

**Directory structure**:
```
/my-python-app
 ├── app.py
 └── Dockerfile
```

<br>

**app.py** File

```
from datetime import date

current_date=date.today()

print("Current Date is: ",current_date)
```

<br>

**Dockerfile**

```
# 1. Choose base image
FROM python:3.11-alpine

# 2. Set working directory
WORKDIR /app

# 3. Copy python file into container
COPY app.py /app

# 4. Default comand to run the app
CMD ["python3","app.py"]
```

<br>

**Build & Run the Dockerfile**

Build docker image:
```
docker build -t today_date:v1 .
```

Run the container:
```
docker run today_date:v1
```

<br>

**Output**:

Current Date is:  2025-05-16
