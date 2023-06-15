# Nginx

### 经典反向代理样例
```bash
server {
  listen 80;
  server_name myc.ink;
  rewrite ^(.*)$ https://${server_name}$1 permanent;
}

server {
  listen       443 ssl http2 default_server;
  listen       [::]:443 ssl http2 default_server;
  server_name  myc.ink www.myc.ink;
  
  access_log   /var/log/nginx/myc.ink.log main;
  error_log    /var/log/nginx/myc.ink.error.log;

  ssl_certificate "/etc/nginx/cert/myc.ink.pem";
  ssl_certificate_key "/etc/nginx/cert/myc.ink.key";
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
  ssl_prefer_server_ciphers on;
  ssl_session_cache shared:SSL:1m;
  ssl_session_timeout 5m;

  gzip                       on;
  gzip_vary                  on;
  gzip_proxied               any;
  gzip_min_length            1k;
  gzip_comp_level            3;
  gzip_types text/plain application/json application/x-javascript application/javascript text/css;

  location / {
    root /data/web/output;
    index index.html index.htm;
  }
  
  location /api/v1/ {
    proxy_set_header Host $Host;
    proxy_pass_request_headers on;
    proxy_set_header X-Forwarded-Host $Host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_http_version 1.1;
    proxy_set_header Connection "";
    proxy_pass http://open_api_v1/;
  }
}

### 端口转发加base auth
```bash
# /etc/nginx/pass_file内容示例：
# 用户名:密码
# docker:wslClcoyKal4c
server {
    listen      8090;
    location / {
        auth_basic   "登录认证";
        auth_basic_user_file /etc/nginx/pass_file;
        autoindex on;
        autoindex_exact_size on;
        autoindex_localtime on;
        proxy_set_header Host 10.95.xx.xx;
        proxy_pass http://localhost:8090/;
    }
}
```

### 转发适配规则
#### 带前缀转发
```config
location /api/v1/ {
    proxy_pass http://open_api_v1;
}
```
#### 不带前缀转发
与带前缀转发写法区别仅仅是一个`/`
```config
location /api/v1/ {
    proxy_pass http://open_api_v1/;
}
```

#### 负载均衡配置
```config
# 在http内定义upstream，此处负载均衡策略为轮询
upstream testservice {
    server 192.168.88.1:2022 weight=1;
    server 192.168.88.2:2022 weight=1;
    server 192.168.88.3:2022 weight=1;
}

# 在server内配置转发
location ^~ /xxx/yyy {
    proxy_set_header Host $Host;
    proxy_pass_request_headers on;
    proxy_set_header X-Forwarded-Host $Host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_http_version  1.1;
    proxy_set_header Connection "";
    if ($uri ~* '/xxx/') {
        proxy_pass http://testservice;
    }
}
```
