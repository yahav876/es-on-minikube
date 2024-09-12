#!/bin/bash

# Function to check if Docker is installed
function is_docker_installed {
  if command -v docker &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Function to check if Minikube is installed
function is_minikube_installed {
  if command -v minikube &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Step 1: Check if Docker is installed
if is_docker_installed; then
  echo "Docker is already installed."
  open --background -a Docker
else
  echo "Docker not found. Installing Docker..."
  # Download Docker
  curl -LO https://desktop.docker.com/mac/main/arm64/Docker.dmg?version=4.33.0
  # Mount and Install Docker
  sudo hdiutil attach Docker.dmg
  sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
  sudo hdiutil detach /Volumes/Docker
fi

# Step 2: Check if Minikube is installed
if is_minikube_installed; then
  echo "Minikube is already installed."
else
  echo "Minikube not found. Installing Minikube..."
  # Download and install Minikube
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-arm64
  sudo install minikube-darwin-arm64 /usr/local/bin/minikube
fi

# Step 3: Start Minikube
open --background -a Docker
minikube start --cpus 4 --memory 6144


# Step 4: Initiate your ES-operator

# Install CRD's
kubectl create -f https://download.elastic.co/downloads/eck/2.14.0/crds.yaml

# Install es operator and his RBAC
kubectl apply -f https://download.elastic.co/downloads/eck/2.14.0/operator.yaml

# Create NS and deploy manifest files
kubectl create ns monitoring
kubectl apply -f elasticsearch-operator/es-operator.yaml
kubectl apply -f elasticsearch-operator/es-service-nodeport.yaml
