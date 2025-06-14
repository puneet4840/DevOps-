# Project-3: Alerts using Prometheus and Grafana

This project demostrate how to acheive alerting using prometheus and grafana.

**Scenario**: 
- Run a simple flask web application in Docker.
- Prometheus monitor:
  - App metrics (custom counters like request rate).
  - Container metrics (CPU, memory, network, disk).
- Visualize data via Grafana.
- Set up alerts in Prometheus if metrics cross a threshold.
- Use Alertmanager to handle those alerts (send to Email, etc.).

We have created a flask web application which is generating metrics on ```/metrics```. It is running as a docker container. A promethues is connects to this ```/metrics``` endpoint as a data source. It is also running as a docker container. Grafna is running as a docker container as connected with prometheus. Alert manager is also running as a docker container and connected with promethues.

<br>

### Project Setup: Directory Structure

```
prometheus-stack/
├── docker-compose.yml
├── app/
│   ├── app.py
│   └── Dockerfile
├── prometheus/
│   ├── prometheus.yml
│   └── alert.rules.yml
└── grafana/

```

<br>
<br>

### Components & What They Do

**1 - Application (Flask-based app)**

- A small Python Flask web app.
- It has:
  - ```/``` → simple hello page.
  - ```/metrics``` → endpoint exposing Prometheus metrics via prometheus_client.

Why?:

Prometheus scrapes this ```/metrics``` endpoint periodically to collect metrics like:
- Total HTTP request count.
- Request rate per second.

Dockerized so it runs inside a container — lightweight, reproducible.

<br>

**2 - cAdvisor (Container Advisor)**

A tool by Google that monitors Docker container performance and resource usage.

What it collects:
- CPU usage.
- Memory usage.
- Disk I/O.
- Network I/O.
- Uptime.

How?:
- Runs as a Docker container itself, exposes a metrics endpoint at ```:8080/metrics```.
- Prometheus scrapes this endpoint for container-level metrics.

Why?:
- To track how much CPU, RAM, etc., our application container is using.

<br>

**3 - Prometheus (Metrics scraper & database)**

What is it?:
- A powerful time-series metrics monitoring tool.
- It scrapes data from:
  - App ```/metrics```.
  - cAdvisor ```/metrics```.
 
Config we wrote:
- ```scrape_configs```: defines which targets to scrape.
- ```alerting block```: defines where to send alerts.
- ```rule_files```: points to our alert rules file.

<br>

**4 - Prometheus Alertmanager**

A service that receives alerts from Prometheus and then:
- Deduplicates them.
- Groups them.
- Sends notifications via:
  - Email.
  - Slack.
 
In this project:
- It's connected to Prometheus on port 9093.
- When our alert rule triggers (like if rate(http_requests_total[1m]) > 5), Prometheus pushes the alert to Alertmanager.

<br>

**5 - Grafana (Visualization tool)**

A popular dashboard and visualization platform.

What it does:
- Connects to Prometheus as a data source.
- Queries and displays metrics in real-time.
- Lets us create custom dashboards (CPU usage, memory, request rates, etc.).

<br>

**6 - Docker Compose (Orchestrator)**

A tool to define and run multi-container Docker applications via a single YAML file.

What it does in this project:

Spins up:
- App container.
- Prometheus container.
- cAdvisor container.
- Alertmanager container.
- Grafana container.

<br>

**7 - The Alerting Process**

Rule:
- If ```rate(http_requests_total[1m]) > 1``` for 10 seconds.
⮕ Trigger alert named HighRequestRate.

Process:
- Prometheus evaluates rules every 5s.
- If rule fires, sends alert to Alertmanager.
- Alertmanager routes alert to notification channels (email/slack/webhook).

<br>
<br>

### How They Connect (Data Flow)

```
User Browser -----> App (Docker) 
                       |
                       +-------> /metrics
                       |
                  Prometheus scrapes App & cAdvisor
                       |
                  Alertmanager for alerts
                       |
                   Grafana queries Prometheus

```

<br>
<br>

### How Prometheus Alerting Works (in short)

- Prometheus evaluates alert rules (in a .rules.yml file).
- If a rule fires (condition met), Prometheus sends the alert to Alertmanager.
- Alertmanager decides:
  - Where to send the alert (email, Slack, webhook, etc.).
  - How to group, silence, and manage alerts.
 
- Alertmanager sends email via your configured SMTP server.

<br>
<br>

## Step to create this project.

<br>

### Step-1: Create a root directory for project

