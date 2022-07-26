Docker
=


### docker基础
##### 0.一条命令运行指定镜像的容器
```bash
docker run -d -t {image_id}
```

##### 1.导出镜像
```bash
docker save -o ./test.tar test:v1.0.0
```

##### 2.导入镜像
```bash
docker load  --input ./test.tar 
```


### docker-compose基础
##### 命令说明
```bash
docker-compose  # 主命令
xxx.yaml       # 需要执行的容器的配置文件
```

##### 启动容器
```bash
docker-compose -f xxx.yaml up       # 前台启动
docker-compose -f xxx.yaml up -d    # 后台启动
docker-compose -f xxx.yaml up xxx   # 指定容器启动
```

##### 查看容器状态
```bash
docker-compose -f xxx.yaml ps
```

##### 查看容器日志
```bash
docker-compose -f xxx.yaml logs        # 查看所有容器日志 
docker-compose -f xxx.yaml logs xxx    # 查看指定容器日志
```

##### 停止容器
```bash
docker-compose -f xxx.yaml stop        # 停止所有容器
docker-compose -f xxx.yaml stop xxx    # 停止指定容器
```

