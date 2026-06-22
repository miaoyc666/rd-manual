# SSH 双因素认证 (公钥 + OTP) 完整配置指南

本手册用于指导在 Debian 11 (OpenSSH 8.4p1) 环境下，配置基于“SSH 私钥 + Google Authenticator OTP”的双重认证体系，强制提升服务器安全性。

原则上本手册适配所有操作系统，目前已经过测试验证的系统
* Debian 11
* Ubuntu 24.04 / 26.04
* CentOS 8
---

## 1. 环境准备与安装
首先更新系统源并安装 Google Authenticator PAM 模块：

```bash
sudo apt update && sudo apt install libpam-google-authenticator -y
```

---

## 2. 生成 OTP 密钥 (针对当前登录用户)

执行以下命令开始配置。**建议在普通用户下运行**，不要直接在 root 下运行（除非你确实需要开启 root 的 OTP）。

```bash
google-authenticator
```

**交互式选项建议（按顺序输入）：**

1.  **Make tokens time-based (y/n):** `y` (启用 TOTP)
2.  **保存二维码：** 此时屏幕会出现巨大的二维码，请用手机 App（Google Authenticator / Microsoft Authenticator / 2FAS）扫码。
3.  **保存备份：** 务必将屏幕下方的 `emergency scratch codes` (5个) 记录在安全的地方，这是手机丢失时唯一的救命稻草。
4.  **Update your .google_authenticator file (y/n):** `y` (存入配置)
5.  **Disallow multiple uses of the same token (y/n):** `y` (防重放攻击)
6.  **Permit a window of up to 4 minutes (y/n):** `n` (保持 30 秒默认窗口，安全性更高)
7.  **Enable rate-limiting (y/n):** `y` (防暴力破解，30秒内最多3次尝试)

**权限检查：**
```bash
chmod 0400 ~/.google_authenticator
```

---

## 3. 修改 PAM 认证配置

PAM 负责决定登录时调用哪些模块。我们需要告诉它：如果公钥验证过了，就不要再问系统密码，直接问 OTP。

编辑文件：
```bash
sudo vim /etc/pam.d/sshd
```

**修改内容：**
找到 `@include common-auth` 这一行，**在其前面加 `#` 注释掉**。然后在文件适当位置添加 Google Authenticator 模块：

```text
# 注释掉标准密码验证（实现公钥登录后无需输入系统密码）
#@include common-auth

# 调用 Google Authenticator 模块
# 如果想让没配置 OTP 的用户也能登录，末尾可以加 nullok
auth required pam_google_authenticator.so
```

---

## 4. 修改 SSH 服务配置

编辑 SSH 主配置文件。在 Debian 11 中，即使默认模板里没有某些参数，你也可以手动添加。

编辑文件：
```bash
sudo vim /etc/ssh/sshd_config
```

**确保或手动添加以下参数：**

```text
# 1. 基础认证开关
# KbdInteractiveAuthentication和ChallengeResponseAuthentication存在一个配置即可
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication yes
ChallengeResponseAuthentication yes
UsePAM yes

# 2. 强制双重认证逻辑 (核心步骤)
# 只有同时满足 publickey (私钥) 和 keyboard-interactive (即 OTP) 才能登录
AuthenticationMethods publickey,keyboard-interactive
```

---

## 5. 服务重启与安全验证

**注意：在验证成功前，千万不要关闭当前的 SSH 连接窗口！**

1.  **检查语法：**
    ```bash
    sudo sshd -t
    ```
2.  **重启服务：**
    ```bash
    sudo systemctl restart ssh
    ```
3.  **测试登录：**
    打开一个新的终端，尝试登录：`ssh username@server_ip`
    * **预期流程：** 自动通过私钥验证 -> 弹出 `Verification code:` 提示 -> 输入手机上的 6 位数字 -> 成功登录。

---

## 6. 常见问题与排错 (Troubleshooting)

### Q1: 提示 Permission denied (keyboard-interactive)
* **原因 1：时间不同步。** OTP 对时间要求极高。运行 `date` 检查服务器时间，如有偏差，请安装 `chrony` 强制对时。
* **原因 2：文件权限。** 确保 `~/.google_authenticator` 属于当前用户且权限为 `0400`。
* **原因 3：SELinux/AppArmor。** 虽然 Debian 默认策略较松，但如果开启了强制模式，请检查相关审计日志。

### Q2: 依然提示输入 Password 而不是 Verification code
* 检查 `/etc/pam.d/sshd` 是否真的注释掉了 `@include common-auth`。
* 确保 `sshd_config` 中的 `AuthenticationMethods` 拼写正确且没有被后面的重复配置覆盖。

### Q3: 手机丢了怎么办？
* 使用生成密钥时保存的 5 个 `emergency scratch codes`。每个码只能使用一次，直接在 `Verification code:` 处输入即可进入系统。
* 进入系统后，删除 `~/.google_authenticator` 并重新运行 `google-authenticator` 生成新密钥。

---
*文档编写日期：2026-03-30*
