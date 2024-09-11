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

2 - **Weighted Round Robin**

In weighted round robin algorithm, servers are assigned weights and requests are distributed to servers according to the weight.

```
Isme har server ko ek weight assign kiya jata hai matlab jis server ki configuration jyada hogi usko jyada weight assign hoga aur jiski kam hogi usko kam weight assign hoga.

To jis server ka jyada weight hai usko jyada requests behji jayenge aur jis server ka kam weight hai usko kam requests.

Isko ese samjhiye ki jo server jyada heavy hai usko jyada requests.
```

e.g.,
```There are 2 servers, Server 1 (high-capacity) gets 5 requests, while Server 2 (low-capacity) gets 2 requests.```

<br>

3 - **Source Ip Hash**





**Dynamic Algorithm**

```These algorithms make real-time decision on which backend server to send the request. Isme algorithm real time decision leta hai ki konse backend server par request bhejni hai```

- Least Connection Method.
- Least Response-Time Method.
