#!/bin/bash

set -e

echo "Creating k3d cluster"

k3d cluster create --servers 1 --agents 1 --port "80:80@loadbalancer" --port "443:443@loadbalancer" || true

echo "Creating namespaces"
kubectl delete namespace argocd --ignore-not-found
kubectl delete namespace dev --ignore-not-found
kubectl create namespace argocd || true
kubectl create namespace dev || true

echo "Installing ArgoCD"

kubectl apply --server-side -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=available --timeout=300s deployment -n argocd --all

kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 -d
echo -e "\n"

echo "applying app+ingress"
pwd

kubectl apply -f confs/

echo "setup sala\n"

echo "👉 Then access:"
echo "Argo CD: https://argocd.local"
echo "App:      http://app.local"


