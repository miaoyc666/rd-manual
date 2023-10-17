Pika
=

#### Doc
[最佳实践](https://mp.weixin.qq.com/s?__biz=Mzg5NDYxNTYyMw==&mid=2247487191&idx=1&sn=db1c3f0bfb2dfe4a4159ca43ae8c1913&source=41#wechat_redirect)

#### 备份数据
先停机，再打包数据目录（hashes、lists、sets、strings和zsets等），注意不能遗漏和删除任何log文件

#### 数据合并和清理
```bash
compact
```