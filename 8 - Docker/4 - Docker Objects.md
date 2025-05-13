# Docker Objects

### DockerFile

A dockerfile is a simple text file which consists instructions to build docker image.

Dockerfile ek text file hoti hai jisme aap step-by-step instructions likhte ho ki Docker image kaise banayi jaye.

Is file ko docker build command ke zariye execute kiya jaata hai.

**Example of DockerFile**

```
# 1. Base image
FROM node:18

# 2. Create app directory
WORKDIR /usr/src/app

# 3. Copy package.json
COPY package*.json ./

# 4. Install dependencies
RUN npm install

# 5. Copy rest of the app code
COPY . .

# 6. App will listen on port 3000
EXPOSE 3000

# 7. Run the app
CMD ["node", "app.js"]
```

<br>

### Docker Image

Docker Image is the template which contains all the things that your app needs to work properly.

It contains application code, libraries and dependencies.

Docker Image ek read-only template hoti hai jisme application ko run karne ke liye sab kuch pre-configured hota hai: source code, dependencies, runtime, libraries, configuration, etc.

When we run a docker image, a container is created using that image.

Jab hum Dockerfile ko build karte hain to us Dockerfile se ek docker image generate ho jati hai. vah image ek tarah se ek application hoti hai aur hum us image se fir container create karte hain

```जब हम Dockerfile को build करते हैं तो उस Dockerfile से एक docker image generate हो जाती है. वह image एक तरह से एक application होती है और हम उस image से फिर container create करते हैं|```

<br>

### Container

A container is an isolated and seperate environment to run an application with all resources that application needed.

Docker Container ek running instance hota hai Docker image ka.

Container ek running application hota hai joki us application ke liye particularly ek os ki tarah hota hai.

Ek container mein:
- Aapka application chalta hai.
- Saath hi uska environment, dependencies, libraries hoti hain.

Jaise apne pc main application run karne ke liye code, libraries, files chaiye hoti hain vaise hi container main wahi sab hota hai application ko run karne ke liye.
