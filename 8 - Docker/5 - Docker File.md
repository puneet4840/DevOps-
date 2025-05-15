# DockerFile

DockerFile is a text file in which we write some instructions to create a docker image.

Dockerfile is a text file which consists instructions to build a docker image.

Dockerfile ek text file hoti hai jisme aap step-by-step instructions likhte ho ki Docker image kaise banayi jaye.

Docker Files are basically scripts in which you can write some instructions and then build into an image then the image can be run to create a container.

<br>

### How does it works?

- You create a file with the name ```DockerFile```.
- Then you build that Dockerfile and an docker image is generated.
- You run that docker image and a container is created.


If you have a Microservice architecture project where you have multiple service and you are creating dockerfile for each service. So, you can simple give ```service_name.dockerfile```.

<br>

### What to write in Docker File

There are some predefined instructions to write in a docker file.

**Syntax**:

```
INSTRUCTION arguments
```

**Instructions**:
- FROM
- LABEL
- WORKDIR
- COPY
- RUN
- EXPOSE
- ENTRYPOINT
- CMD

<br>
<br>

### FROM:
- FROM specifies the base image for your container.
- FROM defines the base image from which the Docker image will be built.
- A base image is the starting point for your docker image and provides a base operating system and environment to your container.
- You can use the base image based on your programming language you are using.

Ye batata hai ki tumhare Docker image ko kis base image se start karna hai. Tumhe ek base chahiye, jisse tumhara app chal sake.

Example: Agar tum Python application bana rahe ho, toh tumhe Python ka image chahiye hoga.

**Kyu use hota hai?**:
- Docker ko batana padta hai ki:
  - “Mujhe ek Python/Linux/Node.js waala environment chahiye — usi par mera code chalega.”
 
- Base image se tumhe wo environment mil jata hai jo tumhare app ko chalane ke liye zaroori hota hai. Agar tum start se sab kuch install karte, toh time waste hota aur errors ka chance badhta.
 
e.g.,
```
FROM python:3.11
```

Iska matlab hai ki tum Python 3.11 waale image ko base bana rahe ho.

e.g.,
```
FROM node:18-alpine
```
Yahaan, node:18-alpine ka matlab hai tum Node.js version 18 ka alpine version use kar rahe ho, jo lightweight hai.

**Tips**:
- Specific version use karo, jaise python:3.11, node:18, kyuki agar tumne apne code main python:3.11 use kiya hai aur base image python:latest use karli to errors aa sakte hain.
- Use ```alpine``` and ```slim``` version for you base image because these versions are lightweight and image size will be low.

<br>

### LABEL:

- LABEL is used to add some key-value pair metadata about your image -  jaise ki image ko kisne banaya, image ka version kya hai, etc.
- It is just used for information like in future any unknow person see your dockerfile, he or she will able to know who created that image.
- This instruction does not affect your image.

**Kyu use karte hain?**:
- Ye image ke baare mein important info ko track karne ke liye hota hai, jaise maintainer, version, etc. Agar tum shared environment mein kaam kar rahe ho, toh ye useful ho sakta hai.

**Kaise likhna hai?**

```
LABEL maintainer="puneet@example.com"
LABEL version="1.0"
```

OR

```
LABEL maintainer="devops@company.com"
LABEL description="Node.js application"
```

**Tips**:
- Labels se tum easily image ke baare mein information fetch kar sakte ho docker inspect command se.

<br>

### WORKDIR

- WORKDIR is used to set the current working directory for your container.
- It sets the current directory for RUN, CMD, ENTRYPOINT, COPY, and ADD.
- We have to set a place where the code and dependencies of your application reside in the container. So, first we specify a working directory so that the code can go to that place inside the container.
- ```We know that की container एक seperate environment होता है, तो उस container मैं application run करने के लिए हमको application का data container के अंदर डालना होगा इसलिए जो भी working directory मैं path हम लिखेंगे वहां पर हमारी application जाकर store हो जाएगी|```

