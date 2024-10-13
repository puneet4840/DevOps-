# Kubernetes

Kubernetes is the container management tool which is used to manage conatiner deployment, container scaling and descaling and load balancer.

```Kubernetes containers को manage करने के लिए एक tool होता है जिससे हम containers की automatic deployment करना, Scaling और De-scaling करना और containers के बीच मैं load को balance करना ये सब operations हम kubernetes के through करते हैं```

It was developed by google but now it is maintained by Cloud Native Computing Foundation (CNCF).

<br>
<br>

**Before Kubernetes**

Before kubernetes applications were built based on **Monotlithic architecture** that means applications have single codebase for entire application and hosted on physical servers or virtual machines. During that time scaling was slow, updates cause downtime and resources were often wasted. 

**After Kubernetes**

With the rise of **Containerization**(like Docker) and **Kubernetes** the applications started building based on **Microservice Architecture** that means applications are broken into microservices where each part (e.g., user service, payment service) codebase is seperate and developed, deployed and scaled seperately. 

<br>
<br>

### Why do we need Kubernetes?

We know that docker creates the container, the problem is docker can create containers but it cannot manage the containers completely for development and production environments. So that we use kubernetes.

```Docker containers को create करने का एक essentail tool है लेकिन kubernetes उन containers को manage करने का tool है.```

```Docker के through हम containers को manage नहीं कर पाते हैं इसलिए Kubernetes का यूज़ किया जाता है```

### Problems with the Docker:-

Here we are discussing some problems with that docker in details.

- **1 - Single Host Problem**:-

  ```Single host problem यह है की एक ही operating system पर docker tool चल रहा है और उस docker पर suppose हम 100 containers run कर देते हैं| So starting के 1, 2 या 3rd containers system के mostly resources use कर लेंगे तो बाकी के बचे containers को resources use करने को मिलेंगे ही नहीं और वह containers धीर-धीरे die हो जायेंगे और उन containers के अंदर की application down हो जाएँगी.```

  ```तो इस problem को kubernetes multiple hosts के through solve करता है. Kubernetes multiple nodes create करके उनपे containers को run करता है जिससे किसी एक node पर containers का load बढ़ रहा हो तो Kubernetes कुछ containers को वहां से हटा कर दूसरे node पर create कर देता है.```
