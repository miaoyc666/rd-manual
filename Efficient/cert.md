Https证书生成
=

### acme.sh
```bash
# 常用的Let's Encrypt 证书生成工具有 certbot、acme.sh、acme-tiny，这里介绍的是acme.sh

# 安装（也可以用 curl 一键安装）
curl https://get.acme.sh | sh -s email=my@example.com
source ~/.bashrc
# 默认安装到 ~/.acme.sh，并自动写入 crontab，每天检查证书是否需要续期

# 准备阿里云的key和secret（RAM子账号，只授予 AliyunDNSFullAccess 权限，不要用主账号AK）
export Ali_Key="YourAccessKeyId"
export Ali_Secret="YourAccessKeySecret"
# 其他DNS服务商对应插件：Cloudflare用 dns_cf，腾讯云DNSPod用 dns_dp

# 生成证书（DNS验证，自动添加/删除TXT记录，推荐ECC证书）
acme.sh --issue --dns dns_ali -d example.com -d dev.example.com --keylength ec-256

# 证书原始文件默认在 ~/.acme.sh/example.com_ecc/，不要直接给服务用，
# 用 --install-cert 发布到实际路径，并指定续期后自动reload的命令
mkdir -p /path/to/ssl/example.com
acme.sh --install-cert -d example.com --ecc \
  --key-file       /path/to/ssl/example.com/key.pem \
  --fullchain-file /path/to/ssl/example.com/fullchain.pem \
  --reloadcmd      "systemctl reload nginx"

# 自动续期：crontab里的 acme.sh --cron 只在证书临近到期（默认到期前60天）时才会续签，
# 续签成功后会自动执行上面 --install-cert 注册的发布+reload动作，无需手动重跑
# 30 8 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null
# 手动验证整个流程（--force强制触发，不加则只在临期时生效）：
sudo /root/.acme.sh/acme.sh --cron --home "/root/.acme.sh" --force

# 示例：happycode.fun
acme.sh --issue --dns dns_ali -d happycode.fun -d www.happycode.fun --keylength ec-256
mkdir -p /home/miaoyc/code/homelab/happycode/ssl
acme.sh --install-cert -d happycode.fun --ecc \
  --key-file       /home/miaoyc/code/homelab/happycode/ssl/happycode.fun.key \
  --fullchain-file /home/miaoyc/code/homelab/happycode/ssl/happycode.fun.pem \
  --reloadcmd      "systemctl reload nginx"
```

### acme.sh常见问题QA

**Q: DNS验证和HTTP验证怎么选？**

A: 优先用DNS验证（`--dns dns_ali` 等插件）。不需要域名解析到当前服务器、不需要开放80端口，还能签发泛域名证书。HTTP验证（webroot/standalone模式）必须域名已指向当前服务器且80端口可用，且不支持泛域名。

**Q: `acme.sh --issue` 生成的证书具体放在服务器哪个位置？**

A: 默认在 `~/.acme.sh/<域名>_ecc/`（RSA证书则在 `~/.acme.sh/<域名>/`），里面有 `.key`/`.cer`/`fullchain.cer` 等文件。**不要让Nginx等服务直接引用这个目录**，续期时这里的文件会被覆盖、路径也不规范。正确做法是用 `--install-cert` 把证书发布到自己指定的路径（如 `/path/to/ssl/`），见上面命令。

**Q: crontab里的 `acme.sh --cron` 会自动执行 `--install-cert` 吗？**

A: 会，但不是每次cron触发都重新跑一遍：
- `--cron` 只检查证书是否临近到期（默认到期前60天），没到期什么都不做；
- 证书**真正续签成功**时，acme.sh 会自动执行你之前 `--install-cert` 时注册的安装动作（拷贝到指定路径 + 执行 `--reloadcmd`），这个配置保存在 `~/.acme.sh/<域名>_ecc/<域名>.conf` 里；
- 所以 `--install-cert` 只需要**手动跑一次**完成注册，之后续期、部署、reload全自动，不用人工干预。

**Q: 用 `sudo ... --cron --home "/root/.acme.sh" --force` 测试时要注意什么？**

A: 如果acme.sh是以root身份安装运行的（crontab里 `--home "/root/.acme.sh"`），而证书要装到非root用户目录（如 `/home/xxx/...`），需要确认：
1. root对目标目录有写权限；
2. `--install-cert` 这条命令也要以root身份执行，注册的安装配置才会被root的crontab用到，否则续期后不会自动部署到目标路径。

### openssl生成证书，自签证书
```bash
openssl genrsa -out xx.xx.com.key 2048
openssl req -new -key dxx.xx.com.key -out dev.intel.sankuai.com.csr
openssl x509 -req -days 365 -in xx.xx.com.csr -signkey xx.xx.com.key -out xx.xx.com.crt
```

### Mac Let's Encrypt生成证书
```bash
brew install certbot

sudo certbot certonly -d "xxx.com" --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory

# https://blog.csdn.net/maxi1234/article/details/141459718
```
