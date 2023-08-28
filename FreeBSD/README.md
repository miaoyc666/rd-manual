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
netstat -rn 
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

#### 3.修改环境变量
```csh 
# freebsd默认使用csh，修改配置信息需要修改.cshrc
vi .cshrc
setenv {$NAME} {$VALUE}
```

#### 4.添加lib搜索路径
```bash 
# 临时方案，一次加载一次有效
ldconfig -m PATH
# 长期方案，
```

### 四、软件安装
####  4.1.更改pkg源
```bash
# 参考资料：https://mirrors.ustc.edu.cn/help/freebsd-pkg.html
# 自 FreeBSD 11 以后的版本，包括 quarterly 和滚动更新的 latest 仓库。
# FreeBSD 9 以前的版本不支持新的 pkg 包管理器（pkgng），请升级到新版
mkdir -p /usr/local/etc/pkg/repos
vi /usr/local/etc/pkg/repos/FreeBSD.conf
# start copy and paste
FreeBSD: {
  url: "pkg+http://mirrors.ustc.edu.cn/freebsd-pkg/${ABI}/quarterly",
}
# end 
pkg update -f
```

#### 4.2 更新Ports
```bash 
portsnap fetch update
portsnap extract
```

### 五. 踩坑
#### 1.curl
FreeBSD9.2不支持pkg，ports也不再支持，想用什么软件需要用源码编译安装。
- [curl](curl.md)

#### 2.curl和openssl
- FreeBSD9.2内置的openssl版本为0.9.8，不支持较新的tls，坑1；
- 编译libcurl需要先编译升级openssl，再编译升级libcurl；
- SSL_load_error_strings函数在高版本api不支持，想要支持需要在编译时指定api版本，坑2；
- 编译openssl指定的api版本参数莫名不生效，坑3；（改源码解决了）

#### 3.yaml
暂空

#### 4.安装 Autoconf, Automake & Libtool
```bash 
curl -OL http://ftpmirror.gnu.org/autoconf/autoconf-2.69.tar.gz 
tar -xzf autoconf-2.69.tar.gz 
cd autoconf-2.69 
./configure && make && sudo make install   


curl -OL http://ftpmirror.gnu.org/automake/automake-1.14.tar.gz 
tar -xzf automake-1.14.tar.gz 
cd automake-1.14 
./configure && make && sudo make install   

curl -OL http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz 
tar -xzf libtool-2.4.2.tar.gz 
cd libtool-2.4.2 
./configure && make && sudo make install
```
