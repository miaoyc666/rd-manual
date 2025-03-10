Sec
=

### 安全相关
#### 清除登录记录

| 命令      | 日志文件路径           | 功能             |
|---------|------------------|----------------|
| last    | /var/log/wtmp    | 所有成功登录/登出的历史记录 |
| lastb   | /var/log/btmp    | 登录失败记录         |
| lastlog | /var/log/lastlog | 最近登录记录         |

```bash
# 注意：直接删除文件可能导致系统异常，建议使用重定向清空
# 清空wtmp记录（需root权限）
sudo echo > /var/log/wtmp

# 清空btmp记录
sudo echo > /var/log/btmp
```
