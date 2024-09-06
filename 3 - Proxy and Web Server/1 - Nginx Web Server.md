# Nginx 

### What is Nginx?

Nginx is a open-source web server which is used to serve http and https requests. 

It is used as a Web Server, Reverse Proxy, Load balancer, Host Multiple Websites, etc.

When a user access a website, that request goes to the web server. Web server retrieves requested content and sends response back to the user.

<br>

### History of Nginx

```A Russian developer named **Igor Sysoev** was frustrated because old web servers couldn't handle **more than 10,000 requests at the same time**. This issue is know as **C10k Problem**. To solve this problem, Igor Sysoev started developing Nginx in **2002**. His goal was to build a web server that could efficiently handle a huge number of connections without using too much memory or system resources. He worked on this project for years, and the first public release of Nginx came out in October 2004.```

<br>

### Installation of Nginx on Linux

```
Step-1: sudo apt install nginx
Step-2: sudo systemctl status nginx
```

When installation is completed, there is directory location where nginx configuration is present. Location is **/etc/nginx**.

<img src="https://github.com/user-attachments/assets/56a5abfb-6631-43ba-bc0a-f82ce9c83f5a" width="650" height="110" >

In these configuration you can see a file named _**nginx.conf**_. This is the main configuration file of nginx or starting point of nginx where nginx takes from everything.

<br>

### Nginx Master-Worker Architecture

Nginx runs with one **Master** process and several **Worker processes**. This architecture helps Nginx manage incoming client requests efficiently. 

Master process handles the incoming requests and assign requests to worker processes then give response to clients. While worker processes complete the work for master process.

**Nginx has sliced into three different parts-**

1 - Master.

2 - Worker.

Let's understand how does Master-Worker and Cache work together.

```When a client sends a request or hit the URL (request to view a web page), the master process receives the request and allocates or assign the task to one of the worker process. This means the master process will select one of the worker processes to handle the request.

Once the master process assigns a task to worker, then master process does not wait for the worker to complete the task. The master process is designed to immediately move on to handle the next incoming request from another clent.

Now the worker process that receives the job(request) is responsible for handling the request. Such as:
1 - Reading the request from client.
2 - Processing the request (such as fetching data and calling another service).
3 - Preparing a response.

Once the worker process completes the job, it prepares the response to be sent back to the client. The worker then sends the rsponse to the master process.

When the master process receives the response from the worker, it forward the response back to the client who made the request.
```

<br>

**NOTE**

When nginx starts, the master process reads the configuration file **(nginx.conf)**. It then parse and validate the configuration.

These master and worker architecture is assigned in **nginx.conf** file.

<br>

### Understand ```nginx.conf``` file.

The ```nginx.conf``` file is the main is the main configuration file for the nginx server. It defines how nginx will handle HTTP/HTTPS requests and other server tasks. The configuration file is hierarchical.


**Tree Architecture of** ```nginx.conf``` **file**

```nginx.conf``` file is divided into multiple block (context). 

<img src="https://github.com/user-attachments/assets/baba496e-79e7-475a-b554-3243b5110aba" width="700" height="350">


**Example** ```nginx.conf``` **file**

```
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    server_names_hash_bucket_size 64;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen 80;
        server_name example.com www.example.com;

        root /var/www/html;
        index index.html index.htm;

        location / {
            try_files $uri $uri/ =404;
        }

        location /images/ {
            alias /var/www/images/;
        }

        error_page 404 /404.html;
        location = /404.html {
            root /usr/share/nginx/html;
        }

        location ~ \.php$ {
            include /etc/nginx/fastcgi_params;
            fastcgi_pass 127.0.0.1:9000;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
    }
}

```

<br>

**Architecture of above config file**

