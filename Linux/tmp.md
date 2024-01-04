Linux
=

### 系统工具安装使用
#### 1.ntp
##### 1.1 部署本地ntp服务器
```bash
```

#### 2.sftp服务器
```bash
# 创建一个新用户
sudo adduser sftpuser

# 设置密码
sudo passwd sftpuser

# 创建一个供SFTP用户使用的目录
sudo mkdir -p /home/sftpuser/files

# 设置目录权限
sudo chown root:root /home/sftpuser
sudo chmod 755 /home/sftpuser
sudo chown sftpuser:sftpuser /home/sftpuser/files

Match User sftpuser
    ChrootDirectory /home/sftpuser
    ForceCommand internal-sftp
    AllowTcpForwarding no
    X11Forwarding no
```
