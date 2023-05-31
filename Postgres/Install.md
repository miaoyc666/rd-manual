Postgres安装
=

### docker-compose启动
docker-compose.yaml中的xxx需要替换为真实密码
```yaml
version: '3'
services:
  db:
    image: postgres:10.6
    restart: always
    environment:
      POSTGRES_PASSWORD: xxx
    volumes:
      - ./data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    mem_limit: 8g
    cpus: 4
```
