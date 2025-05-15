# Docker Image Layer Mechanism

### What is a Docker Image?

A Docker image is a read-only template used to create Docker containers.

It contains:
- A minimal operating system.
- Any software or libraries needed.
- Your application files.
- Configuration and instructions to run your app.

A Docker image is built using a file called a Dockerfile.

<br>

### What is a Layer?

When Docker reads your Dockerfile, it processes each line one by one. When you run ```docker build``` command to create a docker image from it.

A layer is a set of changes to the file system — like added, modified, or deleted files.

- Each command in the Dockerfile like (```FROM```, ```COPY```, ```RUN```, ```WORKDIR```, ```CMD```) creates a new “layer.”
- A layer is like a snapshot of the file system at that stage.
- These layers stack on top of each other to form the final image. Layers ek ke uper ek hoti hain aur ek final image banati hain.

Layers are immutable (cannot be changed), Once a layer is created, it stays as it is.

<br>

### How Are Layers Created?

Example Dockerfile:
```
FROM ubuntu:22.04                  # Base OS - Layer 1
RUN apt-get update                 # Install updates - Layer 2
RUN apt-get install nginx -y       # Install Nginx - Layer 3
COPY . /app                        # Copy your code - Layer 4
CMD ["nginx", "-g", "daemon off;"] # Start Nginx - Layer 5
```

- Layer 1: Base Ubuntu image
- Layer 2: Updates package lists
- Layer 3: Installs Nginx
- Layer 4: Copies your app files
- Layer 5: Defines the command to start Nginx

<br>

### How Do Layers Work Inside Docker?

Docker uses a special technology called **Union File System** (**UnionFS**).

Docker images are made up of multiple layers stacked together.

When you build an image and run a container from it, Docker uses a clever system to combine those layers so your container sees a complete file system. This is where the concept of Union File System (UnionFS) and copy-on-write mechanisms come in.


<br>

### What is UnionFS (Union File System)?

Now — how do we combine multiple read-only layers into one working file system so your container can use it like a normal system?

Docker uses a Union File System (UnionFS).

UnionFS is a type of file system that can combine multiple directories (layers) into a single merged directory (file system view).

Think of it like stacking multiple transparent sheets, each with different parts of a picture — when stacked together, you see a complete image.

<br>

### How Docker Uses UnionFS to Combine Layers?

When a container starts:
- Docker stacks the read-only layers from the image using UnionFS.
- Then it adds a new writable container layer on top (called the container layer)

The container interacts with the merged view of the file system.
- Any read operation looks through the stack from the top layer down.
- Any write operation (like creating, modifying, or deleting a file):
  - Happens in the top, writable container layer.
  - Lower image layers stay unchanged (they are read-only).

UnionFS Combines multiple layers into one virtual file system.

<br>

### Copy-On-Write Mechanism

Now, here’s an important mechanism:
- When a file from a lower (read-only) layer is modified inside a container.
- Docker copies that file to the writable container layer.
- Then the container modifies the copy, leaving the original in the image layer untouched.

This is called copy-on-write.

Why?
- To maintain immutability of image layers while allowing containers to have their own changes.

<br>

### How File Deletion Works (Whiteout Files)

Since image layers are read-only:
- When you delete a file inside a container that exists in a lower image layer.
- Docker doesn’t actually remove the file from the lower layer.
- It adds a special hidden “whiteout” file in the writable layer

This whiteout file hides the file from lower layers when viewing the combined file system.

<br>

### Layer Reuse and Caching

One of the biggest benefits of Docker's layered system is layer caching and reuse.

When building an image:
- If Docker finds a layer with the exact same content from a previous build.
- It reuses the cached layer.
- This saves time and resources.

Example:
- If two images both start from ubuntu:22.04 — Docker only downloads and stores that layer once.

<br>

### Container Lifecycle and Layers

When a container runs:
- It mounts the image’s read-only layers using UnionFS.
- Adds a writable layer on top.
- All changes happen in this writable container layer.

When you stop and remove the container:
- The writable layer is destroyed.
- The image’s read-only layers remain intact.

<br>

### How to View Image Layers

You can inspect the layers in a Docker image using:
```
docker history <image-name>
```

Example:
```
docker history nginx
```

