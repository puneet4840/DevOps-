# Config Maps and Secrets in Kubernetes

### Environment Variables in Kubernetes

Environement variables are the key-value pairs of information that is provided to the application inside container to use it at runtime.

In Kubernetes, environment variables are used to configure applications running in containers. Environment variables let you provide dynamic configuration settings like database URLs, API keys, or other configuration details to containers at runtime. Kubernetes allows you to set environment variables directly in the pod specification, or indirectly by using resources like ConfigMaps and Secrets.

Environment variables in Kubernetes are key-value pairs that can be injected into containers runtime without modifying the application code itself, allowing configuration to be externalized. In Kubernetes, you can define environment variables in multiple ways, such as:

- **Directly in the Pod Spec**: You can define environment variables directly within the pod specification in the manifest file.
- **From ConfigMaps**: ConfigMaps allow you to define configuration data as key-value pairs, which can then be referenced as environment variables in your containers.
- **From Secrets**: Similar to ConfigMaps, Secrets hold sensitive information, which can be referenced as environment variables.

**Defining Environment Variables Directly in the Pod Spec**

Here’s an example of how to set environment variables directly in a pod specification:

```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: example-container
    image: nginx
    env:
      - name: MY_ENV_VAR
        value: "This is a custom value"
      - name: APP_MODE
        value: "production"
```

In this example:
- The env field under the container specifies environment variables directly.
- MY_ENV_VAR and APP_MODE are set to "This is a custom value" and "production", respectively.

**Using Environment Variables from ConfigMaps and Secrets**

In larger deployments, directly specifying values for each environment variable may not be manageable or secure. Instead, you can use ConfigMaps and Secrets to manage configuration and sensitive information separately.

<br>

### ConfigMaps in Kubernetes

A ConfigMap in kubernetes is an api object which is used to store non-sensitive data in key-value pairs.

**Why Use ConfigMaps?**

ConfigMaps are useful for storing:
- Non-sensitive information such as application settings.
- URLs, database endpoints, and environment-specific configurations.
- Structured data in JSON or YAML format.

ConfigMaps provide a way to avoid hardcoding configuration data in the application and to separate the data from the application code, enabling flexibility across different environments (like development, staging, and production).

**Creating a ConfigMap**

You can create a ConfigMap in two primary ways:

- **Using a YAML Manifest**:

  ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: app-config
    data:
      DATABASE_URL: "postgres://user:password@hostname:5432/dbname"
      API_ENDPOINT: "https://api.example.com"
      LOG_LEVEL: "debug"
  ```

  Here, we define a ConfigMap called app-config with three keys: DATABASE_URL, API_ENDPOINT, and LOG_LEVEL.

- **Using kubectl create configmap Command**:

  ```kubectl create configmap app-config --from-literal=DATABASE_URL="postgres://user:password@hostname:5432/dbname" --from-literal=API_ENDPOINT="https://api.example.com" --from-literal=LOG_LEVEL="debug"```

  This command creates the same ConfigMap as the YAML example, directly from the command line.

<br>

- **Using ConfigMaps as Environment Variables**

  To use values from a ConfigMap as environment variables in a container:

  ```
  apiVersion: v1
  kind: Pod
  metadata:
    name: example-pod
  spec:
    containers:
    - name: example-container
      image: nginx
      env:
        - name: DATABASE_URL
          valueFrom:
            configMapKeyRef:
              name: app-config   # Reference to ConfigMap name
              key: DATABASE_URL  # Key to pull from ConfigMap
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: LOG_LEVEL
  ```

  In this example:

  - DATABASE_URL and LOG_LEVEL environment variables are populated with values from the app-config ConfigMap.
  - The valueFrom and configMapKeyRef fields allow Kubernetes to fetch specific keys from the ConfigMap.

<br>

**Mounting ConfigMaps as Files**

You can mount ConfigMaps as files inside a container, which is helpful when the application expects configuration in file format.

```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: example-container
    image: nginx
    volumeMounts:
      - name: config-volume
        mountPath: "/etc/config"
  volumes:
    - name: config-volume
      configMap:
        name: app-config
```

This configuration will mount each ConfigMap key as a file in the specified directory (```/etc/config```). For example, if the ConfigMap contains a key ```DATABASE_URL```, it will create a file ```/etc/config/DATABASE_URL``` containing its value.

<br>

### Secrets in Kubernetes

Kubernetes Secrets are a resource similar to ConfigMaps but designed to hold sensitive data, such as passwords, API keys, and SSL certificates. By storing sensitive information in a Secret, Kubernetes can protect this data from unauthorized access.

**Why Use Secrets?**

Secrets allow you to store sensitive data securely. The contents of a Secret are Base64-encoded, and access to them can be restricted via RBAC (Role-Based Access Control), ensuring that only authorized pods or users have access.

**Creating a Secret**

Secrets can be created in several ways:

- **Using YAML Manifest**:

  ```
    apiVersion: v1
    kind: Secret
    metadata:
      name: app-secret
    type: Opaque
    data:
      DB_PASSWORD: dXNlcnBhc3N3b3Jk  # Base64-encoded "userpassword"
      API_KEY: YXBpa2V5MTIz          # Base64-encoded "apikey123"
  ```

  - This Secret, ```app-secret```, contains two encoded values for ```DB_PASSWORD``` and ```API_KEY```.
  - You can encode values to Base64 using a command like ```echo -n 'userpassword' | base64```.

- **Using kubectl create secret Command**:

  ```kubectl create secret generic app-secret --from-literal=DB_PASSWORD="userpassword" --from-literal=API_KEY="apikey123"```

  - This command automatically encodes the values into Base64, creating the Secret ```app-secret``` with the same keys as above.

**Using Secrets as Environment Variables**

To reference Secret values as environment variables:

```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: example-container
    image: nginx
    env:
      - name: DB_PASSWORD
        valueFrom:
          secretKeyRef:
            name: app-secret  # Reference to Secret name
            key: DB_PASSWORD  # Key to pull from Secret
      - name: API_KEY
        valueFrom:
          secretKeyRef:
            name: app-secret
            key: API_KEY
```

In this example:
- ```DB_PASSWORD``` and ```API_KEY``` are set as environment variables from ```app-secret```.
- The ```valueFrom``` and ```secretKeyRef``` fields specify which keys to retrieve from the Secret.

**Mounting Secrets as Files**

You can also mount Secrets as files in a container:

```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: example-container
    image: nginx
    volumeMounts:
      - name: secret-volume
        mountPath: "/etc/secrets"
  volumes:
    - name: secret-volume
      secret:
        secretName: app-secret
```

This configuration creates files inside /etc/secrets, with each key in the Secret becoming a filename. For example, a key DB_PASSWORD in app-secret will result in a file /etc/secrets/DB_PASSWORD containing the decoded value.

<br>

**Key Differences: ConfigMaps vs. Secrets**

Feature  | ConfigMap  |  Secret 
------------- | -------------  |  -------------
Purpose  | Store non-sensitive configuration data   |  	Store sensitive data like passwords, tokens


