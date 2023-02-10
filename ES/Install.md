# 安装ES

#### 1、Docker
```bash
docker pull docker.io/elasticsearch:7.1.1
docker run -d --name es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" b0e9f9f047e6
```
