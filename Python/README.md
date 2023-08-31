
# Python

##### 创建虚拟环境
```bash
python3 -m venv ${path}
```

##### 生成当前环境的requirements.txt
```bash
pip freeze > requirements.txt
```

##### 生成当前项目的requirements.txt
```bash
pip install pipreqs
pipreqs .
```

##### 查找包依赖
```bash
pip show ${package_name}
```

##### 只下载包和依赖
```bash
pip download -d ${path} -r requirement.txt
```

##### 文件服务器便捷搭建
```bash
python -m pyftpdlib -d .
```

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

##### 计算md5和base64
```python3
def md5(s):
    return hashlib.md5(s.encode('utf-8')).hexdigest()

def base64_encode(s):
    return base64.b64encode(s.encode('utf-8'))

def base64_decode(s):
    return base64.b64decode(s).decode('utf-8')
    
def md5_base64_byte(string):
    m = hashlib.md5()
    m.update(string.encode('utf-8'))
    # 二进制数据字符串值
    md5_str = m.digest()
    b64_str = base64.b64encode(md5_str)
    return md5_str, b64_str.decode('utf-8')

def md5_base64_hex(string):
    m = hashlib.md5()
    m.update(string.encode('utf-8'))
    # 十六进制数据字符串值
    md5_str = m.hexdigest()
    b64_str = base64.b64encode(md5_str.encode('utf-8'))
    return md5_str, b64_str.decode('utf-8')
```

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
