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

### MongoDB Database Tools安装
#### 1.有root权限
```bash
${mongod_dir}/bin/install_compass
```

#### 2.无root权限
```bash
# 以 MongoDB 7.0 的 database tools 为例, redhat
wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-rhel70-x86_64-100.9.4.tgz
tar -zxvf mongodb-database-tools-*.tgz
# mongodb-database-tools-100.9.4/bin/ 即为目标
```
