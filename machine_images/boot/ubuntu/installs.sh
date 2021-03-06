#!/bin/bash

ETCD_VERSION=v3.2.24
K8S_VERSION=1.13.3

sudo apt-get update
DEBIAN_FRONTEND=noninteractive sudo -E apt-get -yq upgrade
sudo apt-get install -y docker.io apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet=${K8S_VERSION}-00 kubeadm=${K8S_VERSION}-00 kubectl=${K8S_VERSION}-00

curl -sSL https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz | sudo tar -xzv --strip-components=1 -C /usr/local/bin/
rm -rf etcd-$ETCD_VERSION-linux-amd64*

sudo mv /tmp/bootctl /usr/local/bin/
sudo chmod +x /usr/local/bin/bootctl

sudo mkdir -p /etc/kubernetes/network
sudo mv /tmp/network.yaml /etc/kubernetes/network/

sudo mkdir -p /etc/kubernetes/infra
sudo mv /tmp/infra.yaml /etc/kubernetes/infra/

