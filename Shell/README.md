Shell 
=

### 一、用户管理篇
#### 1.用户管理
##### 1.1 新增用户
```bash
useradd <username>
passwd
```

### 二、文件操作
[压缩和加解密](./tar.md)

### 三、网络配置篇

##### 网卡配置文件
```bash
# ubuntu
/etc/network/interfaces
# 或
/etc/systemd/network/


# centos
/etc/sysconfig/network-scripts/ifcfg-*
```

##### 1.清空路由表
```bash
ip route flush table main
```

##### 2.关闭防火墙
```bash
systemctl stop firewalld
systemctl stop iptables
```

### 文件系统
#### 1.查找文件，统计代码行数
```bash
find . -name "*.c" | xargs grep -v "^$" | wc -l
```

### 系统篇
#### 1.更改时区
```bash
sudo timedatectl set-timezone Asia/Shanghai
```

#### 2.同步ntp时间
```bash
ntpdate ntp1.aliyun.com
```

