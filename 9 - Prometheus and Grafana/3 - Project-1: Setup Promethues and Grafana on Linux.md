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

