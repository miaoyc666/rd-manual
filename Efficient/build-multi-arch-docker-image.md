构建多架构支持的Docker镜像
=

#### 前置条件
首先在Linux x86_64构建miaoyc/x86镜像，并在Linux arm64中构建miaoyc/arm64镜像，构建好之后推送到Docker仓库

#### 打包方法 
```bash 
# create manifest
docker manifest create miaoyc/test miaoyc/x86 miaoyc/arm64
#  miaoyc/test 为混合架构镜像
docker manifest push miaoyc/test
```

#### 参考文档
- [构建多种系统架构支持的 Docker 镜像](https://yeasy.gitbook.io/docker_practice/image/manifest)
- [manifest-v2-2](https://docs.docker.com/registry/spec/manifest-v2-2)

