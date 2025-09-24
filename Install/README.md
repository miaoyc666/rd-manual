Software Install
= 

## Linux
### Yum
#### 获取软件的全部版本
```bash
yum list --showduplicates | grep ${soft-name}
```
#### 安装指定版本软件
```bash
yum install -y ${soft-name}-${version}
```
#### 提示公钥尚未安装问题解决
```bash
yum install --nogpgcheck ${soft-name}
```

### Apt-get
#### 查看apt已安装软件列表
```bash
apt list --installed
```

#### 获取软件的全部版本
```bash
apt-cache madison ${soft-name}
```
#### 安装指定版本软件
```bash
apt-get install -y ${soft-name}=${version}
```
#### 提示公钥尚未安装问题解决
```bash
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${key-name}
```

## Mac
### Brew
```bash 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
必装工具
```bash
brew install wget
brew install ccat
brew install htop
brew install node
brew install mysql-client  
brew install libpq
brew tap ringohub/redis-cli; brew install redis-cli
```
安装不同版本包（例如python的不同版本）
```bash
brew search {$name}
brew install {$name}@{$version}
```

安装指定包的历史版本（brew 默认只能安装最新版本包）
```bash
# 举例：安装openjdk@11的11.0.27版本(老版本)，最新版是11.0.28
# 1.去https://github.com/Homebrew/homebrew-core/tree/main/Formula找到历史版本包，下载rb文件（可通过git history找到）
wget https://raw.githubusercontent.com/Homebrew/homebrew-core/81e8cf683be640a8da5dc4f3da40e3298d947dbe/Formula/o/openjdk@11.rb
# 2.因brew不允许直接从本地文件安装，需要创建插件仓库后安装
brew tap-new miaoyc/oldjdk
cp openjdk@11.rb /opt/homebrew/Library/Taps/miaoyc/homebrew-oldjdk/Formula
brew install miaoyc/oldjdk/openjdk@11
```

### Docker
[Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/)

## FreeBSD
### pkg
#### 更新包信息
```bash 
pkg update -f 
```

#### 安装
```bash 
pkg install <pkg-name>
```
