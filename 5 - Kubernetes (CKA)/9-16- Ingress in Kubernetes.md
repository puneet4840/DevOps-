# Ingress in Kubernetes

Ingress is a resource in kubernetes which is used to manage external access to service within a kubernetes cluster. 

```Ingress kubernetes का एक resource है जो external traffic को kubernetes की services तक पहुचता है मतलब application को outside world के लिए expose करता है मतलब users ingress के through kubernetes पर deployed application को internet के through access कर पाएंगे|```

In a Kubernetes cluster, applications often need to be accessed from outside the cluster, such as a website that users access via the internet. Ingress is a Kubernetes resource designed to expose such services to external clients, typically via HTTP or HTTPS.

<br>

Kubernetes mein agar humein apne cluster ke andar chal rahi applications ko bahar se access karna hota hai, toh humein ek mechanism chahiye hota hai jo external traffic (jaise user ka browser ya API client) ko correct pod/service tak le jaye.

By default, pods ek cluster-internal IP par run karte hain, jo directly bahar se accessible nahi hota. Iske liye hum Service banate hain (ClusterIP, NodePort, LoadBalancer). Lekin agar tumhare paas multiple microservices hain aur tum chahte ho ki ek hi domain (jaise myapp.com) ke andar alag-alag paths/hostnames ke through traffic route ho, toh waha Ingress use hota hai.

Ingress = ek tarah ka Smart HTTP/HTTPS router jo request ko route karta hai based on hostname aur path.

Example:
- ```myapp.com/api``` → backend service-1
- ```myapp.com/web``` → backend service-2
- ```shop.myapp.com``` → backend service-3

<br>

### Ingress Kyu Zaroori Hai? (Use Cases)

Socho tumhare paas ek ecommerce app hai jisme multiple microservices hain:
- frontend-service (React/Angular UI).
- catalog-service (product list API).
- order-service (order API).
- payment-service (payment API).

Agar tum har ek service ko NodePort/LoadBalancer banate ho toh har service ke liye alag public IP / port manage karna padega. Ye complex ho jaata hai.

Ingress ke saath:
- Tum bas ek hi LoadBalancer use karte ho.
- Baaki sab traffic routing rules Ingress handle karta hai.
- SSL/TLS termination easily ho jata hai (HTTPS setup).
- Host-based aur path-based routing dono milta hai.

<br>


### Why do we need Ingress?

```हमको पता है की जब appllication को kubernetes cluster पर deploy करते है तो उस application को access करने के लिए हम service बनाते हैं खासकर application को internet कर access करना होता है तो Load Balancer type की service बनाते है| तो ये Load Balancer type की service cloud पर एक Load Balancer create कर देती है जिससे Load Balancer पर request भेजकर application को access करते हैं| जब यहाँ तक सब चीज़ ठीक चल रही थी तो ये Ingree नाम की चीज़ क्यों आयी|```

```क्युकी kubernetes मैं service की कुछ disadvantages होती हैं जिसको हम Ingress से solve कर सकते हैं जैसे की: ```

- ```Service को सिर्फ हम cloud clusters पर ही use कर सकते हैं मतलब cloud मैं जब हम cluster बनाते है जैसे AKS, EKS, GKE इन clusters पर ही Load Balancer type सर्विस कर use होता है क्युकी जब service Load Balancer type की होती है तो service को Load Balancer cloud ही provide करता है| इसका मतलब है की Load Balancer type की service सिर्फ cloud dependent होती है जो एक disadvantage है|```

- ```अगर Kubernetes Cluster मैं हमने एक web application deploy की, तो उस web application को internet पर access करने के लिए load balancer type की service बनानी पड़ेगी जिससे एक load balancer web application के लिए cloud पर create हो जायेगा| Suppose अगर हमारे पास ऐसी 10 web applications है और वो हम kubernetes पर deploy कर रहे हैं तो उन सभी वेब एप्लीकेशन को इंटरनेट पर एक्सेस करने के लिए अलग-अलग load balancers क्रिएट करने होंगे मतलब 10 web applications के लिए 10 load balancers create होंगे जिससे होगा ये की इतने सारे load balancers की cost हमको pay करनी पड़ेगी और ऐसा scenario efficient नहीं है तो हर application को internet पर expose करने के लिए load balancer का use न करके हम Ingress resource का use करते हैं|```.

