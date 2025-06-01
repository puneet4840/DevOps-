# Prometheus

Promethues is the system monitoring and alerting tool.

```Promethues एक open-source monitoring और alerting toolkit है, जो originally soundcloud ने बनाया था. यह specially cloud-native environments (जैसे kubernetes) के लिए design किया गया है|```

Promethues store all metrics data as time-serires, i.e, metrics information is stored along with the timestamp at which it was recorded, optional key-value paires called labels also stored along with matrics.

It is the second project within Cloud Native Computing Foundation (CNCF) after the Kubernetes.

<br>

### Why Do We Need Prometheus?

Modern applications are distributed — made up of many microservices and infrastructure components (databases, caches, containers, etc.). Monitoring these systems requires:
- High availability.
- Scalable metric collection.
- Fast querying for dashboards and alerts.
- Reliable storage for time-series data.

Prometheus was built to solve these problems effectively.

<br>

### How does it works?

```Suppose आपके पास system है आपका laptop. आपके पास एक Linux virtual machine है azure मैं और आप इस virtual machine को monitor करना कहते हैं तो:```

```आप सबसे पहले अपने laptop मैं prometheus को install करेंगे जिसके साथ कुछ और componenets भी install हो जाते हैं फिर आपको linux vm पर एक exporter जिसको हम agent भी बोलते हैं इसको install करेंगे| ये agent vm की metrics data को prometheus server पर भेजेगा और prometheus इस data को time-series database मैं स्टोर कर देगा, ये time-series database data को system के local storage मैं स्टोर करता है|```


<br>

### Promethues Architecture
