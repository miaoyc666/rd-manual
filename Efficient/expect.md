一键登录跳板机
=

```bash
#!/usr/bin/expect -f

#该脚本用于自动交互式登录服务器
set timeout 5
set password xxx

spawn ssh -t xxx@jumper.xxx.com
expect "*password:*" { send "$password\n" }
interact
```
