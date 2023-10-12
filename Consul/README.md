consul
=

### 文件清单
consul.json  consul默认配置文件

### consul搭建
https://www.consul.io/docs/install/index.html

### 默认端口
consul 默认使用下列端口

8300(tcp): Server RPC，server 用于接受其他 agent 的请求  
8301(tcp,udp): Serf LAN，数据中心内 gossip 交换数据用  
8302(tcp,udp): Serf WAN，跨数据中心 gossip 交换数据用  
8400(tcp): CLI RPC，接受命令行的 RPC 调用  
8500(tcp): HTTP API 及 Web UI  
8600(tcp udp): DNS 服务，可以把它配置到 53 端口来响应 dns 请求

### 常见问题  
1./var/lib/consul/serf/local.keyring存在不更新的问题，方发现诡异的节点无法组成集群的情况时，删除该文件重启。

### 常用consul命令
获取value:  
`consul kv get [key]`

设置value:  
`consul kv put [key] [value]`

删除key:  
`consul kv delete [key]`

获取全部kv信息：  
`consul kv get -recurse`

### 配置生成与写入
武器库配置信息使用consul+confd进行配置。  
#### 1.启动consul  
单机版（无数据写入磁盘，重启数据丢失）：consul agent -dev -config-dir=/etc/consul.d/   
正式版（需要至少三台机器）：consul agent -config-dir=/etc/consul.d/

#### 2.consul添加权限验证  
consul服务的web页面是是无登录用户认证的，登录{host}:8500即可访问。
由于consul存在数据库密码信息泄露的风险，所以需要给consul添加用户验证，此处采用nginx添加baseauth的方式来处理。  
##### a.安装httpd-tools  
`yum install httpd-tools -y`  
##### b.创建用户名和密码
`htpasswd -c -d /etc/nginx/pass_file consul`  
用户名：consul， 密码：[用户输入]  
##### c.配置nginx添加baseauth  
nginx配置信息代码段参见conf/[mode]/nginx.conf.part，nginx会监听8090端口，将请求转发到consul的8500端口。  
##### d.通过访问[host]:8090即可访问consul

#### 4.写入配置信息   
执行[env.sh](env.sh)

### export_config.sh 用法
使用*sh export_config.sh {consul_token}*命令导出机器中consul的所有k v，并在同级目录生成env.sh文件。
将env.sh文件拷入到新机器中，执行env.sh文件可以在新机器中导入旧机器的k v。

