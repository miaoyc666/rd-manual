upx
=

#### 这是什么
upx用于应用程序压缩，压缩比大于50%

#### 安装
[交付物](https://github.com/upx/upx/releases)

#### 一些容易忽视的问题
- upx不支持freebsd
- 使用pie安全编译的程序，无法通过upx再次压缩

#### 使用
```bash
upx [options] yourfile

# -9参数表示最佳压缩
upx -9 yourfile

# 其他参数
# --best：最高压缩级别
# --brute：尝试使用各种压缩方式来获取最高压缩比
# --ultra-brute：尝试使用更多的参数来获取更高的压缩比
