# Helm Chart in Kubernetes

Helm is a package manager for Kubernetes, similar to ```apt``` for Ubuntu or ```yum``` for CentOS. It simplifies the deployment and management of Kubernetes applications by using Helm charts, which are reusable and shareable packages of Kubernetes manifests.

When you deploy applications in Kubernetes, you need to create many files (YAML manifests) for different resources like Deployments, Services, ConfigMaps, and more. Helm simplifies this by bundling all these files together into a single package called a chart.

A Helm chart is a directory containing:

- ```Chart.yaml```: Metadata about the chart (name, version, description).
  
- ```values.yaml```: Default configuration values used by the templates. This values.yaml file contains the dynamic values which picked from values.yaml file and placed into the Yaml files (Deployment.yaml, service.yaml, etc).
  
- ```templates/```: A directory with Kubernetes manifest files (e.g., Deployment, Service) written as templates.

- Other Files:
  - ```README.md```: Documentation.
  - ```charts/```: Subcharts if needed.
  - ```requirements.yaml```: Dependencies for the chart.

<br>

## How Helm Chart helps.

Managing 20–30 microservices in Kubernetes is challenging, and **Helm charts** greatly simplify this task by providing structure, automation, and consistency. Let’s compare managing microservices with Helm and without Helm to understand its benefits.

**Scenario Setup**

Imagine you have a project with 30 microservices. Each microservice requires the following Kubernetes resources:

- Deployment.
- Service
- ConfigMaps.
- Ingress (optional).
- Secrets.

Each microservice might also have different configurations for environments (development, staging, production).

### 1. Managing Microservices Without Helm

**Challenges:**

- **Multiple YAML Files Per Microservice**

  Each microservice might have 4–5 YAML files. For 30 microservices, you’d manage 120–150 YAML files:

  - Deployment YAML.
  - Service YAML.
  - ConfigMap YAML.
  - Ingress YAML.

- **Environment-Specific Customizations**

  If you deploy to different environments, you need to manually modify values like:

  - Replica counts.
  - Resource limits.
  - Environment variables.
  - Image tags This means duplicating files for each environment, leading to inconsistent configurations and higher chances of errors..

- **Manual Updates**

  If you update a configuration (e.g., image tag or environment variable), you must edit multiple files manually, increasing the risk of errors.

- **No Standardization**

  Different developers might write YAML files differently, leading to inconsistencies in naming, labels, and annotations.

- **Complex Rollbacks**

  Rolling back changes is difficult because you need to track which YAML file or configuration caused the issue.

### Managing Microservices With Helm

**How Helm Helps:**

- **Single Chart for Each Microservice**

  Each microservice can have its own Helm chart. For example:

  - ```service-a``` Helm chart manages Deployment, Service, ConfigMaps, and Ingress for Service A.
  - ```service-b``` Helm chart does the same for Service B.
 
  All YAML files for a microservice are packaged into a single reusable chart.

- **Parameterization Using** ```values.yaml```

  Helm allows dynamic configurations using ```values.yaml```. Instead of duplicating YAML files for different environments, you just modify the ```values.yaml``` file for each environment:

  - ```values-dev.yaml```: Development-specific configurations.
  - ```values-prod.yaml```: Production-specific configurations.

  For Example:

  ```
  # values-dev.yaml
  replicaCount: 1
  image:
    tag: "1.0.0-dev"
  service:
    	type: ClusterIP

  # values-prod.yaml
  replicaCount: 5
  image:
    tag: "1.0.0"
  service:
    type: LoadBalancer
  ```

  You deploy to different environments like this:

  ```
  helm install service-a ./service-a-chart -f values-dev.yaml
  helm install service-a ./service-a-chart -f values-prod.yaml
  ```

- **Reusability**

  Helm charts are reusable across teams and services. For example:

  - A standard NGINX chart can be reused as a reverse proxy for multiple services.
 
- **Easy Updates**

  Updating configurations (e.g., changing image tags) requires a single command:

  ```
  helm upgrade service-a ./service-a-chart -f values-prod.yaml
  ```

  Helm tracks changes and applies only the updates, avoiding manual errors.

<br>

## Why Do We Use Helm Charts?

- **Simplifies Deployment**

  Instead of managing multiple YAML files manually, Helm organizes them into one reusable package. It also allows you to deploy applications with a single command.

- **Reusability**

  Helm charts can be reused across environments like development, staging, and production by simply changing configuration values.

