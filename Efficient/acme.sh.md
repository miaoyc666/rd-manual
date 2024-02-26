acme.sh生成证书
=

### acme.sh
```bash
# 常用的Let's Encrypt 证书生成工具有 certbot、acme.sh、acme-tiny，这里介绍的是acme.sh

# 安装
git clone --depth 1 https://github.com/acmesh-official/acme.sh.git
cd acme.sh
./acme.sh --install -m my@example.com
source ~/.bashrc

# 准备阿里云的key和secret
export Ali_Key="YourAccessKeyId"
export Ali_Secret="YourAccessKeySecret"
# 生成证书
acme.sh --issue --dns dns_ali -d example.com -d dev.example.com
```

### openssl生成证书
```bash
openssl genrsa -out xx.xx.com.key 2048
openssl req -new -key dxx.xx.com.key -out dev.intel.sankuai.com.csr
openssl x509 -req -days 365 -in xx.xx.com.csr -signkey xx.xx.com.key -out xx.xx.com.crt
```

