Linux
=

### 一、用户管理篇
#### 1.用户管理
##### 1.1 新增用户
```bash
useradd <username>
passwd

# adduser 更好用，可以自动创建用户目录用户组
adduser <username>
```

#### 2.添加sudo免密
```bash
# 两种方法：
# 1.编辑/etc/sudoers
# 2.新增/etc/sudoers.d/{$user}文件
# 适配centos, ubuntu, debian

新增内容: {$user} ALL=(ALL) NOPASSWD:ALL
举例: miaoyc ALL=(ALL) NOPASSWD:ALL
```

### 二、文件操作
#### 1.压缩和加解密
[压缩和加解密](tar.md)

#### 2.符号链接
```bash
# 新增硬连接
ln f1 f2
# 新增软链接
ln -s f1 f3
# f1和f2指向同一个inode节点，删除f1后，f2不受到影响，f3受到影响
```

### 三、网络配置篇
[网络配置](network.md)

### 文件系统
#### 1.查找文件，统计代码行数
```bash
find . -name "*.c" | xargs grep -v "^$" | wc -l
```

#### 2.根据inode删除文件
```bash 
# 找到文件的inode号
ls -il
# 根据inode号删除文件
find . -inum <inode> -exec rm -i {} \;
```

#### 3.获取目录内除最新修改外的所有文件
```bash
ls -t | tail -n +2 | xargs echo
```

### 四、系统篇
#### 1.更改时区
```bash
# 查看时区
timedatectl
# 修改时区为上海
sudo timedatectl set-timezone Asia/Shanghai
```

#### 2.同步ntp时间
```bash
# ntp服务器可换为其他
ntpdate time.windows.com
```

#### 3.修改日期时间
```bash
# 同时修改日期时间, 注意要加双引号, 日期与时间之间有一空格
date -s "2023-05-03 14:15:00"  
# 修改完后, 系统时间写入cmos
clock -w
```

#### 4.更改hostname
```bash
# 根据操作系统不同，分别修改以下文件
修改/etc/hostname
修改/etc/hosts
```

### 五、ssh操作
#### 1.更改ssh超时
```bash
# debian
vim /etc/ssh/sshd_config
# 修改一下内容
ClientAliveInterval 30
ClientAliveCountMax 3

systemctl restart sshd
```

#### 2.sftp
[sftp](sftp.md)

