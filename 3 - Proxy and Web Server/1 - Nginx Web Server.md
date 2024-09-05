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

When the master process receives the response from the worker, it forward the response back to the client who made the request.```

<br>

**NOTE**

When nginx starts, the master process reads the configuration file **(nginx.conf)**. It then parse and validate the configuration.

These master and worker architecture is assigned in **nginx.conf** file.

<br>
