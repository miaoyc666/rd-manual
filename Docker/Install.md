# 安装Docker

### 1 Install
#### 1.1 Centos
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

#### Ubuntu
```bash
# 移除旧版包
apt remove docker docker.io containerd runc

# 安装依赖
apt install ca-certificates curl gnupg lsb-release 
apt install software-properties-common

# 添加密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add

# 配置源
add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 更新源
apt -y update

# 安装docker-ce
apt install docker-ce

# 启动
systemctl enable docker
systemctl start docker
```

### 2.修改docker cgroupdriver
安装完成docker后需修改`/etc/docker/daemon.json`，因为systemd是Kubernetes自带的cgroup管理器, 负责为每个进程分配cgroups。
```json
{"exec-opts": ["native.cgroupdriver=systemd"]}
```

### 3.修改镜像存储目录（可选项）
修改镜像存储目录，解决根目录容量不够问题，修改systemd配置文件（例如/usr/lib/systemd/system/docker.service），添加参数：--graph。
```conf
ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --graph /data/docker
```