编译安装Curl
=

#### 发布页
[github curl](https://github.com/curl/curl/releases)

#### 安装步骤
```bash 
# 视实际情况采用下载方式，个人使用的是其他电脑wget，然后scp到目标服务器
wget https://github.com/curl/curl/releases/download/curl-8_2_1/curl-8.2.1.zip
unzip curl-8.2.1.zip
cd curl-8.2.1
./configure --with-openssl
make
make install
```