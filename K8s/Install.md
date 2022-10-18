# 安装k8s

###### 说明：自 v1.24 起，Dockershim 已从 Kubernetes 项目中移除。故相比于老版本，v1.24以上需要安装容器运行时接口（CRI）。

### 1.安装CRI，首选Containerd
##### 官方安装文档：[github](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)
##### 个人安装文档：[安装Containerd](./Install-containerd.md)


### 2.安装K8s
```bash
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
```

```bash
# 将 SELinux 设置为 permissive 模式（相当于将其禁用）
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet
```

### 3.初始化Kubeadm
#### 3.1 默认使用containerd初始化
```bash
kubeadm init --kubernetes-version=v1.25.2 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.46.177.167 --image-repository registry.aliyuncs.com/google_containers
```

#### 3.2 使用cri-docker初始化
```bash
kubeadm init --image-repository registry.aliyuncs.com/google_containers --kubernetes-version=v1.24.1 --pod-network-cidr=10.244.0.0/16 --cri-socket /var/run/cri-dockerd.sock
```

### 故障排查
#### 1.Kubeadm初始化报错
##### [ERROR CRI]: container runtime is not running
##### 解决办法
```bash
rm -rf /etc/containerd/config.toml
systemctl restart containerd

输入后上述命令后再次执行kubeadm init
```

#### 2.	[ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables] /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
##### 解决办法
```bash
modprobe br_netfilter
# echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
```

#### 2. kubeadm init或kubeadm config images pull失败
一般情况是源网络不通，可使用国内源下载
```bash
kubeadm init --kubernetes-version=v1.25.2 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.46.177.167 --image-repository registry.aliyuncs.com/google_containers
```
