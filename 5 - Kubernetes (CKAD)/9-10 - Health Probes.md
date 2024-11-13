# Health Probes in Kubernetes

Health Probes are the mechanism that is used to monitor the health status of container inside the pod.

So you’ve built an amazing app and deployed it to Kubernetes — congrats! But how do you make sure your app stays up and running as intended? That’s where liveness and readiness probes come in.

```Health probes pods के अंदर run हो रहे containers की health को monitor करते हैं.```

In Kubernetes, health probes are tools to help keep your applications running smoothly by checking if each container in your cluster is "healthy." If a container is having issues, these probes let Kubernetes know so it can take action to keep your application up and running.

### Why Health Probes Are Important

In a Kubernetes cluster, applications are packaged as containers, and these containers can sometimes face issues like:

- **Crashes** (where the application stops unexpectedly).
- **Freezes** (where the application gets stuck and becomes unresponsive).
- **Slowdowns** (where the application responds very slowly).

To keep applications reliable, Kubernetes needs a way to monitor whether each container is healthy and working as expected. Health probes are Kubernetes’ solution for this. They check each container periodically and take corrective actions if something goes wrong.

<img src="https://drive.google.com/uc?export=view&id=14HhOV6uYyAkFazhO4kftG36-cB6czLk5" width="600" height="300">

### Types of Health Probes in Kubernetes

Kubernetes provides three types of health probes:

- **Liveness Probe**.
- **Readiness Probe**.
- **Startup Probe**.

Each probe type has a different purpose. Here’s a breakdown of each:

**Liveness Probe**

Liveness Probe check if your container is up and running. If a container fails then liveness probe also fails.