- **Consistency Across Teams**

  In an organization, using Helm ensures everyone uses the same configuration for deployments, avoiding issues caused by manual errors.

- **Automation and CI/CD**

  Helm integrates well with CI/CD tools like Azure DevOps or Jenkins to automate application deployments and updates.

<br>

## Understand Helm Through an Example

Let’s go step by step with a practical example of deploying NGINX using Helm.

**Step 1: Install Helm**

- Install Helm on your system:

  ```
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  ```

- Verify the installation:

  ```
  helm version
  ```

**Step 2: Create a Helm Chart**

- Create a new Helm chart for your NGINX application:

  ```
  helm create nginx
  ```

  This creates a directory structure like this:

  ```
  nginx/
  ├── Chart.yaml       # Metadata about the chart
  ├── values.yaml      # Default configuration values
  ├── templates/       # Folder containing Kubernetes YAML templates
  │   ├── deployment.yaml
  │   ├── service.yaml
  │   └── ingress.yaml
  ```

**Step 3: Understand Helm Files**

- ```Chart.yaml```

  This file contains basic information about the Helm chart.

  ```
  apiVersion: v2
  name: nginx
  description: A Helm chart for Kubernetes
  version: 0.1.0
  ```

  Explaination:

  - ```name```: Name of the chart.
  - ```version```: Version of the chart.
 
- ```values.yaml```

  Contains default configurations for your chart. You can override these during deployment.

  ```
  replicaCount: 2
  image:
    repository: nginx
    tag: "1.23.0"
  service:
    type: ClusterIP
    port: 80
  ```

  Example: If you want to use 3 replicas instead of 2, you can update replicaCount in this file.

- ```templates/```

  Contains the Kubernetes YAML templates with dynamic placeholders.

  Example ```templates/deployment.yaml```:

  ```
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: {{ .Release.Name }}-nginx
  spec:
    replicas: {{ .Values.replicaCount }}
    selector:
      matchLabels:
        app: {{ .Release.Name }}-nginx
    template:
      metadata:
        labels:
          app: {{ .Release.Name }}-nginx
      spec:
        containers:
        - name: nginx
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
          - containerPort: 80
  ```

  **Dynamic Placeholders**:
  - ```{{ .Values.replicaCount }}```: Pulls the value of replicaCount from values.yaml.
  - ```{{ .Values.image.repository }}```: Inserts the image name from values.yaml.

**Step 4: Deploy the Chart**

- Deploy the chart in Kubernetes:

  ```
  helm install my-nginx ./nginx
  ```

  ```my-nginx```: The name of the deployment (release name).
  ```./nginx```: Path to your Helm chart.

- Verify the resources:

  ```
  kubectl get pods
  kubectl get svc
  ```

**Step 5: Customize the Deployment**

If you need to override the default values, create a custom ```my-values.yaml``` file:

```
replicaCount: 3
service:
  type: LoadBalancer
  port: 8080
```

Deploy using the custom values:

```
helm install my-nginx ./nginx -f my-values.yaml
```

<br>

### What is {{ .Release.Name }}?

```{{ .Release.Name }}``` is a Helm built-in template variable that refers to the name of the Helm release.

- A release in Helm is an instance of a chart deployed to your Kubernetes cluster.
- The ```{{ .Release.Name }}``` placeholder ensures that every resource created by Helm is unique to that release.

For example:

If you deploy the same Helm chart multiple times with different release names (my-app-dev, my-app-prod), the {{ .Release.Name }} value will change accordingly in the generated Kubernetes YAML.

**How Does It Work?**

When you run a Helm command like this:

```
helm install my-nginx ./nginx
```

- ```my-nginx``` is the release name.
- Helm substitutes ```{{ .Release.Name }}``` with my-nginx in all templates.


**Practical Example**

Template: ```deployment.yaml```

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-nginx
  labels:
    app: {{ .Release.Name }}-nginx
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}-nginx
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}-nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.23.0
```

Scenario: Deploy to Different Environments

- Deploy to Development:

  ```
  helm install dev-nginx ./nginx
  ```

Kubernetes Deployment Name: ```dev-nginx-nginx```

- Deploy to Production:

  ```
  helm install prod-nginx ./nginx
  ```

  Kubernetes Deployment Name: ```prod-nginx-nginx```

Each release has unique resource names (dev-nginx-nginx, prod-nginx-nginx) to avoid conflicts.

