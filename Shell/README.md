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
[网络配置](./network.md)

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