**Kyu use karte hain?**:
- Jab tum commands run karte ho, toh tumhe har bar full path nahi likhna padta. Tum ek baar directory set kar lo, baad mein relative paths use kar sakte ho.
- Jaise hum RUN, CMD jaisi command dockerfile main likhte hain to vo command isi jagah par run hoti hain.

**Kaise likhna hai?**:
```
WORKDIR /app
```

This means a folder is created at root level with name app.

**Tips**:
- Agar WORKDIR specified folder nahi hai, toh Docker automatically usse bana leta hai.
- Agar tumhe ek se zyada directories chahiye, toh multiple WORKDIR likh sakte ho.

<br>

### COPY

- COPY is used to copy the files and folders from you local machine into container.
- COPY ka use tum apni local machine se files ya directories ko container ke andar copy karne ke liye karte ho.
- ADD bhi wahi kaam karta hai, lekin ye extra functionality bhi provide karta hai — jaise ki tar files ko extract karna ya remote URLs se files ko download karna.
- ```WORKDIR command मैं हमने working directory specify की थी, इस command के through हमारी application उसी working directory पर जाकर copy हो जाएगी, जो हमने path दिया था|```

**Kaise Likhna Hai?**
```
COPY <source> <destination>
ADD <source> <destination>
```

Example:
```
COPY . /app
ADD app.tar.gz /app/
```

- Here . in copy instruction means copy everything from current folder.
- Yahaan, COPY tumhare current folder ko /app mein copy karta hai, aur ADD .tar.gz file ko /app/ mein extract kar ke daalta hai.
  
**Tips**:
- COPY ka use karo agar tum sirf files ko copy kar rahe ho. ADD ka use tab karo jab tum compressed files extract karna ho ya URLs se files copy karna ho.
- ```.dockerignore``` file ka use karo taaki unwanted files ko image mein copy hone se roka ja sake (jaise .git, node_modules etc).

<br>

### RUN

- The RUN instructions executes shell commands inside the container during build time. This is where you can install software, libraries or dependencies that you application needs to run inside a container.
- RUN ka use tum container build time pe commands execute karne ke liye karte ho. ```जैसे किसी application को पहली बार run करने से पहले कुछ libraries और dependencies install करनी पड़ती हैं. तो इस step मैं application के लिए वही सब dependencies container के अंदर install करनी पड़ती हैं|```

**Kaise Use karna Hai**
```
RUN <command>
```

Example:
```
RUN apt update && apt install -y curl
```

**Tips**:
- Best practice here includes chaining commands to reduce the number of image layers (each RUN creates a new layer) and cleaning up temporary files and cache to reduce final image size. For example:
  ```
    RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*
  ```

- Multiple commands ko ek hi RUN statement mein likho. Jaise:
  ```
  RUN apt update && apt install -y curl && rm -rf /var/lib/apt/lists/*
  ```

<br>

### Expose

- EXPOSE instruction is used to document the port number the application will listen on runtime. It does not publish the port — that’s done via ```-p``` at ```docker run```.
- ```EXPOSE instruction को application के port number को document करने के लिए लिखते हैं, इसको लिखने से container पर कोई फरक नहीं पड़ता है, ये instruction सिर्फ user को बताने के लिए होता है की application मैं इस port number का use किया गया है|```

Example:
```
EXPOSE 5000
```
OR

```
EXPOSE 5000/tcp
```

<br>

### ENTRYPOINT

- The ENTRPOINT specifies the command that will always be executed when a container starts. To start an application inside a container we use ENTRYPOINT instruction.
- The ENTRYPOINT instruction defines the primary command to run when a container starts.
- Ye instruction container start hone par run karta hai aur is instruction main application ko run karne ke liye command likhi hoti hai. Iska matlab jab ye instruction run hota hai to application ko run karta hai.
- The commnds given to ENTRYPOINT can not be overridden using docker run commnds. This is the speciality of this instruction.
- Is instruction main jo commands di jati hain usko hum docker run ke time par override nahi kar sakte iska matlab agar docker file ke ENTRYPOINT main jo bhi command humne mention kar di vo baad main bhi change nahi ki ja sakti hain.

