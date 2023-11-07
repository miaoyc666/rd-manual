VPN
=

### OpenVPN
#### 服务端安装
```bash 
wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
```

#### 客户端接管所有流量
```bash
# 客户端配置文件client.ovpn中添加
redirect-gateway def1
```

#### 参考资料
- [OpenVPN Build](https://www.youtube.com/watch?v=o8vbT6siiDU&ab_channel=%E5%B0%8F%E5%85%AD%E6%95%99%E5%AD%A6)


### Wireguard windows
#### 配置
```editorconfig
[Interface]
PrivateKey = xxx
Address = 192.168.89.1/32
DNS = 119.29.29.29

[Peer]
PublicKey = xxx
AllowedIPs = 0.0.0.0/0
Endpoint = x.x.x.x:11112
PersistentKeepalive = 15
```