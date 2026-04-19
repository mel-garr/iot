#!/bin/bash

k3d cluster create --servers 1 --agents 1 -p "8888:8888@loadbalancer" || true

kubectl create namespace argocd || true
kubectl create namespace dev || true

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=available --timeout=300s deployment -n argocd --all
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

kubectl apply -f confs/