**Kyu use karte hain?**:
```
ENTRYPOINT ["executable", "arg"]
```

Example:
```
ENTRYPOINT ["python", "app.py"]
```

It will start app.py file inside the container.

<br>

### CMD

- The CMD instruction in a Dockerfile specifies the default command to execute when a container starts from the image. It means to start an application inside a container we use CMD instruction.
- ```अगर container start होने पर अपनी application run करनी है तो हम CMD instruction का use करेंगे. इस instruction मैं वो कमांड दी जाती है जो एप्लीकेशन को स्टार्ट करती है. और ये डिफ़ॉल्ट कमांड होती है|```
- This is the default command we give in CMD which means the command given in CMD can be overridden during docker run.
- Iska matlab docker run karte time bhi hum CMD ke ander command ko replace kar sakte hain.

**Kyu use karte hain?**:
- Ye tumhe batata hai ki container ko start karte waqt kya run hona chahiye.

**Kaise likhna hai?**:
```
CMD ["command", "arg1"]
```

Example:
```
CMD ["python", "app.py"]
```

**Tips**:
- Sirf ek CMD hona chahiye, agar multiple honge toh last wala hi run hoga.
- Tum docker run command se override bhi kar sakte ho.


<br>
<br>

### Example of Docker File

```
# Start with Python 3.11 base image
FROM python:3.11-slim

# Label the image
LABEL maintainer="you@example.com"

# Set working directory
WORKDIR /app

# Copy only requirements first (to leverage cache)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy rest of the files
COPY . .

# Expose port 5000
EXPOSE 5000

# Set an environment variable
ENV ENVIRONMENT=production

# Run the app
CMD ["python", "app.py"]
```

<br>

### How to build a Docker file

Syntax:
```
docker build -t <image_name>:<tag_name> .
```

Explanation:
- ```docker build``` to build a file.
- ```-t``` is tag name for a image.
- ```<image_name>```: Image name.
- ```<tag_name>```: Tag name.
- ```.``` means take the docker file from current directory. Current directory mein Dockerfile ko use karo.

<br>

### How to Build a Dockerfile and Create a Docker Image

Steps to Build a Dockerfile

**Create a Dockerfile**:
- Make a new file named Dockerfile (without any extension).
- Write your instructions inside it.

Example Directory Structure:
```
/my-project/
├── Dockerfile
├── app.py
├── requirements.txt
```

**Write Instructions in Dockerfile**:

Example Dockerfile:
```
FROM python:3.11-slim             # Use base image
LABEL maintainer="you@example.com" # Image info
WORKDIR /app                       # Set working directory inside container
COPY requirements.txt .            # Copy file into container
RUN pip install --no-cache-dir -r requirements.txt  # Install dependencies
COPY . .                           # Copy all project files
EXPOSE 5000                        # Expose port
CMD ["python", "app.py"]           # Run app when container starts
```

**Build the Docker Image**:

Command:
```
docker build -t image-name:tag-name .
```

Explanation:
- ```docker build``` → Build an image.
- ```-t image-name``` → Give a tag and name to the image.
- ```.``` → Use current directory (where Dockerfile is).

Example:
```
docker build -t my-python-app:latest .
```

**Check the Created Image**:

Command:
```
docker images
```

This will list all available images on your system.

**Run a Container from the Image**:

Command:
```
docker run -d -p host-port:container-port --name container-name image-name
```

Explanation:
- ```-d``` → Run in detached (background) mode. It will not block your current shell.
- ```-p``` → Map port from container to host. Using this you can access your application on host ip and port.
- ```--name``` → Set a name for the container.
- ```image-name``` → Name of the image to run.

Example:
```
docker run -d -p 5000:5000 --name my-container my-python-app
```

