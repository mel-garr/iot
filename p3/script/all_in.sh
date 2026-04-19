#!/bin/bash

k3d cluster create --servers 1 --agents 1 -p "8888L:8888@loadbalancer"

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

kubectl apply -f confs/