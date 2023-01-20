安装containerd
=

### 0.写在前面
[官方文档-安装containerd](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)

### 1.内核模块配置
加载内核模块overlay和br_netfilter, 创建/etc/modules-load.d/containerd.conf 配置文件:
```bash
cat << EOF > /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter
```

### 2.安装containerd
2.1或2.1章节仅执行一次即可
#### 2.1 源安装containerd
```bash
# centos: 配置yum源（此处使用阿里源）
wget -O /etc/yum.repos.d/docker-ce.repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install -y containerd.io

# ubuntu: 配置apt源（此处使用阿里源）
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y containerd.io
```

#### 2.2 下载安装containerd
```bash
# install containerd
wget https://github.com/containerd/containerd/releases/download/v1.6.14/containerd-1.6.14-linux-amd64.tar.gz
tar Cxzvf /usr/local containerd-1.6.14-linux-amd64.tar.gz
mkdir -p /usr/local/lib/systemd/system/
cat > /usr/local/lib/systemd/system/containerd.service <<EOF
[Unit]
Description=containerd container runtime
Documentation=https://containerd.io
After=network.target local-fs.target

[Service]
#uncomment to enable the experimental sbservice (sandboxed) version of containerd/cri integration
#Environment="ENABLE_CRI_SANDBOXES=sandboxed"
ExecStartPre=-/sbin/modprobe overlay
ExecStart=/usr/local/bin/containerd

Type=notify
Delegate=yes
KillMode=process
Restart=always
RestartSec=5
# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNPROC=infinity
LimitCORE=infinity
LimitNOFILE=infinity
# Comment TasksMax if your systemd version does not supports it.
# Only systemd 226 and above support this version.
TasksMax=infinity
OOMScoreAdjust=-999

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now containerd
systemctl status containerd
```

```bash
# Installing runc
wget https://github.com/opencontainers/runc/releases/download/v1.1.4/runc.amd64
install -m 755 runc.amd64 /usr/local/sbin/runc
```

```bash
# Installing CNI plugins
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
```

### 3.配置containerd
生成containerd的配置文件
```bash
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml # 生成配置文
vim /etc/containerd/config.toml # 编辑配置文件
```
编辑内容如下：
- SystemdCgroup = false 改为 SystemdCgroup = true
- sandbox_image = "k8s.gcr.io/pause:3.6" 改为 sandbox_image = "registry.aliyuncs.com/google_containers/pause:3.6"

### 4.启动
```bash
systemctl enable containerd
systemctl start containerd

crictl config runtime-endpoint unix:///var/run/containerd/containerd.sock
```

### 5.导入镜像
```bash
ctr image import <path/to/image/file> -n <namespace>
```