<br>
<br>

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
<br>

### Working of Ingress Example

- Ek nginx app hai aur ek notes app hai.
- Dono sirf ClusterIP service ke saath expose kiye gaye hain (matlab cluster ke andar hi accessible hain, bahar se nahi).
- Requirement: Dono ko ek hi IP se access karna hai, jaise:
  - ```http://<same-ip>/nginx``` → nginx app.
  - ```http://<same-ip>/notes``` → notes app.
 
Yehi kaam Ingress karta hai.

**Traditional Approach (NodePort / LoadBalancer)**:
- Agar tum NodePort/LB service banate toh har ek app ke liye alag port/IP lagti.
- Har app ke liye alag IP/port manage karna padta → messy & costly.

**Ingress Approach**:
- Step 1: Ingress Controller Install Karo:
  - Ingress tabhi kaam karta hai jab ek Ingress Controller cluster me run ho (jaise NGINX Ingress Controller).
  - Ye ek pod/deployment hota hai jo sab external traffic receive karta hai.
    
- Step 2: Applications Deploy Karo:
  - Har app (nginx + notes) ko Deployment aur ClusterIP service ke saath deploy karo.
  - Example:
    - nginx-service (port 80 → nginx pods).
    - notes-service (port 80 → notes pods).
  - Dono sirf cluster ke andar available rahenge.

- Step 3: Ingress Resource Banao:
  - Ek Ingress YAML likho jisme path-based routing rules ho.
  - Ye Ingress Controller ko bata dega ki kaunsi request kahan forward karni hai.
 
- Step 4: Access From Outside:
  - Ingress Controller ek LoadBalancer/NodePort service ke saath expose hota hai.
  - Us IP/domain ko use karke tumhar apps accessible ho jaate hain:
    - ```http://<Ingress-IP>/nginx``` → nginx app.
    - ```http://<Ingress-IP>/notes``` → notes app.

<br>
<br>

### Components of Ingress

Ingress ek API object hai jo cluster ke andar chalne wale applications (services/pods) ko bahar se HTTP/HTTPS traffic ke liye expose karta hai.

Iske andar kuch core components hote hain jo milke kaam karte hain.

- Ingress Resource (YAML Congiguration).
- Ingress Controller (Pod and Service).
- Ingress Class.
- Backend Services (ClusterIP/NodePort/LoadBalancer).

<br>

**1 - Ingress Resource (YAML Configuration)**:

Ye ek YAML configuration object hai jo define karta hai ki traffic ko kaise route karna hai. Actual main ye ek yaml file hoti hai jisme hum likhte hain ki request ko kaise aur kaha route karna hai.

```Ingress resource ingress को define करने के लिए एक Yaml file होती है जिसमे मैं हम define करते हैं की जब ingress से kubernetes service पर external request आएगी तो उस request को कोनसी kubernetes service पर transfer करना है|```

Isme hum define karte hain:
- Hostnames (domain names) → jaise app.example.com
- Paths (URL routes) → jaise /api, /shop, /blog
- Backend services → kis service ko request bhejni hai

Ye sirf ek rule set hai. Ye khud se traffic handle nahi karta. Traffic ko handle karne ka kaam Ingress Controller karega.

Example of Ingress Resource:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
spec:
  rules:
  - host: shop.example.com
    http:
      paths:
      - path: /cart
        pathType: Prefix
        backend:
          service:
            name: cart-service
            port:
              number: 80
      - path: /order
        pathType: Prefix
        backend:
          service:
            name: order-service
            port:
              number: 80
