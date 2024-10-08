编译安装openresty
=

```bash
# 更新系统包
sudo apt update 
sudo apt upgrade -y

# 安装依赖
sudo apt install -y curl build-essential libpcre3-dev libssl-dev zlib1g-dev

# 下载openresty，略
# curl -LO https://openresty.org/download/openresty-1.19.3.1.tar.gz

# install
tar -xzvf openresty-1.19.3.1.tar.gz
cd openresty-1.19.3.1
./configure
gmake
sudo gmake install
echo 'export PATH=$PATH:/usr/local/openresty/bin' >> ~/.bashrc
source ~/.bashrc

# check
openresty -v

# run
openresty

# kill 
kill -9 {openresty的进程号}
```
