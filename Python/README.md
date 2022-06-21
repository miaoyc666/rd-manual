# Python

##### 创建虚拟环境
```bash
python3 -m venv ${path}
```

##### 生成requirements.txt
```bash
pip freeze > requirements.txt
```

##### 查找包依赖
```bash
pip show ${package_name}
```

##### 只下载包
```bash
pip download -d ${path} -r requirement.txt
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
