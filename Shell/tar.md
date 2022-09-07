### aes加解密
#### aes加密命令：
```bash
# -salt 是随机数加盐，-k表示加密密钥
openssl aes-128-cbc -salt -k 123123 -in blog.tar.gz -out blog.tar.gz.aes
```

#### aes解密：
```bash
openssl aes-128-cbc -d -in blog.tar.gz.aes -out blog.tar.gz -k 123123
```

### gzip解压缩
#### 文件
```bash
gzip {$filename}                        # 删除源文件压缩
gzip -c {$filename} > {$filename}.gz    # 不删除源文件压缩    
gzip -d {$filename}                     # 解压缩
```

#### 文件夹
```bash
tar -zcf miaoyc.tar.gz miaoyc               # 压缩
tar -zcf miaoyc.tar.gz -C /folder/miaoyc .  # 不带目录压缩
tar -zxf miaoyc.tar.gz -C miaoyc            # 解压缩指定的目录要保证已存在，例中miaoyc目录要存在
```

### zip解压缩
#### 目录
```bash
zip -r target.zip target    # 压缩 
unzip target.zip            # 解压缩
```
