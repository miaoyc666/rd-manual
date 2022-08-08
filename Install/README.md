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

### Apt

## Mac
### Brew



