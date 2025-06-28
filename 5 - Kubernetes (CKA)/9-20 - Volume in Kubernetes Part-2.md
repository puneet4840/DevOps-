# Volume in Kubernetes Part-2

We will see ConfigMap and Secret ko POD main volume mount kaise karte hain.

<br>

### ConfigMap and Secret as Volume Mount in POD.

<br>

**ConfigMap**

ConfigMap ek Kubernetes ka object hai jo tumhare configuration data jaise environment values ko key-value pair ke form mein store karta hai.

Example:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  APP_ENV: production
  APP_PORT: "8080"
```

Tumhare applications ko kabhi kabhi config chahiye hoti hai:
- Environment variables.
- Properties files.
- JSON, YAML files.

Yeh configs tum images mein hardcode nahi karte. Instead, tum ConfigMap mein store karte ho → taaki tumhara app flexible ho jaye.

<br>

**Secret**

Secret bhi same concept hai jaise ConfigMap, par yeh sensitive data store karta hai:
- Passwords.
- API tokens.
- Certificates.

Secret data Base64 encoded hota hai.

Example:
```
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  DB_PASSWORD: cGFzc3dvcmQ=
```

Yahan:
- ```cGFzc3dvcmQ=``` → Base64 encoded string hai jo “password” ko represent karta hai.

<br>
<br>

### ConfigMap Aur Secret Ko Pod Mein Kaise Use Karte Hain?

Tum do tarike se use kar sakte ho:
- **Environment Variables** → Pod ke containers ke environment variables ke through.
- **Volumes** → File ke form mein container ke andar mount karke.

Aaj hum focus kar rahe hain Volumes par.

<br>
<br>

### ConfigMap as Volume

**Kaise Kaam Karta Hai?**
- Tumhare ConfigMap ke andar jo keys hain, woh sab files ke naam ban jaati hain. Iska matlab key ke naam se ek file create ho jate hai jiske ander value store rehti hai.
- Un files ke andar values likhi hoti hain.
- Matlab ek ConfigMap tumhare container ke andar ek folder ke form mein mount hoti hai → jisme ek-ek file bani hoti hai for each key.

<br>

**Example: ConfigMap Create Karna**

Pehle ek ConfigMap create karte hain:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  APP_ENV: production
  APP_PORT: "8080"
```

<br>

**Ab isse Pod mein Volume ke form mein mount karte hain**:
```
apiVersion: v1
kind: Pod
metadata:
  name: configmap-volume-demo
spec:
  containers:
    - name: demo-container
      image: busybox
      command: ["/bin/sh", "-c", "cat /etc/config/APP_ENV; cat /etc/config/APP_PORT; sleep 3600"]
      volumeMounts:
        - name: config-volume
          mountPath: /etc/config
  volumes:
    - name: config-volume
      configMap:
        name: my-config
```

Explanation: Is Example Mein Kya Ho Raha Hai?
- Tumne ConfigMap banayi → ```my-config```.
- Tumne Pod ke andar volume define kiya:
  ```
  volumes:
    - name: config-volume
      configMap:
        name: my-config
  ```
- Tumne container mein mount kiya:
  ```
  mountPath: /etc/config
  ```

<br>

**Result**:

- Container ke andar yeh files ban jaati hain:
```
/etc/config/APP_ENV
/etc/config/APP_PORT
```

- Aur inka content hota hai:
  - ```/etc/config/APP_ENV → production```.
  - ```/etc/config/APP_PORT → 8080```.
 
Check Kaise Karoge?:

Pod ke andar jaake check karo:
```
kubectl exec -it configmap-volume-demo -- cat /etc/config/APP_ENV
```
Output:
```
production
```

<br>
<br>

### Secret as Volume

**Kaise Kaam Karta Hai?**
- Same mechanism jaise ConfigMap:
  - Tumhare Secret ke andar jo keys hain, woh container ke andar files ban jaati hain.
  - Un files ke andar values likhi hoti hain (Base64 decoded form mein).

<br>
 
**Example: Secret Create Karna**

Pehle Secret create karo:
```
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  DB_PASSWORD: cGFzc3dvcmQ=
  DB_USER: dXNlcg==
```

- ```DB_PASSWORD = password```
- ```DB_USER = user```

<br>

**Ab isse Pod mein Volume ke form mein mount karte hain**

```
apiVersion: v1
kind: Pod
metadata:
  name: secret-volume-demo
spec:
  containers:
    - name: demo-container
      image: busybox
      command: ["/bin/sh", "-c", "cat /etc/secret/DB_USER; cat /etc/secret/DB_PASSWORD; sleep 3600"]
      volumeMounts:
        - name: secret-volume
          mountPath: /etc/secret
  volumes:
    - name: secret-volume
      secret:
        secretName: my-secret
```

Explanation: Is Example Mein Kya Ho Raha Hai?
- Tumne Secret banaya → ```my-secret```.
- Tumne Pod mein volume define kiya:
```
volumes:
  - name: secret-volume
    secret:
      secretName: my-secret
```
- Tumne container mein mount kiya:
```
mountPath: /etc/secret
```
- Container ke andar ban jaati hain yeh files:
```
/etc/secret/DB_PASSWORD
/etc/secret/DB_USER
```

Aur contents:
- ```/etc/secret/DB_PASSWORD → password```.
- ```/etc/secret/DB_USER → user```.

Check Kaise Karoge?:

Pod ke andar jaake:
```
kubectl exec -it secret-volume-demo -- cat /etc/secret/DB_USER
```
Output:
```
user
```

