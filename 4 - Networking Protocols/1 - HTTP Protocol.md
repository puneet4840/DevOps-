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

<br>

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

3 - **Body**
- The body contains the data to be sent to the server. This is send when client uses POST, PUT, Delete methods in their request. e.g., form data, JSON.

e.g., Example of HTTP request.
```
GET /index.html HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0
Accept: text/html
```

<br>

**What is HTTP Response?**

The HTTP response is the server's reply to the client's request. It contains the following components:

1 - **Status Line**
- HTTP Version: The version of HTTP used (e.g, HTTP/1.1).
- Status Code: A three digit code representing the result of the request (e.g., 200, 404).
- Status Message: A textual description of the status code (e.g., OK, Not Found).

e.g., 
```
HTTP/1.1 200 OK
```

2 - **Header**
- It is the meta data about the response, such as content-type, date and server information.

e.g., 
```
Date: Mon, 13 Sep 2024 12:30:00 GMT
Content-Type: text/html; charset=UTF-8
Content-Length: 138
```

3 - **Body**
- This is the actual content returned by the client to ther server (such as HTML page, image or json data).

e.g., 
```
<html>
  <head><title>Welcome</title></head>
  <body><h1>Hello, World!</h1></body>
</html>
```

<br>

**HTTP Methods**

HTTP methods are used to indicate the action to be performed on the server. 

HTTP methods used to tell the server what to do when a client make an request to the server. Common methods are:

1 - **GET**
- Request data from server.

2 - **POST**
- Send data to the server (usuallly used to submit form).

3 - **DELETE**
- Delete a resource on the server like to delete any data from database.

4 - **PUT**
- Replace or Update any resource on the server like to update any data in the database.

5 - **HEAD**
- Request the header from the server.

<br>

**HTTP Status Code**

It is a three digit number which defines the outcome of the client's request from the server.

1XX - Informational (e.g., 100: Continue).

2XX - Success (e.g., 200: OK, 201: Created).

3XX - Redirection (e.g., 301: Moved Permanently, 302: Found).

4XX - Client Errors (e.g., 404: Not Found, 403: Forbidden).

5XX - Server Errors (e.g., 500: Internal Server Error, 503: Service Unavailable).
