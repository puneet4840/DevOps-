# Two-Tier application deployment on kubernetes.

<br>

### Application Overview

Humare paas python(flask) ki two-tier todo application hai. Ek frontend and hai aur ek database hai. Isme ek container mein python application ko run karna hota hai aur dusre container mein mysql database ko run karna hota hai.

Lekin pehle database ko run karna hota hai, fir frontend application ko, tab jake application database se connect hota hai. Ye process hai docker ke through application run karne ki, ab aage hum kubernetes par application deploy karenge.

<br>
<br>

### STEP 1: Project folder banao

```
mkdir two-tier-k8s-lab
cd two-tier-k8s-lab
```

Is folder ke andar saare YAML files rakhenge.

```
two-tier-k8s-lab
|- deployment-mysql.yaml
|- deployment-todo.yaml
|- service-mysql.yaml
|- service-todo.yaml
|- namespace.yaml
```

<br>

### STEP 2: Namespace banao

Namespace mein hum apni app ko logically isolate karenge. 

```namespace.yaml```
```
apiVersion: v1
kind: Namespace
metadata:
  name: two-tier-app
```

Namespace yaml apply karo:
```
kubectl apply -f namespace.yaml
```

Expected output:
```
namespace/two-tier-app created
```

Verify karo:
```
kubectl get ns
```

Output mein ```two-tier-app``` dikhega:
```
NAME              STATUS   AGE
default           Active   ...
kube-system       Active   ...
two-tier-app      Active   5s
```

<br>
<br>

### STEP 3: MySQL Deployment ko deploy karo

Pehle hum database deploy karenge kyuki todo-app ki dependency database, iska matlab hai ki app ko run hone se pehle database ke saath connectivity chaiye hoti hai. Isliye database create karenge. Agar pehle app ka pod run kar diya to error dega run nhi hoga.

```deployment-mysql.yaml```
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
  labels:
    app: mysql
  namespace: two-tier-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:latest
        ports:
        - containerPort: 3306
        env:
          - name: MYSQL_ROOT_PASSWORD
            value: "root"
          - name: MYSQL_DATABASE
            value: "devops"
```

Apply MySQL Deployment:
```
kubectl apply -f mysql-deployment.yaml
```

Output:
```
deployment.apps/mysql-deployment created
```

MySQL Pod status check karo:
```
kubectl get pods -n two-tier-app
```

Thodi der baad aisa kuch dikhna chahiye:
```
NAME                               READY   STATUS    RESTARTS   AGE
mysql-deployment-5d7c9b67f-jklsd   1/1     Running   0          20s
```

<br>

### STEP 4: MySQL Service ko deploy karo

Ab MySQL Pod ko cluster ke andar stable name se expose karenge.

```service-mysql.yaml```
```
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
  namespace: two-tier-app
spec:
  selector:
    app: mysql
  ports:
    - port: 3306
      targetPort: 3306
```

Apply Service:
```
kubectl apply -f service-mysql.yaml
```

Output:
```
service/mysql-service created
```

Service verify karo:
```
kubectl get svc -n two-tier-app
```

Expected Output:
```
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
mysql-service   ClusterIP   10.96.123.45    <none>        3306/TCP   5s
```

Iska matlab:
- MySQL pod ab cluster ke andar host name ```mysql-service``` se reachable hai.

<br>
<br>

### STEP 5: TODO App ko deploy karo:

Ab application layer deploy karte hain jo Flask TODO app hai.

```deployment-todo.yaml```
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: todo-app-deployment
  labels:
    app: todo-app
  namespace: two-tier-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: todo-app
  template:
    metadata:
      labels:
        app: todo-app
    spec:
      containers:
      - name: todo-app
        image: puneet1/my-todo-app:v1
        ports:
        - containerPort: 5000
        env:
          - name: MYSQL_HOST
            value: "mysql-service"
          - name: MYSQL_USER
            value: "root"
          - name: MYSQL_PASSWORD
            value: "root"
          - name: MYSQL_DB
            value: "devops"
```

Yaha sabse important cheez:
- ```MYSQL_HOST = mysql-service```: Is se todo-app mysql pod se connect hoga, kyuki pods service name se accessible hote hain.

Apply Deployment:
```
kubectl apply -f deployment-todo.yaml
```

Output:
```
deployment.apps/todo-app-deployment created
```

Pod status check karo:
```
kubectl get pods -n two-tier-app
```

Ab tumhe 2 Pods dikhenge:
```
NAME                                  READY   STATUS    RESTARTS   AGE
mysql-deployment-5d7c9b67f-jklsd      1/1     Running   0          5m
todo-app-deployment-7c8b9c5d8-klsjd   1/1     Running   0          20s
```

<br>

### Ab Flask app ko bahar se browser se access karne ke liye Service banaenge.

```service-todo.yaml```
```
apiVersion: v1
kind: Service
metadata:
  name: todo-app-service
  namespace: two-tier-app
spec:
  selector:
    app: todo-app
  ports:
    - port: 80
      targetPort: 5000
  type: LoadBalancer
```

Is service ko create karne se azure cloud par ek load balancer ban jayega aur service ko ek external-ip assign ho jayegi. 

```Apply Service```:
```
kubectl apply -f service-todo.yaml
```

Output:
```
service/todo-app-service created
```

Service status check karo:
```
kubectl get svc -n two-tier-app
```

Output:
```
NAME              TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
mysql-service     ClusterIP      10.96.123.45    <none>          3306/TCP       10m
todo-app-service  LoadBalancer   10.105.78.230   20.120.50.10       80:30080/TCP   10s
```

Cloud (AKS) mein kuch seconds/minutes baad ```EXTERNAL-IP``` fill ho jaayega.

<br>
<br>

### Connect to application

Ab browser mein EXTERNAL-IP ```20.120.50.10``` copy karo aur hit karo.

Apka app accessible ho jayega.
