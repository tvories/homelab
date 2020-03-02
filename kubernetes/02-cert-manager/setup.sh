#!/bin/bash

# Install the CustomResourceDefinition resources separately
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.13/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install \
  cert-manager \
  --namespace cert-manager \
  --version v0.13.0 \
  --set 'extraArgs={--dns01-recursive-nameservers=8.8.8.8:53,1.1.1.1:53}' \
  jetstack/cert-manager

# Setup letsencrypt certs
kubectl apply -f lets-encrypt-staging.yml
kubectl apply -f lets-encrypt-prod.yml
kubectl apply -f cloudflare-secret.yml
