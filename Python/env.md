环境配置
=

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