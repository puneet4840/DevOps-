# Http Protocol (Hypertext Transfer Protocol)

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

<br>
<br>

# HTTPS (Hypertext Transfer Protocol Secure)

HTTPS is the secure version of HTTP. HTTPS added a layer of security by using **SSL (Secure Socket Layer)** to encrypt the data between client and server.

<br>

**What if there is not encryption between client and server in a HTTP communication**

When there is no encryption between client and server in a HTTP communication, data is transferred in plain text. This means that any information exchanged including any sensitive data like password, personal details can be easily read or modified by hacker.

In an unencrypted http connection, data travels in a readable format, which poses several various risks:

**1 - Data Interception (Eavesdropping)**

<img src="https://github.com/user-attachments/assets/7b6853ff-6ffc-4724-88e1-74bdd96e49f7" height="400" width="700">

<br>
<br>
<br>

**2 - MAN In The Middle Attack**

<img src="https://github.com/user-attachments/assets/68265663-a340-45dc-997d-139b5d3bbe5c" width="700" height="470">

<br>
<br>
<br>

**3 - Phishing Attcak**

<img src="https://github.com/user-attachments/assets/e39b0a22-a41f-4689-be5c-2b5b63bad5a3" height="490" width="700">


<br>
<br>
<br>

**What is SSL?**

SSL is a security protocol which encrypts and authenticate the data between Client and Server. SSL is now succeeded by TLS (Transport Layer Security)

<br>

**How does SSL works?**

- **1 - Initiating the Connection: Client requests secure communication**

  ```When you visit a website using HTTPS, your browser (the client) initiates a request to establish a secure connection to the web server. This is called the SSL/TLS handshake.```

  Example:
  
   ```You type https://www.example.com in your browser and hit enter.```

- **2 - Server sends SSL Certificate**

  ```The server responds by sending its SSL certificate to the client. This certificate contains the server’s public key and other important information, such as the domain name, issuing authority (Certificate Authority), and expiration date of the certificate.```

  Example:
  
  ```- The server for www.example.com responds with an SSL certificate, which proves its identity to the client.```
  
  ```- The SSL certificate is like an ID card for the server, signed by a trusted organization (called a Certificate Authority, like Let’s Encrypt or DigiCert).```

- **3 - Client verifies the SSL certificate**

  ```- The client (your browser) needs to ensure that the SSL certificate provided by the server is trustworthy. It does this by verifying the certificate against a list of trusted Certificate Authorities (CAs) stored in the browser. If the certificate is valid and from a trusted CA, the browser proceeds with the secure connection.```

  - Certificate Verification: The browser checks if:
      - The certificate is valid (not expired).
      - The certificate was issued by a trusted Certificate Authority.
      - The certificate belongs to the website domain you're trying to visit.

  If the certificate checks out, the browser accepts the connection. If the certificate is invalid or expired, the browser will warn you that the connection is not secure (with messages like "Your connection is not private").

- **4 - Creating a shared secret key(symmetric encryption)**

  ```- Once the certificate is verified, the client and server must agree on a shared secret key that will be used to encrypt the data sent between them. This key is created using the public key sent in the server’s SSL certificate.```

  ```- Now both the client and the server have the same session key, which they will use to encrypt and decrypt the data during their communication.```

- **5 - Secure Data Transmission**
  
  ```Now that both the client and server have agreed on a shared session key, they use this key to encrypt the actual data being transmitted between them. This ensures that any data sent, such as login credentials, personal information, or payment details, is securely encrypted and protected from eavesdropping.```