It shows:
- Layer size.
- Commands that created each layer.
- Creation time.

<br>

### Visual Diagram (Text Version)

```
Writable Container Layer (Top Layer — for runtime changes)
  ↑
Image Layer 4: COPY . /app
  ↑
Image Layer 3: RUN apt-get install nginx
  ↑
Image Layer 2: RUN apt-get update
  ↑
Base Layer: FROM ubuntu:22.04
```

Docker merges these layers using UnionFS so the container sees them as one complete file system.

<br>


### Summary

Docker layers Docker images ka core architecture hai, jisme har image multiple layers ka stack hoti hai, aur har layer ek specific command ke file system changes ko represent karti hai. Jab hum ek Dockerfile likhte hain, uska har instruction — jaise FROM, RUN, COPY, ADD — ek alag read-only layer banata hai. Ye layers stacked hoti hain aur ek saath milkar container ke liye ek complete virtual filesystem banati hain, jise Union File System (UnionFS) ka use karke Docker combine karta hai. Jab hum container run karte hain, Docker inn saari read-only image layers ke upar ek writable layer mount karta hai, jahan runtime changes hote hain (jaise file creation, logs, config edits etc.). Agar container koi aisi file modify karta hai jo kisi lower read-only layer mein hai, to Docker use copy-on-write mechanism se pehle writable layer mein copy karta hai, fir us copy ko modify karta hai — isse original image layer hamesha immutable rehti hai. Agar koi file delete karni ho, to Docker use directly delete nahi karta (kyunki wo read-only layer mein hoti hai), balki ek hidden whiteout file create karta hai jo batata hai ki ye file merged view mein dikhni nahi chahiye. Is system ka ek major benefit hai layer caching: agar koi layer pehle se build ho chuki hai aur uska content change nahi hua, to Docker usse reuse karta hai instead of rebuilding — jisse image builds tezi se hote hain, bandwidth aur storage bachti hai, aur images lightweight bante hain. Jab container delete hota hai, uska writable layer bhi delete ho jaata hai, lekin image ki read-only layers reuse ke liye wapas available rehti hain. Ye layered system Docker ko highly efficient, repeatable, aur secure banata hai — is wajah se Docker itna popular hai for creating isolated, consistent, and fast-deploying application environments.


<br>
<br>
<br>

OR

<br>
<br>

Docker images multiple layers se milkar banti hain — aur har layer ek step ya command ka result hoti hai jo hum Dockerfile mein likhte hain. Socho tum ek cake bana rahe ho, jisme base sponge ek layer hai, uske upar cream, fir fruits, fir icing – sab ek-ek layer hai. Waise hi, Dockerfile mein FROM, RUN, COPY jaise commands alag-alag layers create karte hain. Sabse pehle layer hoti hai base image (jaise ubuntu:22.04), uske baad jitne bhi steps tum add karte ho (packages install karna, files copy karna), sab ek-ek layer ban jaate hain. Ye saari layers read-only hoti hain, matlab unme changes nahi kiye ja sakte. Jab Docker container start hota hai, to in read-only layers ke upar ek nayi writable layer add hoti hai — jisme tumhara container kaam karta hai. Agar container kisi purani file ko change kare (jo neeche wale read-only layer mein hai), to Docker us file ka copy upar wali writable layer mein banaata hai aur waha change karta hai — is process ko kehte hain Copy-on-Write. Isse original image safe rehti hai aur container apna kaam bhi kar leta hai. Agar koi file delete karni ho jo kisi neeche wali layer mein hai, to Docker ek hidden file bana deta hai (whiteout file), jo batata hai ki ye file container mein nahi dikhni chahiye. Is tarike se Docker ka system layered rehta hai, aur container ko ek single complete filesystem dikhai deta hai. Sabse badi baat — ye layers cache hoti hain. Agar tumne pehle se koi step run kiya hai aur content same hai, to Docker us layer ko reuse kar leta hai, dobara nahi banaata. Is wajah se Docker images fast build hoti hain, storage kam lagti hai, aur deployment quick hota hai. Jab container delete karte ho, to sirf upar wali writable layer delete hoti hai, baaki image layers waise hi rehti hain. Ye hi layered system Docker ko powerful, fast, lightweight aur repeatable banata hai — isliye production environments mein itna use hota hai.
