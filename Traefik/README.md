Traefik
=

#### 安装
[安装](Install.md)

#### basicauth用户密码
```bash 
# 生成用户密钥
echo $(htpasswd -nb user password) 
# 如果直接在yml中使用需要改为 echo $(htpasswd -nb user password) | sed -e s/\\$/\\$\\$/g
```




