# 安装k8s

###### 说明：自 v1.24 起，Dockershim 已从 Kubernetes 项目中移除。故相比于老版本，v1.24以上需要安装容器运行时接口（CRI）。

### 1.安装CRI，首选containerd
##### 官方安装文档：[github](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)

借助Docker源的安装方法：
```bash
yum install -y yum-utils
yum-config-manager \
   --add-repo \
   https://download.docker.com/linux/centos/docker-ce.repo
yum install -y containerd.io
systemctl enable containerd
systemctl restart containerd
```

### FAQ
#### 1.Kubeadm初始化报错
##### [ERROR CRI] container runtime is not running
##### 解决办法
```bash
rm -rf /etc/containerd/config.toml
systemctl restart containerd

输入后上述命令后再次执行kubeadm init
```

#### 2. kubeadm init或kubeadm config images pull失败
一般情况是源网络不通，可使用国内源下载
```bash
kubeadm init --kubernetes-version=v1.25.2 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.46.177.167 --image-repository registry.aliyuncs.com/google_containers
```