```
<br>

Example of Ingress Resource:
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

**2 - Ingress Controller**:

Ingress Controller ek software component (controller pod) hai jo Kubernetes ke andar run hota hai aur Ingress Resources (rules) ko implement karta hai.
- Kubernetes sirf ek Ingress API object deta hai, matlab ek yaml configuration deta hai (rules likhne ke liye).
- Lekin vo rules tab tak kaam nahi karenge jab tak ek Ingress Controller na ho jo unko implement kare.

Kubernetes ek built-in Ingress Controller provide nahi karta. Tumhe apna controller install karna padta hai.

Kuch popular Ingress Controllers hain:
- NGINX Ingress Controller → sabse zyada use hota hai, open-source aur stable.
- HAProxy Ingress Controller → high performance.
- Traefik → simple, modern, auto-discovery.
- Envoy/Istio Gateway → service mesh world me
- Cloud Specific:
  - AWS ALB Ingress Controller
  - Azure Application Gateway Ingress Controller
  - GCP Load Balancer Controller

Tumko ingress use karne ke liye alag se ingres ko setup karna hoga, jisme ingres controller setup hota hai.

Jab hum Ingress Controller (jaise NGINX Ingress Controller) deploy karte hain, vo ek Deployment/DaemonSet ke form mein pods run karta hai.

Lekin pods ke paas apna public IP nahi hota. Pods to cluster ke andar internal IPs pe chalte hain.

Client ko agar bahar se access karna hai (internet se), to hume Ingress Controller ko expose karna padta hai.

Yahan aati hai Service ki zarurat.

Ingress Controller Service:
- Jab hum Ingress Controller install karte hain (Helm/YAML se), uske saath ek Service create hoti hai jo Ingress Controller ke pods ko expose karti hai.

Ye service kuch is tarah hoti hai:
```
apiVersion: v1
kind: Service
metadata:
  name: ingress-nginx-controller
  namespace: ingress-nginx
spec:
  type: LoadBalancer
  ports:
  - name: http
    port: 80
    targetPort: http
  - name: https
    port: 443
    targetPort: https
  selector:
    app.kubernetes.io/name: ingress-nginx
```
- ```type: LoadBalancer``` → Yeh batata hai ki Kubernetes cloud provider ko bolega ek external load balancer allocate karo.
- ```ports: 80, 443``` → Yehi ports se client traffic aayega.
- ```selector``` → Yeh service Ingress Controller pods ko select karegi.

Agar tum Cloud Provider (AWS, Azure, GCP) pe Kubernetes cluster main ho:
- Jaise hi Service ```type=LoadBalancer``` banti hai, cloud provider automatically ek external Load Balancer create kar deta hai.
- Is load balancer ko ek public IP assign hoti hai.
- Aur ye hi public ip ingres controller ko assign ho jati hai.

Iska matlab hai ki Ingres Controller ko jab hum apne cluster main setup karte hain to sabse pehle ek ingres controller pod create hota hai, us pod ko expose karne ke liye ek load balancer type ki service create hoti hai, fir vo service cloud main ek Load Balancer create karti hai aur load balancer ki public ip ingres controller pod ko assign ho jati hai.

Isi ip ko use karke hum applications ko access karte hain.

Agar tum KIND ya miki-kube cluster use kar rahe ho to controller ko nodePort ki ip assign hoti hai.

Flow with LoadBalancer IP:
- Tumne Ingress Controller Service type=LoadBalancer banayi.
- Azure/AWS automatically ek load balancer banata hai aur usko ek IP deta hai, maan lo:
  ```
  20.55.88.10
  ```
- Ab client jab bhi http://20.55.88.10 ya tumhara domain (jo is IP pe point kiya hai) access karega →
  - Request pehle Cloud Load Balancer pe aayegi.
  - Cloud Load Balancer request ko cluster ke ek node ke NodePort pe bhejega.
  - Wahan se Ingres Service → Ingress Controller pod ko forward karegi.
  - Ingress Controller apne ingres rules ke hisaab se backend services ko forward karega.

<br>

**3 - Ingress Class**:
- Ingress class ek selector/identifier hai jo batata hai ki kaunsa Ingress Controller is Ingress ko handle karega.
- Ek cluster me multiple Ingress Controllers ho sakte hain. Example:
  - ```nginx``` Ingress Controller.
  - ```traefik``` Ingress Controller.

Agar apke cluster main multiple ingres controller installed hain to apko ingress claas main mention karna hoga ki konsa ingress controller ingress resource ko handle karega, sirf ye hi use hota hai ingress class ka.

Example:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-ingress
spec:
  ingressClassName: nginx
  rules:
  - host: api.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
```
- Yahan ```ingressClassName: nginx``` ka matlab hai ki sirf NGINX Ingress Controller isko process karega.

