# Authentication and Authorization in Kubernetes

The Kubernetes API server is the central component that handles all communication with the Kubernetes cluster. It is the primary interface for users, applications, and even internal Kubernetes components to interact with the cluster. When it comes to **authentication** and **authorization**, the API server plays a key role by deciding who can access the cluster, what they can do, and where they can do it.

### Overview of the API Server in Kubernetes

The API server is a RESTful service that exposes the Kubernetes API, meaning it has a set of endpoints that handle different resources in Kubernetes, like Pods, Nodes, and ConfigMaps. The API server:

- Receives requests (e.g., ```kubectl get pods``` or a request from an application).
- Authenticates the request to verify the identity of the requester.
- Authorizes the request to determine if the requester has the necessary permissions.
- Passes the request to the appropriate component if it’s allowed.

### Step-by-Step Flow: How the API Server Handles a Request

Let’s go through each step that happens when a user sends a request to the API server, using ```kubectl``` as an example.

- **Step 1: User Sends a Request**

  Suppose you run a command like:

  ```kubectl get pods --namespace dev```

  This command sends an HTTP request to the Kubernetes API server. The request includes:
  - The action: ```get pods```.
  - The target namespace: ```dev```.
  - The user’s authentication credentials (like a certificate, token, or access code).

- **Step 2: Authentication – How Kubernetes Verifies the Identity of a Requester**

  The first thing the API server does is check who is making the request. It does this using **Authentication**.

  - **Identify the Authentication Method**:

    The API server checks the incoming request to identify the type of authentication used, which could be:

    - **Client Certificates** (for admins and some users):

      - Admins or Kubernetes users often use client certificates, which are small digital files proving their identity.
     
      - The administrator generates these certificates and provides them to each user who needs access. These certificates are usually embedded in the kubeconfig file, which kubectl uses to send requests to the cluster.

    - **Tokens** (commonly used in cloud-managed clusters like AKS, EKS, and GKE):

      - Cloud services like Azure AKS often use tokens for authentication. A token is like a temporary password or access code.
     
      - For example, in AKS (Azure Kubernetes Service), you can use az aks get-credentials to get your kubeconfig updated with tokens that allow access to the cluster. These tokens are usually issued by identity providers, such as Azure Active Directory (AD), and are often valid for a limited time.
     
    - **Service Accounts for Applications Inside the Cluster**

      - Applications running in Kubernetes use Service Accounts to authenticate. When a Service Account is created, Kubernetes generates a token specifically for that account.
     
      - When a pod runs, Kubernetes automatically places this token in a specific file location inside the pod (e.g., ```/var/run/secrets/kubernetes.io/serviceaccount/token```). The application can use this token to make requests to the API server, similar to how a user would authenticate.

  - **Verify the Credentials**:

    - Based on the authentication method, the API server verifies the credentials.
    - For example, if it’s a token, it checks if the token is valid. If it’s a client certificate, it verifies the certificate.
    - If the authentication is successful, the API server identifies the user making the request.

  If authentication fails (e.g., invalid token or certificate), the API server returns an HTTP 401 Unauthorized error, and the request stops here.

- **Step 3: Authorization – Checking Permissions**

  Once the user is authenticated, the API server needs to check if they’re allowed to perform the requested action. This is done through **Authorization**.

  - **Identify the User’s Role and Permissions**:

    The API server looks up the user’s roles and permissions defined by Role-Based Access Control (RBAC) or other authorization methods like ABAC (Attribute-Based Access Control) or Webhook Authorization.

  - **Role-Based Access Control (RBAC) for Authorization**:

    In most Kubernetes setups, RBAC is the main authorization mechanism, where permissions are defined as Roles or ClusterRoles.

    The API server checks if there’s a Role or ClusterRole allowing the user to perform ```get``` on ```pods``` in the ```dev``` namespace.

    **Roles and ClusterRoles**

    - A Role grants permissions to perform specific actions (like get, create, delete) on resources (like pods or services) within a specific namespace.
   
    - A ClusterRole grants permissions that apply cluster-wide (across all namespaces).
   
    **RoleBindings and ClusterRoleBindings**:

    - A RoleBinding links a Role to a specific user, group, or Service Account, allowing them to perform specific actions within a namespace.
      
    - A ClusterRoleBinding links a ClusterRole to a user, group, or Service Account, granting them permissions across the entire cluster.

    **Example Authorization Flow**

    Let’s say we want a developer to be able to view pods only in the dev namespace:

    - Create a Role: The admin creates a Role in the dev namespace that allows get and list actions on pods.
   
    - Create a RoleBinding: The admin then creates a RoleBinding to link this Role to the developer’s account.
   
    Now, when the developer sends a request to get pods in the dev namespace:
    - The API server checks if their RoleBinding allows this action.
    - Since the developer has the required permissions, the request goes through.
    - If the developer tries to access another namespace or perform restricted actions, the API server denies the request with a "403 Forbidden" error.

   
  - **Decision**:

    - If the user has permission, the API server proceeds to process the request.
    - If the user lacks permission, the API server returns an HTTP 403 Forbidden error, stopping the request here.
   
- **Step 5: Execute the Request**

  If the request passes authentication, authorization, and any applicable admission controls, the API server finally allows the action. For example:
  
  - The ```kubectl get pods``` request is executed, and the list of pods in the ```dev``` namespace is returned to the user.


<br>
<br>

### Working Example

Let’s break down the concepts of Kubernetes authentication and authorization step-by-step with a simple example. Imagine we have a Kubernetes cluster, and we want to understand how access to it is controlled for different users or applications. I'll walk you through the setup and flow of making a request to Kubernetes and explain how the system checks who you are and what you’re allowed to do.

