Node
=

### Install
#### 1.使用git下载nvm
```bash 
# 用git从github下载nvm源码。
git clone https://github.com/cnpm/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`

# 若您的服务器无法访问github，可使用国内的gitee下载nvm源码：
git clone https://gitee.com/koalakit/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
```

#### 2.使用nvm安装Nodejs
```bash
echo "source ~/.nvm/nvm.sh" >> ~/.bashrc

source ~/.bashrc

# 安装 nodejs
nvm install v16.14.0

# (可选步骤) npm切换国内淘宝网镜像，便于加速安装。
npm config set registry http://registry.npm.taobao.org

# npm安装 yarn 
npm install -g yarn

# 用 nvm list-remote 命令可查看所有可安装的nodejs版本
# 用 nvm ls可查看所有已安装到本地的nodejs 版本
```

#### 3.使用yarn
```bash
yarn
yarn build
yarn start 
```