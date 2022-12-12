#!/bin/bash

# https://kubernetes.io/zh/docs/reference/setup-tools/kubeadm/kubeadm-init/

# 初始化 kubeadm
### With Docker CE ###
sudo kubeadm init \
  --pod-network-cidr=192.168.0.0/16 \
  --kubernetes-version=v1.25.4 \
  --cri-socket=unix:///var/run/cri-dockerd.sock

# enable kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 安装pod网络插件 calico
cd ~
curl https://raw.githubusercontent.com/projectcalico/calico/v3.24.5/manifests/calico.yaml -O
kubectl apply -f calico.yaml

# check
sudo systemctl status kubelet # 查看kubelet服务状态
journalctl -xefu kubelet # kubelet logs
kubectl version # 查看kubectl版本
kubectl get node # 查看节点
kubectl get pod -n kube-system # 查看kube-system状态




sudo kubeadm join 192.168.3.90:6443 --token whbai4.xqzd2d84euhay2b6 \
	--discovery-token-ca-cert-hash sha256:be4d5353d055d71ac5585770b18a3c98c60cb443ae3621edbcfc0af8fd42c7ec \
  --cri-socket=unix:///var/run/cri-dockerd.sock


# get join token
# kubeadm token list
# kubeadm token create --print-join-command
# openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'