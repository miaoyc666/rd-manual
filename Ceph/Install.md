Install
=

### QA
#### 1.单机版本和集群版本有什么区别？
osd数量，单机版osd数量为1，集群版osd数量>=3.

### 安装
```bash 
curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm
chmod +x cephadm
```

### 清理节点
```bash 
# 清理ceph集群节点
# https://www.cnblogs.com/varden/p/15966516.htm
ceph orch pause
ceph fsid
cephadm rm-cluster --force --zap-osds --fsid <fsid>
```

### 参考文档
- [cephadm](https://docs.ceph.com/en/quincy/cephadm/#cephadm)
- [one-node-cluster](https://docs.ceph.com/en/quincy/rados/troubleshooting/troubleshooting-pg/#one-node-cluster)
