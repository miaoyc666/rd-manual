# GIT

### 安装Git v2.x====
[升级git方法](Install.md)

### Git子模块指南
[新增、更新和删除](submodule.md)

### ✅基础命令✅
太基础的就不写了，没必要。
```bash
# delete local branch, -d是删除， -D是强制删除
git branch -D localBranchName
```

### ✅低频命令✅
##### checkout所有分支到本地
```bash
for branch in `git branch -r | grep -v '\->'`; do
    git branch --track "${branch#origin/}" "$branch"
done
```

##### 推送所有分支和tag到远端
```bash
git push --all && git push --tags
```

##### delete branch
```bash
# delete remote branch or tag
git push origin --delete <remoteBranchName or tagName>
```

##### tag
```bash
# 查看tag
git tag

# 查看远端所有tag
git ls-remote --tags origin

# 先拉取远程 tag 再查看
git fetch --tags
git tag -l

# 清除远程已经不存在的分支的跟踪分
git fetch -p

# create tag
git tag <tag_name>

# delete tag
git tag -d <tag_name>

# push tag to remote
git push --tags
git push --tag

# delete
git push --delete origin <tagname>
```

##### color ui output
`git config color.ui true`

### 🔶Git lfs🔶
##### Install
```bash
# git lfs need git version >= 1.8.2
yum install git-lfs -y
git lfs install
```

### 🔶Git Submodule🔶
##### 
```bash
git submodule add git@github.com:miaoyc666/pyArsenal.git
git submodule init
git submodule update
```

##### 使用步骤
1. `git lfs install`开启lfs功能
2. 大文件cp到git库
3. `git lfs track`进行大文件追踪, 例如：`git lfs track abc/aaa.tgz`
此时`cat .gitattributes`，会看到：`abc/aaa.tgz filter=lfs diff=lfs merge=lfs -text`
4. `git add .gitattributes`
5. `commit`
6. `git lfs ls-files`可以显示当前跟踪的文件列表


### 🔶不常用命令🔶

##### 设置本地分支对应的远程分支的方法
`git push -u origin {branch name}`

##### 修改远端项目地址
```bash
git remote rm origin
git remote add origin <new project>
```

##### 回滚到指定版本
```bash
git reset --hard {commit_id}
git push --force    # 慎重使用
```

##### 合并以对方分支为准
```bash
git merge -X theirs origin/xxxxx-branch
```

##### 修改提交记录:
```bash
git rebase -i HEAD~3        # 3此处为可变，数值表示需要修改的最近几条提交的数量
git commit --amend 
git rebase --continue
三条语句组合使用

# 举例如下：修改最后一条提交记录的时间
1.git rebase -i HEAD~1, 输入完命令后在弹出框内选择commit, 修改commit前的标识为edit
2.git commit --amend --date="2021-12-26T23:01:07"
3.git rebase --continue
4.git push --force        # 慎重使用
```

##### 修改提交用户名和邮箱
```bash
git filter-branch --env-filter '
OLD_EMAIL="miaoyongchao@xx.com" 
CORRECT_NAME="miaoyc"
CORRECT_EMAIL="miaoyongchao@xx.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_COMMITTER_NAME="$CORRECT_NAME"
export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_AUTHOR_NAME="$CORRECT_NAME"
export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' -f --tag-name-filter cat -- --branches --tags
```

##### 拷贝git项目到新库步骤
```bash
# 镜像仓库的方式 
1. git clone --bare git@github.com:miaoyc666/rd-manual.git
2. 新建git库: git@github.com:miaoyc666/rd-manual_new.git
3. cd rd-manual.git
4. git push --mirror git@github.com:miaoyc666/rd-manual_new.git

# 修改远程仓库的方式
1. 新建git库: git@github.com:miaoyc666/rd-manual_new.git
2. 在旧仓库新增远程仓库：git remote add home git@github.com:miaoyc666/rd-manual_new.git
3. git push home 
```

##### 向已存在的非空仓库A推动仓库B的代码
```bash
git clone https://example.com/repo-B.git
cd repo-B
git remote add repo-A https://example.com/repo-A.git
git push repo-A main --force        # 此处main表示想要推送的仓库B的分支名称，如果仓库A存在main分支，会覆盖提交
```

##### 外部代码迁移到内部仓库
```bash
git clone git@github.com:test/test.git
cd dify

git remote add origin ssh://git@[域名]/test/test.git
// company为自定义名称,无限制
// ssh://git@[域名]/test/test.git为提前建好的空项目
// 执行add后，执行git remote可以看到origin和company两个远端分支

git push company main            // 推送main分支到company远端
git push company 1.5.1           // 推送标签1.5.1到company远端, 根据实际修改

// code fork sync
// ssh://git@[域名]/test/test_fork.git
cd [项目名]        // [项目名]替换为真实的路径
git remote add dify ssh://git@[域名]/test/test.git
git fetch dify tag 1.5.1
git push --tag
```

##### 切换git库的两个方法
```bash
1. 重新git clone项目;
2. 修改.git/config文件, 将git@github.com:miaoyc666/rd-manual.git替换为git@github.com:miaoyc666/rd-manual_new.git
```

### ❌尽量不要使用的命令❌
##### 强行推送tag到远端
`git push --force`
