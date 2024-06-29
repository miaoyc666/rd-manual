
# Python

### 环境配置
[虚拟环境和包依赖等](env.md)

### 性能分析
[profiler.md](profiler.md)

### gdb运行进程调试
[pygdb.md](pygdb.md)

### 单元测试
```bash
python -m unittest test_xxx.py TestClass
```

##### 文件服务器便捷搭建
```bash
python -m pyftpdlib -d .
```

##### 编译加密
```bash
# 依赖： apt install python3-dev or yum install python3-devel.x86_64
```
[nuitka](https://github.com/Nuitka/Nuitka)

##### 批量重命名
```python
#!/usr/bin/env python
import os
path = "."
fileList = os.listdir(path)
for i in fileList:
    if ".ts" != os.path.splitext(i)[-1]:
        continue
    oldname = path + os.sep + i
    newname = ".".join(oldname.split(".")[2:])
    os.rename(oldname, newname)
```

##### pip安装
```bash
# py2
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
sudo python get-pip.py
# py3
# 依赖：apt install python3-distutils
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py 
```

##### hash和编解码
[base64](https://github.com/miaoyc666/pyArsenal/blob/master/encoding/base64.py)
[md5](https://github.com/miaoyc666/pyArsenal/blob/master/hash/md5.py)
[sha256](https://github.com/miaoyc666/pyArsenal/blob/master/hash/sha256.py)

##### QA
###### 1
- Q: ModuleNotFoundError: No module named '_ctypes'
- A: sudo yum install libffi-devel -y

###### 2
- Q: 致命错误：Python.h：没有那个文件或目录
- A: sudo yum install python3-devel

###### 3
- Q: psycopg2安装失败, centos
- A: yum install postgresql-devel*

- Q: psycopg2安装失败, mac
- A: pip3 install psycopg2-binary
