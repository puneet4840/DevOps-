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

There are some predefined instructions to create a docker file.

**Syntax**:

```
INSTRUCTION arguments
```

