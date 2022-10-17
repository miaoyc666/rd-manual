k8s
=


## 💚原子命令
#### 通用命令
```bash
# command命令，entity实体/资源
kubectl ${command} ${entity}
```
#### command命令
##### 获取所有command：kubectl -h
##### 常用command如下：
- apply
- get 
- config
- create
- delete
- describe
- labels
- replace

#### entity列表
##### 获取所有entity：kubectl api-resources 
##### 常用entity如下：
- view
- namespaces（ns）
- deployments（deploy）
- nodes
- pod
- secrets
- configmap（cm）
- daemonsets（ds）

## 💔常见问题
##### 1.kubectl命令无权限问题
```bash
# 修改配置文件权限，此处为k3s配置，其它同理
sudo chmod 666 /etc/rancher/k3s/k3s.yaml
```
##### 2.证书过期问题
```bash
# 执行kubectl命令时，提示如下
Unable to connect to the server: x509: certificate has expired or is not yet valid
```
解决方法有两个，一是升级集群，二是手动更新证书。
###### 2.1 升级集群
官方文档

###### 2.2 更新证书
官方操作文档
`https://kubernetes.io/zh/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/`
更新证书命令
`kubeadm certs renew all`


## 💚基础命令
### 0.config
#### 0.1 获取kubeconfig
`kubectl config view`
#### 0.2 通用逻辑
- -A : 表示获取全部命名空间的对象

### 1.namespace
#### 1.1 获取所有工作空间
`kubectl get namespace  # namespace可简写为ns`
#### 1.2 创建命名空间
`kubectl create namespace <insert-namespace-name-here>`
#### 1.3 删除命名空间
`kubectl delete namespaces <insert-some-namespace-name>`
#### 1.4 查看当前工作空间
`kubectl config view | grep namespace`
#### 1.5 切换命名空间
`kubectl config set-context --current --namespace=<insert-namespace-name-here>`

### 2.node
#### 2.1 查看集群所有节点的状态
`kubectl get nodes`
#### 2.2 查看指定节点详细信息
`kubectl describe node <节点名称>`
#### 2.3 给node加标签
`kubectl label nodes {节点名称} disktype={标签名}`

### 3.pod
#### 3.1 获取pods
```bash
kubectl get pods
kubectl get pods -A
```
### 3.2 获取指定工作空间的所有
`kubectl get pods -n <namespace>`
### 3.3 重启pod
```bash
kubectl replace --force -f {yaml文件}
kubectl get pod {podname} -n {namespace} -o yaml | kubectl replace --force -f -
```
### 3.4 删除pod
`kubectl delete pod {podname}`

### 4.secret
#### 4.1 获取secrets
```bash
kubectl get secrets        
kubectl get secrets -A
```
#### 4.2 创建secrets（以docker仓库为例）

基于用户名密码创建
```bash
kubectl create secret docker-registry <key name> --docker-server=<cluster_CA_domain>:8500 --docker-username=<user_name> --docker-password=<user_password> --docker-email=<user_email>
```
基于docker配置文件创建
```bash
kubectl create secret generic harborsecret --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson
```
#### 4.3 查看secret信息
`kubectl get secret {secret name} -o yaml`

### 5.configmap
#### 5.1 获取configmap
`kubectl get cm -A`
#### 5.2 获取指定configmap的详情
`kubectl get cm <configmap> -o yaml`
#### 5.3 创建configmap
`kubectl create cm {configmap name} --from-file=/path/file -n {namespace}`
#### 5.4 删除configmap
`kubectl delete cm {configmap name} -n {namespace}`

### 6.describe
输出指定的一个/多个资源的详细信息
```bash
kubectl describe pod {podname}       # 描述指定pod
kubectl desctibe pods                # 描述所有pod
```

### 7.api
获取所有可用API版本
`kubectl api-versions`
获取api权限列表
`kubectl api-resources`

### 8.cert
检查证书是否过期
`kubeadm certs check-expiration`
