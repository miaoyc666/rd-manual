# K8s QA

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
