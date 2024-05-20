Kube-vip
=

### 配置集群高可用
#### 1.创建Kube-vip的静态pod
kube-vip的pod需要先于k8s集群创建，因此我们采用static pod方式来创建kube-vip的pod。
在三台master服务器上执行以下命令（VIP和网卡名根据实际情况修改）
```bash 
export VIP=192.168.88.200
export INTERFACE=enp0s18

KVVERSION=$(curl -sL https://api.github.com/repos/kube-vip/kube-vip/releases | jq -r ".[0].name")

alias kube-vip="ctr run --rm --net-host ghcr.io/kube-vip/kube-vip:$KVVERSION vip /kube-vip"

kube-vip manifest pod \
    --interface $INTERFACE \
    --address $VIP \
    --controlplane \
    --services \
    --arp \
    --leaderElection | tee /etc/kubernetes/manifests/kube-vip.yaml
```

#### 2.部署第一台k8s master节点
```bash
export VIP=192.168.88.200
sudo kubeadm init --control-plane-endpoint "$VIP:6443" --upload-certs --image-repository registry.aliyuncs.com/google_containers
```


#### 常见问题
1. 报错：`ctr: image "ghcr.io/kube-vip/kube-vip:v0.8.0": not found`
   解决方案：`ctr image pull ghcr.io/kube-vip/kube-vip:v0.8.0`
