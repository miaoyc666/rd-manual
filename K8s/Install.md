# 安装k8s

### [官方文档](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

###### 截止24年5月，k8s最新版本为v1.30
###### k8s版本更新太快啦，这个文档第一版本封版的时候是23年1月份，当时最新的版本是v1.24
###### 说明：自 v1.24 起，Dockershim 已从 Kubernetes 项目中移除。故相比于老版本，v1.24以上需要安装容器运行时接口（CRI）。若需要在v1.24版本以上使用docker命令，需要安装docker和cri-docker。


### 1.安装CRI
| 运行时 | Unix 域套接字 |
| --- | --- |
| containerd | unix:///var/run/containerd/containerd.sock |
| CRI-O | unix:///var/run/crio/crio.sock |
| Docker Engine（使用 cri-dockerd） | unix:///var/run/cri-dockerd.sock |


#### 1.1 首选containerd
##### 官方安装文档：[github](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)
##### 个人安装文档：[安装Containerd](./cri/Install-containerd.md)

#### 1.2 次选安装cri-docker
依赖Docker: [安装cri-docker](./cri/install-cri-docker.md)

### 2.安装K8s
#### 2.1 centos安装
```bash
### centos
cat <<EOF >/etc/yum.repos.d/kubernetes.repo

[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
       http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# 将 SELinux 设置为 permissive 模式（相当于将其禁用）
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet
```

#### 2.2 ubuntu安装
```bash
### Debian/Ubuntu
# 1.更新 apt 包索引并安装使用 Kubernetes apt 仓库所需要的包
apt update && apt install -y apt-transport-https
# 2.下载公开签名秘钥
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
# 3.添加 Kubernetes apt 仓库
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
# 4. 更新 apt 包索引，安装 kubelet、kubeadm 和 kubectl，并锁定其版本
apt update
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# ps: 安装指定版本k8s: 
apt-get install -y kubelet=1.25.2-00 kubeadm=1.25.2-00 kubectl=1.25.2-00
```

#### 2.3 debian安装
```bash
sudo apt-get update
# apt-transport-https 可能是一个虚拟包（dummy package）；如果是的话，你可以跳过安装这个包
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# 如果 `/etc/apt/keyrings` 目录不存在，则应在 curl 命令之前创建它，请阅读下面的注释。
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# 此操作会覆盖 /etc/apt/sources.list.d/kubernetes.list 中现存的所有配置。
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

#### 2.4 修改内核运行参数
```bash 
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# 应用配置
sysctl --system
```

### 3.初始化Kubeadm
#### 3.1 默认使用containerd初始化
如果使用kube-vip，则修改以下配置：--apiserver-advertise-address=<vip>， apiserver-advertise-address参数的地址指向预先分配好的ip地址。
```bash
# 默认使用containerd初始化
kubeadm init --kubernetes-version=v1.25.2 --apiserver-advertise-address=192.168.88.110 --image-repository registry.aliyuncs.com/google_containers --pod-network-cidr=10.244.0.0/16 --cri-socket /var/run/containerd/containerd.sock

# 使用cri-docker初始化
kubeadm init --kubernetes-version=v1.25.2 --apiserver-advertise-address=192.168.88.110 --image-repository registry.aliyuncs.com/google_containers --pod-network-cidr=10.244.0.0/16 --cri-socket /var/run/cri-dockerd.sock
```

#### 3.2 清理节点
```bash
kubeadm reset -f
rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/run/kubernetes ~/.kube/*
iptables -F && iptables -X
iptables -t nat -F && iptables -t nat -X
iptables -t raw -F && iptables -t raw -X
iptables -t mangle -F && iptables -t mangle -X
systemctl restart docker
```

### 4.安装网络插件
[kube-flannel.yml](https://github.com/miaoyc666/rd-manual/blob/main/K8s/cni/kube-flannel.yml)
```bash
# kube-flannel.yml依赖镜像
# quay.io/coreos/flannel:v0.14.0
# k8s.gcr.io/pause:3.6
#  kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f kube-flannel.yml
```

### 故障排查
#### [官方FAQ](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/)
#### 1.Kubeadm初始化报错
##### 在已经安装containerd并且状态是running情况下，kubeadm init提示 [ERROR CRI]: container runtime is not running
##### 解决办法：
```bash
rm -rf /etc/containerd/config.toml
systemctl restart containerd

输入后上述命令后再次执行kubeadm init
```

#### 2.[ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables] /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
##### 解决办法
```bash
modprobe br_netfilter
# echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
```

#### 3.kubeadm init或kubeadm config images pull失败
```bash
# 一般情况是源网络不通，可使用国内源下载
--image-repository registry.aliyuncs.com/google_containers
```

#### 4.The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05
`apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B53DC80D13EDEF05`

#### 5.running with swap on is not supported, please disable swap!
`swapoff -a`

#### 6. 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }
```bash 
# 移除污点
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```

<!-- #### 7. 0/1 nodes are available: 1 node(s) had untolerated taint {node.kubernetes.io/not-ready: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling
```bash 
kubectl taint vm111 node.kubernetes.io/not-ready:NoSchedule-
``` -->

##### 7. /proc/sys/net/ipv4/ip_forward contents are not set to 1
`echo 1 > /proc/sys/net/ipv4/ip_forward`