```
nginx.conf
├── user nginx;
├── worker_processes auto;
├── error_log /var/log/nginx/error.log;
├── pid /run/nginx.pid;
├── events {
│   └── worker_connections 1024;
├── http {
│   ├── include /etc/nginx/mime.types;
│   ├── default_type application/octet-stream;
│   ├── log_format main '$remote_addr - $remote_user [$time_local] "$request" ...';
│   ├── access_log /var/log/nginx/access.log main;
│   ├── sendfile on;
│   ├── tcp_nopush on;
│   ├── tcp_nodelay on;
│   ├── keepalive_timeout 65;
│   ├── types_hash_max_size 2048;
│   ├── server_names_hash_bucket_size 64;
│   ├── include /etc/nginx/conf.d/*.conf;
│   └── server {
│       ├── listen 80;
│       ├── server_name example.com www.example.com;
│       ├── root /var/www/html;
│       ├── index index.html index.htm;
│       ├── location / {
│       │   └── try_files $uri $uri/ =404;
│       ├── location /images/ {
│       │   └── alias /var/www/images/;
│       ├── error_page 404 /404.html;
│       ├── location = /404.html {
│       │   └── root /usr/share/nginx/html;

```

<br>

**Explaination of Key Sections**

**1 - Main block (Global Setting)**

- ```user nginx;```: Specifies the user and group under which NGINX run.

- ```worker process auto;```: Defines the number of worker processes, auto adjust this based on the CPU cores.

- ```error log;```: Path to the error log file.

- ```pid```: Specifies the location of PID file.


**2 - Events Block**

- ```worker_connections 1024;```: Defines the maximum number of simultaneous connections each worker can handle.

**3 - Http Block**

This is the main block where HTTP server configuration is specified.

- ```include /etc/nginx/mime.types;```: Includes a list of file MIME types for NGINX to handle.

- ```default_type application/octet-stream;```: Default MIME type if no specific type is found.

- ```log_format```: Defines the format of access logs.

- ```access_log```: Specifies the location of access logs.

- ```sendfile on;```: Enables efficient fie serving by bypassing kernal space.

- ```keepalive_timeout 65;```: Time the server will wait to close inactive connections.

**4 - Server Block**

This the is block where we define the configuration of individual server. It means we give the information about the website we want to host on nginx.

- ```listen 80;```: Tells the server to listen on port 80 (HTTP).

- ```server_name example.com www.example.com;```: Specifies the domain names this server block responds to. We have to mention the domain name of our website here.

- ```root /var/www/html;```: Root directory for the server's content. We keep the html, css, js and other files which is going to be render.

- ```index```: Defines the default file to serve (e.g., index.html).

**5 - Location Block**

This block is used to handle specific request URL or routes. 

- ```/```: This matches all requests and tries to serve a file or directory. If none are found, a 404 is returned.

- ```/images/```: This matches the /images/ path and serves static files from /var/www/images/.

- ```/404.html```: Custom error page for 404 errors.


<br>

**include directive in**```nginx.conf```**file**

```include``` directive allows you to refernece external configuration files within the main configuration file. It add the link to external file at the place where the include directive is used. This makes the configuration modular and easier to manage.

How it Works

Instead of having all configurations in one large file, you can break them into smaller files (e.g., for virtual hosts, MIME types, SSL certificates) and then include those files in the main configuration using ```include```. This improves maintainability.

e.g., ```include /etc/nginx/conf.d/*.conf;```

This will include all .conf files inside the /etc/nginx/conf.d/ directory. It is commonly used for separating server configurations and virtual hosts.

<br>

### Nginx recommendation for Server Block

Usually we write our website's server configuration directly in ```nginx.conf``` file. This is not best practice or not recommended by nginx.

```What we can do is, We can create a server block inside conf.d directory which will automatically include to the main configuration file **nginx.conf** using the include directive.```

``` include /etc/nginx/conf.d/*conf; ``` This command include the server block to the main configuration file.

**Step-by-step guide to setup server block in** ```conf.d``` directory.

We can create individual server block(Virtual Host) in ```/etc/nginx/conf.d/``` directory for each website. We can host multiple website using nginx for this we need to create multiple server block.

Suppose we want to host a schrack web application using nginx. We can follow the below steps.

- For '''schrack.com''':

```
Step-1: Navigate to **conf.d/** directory.

Step-2: Create a file named **schrack.com.conf**.

Step-3: Open the file **schrack.com.conf**.

Step-4: Add the following content inside the file.


server {
    listen 80;
    server_name example1.com www.example1.com;

    root /var/www/example1;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}


Step-5: Verify the configuration using **sudo nginx -t** command.
```
