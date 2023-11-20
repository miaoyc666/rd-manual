网络配置
=


#### Centos
##### 主要配置文件
```conf
# /etc/sysconfig/network-scripts/ifcfg-*
# /etc/sysconfig/network-scripts/route-*
```

##### 设置默认网关
```conf

# 示例
default via 192.168.88.254 dev eth0
```

##### 设置静态路由
```conf

# 示例
10.15.150.0/24 via 192.168.150.253 dev eth1
```

#### Ubuntu
##### 重启网络服务


##### 配置静态ip
1.修改文件内容：/etc/netplan/01-network-manager-all.yaml
```yaml
# Let NetworkManager manage all devices on this system
network:
    ethernets:
        ens32:                    ## network card name
            dhcp4: false
            addresses:
              - 192.168.3.88/24   ## set static IP
            routes:
              - to: default
                via: 192.168.3.1  ## gateway
            nameservers:
              addresses: [8.8.8.8,8.8.4.4,192.168.3.1]
    version: 2
```
2.netplan apply
```bash
netplan安装: apt install netplan.io
```

#### 命令
##### 1.清空路由表
```bash
ip route flush table main
```

##### 2.关闭防火墙
```bash
systemctl stop firewalld
systemctl stop iptables
```
