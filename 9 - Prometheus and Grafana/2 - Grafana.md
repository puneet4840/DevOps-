# Grafana

Grafana is monitoring and data visualization tool.

Grafana is monitoring and data visualization tool which is used to monitor and visualization time-series data.

Grafana ek open-source data visualization aur monitoring tool hai jo aapko time-series data aur alag-alag types ke data sources se real-time data visualize karne ka option deta hai.

Iska major use hota hai:
- System metrics monitor karne ke liye (CPU, memory, disk usage).
- Application metrics jaise HTTP request rate, error rate, etc.
- Log monitoring.
- Alerting system create karne ke liye.

Grafana khud koi data store nahi karta, balki ye external data sources (Prometheus, Elasticsearch, InfluxDB, etc.) se data pull karta hai aur usko visualize karta hai.

Basically prometheus and grafana both works together, prometheus collects and stores time-series data in their own data base but prometheus can not visualiza the data, it does not have that capability. We connect grafana with prometheus, so grafana pulls the time-series data from prometheus's database and visualize it.

**Why do we need visualization of data?**

Because data is stored in number and we can not find out any trends, analysis by seeing those number. For that we visualiza the data and easily find out the insight from it. So, that we use visualization of data.

We visualize data to make it easier to understand. Instead of looking at boring numbers or long logs, we use charts, graphs, and dashboards to see patterns, spot problems, and make quick decisions. For example, a spike in a graph instantly shows high server load, while scrolling through raw data would take much longer.

<br>

### Grafana Hight Level Architecture

<img src="https://drive.google.com/uc?export=view&id=1VI98Qu8tuluFIujc3k7ZVlDxS0518JIS" width="650" height="380">


<br>
<br>

### Grafana Hight Level Architecture

<img src="https://drive.google.com/uc?export=view&id=1XQcUlrndHrIs6bNNZ46iS3BmVZBTMQsV" width="850" height="460">

<br>
<br>

### Explanation of Architecture

Grafana works as a web server with a frontend and backend architecture. When you install Grafana on Linux (using apt, yum, or a standalone binary), it runs as a single integrated instance—but internally, it follows a client-server architecture with distinct frontend and backend components.

There are multiple components in Grafana architecture:
- Frontend.
- Backend.
- Internal Database.
- Data Source.
- Plugins.
- Alert System.


**Frontend**:

The frontend of grafana is a web ui where user access the grafana dashboard and controls grafana. It is build using **React** and **TypeScript**.

Frontend wo interface hota hai jise users browser mein dekhte hain. Ye React aur TypeScript se bana hota hai.

User yahan:
- Dashboards dekhte hain.
- Panels configure karte hain.
- Graph banate hain.
- Query likhte hain.
- Alerts set karte hain.

User jo bhi request karta hai (like ek graph open karna), wo backend ko forward hoti hai.

```Grafana का frontend user के लिए वह visual interface होता है जिससे वो browser के ज़रिये dashboards देखते, edit करते और query लिखते हैं. ये React और TypeScript technologies का use करता है. जब user एक dashboard open करता है या एक graph के लिए query लिखता है या alert configure करता है तो ये सब actions frontend के ज़रिये होती हैं. लेकिन frontend सिर्फ एक UI layer है, उसका काम सिर्फ user input लेना और response को दिखाना होता है. जो भी request होती है (जैसे: “prometheus से CPU usage लेकर आओ”) वो HTTP/REST api के ज़रिये backend को भेजी जाती है. Backend फिर actual processing करता है. इसलिए frontend को हम presentation layer कहते हैं. जो user और grafana system के बीच bridge का काम करता है.```

<br>

**Backend**

Backend is the core engine of grafana and it is written in **GO** (Golang) language. The main work of backend is to handle the request coming from frontend.

Backend Grafana ka core engine hai jo user se aayi request ko handle karta hai.

Ye Go (Golang) language mein likha gaya hai.

Iska kaam:
- Frontend se request lena.
- Data sources se connect hona.
- Query run karna.
- Result ko frontend tak bhejna.
- Alert rules evaluate karna.
- Authentication validate karna.
- Plugin load karna.

Ye APIs ke through kaam karta hai (RESTful APIs)

```Grafana का backend एक Go (Golang) based HTTP server है जो frontend से आयी requests को receive करता है उन्हें process करता है और उनका response वापस भेजता है. ये system का core processing engine है. जब user कोई query submit करता है backend उस query को parse करता है फिर configured data source (e.g., prometheus, influxDb) से communicate करता है और वहां से जो result आता है उससे parse करके frontend को भेज देता है. इसके अलावा backend authentication check करता है, Alter evaluation करता है, plugin manage करता है और internal database से dashboard और settings retrieve/save करता है. Backend के पास APIs होती हैं जिनसे external tools भी grafana को programatically control कर सकते हैं (like provisioning, user management).```

<br>

**Internal Database**

Grafana ek internal DB use karta hai jisme sirf configuration aur metadata store hota hai, jaise:
- User accounts.
- Teams.
- Dashboards.
- Data source configs.
- Alert definitions.
- Permissions.

By default ye SQLite use karta hai (lightweight), lekin production ke liye MySQL ya PostgreSQL recommend hai.

Ye database metrics ka data store nahi karta, sirf config data store karta hai.

```Grafana ke paas apna ek internal database hota hai jisme sirf configuration aur metadata store hota hai – actual monitoring data nahi. Default DB SQLite hota hai, lekin production mein MySQL ya PostgreSQL recommend kiya jata hai. Isme user accounts, team membership, dashboard definitions, data source configurations, alert rules, API tokens, plugin settings, aur permission mappings stored hote hain. Jab user ek dashboard create karta hai, to wo dashboard ek JSON object ke form mein DB mein save hota hai. Jab dashboard open hota hai, to backend DB se data fetch karke frontend ko deta hai. Internal DB Grafana ke stability aur consistency ke liye backbone ka kaam karta hai.```

