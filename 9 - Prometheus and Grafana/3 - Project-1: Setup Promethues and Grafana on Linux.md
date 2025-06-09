# Project: Setup Prometheus and Grafana on Ubuntu and see ubuntu metrics on Grafana Dashboard.

## End-to-End Prometheus + Grafana Ubuntu Setup Project

**Scenario**: We are going to setup the promethues and grafana on ubuntu (local system). Then scraping the metrics from ubuntu and create a grafana dashboard to see the metrics on dashbaord.

**Objectives**:
- ✔ Install Prometheus on Ubuntu.
- ✔ Install Node Exporter to expose system metrics.
- ✔ Install Grafana.
- ✔ Connect Prometheus to Node Exporter.
- ✔ Connect Grafana to Prometheus.
- ✔ Build a basic dashboard to visualize Ubuntu system metrics.

<br>

### Steps

### Step-1: Install Prometheus on Ubuntu

- **Update packages**:
```
sudo apt-get update
```

- **Create a Prometheus user**:
```
sudo useradd --no-create-home --shell /bin/false prometheus
```

- **Download Prometheus binary**:
```
wget https://github.com/prometheus/prometheus/releases/download/v2.53.4/prometheus-2.53.4.linux-amd64.tar.gz
```

- **Extract it**:
```
tar -xvf prometheus-2.53.4.linux-amd64.tar.gz
```

- **Move binaries to /usr/local/bin**:
```
sudo cp -R prometheus-2.53.4.linux-amd64/prometheus /usr/local/bin/

sudo cp -R prometheus-2.53.4.linux-amd64/promtool /usr/local/bin/
```

- **Set ownership for Prometheus**:
```
sudo chown prometheus:prometheus /usr/local/bin/prometheus

sudo chown prometheus:prometheus /usr/local/bin/promtool
```

- **Move config and console files**
```
sudo cp -R prometheus-2.53.4.linux-amd64/consoles/ /etc/prometheus

sudo cp -R prometheus-2.53.4.linux-amd64/console_libraries/ /etc/prometheus
```

- **Set ownership**
```
sudo chown -R prometheus:prometheus /etc/prometheus

sudo chown -R prometheus:prometheus /var/lib/prometheus
```

<br>

### Step-2: Create Prometheus Config File

Create ```/etc/prometheus/prometheus.yml```

```
sudo touch /etc/prometheus/prometheus.yml
```

Write the below yaml code in prometheus.yml file.

```
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
```

<br>

### Step-3: Create Systemd Service for Prometheus

Create ```/etc/systemd/system/prometheus.service```

Write the below code in prometheus.service

```
[Unit]
Description=Prometheus Monitoring
After=network.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
```

- **Reload systemd, enable and start Prometheus**
```
sudo systemctl daemon-reload

sudo systemctl enable prometheus

sudo systemctl start prometheus

sudo systemctl status prometheus
```

Now your prometheus is running on ```http://localhost:9090```.

You can access prometheus on browser using ```http://localhost:9090```.
