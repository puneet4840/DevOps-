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

When installation is completed, there is directory location where nginx configuration is present. Location is **/etc/nginx**

<img src="https://github.com/user-attachments/assets/56a5abfb-6631-43ba-bc0a-f82ce9c83f5a" width="700" height="140" >
