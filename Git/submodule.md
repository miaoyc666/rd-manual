Git子模块
=

### 添加
```bash
1. git submodule add https://github.com/miaoyc-test.git
2. git add .
3. git commit -m "Added submodule"
```

### 更新
```bash
1. git submodule init
2. git submodule update
```

### 删除
```bash 
# 前提条件，存在git子模块miaoyc-test
1. git rm --cached miaoyc-test
2. 编辑.gitmodules文件并删除相关子模块的配置部分
3. 编辑.git/config文件并删除相关子模块的配置部分
4. rm -rf .git/modules/miaoyc-test
5. rm -rf miaoyc-test
6. git add .
7. git commit -m "Remove submodule"
```
