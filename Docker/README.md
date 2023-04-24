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
gzip test.tar test.tar.gz

# or one cmd
docker save test:v1.0.0 | gzip > ./test.tar
```

##### 2.导入镜像
```bash
docker load  --input ./test.tar.gz
```

##### 3.容器转镜像
```bash
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
参数说明:
-a :提交的镜像作者
-c :使用Dockerfile指令来创建镜像
-m :提交时的说明文字
-p :在commit时, 将容器暂停

# example
docker commit -a "miaoyc@xxx.com" -m "add user miaoyc" 74df600453b5  miaoyc-xxx:v5.0.0
```

##### 4.镜像转容器
```bash
docker run -itd --name miaoyc-xxx miaoyc-xxx:v5.0.0
```

##### 5.查看容器IP
```bash
docker inspect --format='{{.NetworkSettings.IPAddress}}' miaoyc-xxx
```

##### 6.查看容器内进程
```bash
docker top miaoyc-xxx
docker exec -it miaoyc-xxx ps -ef
```

##### 7.查看容器内部端口
```bash
docker exec -it miaoyc-xxx netstat -tunlp
```

##### 8.使容器保持运行状态
```bash
docker run -itd --restart=always --name miaoyc-xxx miaoyc-xxx:v5.0.0
```

### docker-compose
##### 基础命令说明
```bash
# 启动容器
docker-compose -f xxx.yaml up       # 前台启动
docker-compose -f xxx.yaml up -d    # 后台启动
docker-compose -f xxx.yaml up xxx   # 指定容器启动
# 查看容器状态
docker-compose -f xxx.yaml ps
# 查看容器日志
docker-compose -f xxx.yaml logs        # 查看所有容器日志 
docker-compose -f xxx.yaml logs xxx    # 查看指定容器日志
# 停止/重启/删除容器
docker-compose stop/restart/rm/down
```