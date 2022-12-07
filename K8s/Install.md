# 安装k8s

### [官方文档](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

###### 说明：自 v1.24 起，Dockershim 已从 Kubernetes 项目中移除。故相比于老版本，v1.24以上需要安装容器运行时接口（CRI）。若需要在v1.24版本以上使用docker命令，需要安装docker和cri-docker。

### 1.安装CRI
#### 1.1 首选containerd
##### 官方安装文档：[github](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)
##### 个人安装文档：[安装Containerd](./Install-containerd.md)

#### 1.2 次选安装cri-docker
依赖Docker: [安装Docker](../Docker/Install.md)
```bash
# 由于1.24以及更高版本不支持docker所以安装cri-docker
# 下载cri-docker 
wget https://ghproxy.com/https://github.com/Mirantis/cri-dockerd/releases/download/v0.2.5/cri-dockerd-0.2.5.amd64.tgz

# 解压cri-docker
tar xvf cri-dockerd-0.2.5.amd64.tgz 
cp cri-dockerd/cri-dockerd  /usr/bin/

# 写入启动配置文件
cat > /usr/lib/systemd/system/cri-docker.service <<EOF
[Unit]
Description=CRI Interface for Docker Application Container Engine
Documentation=https://docs.mirantis.com
After=network-online.target firewalld.service docker.service
Wants=network-online.target
Requires=cri-docker.socket

[Service]
Type=notify
ExecStart=/usr/bin/cri-dockerd --network-plugin=cni --pod-infra-container-image=registry.aliyuncs.com/google_containers/pause:3.7
ExecReload=/bin/kill -s HUP $MAINPID
TimeoutSec=0
RestartSec=2
Restart=always
StartLimitBurst=3
StartLimitInterval=60s
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

# 写入socket配置文件
cat > /usr/lib/systemd/system/cri-docker.socket <<EOF
[Unit]
Description=CRI Docker Socket for the API
PartOf=cri-docker.service

[Socket]
ListenStream=%t/cri-dockerd.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker

[Install]
WantedBy=sockets.target
EOF

# 进行启动cri-docker
systemctl daemon-reload; systemctl enable cri-docker --now
```

### 2.安装K8s
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
一般情况是源网络不通，可使用国内源下载
```bash
kubeadm init --kubernetes-version=v1.25.2 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.46.177.167 --image-repository registry.aliyuncs.com/google_containers
```
