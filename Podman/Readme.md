Podman
=


### 一、安装 Podman
[官方安装文档](https://podman.io/docs/installation)
#### 1.通过 Homebrew 安装 Podman
```bash
brew install podman
```
#### 2.初始化 Podman 虚拟机
因为 macOS 不是 Linux，Podman 需要运行在一个轻量级的虚拟机（podman machine）中。
```bash
podman machine init
podman machine start
```
#### 3.验证 Podman 是否可用
```bash
podman info
podman run hello-world
```

### 二、安装 Podman-compose
#### 1.通过 Homebrew 安装 Podman-compose
```bash
brew install podman-compose
```

#### 2.用法基本同 docker-compose，略
