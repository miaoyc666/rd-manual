Docker
=

### 安装
[install docker](Install.md)

### docker基础命令
[base cmd](base.md)

### 实用场景
#### 1.导出镜像和导入镜像
```bash
# export
docker save -o ./test.tar test:v1.0.0
gzip test.tar test.tar.gz

# or one cmd
docker save test:v1.0.0 | gzip > ./test.tar.gz

# import 
docker load --input ./test.tar.gz
docker load < ./test.tar.gz
```

#### 2.容器和镜像互转
```bash
# 容器转镜像
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
参数说明:
-a :提交的镜像作者
-c :使用Dockerfile指令来创建镜像
-m :提交时的说明文字
-p :在commit时, 将容器暂停
# example
docker commit -a "miaoyc@xxx.com" -m "add user miaoyc" 74df600453b5  miaoyc-xxx:v5.0.0

# 镜像转容器，其实就是运行容器
docker run -itd --name miaoyc-xxx miaoyc-xxx:v5.0.0
```

#### 3.清理无效镜像
```bash
# 无效镜像会在删除时报出错误“response from daemon: reference does not exist”
systemctl stop docker
cd /var/lib/docker/image/overlay2/imagedb/content/sha256
# 找到无效镜像id对应的文件，例如image is是5076a7d1a386，在content/sha256目录下会存在5076a7d1a386开头的文件，删掉即可
systemctl restart docker
# 此时可以看到原本删除不掉的镜像在docker images列表中不存在了
```

#### 4.构建多架构镜像
[构建多架构镜像](../Test/build-multi-arch-docker-image.md)

### docker-compose
[docker-compose](./docker-compose.md)

