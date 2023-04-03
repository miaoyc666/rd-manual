# 安装ES

#### 1、Docker
```bash
docker pull docker.io/elasticsearch:7.1.1
docker run -d --name es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" b0e9f9f047e6
```


#### Kibana
```bash 
# https://www.elastic.co/cn/downloads/kibana
for mac: 
1. run bin/kibana
2. http://localhost:5601 
```

#### 集群配置
[es_setup](https://github.com/miaoyc666/es-setup)
