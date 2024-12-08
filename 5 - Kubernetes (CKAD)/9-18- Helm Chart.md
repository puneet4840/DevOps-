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

  
