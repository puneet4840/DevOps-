# Docker Image

Docker Image is the template which contains all the things that your app needs to work properly.

A Docker image is a read-only, portable, lightweight, standalone template used to create Docker containers.

It has everything your application needs to run:
- The operating system files.
- Application source code.
- Required libraries and dependencies.
- Environment configurations.
- A default command to start your app.

<br>

### How a Docker Image Works (Step by Step)

An image is built using a Dockerfile.

A Dockerfile is a text file containing instructions like:
- What base image to start with.
- What files to copy.
- What commands to run.

Example:
```
FROM node:18-alpine
WORKDIR /app
COPY . /app
RUN npm install
CMD ["node", "server.js"]
```

Docker reads the Dockerfile and builds an image.

When you run:
```
docker build -t myapp-image
```

Docker follows the instructions line-by-line and creates a new image layer for each instruction.

Layers make images efficient and easy to cache and reuse.

For example:
- One layer for ```FROM node:18-alpine```.
- One layer for copying files.
- One layer for running ```npm install```.
- One layer for the final ```CMD```.


The final image is saved on your system (Docker image cache).

You can list all your local images with:
```
docker images
```

And you’ll see something like:
```
REPOSITORY   TAG       IMAGE ID       SIZE
myapp-image  latest    abc123def456   90MB
node         18-alpine 789xyz000abc   60MB
```

A container is created from an image.

You start a container by running:
```
docker run -p 3000:3000 myapp-image
```

This takes the image, creates a new writable container layer on top of it (for temporary data), and starts the application.

The image itself never changes — it's read-only.