<br>

**Data Source**

Data sources are external systems where your data is stored. Grafana connects to them and fetches the data (metrics) when needed.

Common data sources:
- Prometheus (for infrastructure metrics).
- InfluxDB (time-based data).
- MySQL/PostgreSQL (SQL data).
- AWS CloudWatch (cloud metrics).
- Elasticsearch (log search and analysis).
- Loki (Grafana’s own log system).

You just add the data source URL, credentials, and query settings in Grafana, and it connects directly to pull the data when you open a dashboard.

Kaise kaam karta hai:
- Aap Grafana mein ek data source add karte ho (e.g., Prometheus ka URL).
- Jab aap dashboard mein panel banaoge aur query likhoge, Grafana backend wo query data source ke API ko bhejega.
- Data source response deta hai (JSON format mein).
- Backend us data ko frontend tak bhej deta hai.
- Frontend us data ko graph/table/heatmap ki form mein render karta hai.

```Grafana khud koi metrics store nahi karta, balki ye external systems se data fetch karta hai jinhe hum data sources kehte hain. Ye data sources monitoring systems (like Prometheus), logging platforms (like Loki), tracing systems (like Tempo), ya even relational databases (like PostgreSQL, MySQL) ho sakte hain. Jab user ek dashboard panel mein query likhta hai, backend us query ko data source ke API ke format mein convert karta hai aur HTTP request ke zariye us system ko bhejta hai. Jo response aata hai (mostly JSON), usse backend interpret karta hai aur frontend ko bhejta hai. Har data source Grafana ke liye ek plugin ke roop mein hota hai, jise configure kiya ja sakta hai. Isliye Grafana ek universal visualization layer ban jata hai jo multiple systems ko ek jagah jodta hai.```

<br>

**Plugins**

Plugins in Grafana are add-ons that extend its functionality. They allow Grafana to connect to new data sources, add custom visualization styles, or integrate with other tools.

```Grafana ka plugin system usko highly flexible banata hai. Iska use karke naye data sources, naye panel types (visualizations), ya even complete apps add kiye ja sakte hain. Plugin 4 type ke hote hain: Data source plugins (new APIs support karne ke liye), Panel plugins (new graph types jaise gauge, pie chart), App plugins (custom full-page apps, e.g., Kubernetes), aur Backend plugins (Go-based logic). Ye plugins Grafana ke lifecycle ke har part mein integrate ho sakte hain. Jab user koi plugin-based feature use karta hai (jaise ek custom graph), to backend plugin load karta hai aur request flow uske through bhi ja sakta hai. Plugin system Grafana ko ek extendable platform banata hai, sirf ek fixed tool nahi.```

<br>

**Alerting Engine**

Alerts are rules you set on graphs or metrics.

Alerting Engine is the tool in grafana to set alerts.

Grafana monitoring ka real power tab aata hai jab aap alerting enable karte ho.

Alert Engine ka kaam:
- User alert rule define karta hai (e.g., CPU > 80% for 5 mins).
- Grafana backend periodic evaluation karta hai (e.g., har 1 minute).
- Agar condition true hoti hai, to notification bhejta hai.

Notification Channels:
- Email.
- Slack.
- Webhook.
- Microsoft Teams.
- Pagerduty.

```Grafana ka alerting engine monitoring ka heart hai. Jab user ek panel mein alert rule banata hai (e.g., "agar CPU usage 90% se upar jaye 5 min tak"), to backend ek scheduler ke roop mein kaam karta hai – wo rule ko periodic interval (e.g., har 1 minute) pe evaluate karta hai. Evaluation ke liye backend pehle data source ko query bhejta hai, uska result analyze karta hai, aur agar alert condition match hoti hai to wo alert trigger karta hai. Alert trigger hone par configured notification channels (Slack, Email, Webhook, etc.) pe message bheja jata hai. Alert ka state (firing, resolved, pending) bhi internal DB mein persist hota hai. Grafana 8 ke baad se Unified Alerting system aaya jisme alerts multiple data sources pe based ho sakte hain.```

<br>

**Authentication & Authorization – Access Control**

It is used to controls the user access to grafana.



```Grafana mein secure access control ke liye built-in authentication aur authorization system hota hai. Authentication ka matlab hai user ka identity verify karna – ye Grafana kar sakta hai via Basic Auth (username/password), OAuth (Google, GitHub, Azure), LDAP, ya API tokens. Authorization ka matlab hai ki user kya dekh sakta hai, kya edit kar sakta hai. Grafana mein 3 roles hote hain: Admin (full control), Editor (dashboard edit kar sakta hai), aur Viewer (sirf dekh sakta hai). Aap folder-wise aur dashboard-wise permissions define kar sakte ho. Jab user login karta hai aur dashboard open karta hai, backend user ke token ko validate karta hai, uska role check karta hai, aur uske according data serve karta hai. Ye system enterprise level mein bohot useful hota hai jahan team aur role-based access zaroori hoti hai.```

<br>
<br>

### Request Flow Summary Across All Components

- User browser se Grafana open karta hai (Frontend).
- Wo dashboard open karta hai aur panel mein query likhta hai (Frontend → Backend).
- Backend us query ko respective data source ke API call mein convert karta hai.
- Data Source se JSON response aata hai → Backend → Frontend.
- Frontend us data ko render karta hai (graph, table, etc.).
- Agar alert configured hai, Backend periodically query run karta hai.
- Condition match hone par notification channel pe message jata hai.
- Dashboards, alert rules, etc. Internal DB mein save rehte hain.
- Authentication layer ensure karta hai ki har user sirf apne allowed data ko access kare.

