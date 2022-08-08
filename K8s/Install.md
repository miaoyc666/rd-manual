# 安装k8s
## 先安装docker，再安装k8s
### 1.安装docker
一键安装docker脚本如下：
```bash
# 移除旧版包
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# 安装依赖
sudo yum install -y yum-utils \
           device-mapper-persistent-data \
           lvm2

# 配置源
sudo yum-config-manager \
    --add-repo \
    https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo

# 安装
sudo yum makecache fast
sudo yum install -y docker-ce

# 启动
sudo systemctl enable docker
sudo systemctl start docker

# 用户配置
sudo groupadd docker
sudo usermod -aG docker $USER
```

### 2.修改docker cgroupdriver
安装完成docker后需修改`/etc/docker/daemon.json`，因为systemd是Kubernetes自带的cgroup管理器, 负责为每个进程分配cgroups。
```json
{"exec-opts": ["native.cgroupdriver=systemd"]}
```
```bash
systemctl start docker
```

### 3.修改镜像存储目录（可选项）
修改镜像存储目录，解决根目录容量不够问题，修改systemd配置文件（例如/usr/lib/systemd/system/docker.service），添加参数：--graph。
```yaml
ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --graph /data/docker
```

### 安装k8s

#### [官网链接](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
```bash
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# 将 SELinux 设置为 permissive 模式（相当于将其禁用）
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet
```

#### 配置国内阿里源进行更新
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

#### [安装指定版本程序](https://github.com/miaoyc666/rd-manual/blob/main/Install/README.md)


#### 设置主节点, Master init
```bash
kubeadm init --kubernetes-version=v1.23.4 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.249.192.42
# 在上面的命令中，--kubenets-version要对应真实版本的，--pod-network-cidr需要自己想一个网段，--apiserver-advertise-address这个master的ip，即当前master的IP

# kubeadm init会返回从节点用鱼join的命令，拷贝粘贴到想要加入到主节点的节点上执行即可
```

#### 设置环境变量
```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/kubelet.conf
```

#### 配置从节点，Node join
```bash
# 使用kubeadm init的返回结果执行即可
You can now join any number of machines by running the following on each node
as root:
kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

#### 主节点的Token管理
```bash
kubeadm token create    # 创建新token
kubeadm token list      # 获取token列表
```

#### 常规自启设置
```bash
systemctl enable kubelet
systemctl restart kubelet
```

#### 安装网络插件
```bash
kubectl apply -f kube-flannel.yml
```

#### 修改kube-proxy支持
```bash
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
```

#### 解决no networks found in /etc/cni/net.d
```bash
```


## 升级K8s
#### yum安装软件包提示公钥尚未安装问题
```bash
# install时添加参数
yum install --nogpgcheck
```

