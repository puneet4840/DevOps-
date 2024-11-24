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

- **Update DNS**:
  - Map the domain ```myapp.example.com``` to the Load Balancer IP in your DNS provider settings.

- **Test Access**:
  - Open ```http://myapp.example.com/app1``` and ```http://myapp.example.com/app2``` in a browser.

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

  Explanation of the YAML:
  - host: app1.example.com and host: app2.example.com: These are the hostnames used for host-based routing. Requests with Host: app1.example.com will be directed to app1-service, while requests with Host: app2.example.com will be directed to app2-service.
 
  - path: /: This is the URL path. Since we specified /, it matches any URL path on the domain (e.g., /, /page1, /api).
 
  - backend.service.name and backend.service.port.number: These specify the Kubernetes services that should receive the traffic based on the hostname.
 

  With this setup:
  - Requests to http://app1.example.com will be routed to app1-service.
  - Requests to http://app2.example.com will be routed to app2-service.

  Note: For this to work, DNS records should point app1.example.com and app2.example.com to the Ingress Controller’s IP address, usually provided by a cloud LoadBalancer.


- **Path-Based Routing**

  Path-based routing in an Ingress resource directs traffic based on the URL path. This allows different URL paths on the same domain to route to different services.

  When to Use Path-Based Routing:
  - You have multiple applications or APIs that you want to expose under a single domain.
  - You want to organize a large application by routing different sections (e.g., /app1, /app2, /api) to different services.

  Example: Path-Based Routing:

  In the following example, we’ll set up path-based routing for two different applications on the same domain, example.com. The applications will be accessible at /app1 and /app2.

  ```
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: example-path-based-ingress
    spec:
      rules:
      - host: example.com
        http:
          paths:
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: app1-service
                port:
                  number: 80
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: app2-service
                port:
                  number: 80
  ```

  Explanation of the YAML:
  - host: example.com: All requests to example.com are handled by this Ingress rule.
  - path: /app1: Routes traffic with the URL path /app1 to app1-service.
  - path: /app2: Routes traffic with the URL path /app2 to app2-service.
  - pathType: Prefix: Indicates that any URL starting with /app1 (e.g., /app1, /app1/section) will match this rule.

  With this setup:
  - Requests to http://example.com/app1 will be routed to app1-service.
  - Requests to http://example.com/app2 will be routed to app2-service.

  Note: Path-based routing works well for organizing services under a single domain. Each path should ideally correspond to a specific service in the cluster.

  - **Path Types in Path-Based Routing**

    In Kubernetes, each path rule in an Ingress resource has a pathType field, which specifies how the path should be matched. There are three main path types:

    - Prefix: Matches if the URL path starts with the specified path. For example, if you specify path: /app1 with pathType: Prefix, requests to /app1, /app1/subpath, etc., will match.
   
    - Exact: Matches only if the URL path exactly matches the specified path. So if you use path: /app1 with pathType: Exact, only requests to /app1 will match, while /app1/anything-else will not.
   
    - ImplementationSpecific: Allows the Ingress Controller to decide how to match paths. This behavior can vary between Ingress Controllers and is usually not recommended unless you have a specific controller requirement.

  For most use cases, Prefix is the preferred pathType, as it provides more flexibility.

<br>

### Ingress Workflow (When a user send a request to load balancer).

Now let’s walk through what happens when a user sends a request to your application using the Load Balancer IP.

- **Step 1: User Makes a Request to the Load Balancer IP**

  - A user opens a browser and types in the Load Balancer IP address (e.g., ```http://<LoadBalancer-IP>/```).
  - This request goes over the internet and reaches the Azure Load Balancer, which is the public entry point to your cluster.

- **Step 2: Azure Load Balancer Forwards Traffic to the Ingress Controller**

  - The Load Balancer is configured to forward traffic on ports 80 (HTTP) and 443 (HTTPS) to the Ingress Controller.
  - The Ingress Controller is running inside your AKS cluster as a Kubernetes Pod, listening for incoming traffic from the Load Balancer.