<br>

**4 - Backend Services (ClusterIP/NodePort/LoadBalancer)**:
- Pods ko expose karne ke liye jo service created hoti hain, jaise nginx pod ko expose karna hai uske liye hum clusterIp type ki service bana denge, to isi ko hum bakend services bolte hain.
- Ingress ka ultimate kaam hai request ko ek Kubernetes Service tak bhejna.
- Service ka type mostly ClusterIP hota hai (kyunki Ingress controller already LoadBalancer ya NodePort ke through expose hota hai).
- Service ke peeche Pods hote hain jo actual application run kar rahe hote hain.

Example Flow:
- Ingress rule → /order → order-service (ClusterIP: 10.96.23.15) → pods of order-service.

<br>
<br>

### How to Set Up an Ingress Controller (Example: NGINX Ingress Controller)

Setting up an Ingress Controller involves deploying it within your cluster, configuring the necessary services, and then defining Ingress resources to route traffic to services.

- **Install the NGINX Ingress Controller**:

  You can install the NGINX Ingress Controller using kubectl and a YAML file provided by the Kubernetes project. This file contains the deployment and service specifications for the NGINX Ingress Controller.

  ```
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
  ```

  This deployment sets up the NGINX Ingress Controller within your cluster. By default, it creates a LoadBalancer service to expose the Ingress Controller, allowing external traffic to be routed through it.

Ye install karega:
- ```nginx-ingress-controller``` pod (Deployment).
- Ek ```Service type=LoadBalancer``` jo external IP expose karega.
- Ek ```ConfigMap``` for custom settings

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
<br>

### What is path based routing OR host based routing

Socho tumhare paas ek cluster hai jisme tumne multiple services deploy ki hain. Example:
- ek **Todo App** service.
- ek **Notes App** service.
- ek **User Profil**e service.
- ek **Analytics** service.

Ab problem kya hoti hai?
- Har ek service ki apni ClusterIP hoti hai jo cluster ke andar hi accessible hai.
- Agar tum directly external world se connect karna chahte ho to ya to har ek service ko LoadBalancer type service banana padega (jo har ek service ke liye ek alag external IP allocate karega), ya phir ek Ingress banakar ek hi external IP se sabhi services ko route kar sakte ho.

Ingress ka kaam hi ye hai ki ek single entry point (LoadBalancer IP ya domain) ke through multiple applications/services ko expose kare.
- Lekin question ye hota hai: traffic ko kis service tak bhejna hai?
- Aur ye decide karna ki kis request ko kis service tak bhejna hai, wahi kaam karte hain routing rules:

Iske liye Ingress 2 main mechanisms deta hai:
- **Host-based Routing** → Hostname (domain) ke basis pe route hota hai.
- **Path-based Routing** → URL path ke basis pe route hota hai.

<br>

**Path-Based Routing**:

Path-based routing me tum ek hi host/domain (ya IP) ke andar multiple URL paths define karte ho aur unko alag-alag backend services ke saath map karte ho.

Iska matlab:
- Agar request me path ```/todo``` aaya to wo todo-service tak jaye.
- Agar request me path ```/notes``` aaya to wo notes-service tak jaye.
- Agar request me path ```/profile``` aaya to wo profile-service tak jaye.

Example Scenario:

Maan lo tumhare paas ek external IP hai: ```20.55.100.25```:
- ```http://20.55.100.25/todo``` → todo-service.
- ```http://20.55.100.25/notes``` → notes-service.
- ```http://20.55.100.25/profile``` → profile-service.

Ek hi IP par tumne teen alag alag microservices chala diye. Ye hi fayda hota hai ingress ka. Agar tumne simple load balancer service ke through in applications ko expose karna hota to tumko 3 alag alag load balancers banane padte, jo thik nahi hai.

<br>

