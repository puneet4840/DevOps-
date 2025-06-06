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

### Prometheus Architecture

<img src="https://drive.google.com/uc?export=view&id=10PSfiEn2u5jjXKI4JaN6EG97fXwzNbp_" width="750" height="420">

<br>

Prometheus follows a pull-based mechanism for collecting metrics from targets (applications or services).

There are multiple components in the architecture:

**Prometheus Server**:

This is the main componenet of prometheus which collects the data from applications and servers and stores it in TSDB (Time Series Data Base).

It has multiple components:

- Retrieval:
  - It is used to pull the data from exporter aur push_gateway. Exporter is the agent which is installed on target servers. Exporter metrics expose karte hain ```/metrics``` endpoint pe.
  - There are multiple exportes for multiple kind of servers. Node Exporter (system metrics ke liye), Blackbox Exporter (uptime/ping check ke liye), MySQL Exporter (mysql ki metrics ke liye), etc.
 

- TSDB:
  - Prometheus stores time series pulled data into Time-Series Database.
  - A time series in Prometheus has:
    - A metric name (e.g., http_requests_total).
    - Labels (key-value pairs providing additional dimensions like instance, job, status).
    - A timestamp.
    - A value.
   
    Example:
    
    | Metric Name           | Labels                                           | Timestamp    | Value   |
    | :-------------------- | :----------------------------------------------- | :----------- | :------ |
    | `http_requests_total` | `instance="server1", method="GET", status="200"` | `1717245600` | `12345` |


- HTTP Server:
  - Prometheus provides a built-in web based user interfact on this HTTPS server where user can use PromQL query to get the metrics from database.
  - User ya developer ko ek web interface dena jahan wo queries kar sake, jaise CPU kitna chal raha hai? Memory ka use kitna ho raha hai?

<br>

**Prometheus Targets**

Prometheus targets wo server hote hain jinko hum prometheus ke through monitor karna chte hain. In servers par expoerters yani agents ko install kiya jata jo specfied time par servers se promethues ko data behjte hain.

Aapka system (Linux server, database, application) apne metrics deta hai exporters ke zariye. Jaise:
- Agar aapka Linux server hai to usme Node Exporter laga hota hai.
- Agar aapka database hai to usme MySQL Exporter ya koi aur exporter hoga.

To jis tarah ka server hota hai usi tarah ka exporter laga hota hai.

Yeh exporters ek HTTP endpoint pe apna health aur metrics batate hain — jise hum kehte hain ```/metrics```.

<br>

**Short-lived jobs ka kya?**

Kuch aise jobs hote hain jo jaldi chalu hote hain aur turant khatam ho jaate hain (jaise ek cron job). Inke paas itna time nahi hota ki Prometheus baar-baar unse metrics le.

To yeh jobs Pushgateway ko apne metrics de dete hain. Pushgateway ek middleman hai. Prometheus baad mein Pushgateway se wo metrics uthaa leta hai.

<br>

**Service Discovery**

Prometheus ko batana padta hai ki usse kis machine ya exporter se data lena hai. Ye hum ```prometheus.yml``` file mein define karte hain. 

Lekin agar aapke paas 100 machines hain, ya Kubernetes cluster hai, to har ek ko manually define karna mushkil hai. Isliye Service Discovery hoti hai — Prometheus automatically Kubernetes, Consul ya static file se pata kar leta hai ki kahan se metrics lena hai.

<br>

**Prometheus Alerting**

Prometheus ke paas rules hote hain — jaise agar CPU usage 90% se upar gaya to alert bhejna hai. Jab aisa kuch hota hai to Prometheus ek alert Alertmanager ko bhejta hai.

Alertmanager ka kaam hota hai:
- Alertmanager tumhare alert ko process karta hai.
- Decide karna ki alert email se bhejna hai ya Slack pe ya PagerDuty pe.
- Bar-bar repeat hone wale alert ko group karna.
- Alert bhejne ka format banana.

<br>

**Data Visualization and Exports**

Prometheus ke paas apna ek web UI hota hai jahan PromQL naam ki language se query karke graphs dekh sakte ho. Lekin zyada achhe aur interactive graphs ke liye log Grafana ka use karte hain. Grafana mein aap dashboards bana sakte ho, alerts configure kar sakte ho, aur multiple Prometheus servers ko connect kar sakte ho.

<br>
<br>

### Working of Prometheus

Prometheus ek open-source monitoring system hai jo servers, apps (jaise Python/Java), ya containers se performance-related metrics collect karne ke liye bana hai.

Yeh kaam Prometheus pull model se karta hai, matlab ki tum har system pe ek agent (jaise ```node_exporter``` Linux ke liye, ya ```prometheus_client``` Python ke liye) install karte ho jo ```/metrics``` endpoint pe data expose karta hai.

Fir tum apne system par prometheus ko install karte ho jisko prometheus server bolte hain jo ek central component hota hai. 

Before Prometheus can start collecting data, prometheus ko ye pta hona chaiye ki konse target server se data collect karna hai kitne-kitne time period par. Iske liye ek ```prometheus.yml`` file create karte ho jisme tum targer server ki information likhte ho aur kaafi detail bhi likhte ho. 

Ab Prometheus server apne config file (```prometheus.yml```) ke zariye un endpoints ko register karta hai aur regular interval (default 15s) par un endpoints se metrics fetch karta hai. Yeh metrics time-stamped hote hain aur Prometheus unhe internally Time Series Database (TSDB) mein store karta hai.

Pehle ye data **Write-Ahead Log** file main store karta hai to avoid losing it if the server crashes, fir har 2 ghante mein compress karke blocks bana ke efficient format mein store karta hai. Har metric ke saath labels (jaise instance, status code, method) hote hain jo query karne mein madad karte hain.

Ab prometheus ke paas metrics data aa chuka hai. Fir user PromQL (Prometheus Query Language) se queries karta hai jaise rate() ya sum() jaise functions use karke data analyse karta hai, jo Prometheus UI ya Grafana dashboards par visualize kiya ja sakta hai. Saath hi, Prometheus mein alerting rules banaye ja sakte hain jo Alertmanager ko trigger karte hain aur Alertmanager fir Slack, Email ya webhook ke zariye notification bhejta hai. Agar tu Python ya Java app monitor kar raha hai, to Prometheus-compatible libraries ke through code ke andar custom metrics generate karta hai (jaise HTTP request count, latency), jise Prometheus /metrics endpoint se scrape karta hai, aur baaki process wahi rehta hai.

Is tarah, Prometheus ek full pipeline provide karta hai: metrics collection → efficient storage → query → visualization → alerting, bina kisi agent push ke, sab kuch apne pull system aur label-based architecture pe chalata hai.