- **Step 3: Ingress Controller Checks Ingress Rules**

  - The Ingress Controller receives the user’s request from the Load Balancer.
  - It checks the request against the Ingress resource rules that you defined for your web application.
  - For example, if you set up the Ingress resource to match requests to the path ```/``` and route them to a Service named ```webapp-service```, the Ingress Controller recognizes this rule and decides to forward the request to ```webapp-service```.

- **Step 4: Ingress Controller Forwards the Request to the Service**

  - Based on the matched rule, the Ingress Controller forwards the request to ```webapp-service```.
  - In Kubernetes, Services act as a load balancer within the cluster, distributing traffic to the application Pods (replicas of your web app) running behind the service.

- **Step 5: Service Directs Traffic to Application Pods**

  - The ```webapp-service``` sends the request to one of the Pods running your web application.
  - These Pods handle the request, generate a response, and send it back to the Service.

- **Step 6: Response Travels Back to the User**

  - The Service sends the response back to the Ingress Controller.
  - The Ingress Controller then sends the response to the Load Balancer, which in turn forwards it to the user’s browser.
  - The user sees the response, which could be a web page or any other content served by your application.

<br>

### More about ingress

In my greenlit project there is an ingress implementation which yaml's looks like below. In the bwloe yaml you can see there no host mentioned. Let's understand it.

```
apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: null
  name: shipping-service
spec: {}
status: {}
---
apiVersion: v1
data:
  .dockerconfigjson: ewoJImF1dGhzIjogewoJCSJodHRwczovL2luZGV4LmRvY2tlci5pby92MS8iOiB7CgkJCSJhdXRoIjogImNIVnVaV1YwTVRwd2EzWXhNVFJBVWpreE1ERTVPVGs9IgoJCX0sCgkJInJlZ2lzdHJ5ZGV2YXVlYXN0MDAxLmF6dXJlY3IuaW8iOiB7CgkJCSJhdXRoIjogIk9EVmtOV1V6TlRrdE5XVTBPQzAwWmpBMUxXSmlPREl0WmpCbU1ERTFOekV5TnpCa09tUmhZamhSZm5kc2NtVldjVTAxVjNnNVpTNW5WeTE0WlRaRmIwSXhVRWR0WVhOWGQyeGlVVFk9IgoJCX0KCX0KfQ==
kind: Secret
metadata:
  creationTimestamp: null
  name: registry-secret-new
  namespace: shipping-service
type: kubernetes.io/dockerconfigjson
---
apiVersion: apps/v1
kind: Deployment
metadata:
 namespace: shipping-service
 name: shipping-service
 labels: 
  owner: Aquib
spec:
 replicas: 1
 selector:
  matchLabels:
   app : shipping-service
 template:
  metadata:
   labels:
    app : shipping-service
  spec:
   containers:
   - name: shipping-service
     image: registrydevaueast001.azurecr.io/shippingservice:#(dockertag)#
     imagePullPolicy: Always
     ports:
     - containerPort: 80
     resources:
      # limits:
      #  memory: 500Mi
      #  cpu: 30m
      requests:
        memory: 500Mi
        cpu: 30m
    #  Update the Key vault credentials here
     env:
      - name: KVClientId
        value: "ff7e2427-18ef-4373-a0ea-f9d60536e3c1"
      - name: KVClientSecret
        value: "ra-bu-~1pp.LStD_5foY3N76oXm6s5gZyA"
      - name: KVEndpoint
        value: "https://shipping-vault-dev-001.vault.azure.net/"
      - name: ASPNETCORE_ENVIRONMENT
        value: "Dev001"  
   imagePullSecrets:
      - name: registry-secret-new
---
apiVersion: v1
kind: Service
metadata:
 namespace: shipping-service
 name: shipping-service-svc
 labels:
  kind : service
spec:
 type: ClusterIP
 selector:
    app : shipping-service
 ports:
 - protocol: TCP
   port: 80
   targetPort: 80
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  namespace: shipping-service
  name: shippng-service-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: shipping-service
  minReplicas: 1
  maxReplicas: 4
  metrics:
  - type: Resource
    resource:
      name: memory
      target:
        averageUtilization: 80
        type: Utilization
  - type: Resource
    resource:
      name: cpu
      target:
        averageUtilization: 80
        type: Utilization
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: shipping-service-ingress
  namespace: shipping-service
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /shipping(/|$)(.*)
        pathType: ImplementationSpecific
        backend:
          service:
            name: shipping-service-svc
            port:
              number: 80
```

