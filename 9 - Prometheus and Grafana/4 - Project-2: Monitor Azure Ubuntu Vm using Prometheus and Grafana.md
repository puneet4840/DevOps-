# Project-2: Monitor Azure Ubuntu Vm using Prometheus and Grafana

**Scenario**: I have an ubuntu vm created in Azure. I want to monitor the metrics of that vm using prometheus and grafana. These tools are installed on local linux on Docker. And I am going to setup it using docker compose.

**Objectives**:
- Install Node Exporter on Azure Ubuntu VM.
- Create a ```prometheus.yml``` file in your local system.
- Create Docker Compose yml file to run containers.

**Project Directory Structure**:
```
monitor-azure-vm-using-containerized-promethes-and-grafana/
├── docker-compose.yml
└── prometheus/
    └── prometheus.yml
```

<br>

## Steps

### Step-1: Install Node Exporter on Azure Ubuntu VM.

There are two ways to run node_exporter on Azure Ubuntu:
- Run node_exporter as a system service. It means setup a system service so that node exporter remains run all the time.
- Run node_exporter as exe file. It means we run a node_exporter exe file after downloading it from prometheus.

Here, I will run node_exporter using exe file which is temporary but I have mentioned both ways below.

**Node_Exporter using exe file**:

```
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.0/node_exporter-1.8.0.linux-amd64.tar.gz
tar -xvf node_exporter-1.8.0.linux-amd64.tar.gz
cd node_exporter-1.8.0.linux-amd64
./node_exporter
```

You can access metrics on ```http://<vm-public-ip>:9100/metrics

<br>

**Node_Exporter using system service**

```
# Download Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz

# Extract and move binary
tar -xvf node_exporter-1.8.1.linux-amd64.tar.gz
sudo cp node_exporter-1.8.1.linux-amd64/node_exporter /usr/local/bin/

# Create a system user
sudo useradd --no-create-home --shell /bin/false node_exporter

# Create systemd service
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Start and enable Node Exporter
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
```

<br>

### Step-2: Create prometheus.yml file where you are running promethues. In this example I am running prometheus on my local linux system

Create ```promethues.yml``` file at any location becuase we need to give that location inside docker volume. Here, I am creating this file at ```/home/puneet/```.

```promethues.yml```

```
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'azure-ubuntu-node'
    static_configs:
      - targets: ['128.251.132.58:9100']
```

<br>

### Step-3: Create Docker Compose File to run promethues and grafana tools as a container.

Now create ```docker-compose.yml``` file to run prometheus and grafana as docker containers.

```docker-compose.yml```

```
version: '3.8'

services:

  prometheus:
    image: prom/prometheus:latest
    container_name: promethues
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml


  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin
```

**Start the Stack**

From the project root directory:
```
docker-compose up
```

This will start:
- Prometheus at ```http://localhost:9090```.
- Grafana at ```http://localhost:3000```.

Node Exporter still running on your Ubuntu host at ```http://<vm-public-ip>:9100```.

<br>

### Step-4: Verify Prometheus Targets

Go to ```http://localhost:9090/targets```.

You should see:
- node_exporter (up).

<br>

### Step-5: Access prometheus and grafana in browser

Access prometheus and grafana in your browser.

Prometheus: ```http://localhost:9090```

Grafana: ```http://localhost:3000```

<br>

### Step-6: Connect Prometheus to Grafana

After accessing the prometheus and grafana, Now connect grafana with prometheus.

- Open ```http://localhost:3000```.
- Login- Username: ```admin``` and Password: ```admin```.
- Go to **Connections -> Data Sources**.
- Click on **Add Data Source** and select **prometheus**.
- Set URL to: ```http://prometheus:9090```.
- Click **Save & Test**.

**Note**:

If you type ```http://localhost:9090``` when try to connect prometheus with grafana. It will an error.

Because:
- You have Prometheus and Grafana running as Docker containers using Docker Compose.
- Both services are connected to a custom Docker network called connection (you did this part correctly in the Compose file).
- But Grafana is trying to connect to localhost:9090 to reach Prometheus —and that won’t work inside Docker containers.

Why?

Inside Docker:
- When Grafana tries to connect to localhost it tries to connect to itself (Grafana container).
- But Prometheus is in a different container.
- To talk to Prometheus, Grafana should use the service name you gave to Prometheus inside Docker Compose.

You need to use the service name of the Prometheus container.

Iska matlab hai ki jab do services container ke ander run ho rhi ho aur hum unko localhost se browser par access kar rhe ho to vo dono service ek dusre ke service name se connect hongi na ki localhost se. Esa isliye kyuki localhost se container khud ko access karne ka try karta hai.

<br>
<br>

### Step-7: Create Dashboard or Import Dashboard in Grafana

- Go to Dashboards → Import
- Enter dashboard ID 1860 (official Node Exporter dashboard).
- Click Load.
- Select your Prometheus data source.
- Click Import.

Done !!! — you now have real-time Ubuntu system metrics monitored by Node Exporter → Prometheus → Grafana.

<br>

**What You'll See on the Dashboard**:
- CPU Usage per core.
- Memory utilization.
- Disk space & I/O.
- Network bandwidth.
- Load average.
- System uptime.
- Filesystem stats

<br>

### Step-8: To Stop and Clean Everything

To stop prometheus and grafana containers.

```
docker-compose down
```


And to stop Node Exporter (if still running in the foreground):
- Press Ctrl+C.
- Or kill its process via ```killall node_exporter```.

