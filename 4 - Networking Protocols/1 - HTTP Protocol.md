# Http Protocol

### What is a Protocol?

Protocol are the rules defined by the Internet Society which ensure how the data should transfer between the devices. It ensures that the data packets must completely sent to receiver and inform during the failure and success.

```
Protocol rules hote hain jo Internet Society ek organization hai usne banaye the jab internet ki shuruaat hui thi.
Ye rules batate hain ki do devices ke beech main data kaise tranfer hota hain. In rules ki wajah se data packets completely receiver
ke pass jate hain aur agar koi data packet receiver ke paas nahi pahunch pata hai to us data packet ki information sender ko dete hain.

Inhi rules ko protocol kaha jata hai.
```

### Basic Protocols:

- HTTP
- HTTPS
- FTP
- SCP
- DNS
- DHCP

<br>

### HTTP Protocol

HTTP (Hyper Text Transfer Protocol) is a set of rules which define how the data (web pages, images, videos) transmitted to the server and receive from the server over the internet.

It works on a client-server model where a client (your web browser) sends a HTTP request to the server and a server sends HTTP responce to the client (your web browser).

HTTP uses TCP protocol to send and receive the data.

It is a stateless protocol it means when a user sends HTTP request to server then server does not store any information about the user's machine by default.

**What is HTTP Request?**

A HTTP request is send by the client to perform an action(GET, POST, PUT,DELETE) to the server.

Each request is composed of several component:

1 - **Request Line**
- Method: Specifies what action to be performed to the server (e.g., GET, POST, PUT, DELETE).
- Reource/Path: Resource or path the client wants to access (e.g., /index.html).
- HTTP Version: Specifies the HTTP version (e.g., HTTP/1/1 or HTTP2).

e.g.,
```
GET /index.html HTTP/1.1
```

2 - **Header**
- Header provides meta information about request, such as content-type, user-agent, and accepted language.

e.g.,
```
Host: www.example.com
User-Agent: Mozilla/5.0
Accept: text/html
```