In this YAML configuration, the Ingress resource does not specify a ```host``` field, which makes it a catch-all configuration. This means that the Ingress rule will respond to requests sent to any hostname, as long as the request path matches the ```path``` specified. This is typically used in scenarios where the application doesn’t require a specific hostname or is designed to respond to requests on any hostname, as is often the case in development environments or internal services that don’t need external DNS entries.

**Explanation of Key Parts**:

Let’s break down the critical elements in this Ingress configuration to understand how it functions without a specified host.

- **Path-Based Routing Without Host**

  ```
    rules:
    - http:
        paths:
        - path: /shipping(/|$)(.*)
          pathType: ImplementationSpecific
          backend:
            service:
              name: shipping-service-svc
              port:
                number: 80
  ```

  Explaination:

  - **path**: ```/shipping(/|$)(.*):``` This path uses a regular expression-like syntax to match any URL path that starts with ```/shipping``` or has ```/shipping/``` as a prefix. For example, requests to ```/shipping```, ```/shipping/order```, and ```/shipping/status``` would match this rule. The use of (.*) at the end allows it to match any characters that follow /shipping.
 
  - **pathType**: ```ImplementationSpecific```: This allows the Ingress Controller (in this case, the NGINX Ingress Controller as specified by ```ingressClassName: nginx```) to determine how to handle path matching. NGINX typically interprets this in a flexible way, allowing regex or prefix-based matching as defined by the ```path```.
 
  - **Backend Service**: Requests that match the path rule are forwarded to the shipping-service-svc service on port 80, which routes traffic to the shipping-service Pods.

- **No Host Specification**:

  - Since the host field is omitted, this Ingress will catch all requests that match the path rule regardless of the hostname. In practice, this means it can respond to requests made to any domain or IP pointing to the Ingress Controller.
 
  - This is useful when you want to simplify routing rules or when the application doesn’t need to differentiate requests based on the hostname.

- **How It Works in Your Scenario with Azure AKS**:

  Assuming that you have:
  - An AKS cluster with the NGINX Ingress Controller installed.
  - A public IP assigned to the Ingress Controller via an Azure Load Balancer.

  Here’s how this Ingress will work when a user makes a request:

  - **Request to Load Balancer IP**: When a user accesses the Load Balancer’s IP (e.g., ```http://<LoadBalancer-IP>/shipping/orders```), the request is directed to the Ingress Controller within AKS.
 
  - **Ingress Controller Checks Path Rules**: The Ingress Controller checks if any Ingress resource has a path rule that matches ```/shipping/orders```. Since this configuration has a path rule of ```/shipping(/|$)(.*)```, this request matches and is accepted.
 
  - **Routing to Service**: The Ingress Controller then forwards the request to ```shipping-service-svc``` on port 80.
 
  - **Service to Pods**: The ```shipping-service-svc``` service load-balances the request to one of the available ```shipping-service Pods```, which processes the request and returns the response.
 
  - **Response**: The response travels back through the Service, Ingress Controller, and Load Balancer to the user.
 
- **When to Use This Configuration**

  This kind of hostless Ingress configuration is commonly used when:
  - The service should respond to requests on any hostname.
  - The service is internal or accessed only through IP, rather than a specific domain.
  - You’re setting up a simple routing rule in a development or testing environment.
 
  In production, it’s often a best practice to specify a host to improve security, control, and organization (e.g., to separate different applications by domain). However, omitting the host can simplify things for internal or non-production services.

<br>
<br>
<hr>

## Example (Lab):
