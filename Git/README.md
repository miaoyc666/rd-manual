# GIT

### ✅Basic Commands✅
```bash
# delete local branch
git branch -d localBranchName
```

### ✅Low Frequency Commands✅
##### delete branch
```bash
# delete remote branch
git push origin --delete remoteBranchName
```

##### proxy
```bash
git config --global http.proxy http://127.0.0.1:1080
git config --global https.proxy http://127.0.0.1:1080
git config --global --unset http.proxy
git config --global --unset https.proxy
```

##### tag
```bash
# 清除远程已经不存在的分支的跟踪分
git fetch -p
# create tag
git tag <tag_name>
# delete tag
git tag -d <tag_name>
# push tag to remote
git push --tags
git push --tag
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
2.git commit --amend
3.GIT_COMMITTER_DATE="2021-12-26T23:01:07" git commit --amend --date="2021-12-26T23:01:07"
4.git rebase --continue
5.git push --force        # 慎重使用
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
1. git clone --bare git@github.com:miaoyc666/rd-manual.git
2. 新建新的git库，空白库：git@github.com:miaoyc666/rd-manual_new.git
3. cd rd-manual.git
4. git push --mirror git@github.com:miaoyc666/rd-manual_new.git
```

##### 切换git库的两个方法
```bash
1. 重新git clone项目；
2. 修改.git/config文件，将git@github.com:miaoyc666/rd-manual.git替换为git@github.com:miaoyc666/rd-manual_new.git
```

### ❌尽量不要使用的命令❌
##### 强行推送tag到远端
`git push --force`

