# Kubernetes

Kubernetes is the container management tool which is used to manage conatiner deployment, container scaling and descaling and load balancer.

```Kubernetes containers को manage करने के लिए एक tool होता है जिससे हम containers की automatic deployment करना, Scaling और De-scaling करना और containers के बीच मैं load को balance करना ये सब operations हम kubernetes के through करते हैं```

<br>
<br>

**Before Kubernetes**

In the early days of software development, applications were typically developed as **Monolithic Applications**. This means that all the components of application (e.g., UI, Business logic, Database access) were bundeled together into a single codebase and deployed as one unit.

**Challenges of Monolithic Architecture**
- Scaling: Monolithic applications could only be scaled by adding more servers (vertical scaling). This was inefficient because the entire application needed to be scaled even if only one part required more resources.
- Updates: Deploying updates required redeploying the entire application, often leading to downtime and slower release cycles.
- Lack of Flexibility: Any small change or bug fix would affect the entire system.
