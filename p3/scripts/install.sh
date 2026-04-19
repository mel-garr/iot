#!/bin/bash

set -e

apt-get update -y
apt-get install -y curl

curl -fsSL https://get.docker.com | bash
usermod -aG docker ${SUDO_USER:-$USER}

KUBECTL_VERSION=$(curl -s https://dl.k8s.io/release/stable.txt)

curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256"

echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

rm kubectl kubectl.sha256

curl -fsSL https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash