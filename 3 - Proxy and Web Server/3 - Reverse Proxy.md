# Reverse Proxy

A reverse proxy is a server that sits between Servers and the Client, forwarding client's request to the appropriate server and then returning the server's response to the client.

<img src="https://github.com/user-attachments/assets/f84295cf-574b-436f-91d0-5213f15723b2" width="600" height="320">

<br>

### Reverse Proxy vs Forward Proxy

- **Reverse Proxy**:  Acts on behalf of the server, hiding the server’s identity from the client.

- **Forward Proxy**: Acts on behalf of the client, hiding the client's identity from the server.


**How a Reverse Proxy works?**

When a client(e.g., a browser) sends a request to the server. the reverse Proxy receives it first. The proxy then forwards the request to one of the backend servers (either based on load balancing or other rules), and once the server processes the request, the proxy sends the server's response back to the client.

e.g.,

```Suppose you have three backend servers hosting a web application, and you want to ensure that traffic is balanced across them, and users don't directly interact with the backend servers. A reverse proxy, such as Nginx, can be configured to route requests to these servers based on specific rules.```

**Common use of reverse proxy**

- **Load Balancing**: Distributing traffic across multiple servers to improve reliability and performance.
- **Security Gateway**: Shielding backend servers from direct exposure to the internet and providing features like firewalls, SSL termination, etc.