**Scenario Overview**

Suppose we have a Kubernetes cluster running on Azure AKS (Azure Kubernetes Service). In this example:

- Alice is a developer who wants to view the details of a pod in the dev namespace.
- Bob is another user who tries to delete a pod in the same namespace.

We’ll go through how Alice and Bob would access the cluster and how Kubernetes determines what each person is allowed to do.

**1 - Setting Up Access to the Kubernetes Cluster**

When you create a Kubernetes cluster (like an AKS cluster), you set up who can access it. This setup involves a few steps:

- **Getting Authentication Credentials**

  The Kubernetes API Server needs to confirm who a requester is. To do this, users must have authentication credentials.

**How do users get these credentials?**

- **Certificates or Tokens**:

  - In AKS (Azure’s managed Kubernetes service), credentials are provided by Azure, which manages user authentication using tokens.
    
  - For example, when Alice wants to connect to the AKS cluster, she runs a command in her terminal:
    
    ```az aks get-credentials --resource-group myResourceGroup --name myAKSCluster```
    
  - This command configures her kubeconfig file (a configuration file kubectl uses) with a token that lets her connect to the AKS cluster. This token acts like an access card, proving her identity.

**Setting Up Service Accounts for Applications Inside the Cluster**

If an application (e.g., a web service) inside the cluster wants to interact with Kubernetes, it needs a Service Account.

- Service Accounts are special accounts created by Kubernetes for applications running in the cluster.

- When an application starts, Kubernetes gives it a token (just like a user token) that it can use to authenticate.

<br>

**2 - Making a Request to the Kubernetes API Server**

Now, let’s say Alice wants to see the list of pods in the dev namespace. She uses the following command:

```kubectl get pods --namespace dev```

What happens when Alice runs this command?

- kubectl (the Kubernetes command-line tool) reads her kubeconfig file to know:

  - The URL of the Kubernetes API server (where the request will be sent).
  - The token or certificate for authentication (to prove that she is Alice).

- kubectl sends an HTTP request to the API server with:

  - The action: get (meaning she wants to view information).
  - The resource: pods (she’s interested in pods).
  - The namespace: dev (she only wants pods in this specific namespace).
  - The token or certificate from her kubeconfig, proving her identity.

<br>

**3 - Authentication – Verifying Who Alice Is**

When the API server receives Alice's request, it starts by verifying who she is. This is the authentication step.

- **Identifying the Authentication Method**:

  - The API server sees that Alice’s request includes a token (issued by Azure AD when she set up her kubeconfig).

- **Verifying the Token**:

  - The API server checks the token to ensure it’s valid and not expired. Since the token came from Azure AD, the API server might use a Webhook Token Authentication to validate the token with Azure.

- **Authentication Success**:

  If the token is valid, the API server determines that the requester is indeed Alice. Now it knows who is making the request.

If the token were invalid or expired, the API server would reject the request with a 401 Unauthorized error, stopping further processing.

<br>

**4 - Authorization – Checking What Alice Can Do**

Now that the API server knows Alice’s identity, it checks whether she has permission to get pods in the dev namespace. This is the authorization step.

**Role-Based Access Control (RBAC) in Kubernetes**

Kubernetes uses RBAC (Role-Based Access Control) to control what users and applications can do in the cluster. RBAC has four main components:

- **Role**: Defines what actions (like get, create, delete) can be performed on which resources (like pods, services) within a specific namespace.
  - For example, a Role in the dev namespace might allow the get and list actions on pods.

- **ClusterRole**: Similar to a Role but applies across all namespaces in the cluster.

- **RoleBinding**: Links a Role to a specific user or group within a namespace.

- **ClusterRoleBinding**: Links a ClusterRole to a user or group across the cluster.

**Checking Alice’s Permissions**

- The API server checks if there’s a RoleBinding that links Alice to a Role allowing her to get pods in the dev namespace.

- If there is a matching RoleBinding, the request is authorized, and Alice can proceed.

- If there’s no matching RoleBinding, the API server rejects the request with a 403 Forbidden error.

For example, if an admin created the following Role and RoleBinding, Alice would have access to view pods:

```
# Role in dev namespace allowing get and list actions on pods
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: dev
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]

# RoleBinding linking the pod-reader Role to Alice
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: alice-pod-reader
  namespace: dev
subjects:
- kind: User
  name: "alice" # The name of the user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

In this example:

- The Role pod-reader allows get and list actions on pods within the dev namespace.
- The RoleBinding alice-pod-reader links Alice to the pod-reader Role in the dev namespace.

<br>

**5 - Admission Control – Applying Additional Policies (Optional)**

Once Alice's request passes authentication and authorization, the API server may apply additional admission control policies. These are optional checks that ensure requests meet specific rules or policies set by the cluster admin.

For example:
- ResourceQuota: An admission controller might limit the number of pods that can be created in a namespace.
- PodSecurityPolicy: It might enforce security constraints on pods to prevent risky configurations.

If any admission controller blocks the request, the API server returns an error explaining the policy violation.

<br>

**6 - Final Execution of the Request**

If Alice’s request passes all checks, the API server executes it:

- Reading Data: Since Alice requested to view pods, the API server reads the information from Kubernetes' data store (called etcd).

- Returning Data: The API server sends the requested information (a list of pods in the dev namespace) back to Alice’s kubectl command, which displays it to her on her terminal.

By following this series of checks, Kubernetes ensures that only authorized users and applications have access to the cluster and can perform only the actions they’re permitted to. This layered approach secures the Kubernetes environment, controlling access at every step.

