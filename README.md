# Monitoring Infrastructure
Monitoring Infrastructure:
- Grafana UI Dashboard
- Node Exporter
- Management Logs (Loki)
- Management Metrics (Prometheus)
- Management Alerts (Alertmanager)

![Grafana UI Dashboard](images/langfuse.png)


## 1. 🚀 **Deployment**
### 1.1. Install dependency
```bash
curl -fsSL https://just.systems/install.sh | bash -s -- --to /usr/local/bin
```

### 1.2. Start Server
```bash
just environment //Add your key 

just start
```

## 2. App Setup
### 2.1. Node Exporter
```bash
cd app_setup/node_exporter

just environment //Add your key 

just start
```

- In Grafana UI Dashboard, you can import the Node Exporter metrics with ID `1860`

### 2.2. App Logs (Loki)
... (see at ./examples)
### 2.3. App Metrics API (Prometheus)
... (see at ./examples)
