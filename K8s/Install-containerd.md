安装containerd
=

#### 1.加载内核模块overlay和br_netfilter
创建 /etc/modules-load.d/containerd.conf 配置文件:
```bash
cat << EOF > /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter
```

#### 2.安装containerd
配置yum源（此处使用阿里源）
```bash
wget -O /etc/yum.repos.d/docker-ce.repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

yum install -y containerd.io
```

#### 3.配置containerd
生成containerd的配置文件
```bash
mkdir /etc/containerd -p 
containerd config default > /etc/containerd/config.toml # 生成配置文
vim /etc/containerd/config.toml # 编辑配置文件
```
编辑内容如下：
- SystemdCgroup = false 改为 SystemdCgroup = true
- sandbox_image = "k8s.gcr.io/pause:3.6" 改为 sandbox_image = "registry.aliyuncs.com/google_containers/pause:3.6"

#### 4.启动
```bash
systemctl enable containerd
systemctl start containerd
```