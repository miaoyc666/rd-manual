# 安装k8s

###### 说明：自 v1.24 起，Dockershim 已从 Kubernetes 项目中移除。故相比于老版本，v1.24以上需要安装容器运行时接口（CRI）。
###### v1.24以前的安装教程链接
### [0.安装老k8s](./Install-old.md)

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

### 2.安装kubelet
与老版本相同

### FAQ
#### 1.Kubeadm初始化报错：[ERROR CRI]: container runtime is not running
解决办法
```bash
rm -rf /etc/containerd/config.toml
systemctl restart containerd

输入后上述命令后再次执行kubeadm init
```