**YAML (Path-based Example)**:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: todo-ingress
spec:
  rules:
  - http:
      paths:
      - path: /todo
        pathType: Prefix
        backend:
          service:
            name: todo-service
            port:
              number: 80
      - path: /notes
        pathType: Prefix
        backend:
          service:
            name: notes-service
            port:
              number: 80
      - path: /profile
        pathType: Prefix
        backend:
          service:
            name: profile-service
            port:
              number: 80
```

<br>

**Request Flow (Path-based)**:
- User ne apne browser me request dali:
```
http://20.55.100.25/todo
```
- Request pehle jaati hai Cloud LoadBalancer (jo Ingress controller ke liye allocate hua hai).
- LoadBalancer request ko forward karta hai Ingress Controller pod ko (jaise NGINX Ingress Controller).
- Ingress controller apni rules ki table check karta hai.
  - Rule: agar path ```/todo``` se start hota hai → backend service: todo-service.
- Ingress controller request ko todo-service ke ClusterIP pe bhej deta hai.
- Kube-proxy ya kube-proxy ka iptables rule request ko actual pod tak pahucha deta hai.
- User ko response milta hai directly todo-service ka.

<br>
<br>

**Host-Based Routing**:

Host-based routing me path important nahi hota. Yaha domain name (host) decide karta hai ki request kis service ko jaye.

Example:
- ```http://todo.example.com``` → todo-service.
- ```http://notes.example.com``` → notes-service.
- ```http://profile.example.com``` → profile-service.

Example Scenario:

Maan lo tumne DNS configure kiya hua hai load balancer ki ip par:
- ```todo.example.com``` → IP ```20.55.100.25```.
- ```notes.example.com``` → IP ```20.55.100.25```.
- ```profile.example.com``` → ```IP 20.55.100.25```.

Yani 3 alag domains ek hi LoadBalancer IP pe map hote hain, aur Ingress unke host header ke basis pe decide karta hai ki kaunsi service ko bhejna hai.

**YAML (Host-based Example)**:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: todo-ingress
spec:
  rules:
  - host: todo.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: todo-service
            port:
              number: 80
  - host: notes.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: notes-service
            port:
              number: 80
  - host: profile.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: profile-service
            port:
              number: 80
```

<br>

**Request Flow (Host-based)**:
- User ne apne browser me request dali:
```
http://todo.example.com
```
- Request LoadBalancer IP pe aayi.
- LoadBalancer ne isko Ingress Controller ko bheja.
- Ingress controller HTTP request ka Host header check karega.
  - Host header: ```todo.example.com```
  - Rule: agar ```host = todo.example.com``` → backend service: ```todo-service```.
- Request todo-service tak forward ho gayi.
- Pod ne response bhej diya user ko.

<br>

**Combined Use Case – Host + Path**:

Real production systems me dono concepts ek saath use hote hain.

Example:
- ```shop.example.com/cart``` → cart-service.
- ```shop.example.com/order``` → order-service.
- ```blog.example.com/``` → blog-service


Example Scenario:

Socho tum ek company ke paas do alag applications chala rahe ho:
- Ecommerce App (shop related services).
- Blog App (articles related services).

Aur unke andar bhi multiple microservices hain:
- Ecommerce App → services:
  - ```/cart``` → cart-service.
  - ```/order``` → order-service.
  - ```/products``` → product-service
- Blog App → services:
  - ```/ (homepage)``` → blog-service.
  - ```/admin``` → blog-admin-service

Combined YAML Example:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: combined-ingress
spec:
  rules:
  - host: shop.example.com
    http:
      paths:
      - path: /cart
        pathType: Prefix
        backend:
          service:
            name: cart-service
            port:
              number: 80
      - path: /order
        pathType: Prefix
        backend:
          service:
            name: order-service
            port:
              number: 80
      - path: /products
        pathType: Prefix
        backend:
          service:
            name: product-service
            port:
              number: 80

  - host: blog.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: blog-service
            port:
              number: 80
      - path: /admin
        pathType: Prefix
        backend:
          service:
            name: blog-admin-service
            port:
              number: 80
```

