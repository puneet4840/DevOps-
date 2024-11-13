# Health Probes in Kubernetes

Health Probes are the mechanism that is used to monitor the health status of container inside the pod.

```Health probes pods के अंदर run हो रहे containers की health को monitor करते हैं.```

In Kubernetes, health probes are tools to help keep your applications running smoothly by checking if each container in your cluster is "healthy." If a container is having issues, these probes let Kubernetes know so it can take action to keep your application up and running.

### Why Health Probes Are Important

In a Kubernetes cluster, applications are packaged as containers, and these containers can sometimes face issues like:

- **Crashes** (where the application stops unexpectedly).
- **Freezes** (where the application gets stuck and becomes unresponsive).
- **Slowdowns** (where the application responds very slowly).

  To keep applications reliable, Kubernetes needs a way to monitor whether each container is healthy and working as expected. Health probes are Kubernetes’ solution for this. They check each container periodically and take corrective actions if something goes wrong.

