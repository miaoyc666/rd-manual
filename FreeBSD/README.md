FreeBSD
=

### 一、用户管理篇
#### 1.用户管理
##### 1.1 新增用户
```bash
adduser
# 输入adduser后根据提示填写信息
```

### 二、网络配置篇
#### 相关配置文件 
```bash
# 修改ip、hostname和默认网关
/etc/rc.conf
# 修改dns
/etc/resolv.conf
```
#### 查看命令
```bash 
# 查看路由表
netsta -rn 
```

#### 新增默认网关
```bash 
route add default <ip>
```

#### 重启服务
```bash 
service netif restart 
```

### 三、系统篇
#### 1.更改hostname
```bash
# 根据操作系统不同，分别修改以下文件
修改/etc/rc.conf中的hostname
# 执行命令
hostname <new hostname>
```

#### 2.同步ntp时间
```bash
ntpdate time.nist.gov
```

#### 3.更改pkg源
```bash
# 参考资料：https://mirrors.ustc.edu.cn/help/freebsd-pkg.html
mkdir -p /usr/local/etc/pkg/repos
vi /usr/local/etc/pkg/repos/FreeBSD.conf
# start copy and paste
FreeBSD: {
  url: "pkg+http://mirrors.ustc.edu.cn/freebsd-pkg/${ABI}/quarterly",
}
# end 
pkg update -f
```

