# Docker and Minikube Setup Script

This script is designed to automate the installation and setup of Docker and Minikube on a macOS system. Additionally, it installs the Elasticsearch operator using the ECK (Elastic Cloud on Kubernetes) operator and deploys Elasticsearch in a Kubernetes cluster.

## Prerequisites

- macOS with `arm64` architecture (Apple Silicon)
- Administrative privileges to install software

## What the Script Does

1. **Checks for Docker Installation**:
    - If Docker is already installed, it starts the Docker application in the background.
    - If Docker is not installed, it automatically downloads, mounts, and installs Docker.

2. **Checks for Minikube Installation**:
    - If Minikube is installed, it skips the installation.
    - If Minikube is not installed, it downloads and installs Minikube for macOS (`arm64` architecture).

3. **Starts Minikube**:
    - Minikube is started with 4 CPUs and 6144 MB of memory.

4. **Elasticsearch Operator Setup**:
    - Installs the required Custom Resource Definitions (CRDs) for the Elasticsearch operator.
    - Deploys the Elasticsearch operator and its associated RBAC permissions.
    - Creates a Kubernetes namespace called `monitoring`.
    - Deploys the Elasticsearch operator and NodePort service from your provided manifest files.

## Usage

### 1. Run the Script

You can run the script by following these steps:

1. Clone the repository or copy the script to your local machine.
2. Open a terminal and navigate to the directory containing the script.
3. Make the script executable:

    ```bash
    chmod +x setup.sh
    ```

4. Run the script:

    ```bash
    ./setup.sh
    ```

### 2. Elasticsearch Operator Manifest Files

Ensure you have the following manifest files available for the Elasticsearch operator:
- `elasticsearch-operator/es-operator.yaml`
- `elasticsearch-operator/es-service-nodeport.yaml`

The script will automatically apply these files to deploy the Elasticsearch operator and a service using NodePort.

### 3. Check the Elasticsearch Operator

Once the script completes, verify that the Elasticsearch operator is running by using:

```bash
kubectl get pods -n monitoring
```

### 4. Run es locally
```
kubectl port-forward -n monitoring  service/eck-elasticsearch-es-http 9200
```



