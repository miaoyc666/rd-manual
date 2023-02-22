Tmux
= 

##### 极简使用步骤
0. 安装`sudo yum install tmux`
1. 新建会话`tmux new -s my_session`
2. 在Tmux窗口运行所需的程序
3. 按下快捷键`ctrl+b d`将会话分离
4. 下次使用时，`tmux ls`查看当前有哪些会话
5. 重新连接到会话`tmux attach -t my_session`

##### 配和bash alias使用
```bash
alias tnew='tmux new'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias trename='tmux rename -t'
```
