Nomad
=


### 部署步骤  
集群一般由三个节点组建而成，安装nomad需要分别在集群的节点上执行以下安装步骤：  
```bash
wget https://releases.hashicorp.com/nomad/0.11.2/nomad_0.11.2_linux_amd64.zip  
unzip nomad_0.11.2_linux_amd64.zip    
mv -f nomad /usr/local/bin/    
mkdir -p /etc/nomad.d/  
mv -f nomad.hcl /etc/nomad.d/  
mv -f nomad.service /usr/lib/systemd/system/  
systemctl enable nomad  
systemctl start nomad  
systemctl status nomad
```
启动成功后访问`http://x.x.x.x:4646`访问nomad web管理页面

### 常用端口
部署集群时，需检查集群节点间端口访问是否通畅  
* http = 4646  
* rpc  = 4647  
* serf = 4648

### nomad常用命令
#### 查看集群节点状态  
`nomad server members`

#### 运行任务   
`nomad run [${project}.nomad]`

#### 停止任务  
`nomad job stop ${job_name}`

### 常见问题
1. /var/lib/nomad/server/serf.keyring存在不更新的问题，发现诡异的节点无法组成集群的情况时，删除该文件重启。

### nomad 运维知识  
1. nomad status regulator （查看allocation）  
2. nomad alloc status alloc_id (alloc_id就是a中的id号,查看allocation的具体状态）  