Flow Example:

Case 1: Ecommerce App (shop.example.com)
- User request →
```
http://shop.example.com/cart
```
- Request LoadBalancer IP → Ingress Controller.
- Ingress rule check:
  - Host = ```shop.example.com```
  - Path = ```/cart```
  - Service = cart-service.
- Request cart-service ke pod tak pahunchti hai.

<br>
<br>

### Ingress Workflow (When a user send a request to load balancer).

**Scenario Setup**:
- Tumne ek todo app deploy kiya hai Kubernetes me.
- ```todo-service``` ek ClusterIP service hai jo pods ko map karti hai.
- Tumne ek Ingress Resource banaya hai jisme ```/todo``` path ```todo-service``` pe jaata hai.
- Tumne ek Ingress Controller (NGINX) install kiya hai with Service type=LoadBalancer.
- Cloud provider (jaise Azure/AWS) ne tumhare Ingress Controller ko ek public IP allocate ki:
```
20.55.100.25
```
- Ab user isi IP ko use karke app access karega.

<br>

**Ingress Workflow**:

<br>

**Step 1: User Request Initiates**:
- User browser kholta hai aur likhta hai:
```
http://20.55.100.25/todo
```
- Ye request ek normal HTTP GET request hoti hai.

<br>

**Step 2: Request Reaches Cloud Load Balancer**:
- ```20.55.100.25``` jo IP hai, vo actually cloud provider ke Load Balancer ki IP hai.
- Request pehle external Load Balancer pe aati hai.

Example: Azure Application Gateway / AWS NLB.

<br>

**Step 3: Load Balancer to Kubernetes Node**:
- Cloud Load Balancer check karta hai ki uske backend me kaunse Kubernetes nodes associated hain.
- Ye request kisi ek healthy node pe bhej deta hai.
- Jaise maan lo cluster me 3 nodes hain → Node1, Node2, Node3.
- Load Balancer ne request Node2 ke ek port pe bhej diya (jo NodePort automatically assign hua hai service ke liye).

<br>

**Step 4: Service (LoadBalancer Type) → Ingress Controller Pods**:
- Cluster ke andar ```Service type=LoadBalancer``` bana tha jo Ingress Controller pods ko expose karta hai.
- Ye service NodePort/IPVS/iptables ke through request ko Ingress Controller Pod tak route karti hai.
- Ab request Ingress Controller (NGINX) pod ke paas aa gayi.

<br>

**Step 5: Ingress Controller Processing**:
- Ingress Controller apne paas stored Ingress Resource rules check karega.
- Rule kuch aisa hoga:
```
rules:
- http:
    paths:
    - path: /todo
      pathType: Prefix
      backend:
        service:
          name: todo-service
          port:
            number: 80
```
- Controller dekhta hai ki request ka path ```/todo``` hai.
- Match milta hai → Rule ke hisaab se backend service = ```todo-service```.

<br>

**Step 6: Ingress Controller → Backend Service (todo-service)**:
- Ingress Controller ab request ko ClusterIP service ```todo-service``` ke IP pe forward karega.
- Example:
```
todo-service → ClusterIP: 10.96.12.45, Port: 80
```

<br>

**Step 7: Service → Pod Selection**:
- ```todo-service``` ke backend me multiple pods run ho rahe hain (replicas). Example:
  - Pod1: 10.244.1.15:8080
  - Pod2: 10.244.2.20:8080
- Kube-proxy + iptables/IPVS decide karega ki request kis pod ko bhejna hai (round-robin ya random).
- Maan lo is request ko Pod1 mila.

<br>

**Step 8: Pod Processes the Request**:
- Ab request Pod1 (todo container) ke andar app ke HTTP server (Flask/Express/Spring etc.) pe chali gayi.
- Pod request process karega → DB se data fetch karega (agar needed) → response generate karega.

<br>

**Step 9: Response Returns**:
- Pod response Ingress Controller ko deta hai.
- Ingress Controller response wapas LoadBalancer ko deta hai.
- LoadBalancer response wapas client ko bhej deta hai.
- Browser me user ko todo app ka response show ho jaata hai.





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
