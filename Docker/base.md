Docker基础命令
= 


### docker基础
#### 1.一条命令运行指定镜像的容器
```bash
docker run -d -t {image_id}
```

#### 2.查看容器IP
```bash
docker inspect --format='{{.NetworkSettings.IPAddress}}' miaoyc-xxx
```

#### 3.查看容器内进程
```bash
docker top miaoyc-xxx
docker exec -it miaoyc-xxx ps -ef
```

#### 4.查看容器内部端口
```bash
docker exec -it miaoyc-xxx netstat -tunlp
```

#### 5.使容器保持运行状态
```bash
# 主要是添加 --restart=always
docker run -itd --restart=always --name miaoyc-xxx miaoyc-xxx:v5.0.0
```

#### 6.查看容器状态
```bash
docker stats <container_id>
```

#### 7.查看存储
```bash
docker volume ls
# 删除rm
```
