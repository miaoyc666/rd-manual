# gdb调试

### 依赖
sudo apt-get install libc6-dbg

### 常规调试
```bash
gdb -p <pid>
# 此时可以使用gdb命令查看进程状态
```

### py gdb调试
需要先安装libpython
```bash
# libpython.py 源码
# 关键点，要根据python版本选择指定分支的libpython
https://github.com/python/cpython/blob/main/Tools/gdb/libpython.py
# python3.10
https://github.com/python/cpython/blob/3.10/Tools/gdb/libpython.py
# python3.12
https://github.com/python/cpython/blob/v3.12.3/Tools/gdb/libpython.py
```

#### 使用步骤
```bash
gdb -p <pid>
souce <libpython.py源码路径>

# 此时可以使用命令查看进程状态
bt       # 当前C调用栈
py-bt    # 当前Py调用栈
py-list  # 当前py代码位置
info thread   # 线程信息
thread <id>   # 切换到某个线程
thread apply all py-list  # 查看所有线程的py代码位置
ctrl-c        # 中断
```
