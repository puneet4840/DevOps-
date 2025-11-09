# Error: Unauthorized Access

<br>

### Pehle samjho — “Unauthorized Access” ka basic matlab kya hai?

Kubernetes world mein “Unauthorized Access” ka matlab hai — kisi component (user, serviceaccount, kubelet, controller) ne kisi resource ya endpoint ko access karne ki koshish ki, lekin uske paas permission nahi thi ya authentication fail ho gaya.

<br>
<br>

### Ye error kis-kis layer pe aa sakta hai?

| Layer                                            | Example Error Message                                         | Description                            |
| ------------------------------------------------ | ------------------------------------------------------------- | -------------------------------------- |
| **1. Kubernetes API Server (kubectl commands)**  | `Error from server (Unauthorized)`                            | User ke paas RBAC access nahi          |
| **2. Image Registry (ECR, GCR, DockerHub)**      | `Failed to pull image: unauthorized: authentication required` | Image pull ke liye credentials missing |
| **3. Ingress / Application level**               | `401 Unauthorized` in browser/API                             | App ke andar auth fail                 |
| **4. ServiceAccount / Pod-to-Pod communication** | `The token is invalid or expired`                             | ServiceAccount token ya role missing   |
