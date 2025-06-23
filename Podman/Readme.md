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
启动后提示
```bash
╰─$ podman machine start
Starting machine "podman-machine-default"

This machine is currently configured in rootless mode. If your containers
require root permissions (e.g. ports < 1024), or if you run into compatibility
issues with non-podman clients, you can switch using the following command:

	podman machine set --rootful

API forwarding listening on: /var/folders/55/v3zxny410pgcndl8qr0vch1r0000gn/T/podman/podman-machine-default-api.sock

The system helper service is not installed; the default Docker API socket
address can't be used by podman. If you would like to install it, run the following commands:

        sudo /opt/homebrew/Cellar/podman/5.5.1/bin/podman-mac-helper install
        podman machine stop; podman machine start

You can still connect Docker API clients by setting DOCKER_HOST using the
following command in your terminal session:

        export DOCKER_HOST='unix:///var/folders/55/v3zxny410pgcndl8qr0vch1r0000gn/T/podman/podman-machine-default-api.sock'

Machine "podman-machine-default" started successfully
```
#### 3.验证 Podman 是否可用
```bash
podman info
```

### 二、安装 Podman-compose
#### 1.通过 Homebrew 安装 Podman-compose
```bash
brew install podman-compose
```

#### 2.用法基本同 docker-compose，略
