环境配置
=

### uv
```bash
# uv大概可以一统江湖了

# 查看py版本
uv python list

# 虚拟环境（例子）
uv venv --python 3.13

# 安装pip
python -m ensurepip --upgrade
python -m pip install --upgrade pip
```




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

##### 查找所有包版本
```bash
pip install package==
```

##### 只下载包和依赖
```bash
pip download -d ${path} -r requirement.txt
```

##### 获取操作系统环境
```python
# 三种方式
import platform
import os
import sys

# 获取操作系统名称
os_name = platform.system()
# 获取操作系统的环境变量
os_env = os.environ
# 获取操作系统平台
os_platform = sys.platform
```
