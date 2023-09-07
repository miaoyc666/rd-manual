Docker-compose
=

##### 安装
```bash
wget https://github.com/docker/compose/releases/download/v2.18.0/docker-compose-linux-x86_64
chmod +x docker-compose-linux-x86_64
mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose
```
`高版本（具体版本没细查）docker无需额外安装docker-compose, 可直接使用内置docker compose命令`

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
