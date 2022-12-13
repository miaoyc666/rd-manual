# Debug

#### 网络服务是否开启
tcp:
- telnet {ip} {port}
- nc -z {ip} {port}

udp:
- nc -uz {ip} {port}

#### strace
```bash
# install
yum install centos-release-scl-rh -y
yum install strace --enablerepo=centos-sclo-rh -y

# 命令追踪，例如df -h卡顿
strace df -h
```
