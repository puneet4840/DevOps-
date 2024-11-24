# Ingress in Kubernetes

Ingress is a resource in kubernetes which is used to manage external access to service within a kubernetes cluster. 

```Ingress kubernetes का एक resource है जो external traffic को kubernetes की services तक पहुचता है मतलब application को outside world के लिए expose करता है मतलब users ingress के through kubernetes पर deployed application को internet के through access कर पाएंगे|```

In a Kubernetes cluster, applications often need to be accessed from outside the cluster, such as a website that users access via the internet. Ingress is a Kubernetes resource designed to expose such services to external clients, typically via HTTP or HTTPS.

### Why do we need Ingress?

```हमको पता है की जब appllication को kubernetes cluster पर deploy करते है तो उस application को access करने के लिए हम service बनाते हैं खासकर application को internet कर access करना होता है तो Load Balancer type की service बनाते है| तो ये Load Balancer type की service cloud पर एक Load Balancer create कर देती है जिससे Load Balancer पर request भेजकर application को access करते हैं| जब यहाँ तक सब चीज़ ठीक चल रही थी तो ये Ingree नाम की चीज़ क्यों आयी|```

```क्युकी kubernetes मैं service की कुछ disadvantages होती हैं जिसको हम Ingress से solve कर सकते हैं जैसे की: ```

- ```Service को सिर्फ हम cloud clusters पर ही use कर सकते हैं मतलब cloud मैं जब हम cluster बनाते है जैसे AKS, EKS, GKE इन clusters पर ही Load Balancer type सर्विस कर use होता है क्युकी जब service Load Balancer type की होती है तो service को Load Balancer cloud ही provide करता है| इसका मतलब है की Load Balancer type की service सिर्फ cloud dependent होती है जो एक disadvantage है|```

- ```अगर Kubernetes Cluster मैं हमने एक web application deploy की, तो उस web application को internet पर access करने के लिए load balancer type की service बनानी पड़ेगी जिससे एक load balancer web application के लिए cloud पर create हो जायेगा| Suppose अगर हमारे पास ऐसी 10 web applications है और वो हम kubernetes पर deploy कर रहे हैं तो उन सभी वेब एप्लीकेशन को इंटरनेट पर एक्सेस करने के लिए अलग-अलग load balancers क्रिएट करने होंगे मतलब 10 web applications के लिए 10 load balancers create होंगे जिससे होगा ये की इतने सारे load balancers की cost हमको pay करनी पड़ेगी और ऐसा scenario efficient नहीं है तो हर application को internet पर expose करने के लिए load balancer का use न करके हम Ingress resource का use करते हैं|```.


Kubernetes provides several ways to expose services, including:

- **ClusterIP**: Default type, makes the service only accessible within the cluster.
- **NodePort**: Exposes the service on a static port on each node, allowing access from outside the cluster.
- **LoadBalance**r: Allocates a cloud provider’s load balancer, exposing the service externally.

Each of these has its limitations:

- **NodePort**: Uses static ports and can expose a limited number of services due to port limits.
- **LoadBalancer**: Good for a single service but can be inefficient when you need to expose multiple services.

**Ingress provides**:

- **Routing** to direct external requests to the appropriate services.
- **Host-based or path-based** routing to control which traffic goes to which application.
- **TLS/SSL** support to secure applications with HTTPS.

Ingress offers a more centralized and scalable way to manage access to multiple services, especially for HTTP/HTTPS traffic. You can:

- Manage all routing rules in one place (It means we can forward incoming request to multiple services using only one ingress resource).
- Configure HTTPS/TLS centrally.
- Route based on paths and hostnames, allowing multiple services to share a single IP.

<br>

<img src="https://drive.google.com/uc?export=view&id=1OI23Rgntu7TK5QnTBKZIBzBIxI1lMIaE">

<br>

### Key components of Ingress

- Ingress resource.
- Ingress Contoller.
- Ingress Class.

<br>

### How does Ingress works?