```
prometheus-stack/
├── docker-compose.yml
├── app/
│   ├── app.py
│   └── Dockerfile
├── prometheus/
│   ├── prometheus.yml
│   └── alert.rules.yml
├── alert-manager/
│   ├──alertmanager.yml
└── grafana/
```

Inside root directory create other files and folder.

<br>

### Step-2: Create app.py file

First create ```app``` directory and inside it create ```app.py``` and write the below content in it.

```app.py```
```
from flask import Flask
from prometheus_client import Counter, generate_latest

app = Flask(__name__)

c = Counter('http_requests_total', 'Total HTTP Requests')

@app.route('/')
def hello():
    c.inc()
    return 'Hello, World!'

@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': 'text/plain; version=0.0.4; charset=utf-8'}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

```

<br>

### Step-3: Create Dockerfile

Inside ```app``` directory, create dockerfile for flask application.

```dockerfile```
```
FROM python:3.11-slim

WORKDIR /app
COPY . /app

RUN pip install flask prometheus_client

EXPOSE 5000

CMD ["python", "app.py"]
```

<br>

### Step-4: Prometheus Config

Create a folder ```prometheus``` and create ```prometheus.yml``` file in it to write config.

```prometheus.yml```

```
global:
  scrape_interval: 5s
  evaluation_interval: 5s


scrape_configs:
  - job_name: 'app-metrics'
    static_configs:
      - targets: ['app:5000']

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']

alerting:
  alertmanagers:
    - static_configs:
        - targets: ['alertmanager:9093']

rule_files:
  - "alert.rules.yml"
```

<br>

### Step-5: Create alert.rule.yml file

Inside the prometheus filder create ```alert.rules.yml``` file. So that prometheus can get alert rule from it.

```alert.rules.yml```

```
groups:
- name: app-alerts
  rules:
  - alert: HighRequestRate
    expr: rate(http_requests_total[1m]) > 0.1
    for: 5s
    labels:
      severity: critical
    annotations:
      summary: "High request rate detected"
      description: "More than 5 req/sec for 5 seconds"
```

<br>

### Step-6: Configure Alertmanager for Email

Create ```alertmanager.yml``` inside ```./alert-manager``` folder:

```
global:
  smtp_smarthost: 'smtp.gmail.com:587'
  smtp_from: 'puneet.notes1@gmail.com'
  smtp_auth_username: 'puneet.notes1@gmail.com'
  smtp_auth_password: '*******'

route:
  receiver: 'email-receiver'

receivers:
  - name: 'email-receiver'
    email_configs:
      - to: 'pkv4840@gmail.com'
        send_resolved: true
```

<br>

### Step-7: Create Docker Compose File

Create a ```docker-compose.yml``` file in root directory.

```docker-compose.yml```

```
version: "3.8"

services:

  app:
    build: ./app
    container_name: my-app

    ports:
      - "5000:5000"
    networks:
      - my-net


  prometheus:
    image: prom/prometheus:latest
    container_name: my-prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus/:/etc/prometheus/
    networks:
      - my-net


  grafana:
    image: grafana/grafana
    container_name: my-grafana
    ports:
      - "3000:3000"
    networks:
      - my-net




  cadvisor:
    image: gcr.io/cadvisor/cadvisor:latest
    container_name: cadvisor
    ports:
      - "8080:8080"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro

    networks:
      - my-net


  alertmanager:
    image: prom/alertmanager
    container_name: my-alertmanager
    ports:
      - "9093:9093"
    volumes:
      - ./alert_manager/alertmanager.yml:/etc/alertmanager/alertmanager.yml
    networks:
      - my-net


networks:
  my-net:
```

<br>

### Step-8: Run the application and stack

Run the below command to run all containers.

```
docker-compose up --build -d
```

Access:
- App → ```http://localhost:5000```.
- Prometheus → ```http://localhost:9090```.
- Grafana → ```http://localhost:3000``` (admin/admin).
- cAdvisor → ```http://localhost:8080```.
- Alertmanager → ```http://localhost:9093```.

<br>

### Step-9: Test the Alert

- Hit your app’s ```/``` endpoint repeatedly to exceed 5 req/sec.
- Check Prometheus Alerts tab at ```localhost:9090/alerts.
- Check Alertmanager UI at ```localhost:9093```.
- You should receive an email alert within a few seconds when the alert fires and resolves

**Note**: Gmail no longer allows direct password login. I have given my email's password but and it is not working, we have give the app password there then it will work.

You will not get any alerts on your email but you will see alerts are created and fired.

DONE!!!
