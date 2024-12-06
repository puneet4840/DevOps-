# Helm Chart in Kubernetes

Helm is a package manager for Kubernetes, similar to ```apt``` for Ubuntu or ```yum``` for CentOS. It simplifies the deployment and management of Kubernetes applications by using Helm charts, which are reusable and shareable packages of Kubernetes manifests.

When you deploy applications in Kubernetes, you need to create many files (YAML manifests) for different resources like Deployments, Services, ConfigMaps, and more. Helm simplifies this by bundling all these files together into a single package called a chart.

A Helm chart is a directory containing:

- ```Chart.yaml```: Metadata about the chart (name, version, description).
  
- ```values.yaml```: Default configuration values used by the templates. These values.yaml file container the values which are picked from values.yaml file and placed into the Yaml files (Deployment.yaml, service.yaml, etc).
  
- ```templates/```: A directory with Kubernetes manifest files (e.g., Deployment, Service) written as templates.

- Other Files:
  - ```README.md```: Documentation.
  - ```charts/```: Subcharts if needed.
  - ```requirements.yaml```: Dependencies for the chart.
  
