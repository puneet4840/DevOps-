# Load Balancer

### What is Load Balancer?

A load balancer is a device or software which is used to distribute the incoming client requests on multiple servers. 

Its purpose is that no server gets overloaded by incomming traffic.

### What is Load balancing?

Load balancing is the process of efficient distribution of incoming network requests on all servers.

<br>

e.g., **Real Life Example**

```When you visit Vishal Mega Mart for billing. There are multiple billing counters, if there is croud on billing counters. A staff person will guide you to go on which billing counter for fast billing.```

<br>

### Types of Load Balancer

**1 - Hardware Load Balancers**

- There are physical devices that are placed in data center to distribute traffic. Hardware Load balancers offers high performance and advanced features but they are expensive.

**2 - Software Load Balancers**

- They run as software application on servers. It means we need to install it like a software on a server. They are cheaper and more flexible because you can install them on any server.
- **Example**: ```HAProxy, F5, Nginx, Traefik.```

**3 - Cloud Load Balancers**

- These are provided as a service by Cloud Providers like Azure, AWS, Google, etc. They are scalable, easy to set up, and ideal for cloud-based applications.
- **Example**: ```Azure Load Balancer, AWS Elastic Load Balancer, Google Cloud Load Balancer.```

<br>

### How Load Balancer Works?

- **Client Request**: Client sends a request to load balancer.
  
- **Alogrithm Selection**: The load balancer uses an algorithm to identify which backend server can handle the request.
  
- **Request Forwarding**: The load balancer forward the request to selectd backend server.
  
- **Response Handling**: The backend server processes the request and sends a response to load balancer.
  
- **Response Forwarding**: The load Balancer forward the response to the client.

<br>

### Load Balancing Algorithms

We need a load balancing algorithm to decide which request goes to which backend server.

There are two types of load balancing algorithm:

**Static Algorithms**

```Server on which request is send is already predetermined and fixed. Isme load konse server par bhejna hai ye pehle hi pta hota hai.```

- Round Robin.
- Weighted Round Robin.
- Source IP Hash.

<br>

1 - **Round Robin**

In Round Robin algorithm, requests are distributed to servers in a circular fashion.

```
Round Robin algorithm main request ko circular fashion main behja jata hai. 
```

e.g.,
``` If there are three servers, the first request goes to server 1, the second to server 2, and so on.```

<br>
<br>

2 - **Weighted Round Robin**

In weighted round robin algorithm, servers are assigned weights and requests are distributed to servers according to the weight.

```
Isme har server ko ek weight assign kiya jata hai matlab jis server ki configuration jyada hogi usko jyada weight assign hoga
aur jiski kam hogi usko kam weight assign hoga.
To jis server ka jyada weight hai usko jyada requests behji jayenge aur jis server ka kam weight hai usko kam requests.
Isko ese samjhiye ki jo server jyada heavy hai usko jyada requests.
```

e.g.,
```There are 2 servers, Server 1 (high-capacity) gets 5 requests, while Server 2 (low-capacity) gets 2 requests.```

<br>
<br>

3 - **Source Ip Hash**

This algorithm uses the client's ip address to determine which server will handle the request. The same ip will always be routed to the same server.

How it works?
- Hash Function: A hash function is applied to the client's IP address to generate a numerical value.
- Server Selection: The generated hash value is used to select a server from a pool of available servers.
- Request Routing: The request is then routed to the selected server.

e.g.,
```Imagine you have three servers (A, B, and C) and a load balancer using source IP hash. If a client with the IP address 192.168.1.100 sends a request, the load balancer might apply a hash function to this IP address and generate the value 123. Based on this value, the request could consistently be routed to server A.```

<br>
<br>
<br>

**Dynamic Algorithm**

```These algorithms make real-time decision on which backend server to send the request. Isme algorithm real time decision leta hai ki konse backend server par request bhejni hai```

- Least Connection Method.
- Least Response-Time Method.

1 - **Least Connection Method**

This algorithm distributes the traffic based on the least active connection on the server.

```
Jis bhi server ke paas sabse kam active request hongi ye algorithm us server ko request bhejgi.
```

How it works:
- Connection Tracking: The load balancer keeps track of the number of active connections to each server.
- Server Selection: When a new request arrives, the load balancer selects the server with the fewest active connections.
- Request Routing: The request is then forwarded to the selected server.

e.g.,
```Imagine you have three servers (A, B, and C) and a load balancer using least connections. If server A has 10 active connections, server B has 5 active connections, and server C has 20 active connections, the load balancer will route the next request to server B, as it has the fewest connections.```

<br>
<br>

2 - **Least Response Time Method**

This algorithm distribute the traffic on a server which has least response time.

```
Jis bhi server fast response ka rha hoga ye algorithm us server ko request bhejti hai.
```

How it works:
- Response Time Tracking: The load balancer keeps track of the average response time for each server.
- Server Selection: When a new request arrives, the load balancer selects the server with the shortest response time.
- Request Routing: The request is then forwarded to the selected server.

e.g.,
```Imagine you have three servers (A, B, and C) and a load balancer using least response time. If server A has an average response time of 100 milliseconds, server B has an average response time of 200 milliseconds, and server C has an average response time of 50 milliseconds, the load balancer will route the next request to server C, as it has the shortest average response time.```

<br>
<br>

### Why use a Load Balancer?

- **Scalability**: As your application grows, you can add more servers, and the load balancer will distribute traffic among them, ensuring the system scales effectively.

- **Redundancy and Reliability**: If one server fails, the load balancer redirects traffic to healthy servers. This ensures that your application is always available.

- **Improved Performance**: By distributing the load evenly, no single server is overwhelmed, which leads to faster response times for users.

- **Security**: Load balancers can act as a first line of defense by filtering out bad traffic, reducing the chances of Distributed Denial of Service (DDoS) attacks.

<br>

### Real-World Example

**E-commerce Website**

```Imagine an online shopping website that has millions of users. The website has multiple servers handling different requests (like browsing products, handling payments, etc.). Without a load balancer, one server could become overwhelmed with traffic, causing slowdowns or crashes. A load balancer ensures traffic is evenly distributed, and if one server goes down, the others will handle the load.```
