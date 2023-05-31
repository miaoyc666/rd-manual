Mongodb安装
=

### docker-compose启动
docker-compose.yaml中的xxx需要替换为真实密码
```yaml
version: '3'
services:
  mongo:
    image: mongo:5.0
    container_name: mongo5
    restart: always
    ports:
      - "27017:27017"
    volumes:
      - /da1/s/data/mongo5:/data/db
      - /var/log/mongo5:/var/log/mongodb
    environment:
      TZ: Asia/Shanghai
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: xxx
    mem_limit: 4g
    cpus: 4
```
