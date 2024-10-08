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
openresty -s quit

# cmd list
nginx version: openresty/1.19.3.1
Usage: nginx [-?hvVtTq] [-s signal] [-c filename] [-p prefix] [-g directives]

Options:
  -?,-h         : this help
  -v            : show version and exit
  -V            : show version and configure options then exit
  -t            : test configuration and exit
  -T            : test configuration, dump it and exit
  -q            : suppress non-error messages during configuration testing
  -s signal     : send signal to a master process: stop, quit, reopen, reload
  -p prefix     : set prefix path (default: /usr/local/openresty/nginx/)
  -c filename   : set configuration file (default: conf/nginx.conf)
  -g directives : set global directives out of configuration file
```
