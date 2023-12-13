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
