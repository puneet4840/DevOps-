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
- VOLUME
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
- Sets the current directory for RUN, CMD, ENTRYPOINT, COPY, and ADD.
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
