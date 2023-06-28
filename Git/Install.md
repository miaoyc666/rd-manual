# GIT

#### 安装Git v2.x====
```bash 
sudo yum remove git
sudo yum remove git-*
sudo yum install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm
sudo yum install git
```

#### 可能遇到的问题
1.This system is not registered with an entitlement server. 
You can use subscription-manager to register.  
解决方案：
```bash 
vim /etc/yum/pluginconf.d/subscription-manager.conf
enabled=0
```