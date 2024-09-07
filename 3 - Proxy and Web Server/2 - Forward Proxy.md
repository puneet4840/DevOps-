# Forward Proxy

### What is a Proxy?

Proxy is a machine or set of machines that sits in-between two systems(Client and Server).

A proxy server acts as a intermediary between client and server.

**Note**: A forward proxy hides the client's IP address.

e.g.,

```Suppose you want to access a website xyz.com of USA. You saw that access is denied to the user of India to that website. You search for proxy website for xyz.com``` 
```There are lists of many websites, You click anyone of them and xyz.com website is accessible to you.```

This is becuase of proxy server. ```xyz.com``` does not know your country because you are accessing xyz.com from proxy server.

<img src="https://github.com/user-attachments/assets/73c72632-86f3-4bac-b6a0-25bcb57da5e5" width="600" height="400">

<img src="https://github.com/user-attachments/assets/350d65cb-6abd-480a-abe5-6ac544eab628" widht="500" height="320">


<br>

### What is Forward Proxy?

A Forwar Proxy is a server which lies between Client and Server.

When the client sends a request to server, the forward proxy handles it, sending the request to the server on the client's behalf.

e.g.,

```Suppose you want to access a website that is restricted in your region. Instead of accessing it directly, you use  forward proxy that is located in different region. The request goes from your device to forward proxy, which forwards the request to the website. The website sees the request coming from the proxy, not you, allowing you to access to content.```

OR

```A company may use a forward proxy to control employees' internet access. All web traffic goes through the proxy, and the company can filter out websites, track usage, or apply security policies.```

**Benefits of Forward Proxy**

- **Anonymity**: Hides the client's IP address from the target server.
- **Bypass Restrictions**: Can bypass geo-restrictions or network blocks.
- **Filtering**: Can restrict access to certain content or websites.

<br>

**Forward Proxy Workflow**

- **Clinet -> Proxy**: The client sends a request to the forward proxy instead of directly contacting the target server.
- **Proxy -> Server**: The proxy forwards the request to the destination server.
- **Server -> Proxy**: The server responds to the proxy with the requested content.
- **Proxy -> Client**: The proxy sends the content back to the client.

