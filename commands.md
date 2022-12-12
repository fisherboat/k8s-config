### 查看默认空间pods 详细列表
kubectl get pods -o wide
### 查看 kube-system pod 详细列表
kubectl get pod -n kube-system -o wide