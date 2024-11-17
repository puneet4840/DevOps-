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

- **Step 2: Authentication – Verifying Identity**

  The first thing the API server does is check who is making the request. It does this using **Authentication**.

  - **Identify the Authentication Method**:

    The API server checks the incoming request to identify the type of authentication used, which could be:

    - **Client Certificate** (from a kubeconfig file).
    - **Bearer Token** (e.g., a JWT token issued by an identity provider like Azure AD).
    - **Static Token File** (tokens configured in a file for quick setup).
    - **Webhook Token Authentication** (external service verifying tokens).

  - **Verify the Credentials**:

    - Based on the authentication method, the API server verifies the credentials.
    - For example, if it’s a token, it checks if the token is valid. If it’s a client certificate, it verifies the certificate.
    - If the authentication is successful, the API server identifies the user making the request.

  If authentication fails (e.g., invalid token or certificate), the API server returns an HTTP 401 Unauthorized error, and the request stops here.

- **Step 3: Authorization – Checking Permissions**

  Once the user is authenticated, the API server needs to check if they’re allowed to perform the requested action. This is done through **Authorization**.

  - **Identify the User’s Role and Permissions**:

    The API server looks up the user’s roles and permissions defined by Role-Based Access Control (RBAC) or other authorization methods like ABAC (Attribute-Based Access Control) or Webhook Authorization.

  - **RBAC Authorization Process**:

    In most Kubernetes setups, RBAC is the main authorization mechanism, where permissions are defined as Roles or ClusterRoles.

    The API server checks if there’s a Role or ClusterRole allowing the user to perform ```get``` on ```pods``` in the ```dev``` namespace.

    Specifically, the API server evaluates:

    - Verb: ```get```.
    - Resource: ```pods```.
    - Namespace: ```dev```.
    - User’s Roles: It looks for RoleBindings or ClusterRoleBindings that link the user to a Role or ClusterRole with this permission.
   
  - **Decision**:

    - If the user has permission, the API server proceeds to process the request.
    - If the user lacks permission, the API server returns an HTTP 403 Forbidden error, stopping the request here.
   
- **Step 5: Execute the Request**

  If the request passes authentication, authorization, and any applicable admission controls, the API server finally allows the action. For example:
  
  - The ```kubectl get pods``` request is executed, and the list of pods in the ```dev``` namespace is returned to the user.