- **Ingress Resource**:

  The Ingress resource in Kubernetes is a configuration file (YAML) that defines how external requests should be routed to internal services.

  ```Ingress resource ingress को define करने के लिए एक Yaml file होती है जिसमे मैं हम define करते हैं की जब ingress से kubernetes service पर external request आएगी तो उस request को कोनसी kubernetes service पर transfer करना है|```

  Each Ingress resource mainly contains:

  - **Routing Rules**: For routing traffic to services based on Path based routing OR Host based routing. For example, it can route requests based on the URL path (e.g., ```/app1, /app2```) or hostname (e.g., ```app1.example.com, app2.example.com```).
 
  - **TLS settings** (optional): Allow HTTPS traffic using SSL/TLS certificates.

Exmaple of Ingress resource:

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
      - myapp.example.com
    secretName: myapp-tls
  rules:
  - host: myapp.example.com
    http:
      paths:
      - path: /app1
        pathType: Prefix
        backend:
          service:
            name: app1-service
            port:
              number: 80
```

Explaination:

- apiVersion and kind:
  - apiVersion: Specifies the version of the Kubernetes API used for this resource. For Ingress resources, this is typically networking.k8s.io/v1.
  - kind: Defines the type of Kubernetes resource, which is Ingress in this case.
 
  These fields tell Kubernetes that we are creating an Ingress resource according to the networking.k8s.io/v1 API.

- metadata:
  - name: The name of the Ingress resource, which should be unique within the namespace. In this case, it’s named example-ingress.
  - namespace: Specifies the Kubernetes namespace where this Ingress resource will be created. By default, it’s set to default, but you could use other namespaces if desired.
 
- annotations:
  - Annotations provide additional options for configuring the behavior of the Ingress Controller. Here, we have:
    - nginx.ingress.kubernetes.io/rewrite-target: /: This annotation is specific to the NGINX Ingress Controller. It rewrites the URL path for requests that match a certain path. For instance, if a request is made to /app1, the controller will rewrite the path to / before forwarding it to the service. This can be helpful if the backend service is expecting a specific path format.

  Note: Different Ingress Controllers support different annotations, so the available options depend on the Ingress Controller you’re using (e.g., NGINX, Traefik, or HAProxy)

- spec:
  - The spec section is where we define the actual routing rules, TLS settings, and other configurations for the Ingress resource.
 
  - tls:
    - Specifies the TLS (Transport Layer Security) settings to enable HTTPS for specific hosts.
      - hosts: A list of hostnames (domains) that will use TLS. In this example, myapp.example.com is specified.
      - secretName: The name of a Kubernetes Secret that contains the TLS certificate and key. This Secret must be created beforehand and should include the certificate and private key for the specified host(s).
     
    - This section configures HTTPS for the myapp.example.com domain. When a client requests https://myapp.example.com, the Ingress Controller will use the specified TLS certificate from myapp-tls.

  - rules:

    The rules section defines the main routing rules for the Ingress resource. Each rule specifies how traffic should be directed based on the requested host and path.

    - host:
      - host: The hostname (domain) that the rule applies to, e.g., myapp.example.com. Only requests matching this hostname will be processed by this rule. If the request doesn’t match the hostname, the Ingress Controller will ignore it.

        In our example, the rules are defined for the myapp.example.com host. Requests to this domain are routed based on the paths defined in http.

    - http:
      - http: Defines HTTP-specific routing rules for the host. Within http, you can define multiple paths, each with its own backend service.


    - paths:
      - paths: A list of path rules. Each path rule consists of:
        - path: Specifies the URL path for which this rule applies. For example, /app1 or /app2. This path is matched against the incoming request’s URL.
       
        - pathType: Defines how the path should be matched. The main options are:
          - Prefix: Matches requests where the URL path begins with the specified path. For example, if path: /app1 and pathType: Prefix, requests to /app1, /app1/page, etc., will match this rule.
          - Exact: Matches the path exactly. So path: /app1 with pathType: Exact would only match requests to /app1, not /app1/page.
          - ImplementationSpecific: Allows the Ingress Controller to determine how paths are matched, which might vary by controller.

    - backend:
      - backend: Defines the target service and port where matching requests should be routed.
        - service.name: Specifies the name of the service to forward traffic to (e.g., app1-service).
        - service.port.number: The port on the service where traffic should be directed (e.g., 80).

  Exmple Path rule:

  ```
    - path: /app1
      pathType: Prefix
      backend:
        service:
          name: app1-service
          port:
            number: 80
  ```

  In this example:
  - Requests to myapp.example.com/app1 will be routed to the app1-service service on port 80.
  - Since pathType is Prefix, requests to /app1/page will also match this rule.

<br>

- **Ingress Controller**

  An Ingress Controller is a component that reads the Ingress resource rules and processes them. It means ingress contoller reads the ingress resource yaml file and decide to which service has to forward the incoming request.

  It’s an add-on that watches for changes to Ingress resources and adjusts routing accordingly.

  Kubernetes does not come with a default Ingress Controller. You need to install one separately, and there are several popular options, such as:

  - NGINX Ingress Controller (most widely used).
  - Traefik.
  - HAProxy.
  - Istio Gateway (for Istio service mesh).
  - Azure Application Gateway Ingress Controller.


<br>

- **Ingress Class**

  Ingress Class is a way to define which Ingress Controller should manage a particular Ingress resource. You can have multiple Ingress Controllers in the same cluster, each handling different Ingress resources based on their Ingress Class.

  Suppose we have mentioned the nginx ingress in yaml then kubernetes will use nginx ingress contoller for that situation.

  **How Does an Ingress Controller Work?**

  Here’s a step-by-step overview of how an Ingress Controller works:

  - **Monitors for Ingress Resources**:

    The Ingress Controller constantly monitors the Kubernetes API for any Ingress resources (YAML configurations) that are created, updated, or deleted.

  - **Parses Ingress Rules**:

    When a new Ingress resource is created, the Ingress Controller reads the routing rules defined in the resource, such as hostnames, paths, and backend services. It then configures itself to route traffic according to these rules.

  - **Routes Incoming Traffic**:

    - The Ingress Controller listens for HTTP and HTTPS requests on specified ports (usually 80 and 443).
    - When it receives a request, it checks the request’s hostname and path against the Ingress rules. Based on the match, it routes the request to the appropriate service within the cluster.
   
  - **Handles SSL/TLS Termination**:

    If HTTPS is enabled in the Ingress resource, the Ingress Controller handles SSL/TLS termination, meaning it decrypts incoming HTTPS traffic and forwards it to the appropriate backend services as HTTP traffic. This is done using SSL certificates configured in the Ingress resource.

  - **Load Balancing**:

    If multiple replicas of a service are running, the Ingress Controller distributes incoming requests among these replicas, providing load balancing.

<br>

**How to Set Up an Ingress Controller (Example: NGINX Ingress Controller)**

Setting up an Ingress Controller involves deploying it within your cluster, configuring the necessary services, and then defining Ingress resources to route traffic to services.

- **Install the NGINX Ingress Controller**:

  You can install the NGINX Ingress Controller using kubectl and a YAML file provided by the Kubernetes project. This file contains the deployment and service specifications for the NGINX Ingress Controller.

  ```
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
  ```

  This deployment sets up the NGINX Ingress Controller within your cluster. By default, it creates a LoadBalancer service to expose the Ingress Controller, allowing external traffic to be routed through it.

- **Verify the Ingress Controller**:

  You can verify the Ingress Controller setup by checking the status of the ingress-nginx-controller service. Run:

  ```
    kubectl get services -o wide -w -n ingress-nginx
  ```

  This command displays the external IP address assigned to the LoadBalancer service. This IP address will serve as the entry point for external traffic directed to the Ingress Controller.

<br>

### What is path based routing OR host based routing

In Kubernetes, path-based routing and host-based routing in an Ingress resource allow you to control traffic routing to specific services within a cluster based on the URL’s hostname or path. These routing options give you flexibility to organize how users access different applications and services under one or more domains.

- **Host-Based Routing**:

  Host-based routing in an Ingress resource directs traffic based on the hostname (domain) in the URL. This means that requests to different hostnames can be routed to different services within the cluster.

  - **When to Use Host-Based Routing**:

    Host-based routing is ideal when:
    - You have multiple applications that you want to access under different domains or subdomains.
    - You need to organize traffic to different services based on their hostnames.
    - You’re handling multi-tenant scenarios where different domains serve different clients or teams.
   
  Example: Host-Based Routing

  In the following example, we’ll set up host-based routing for two different applications: app1 and app2, accessible under app1.example.com and app2.example.com, respectively.

  ```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-host-based-ingress
spec:
  rules:
  - host: app1.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app1-service
            port:
              number: 80
  - host: app2.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app2-service
            port:
              number: 80
  ```
