### aes加解密
#### aes加密命令：
Aes加密支持多种密钥长度的加密，包括128位、192位和256位，具体使用哪一种取决于密钥长度。
```bash
# -salt 是随机数加盐，-k表示加密密钥
openssl aes-128-cbc -salt -k 123123 -in blog.tar.gz -out blog.tar.gz.aes
```

#### aes解密：
```bash
openssl aes-128-cbc -d -in blog.tar.gz.aes -out blog.tar.gz -k 123123
```

### gzip压缩和解压缩
#### 文件
```bash
gzip {$filename}                        # 删除源文件压缩
gzip -c {$filename} > {$filename}.gz    # 不删除源文件压缩    
gzip -d {$filename}                     # 解压缩
```

#### 文件夹
```bash
# 参数说明：
# c：创建一个新的归档文件
# v：显示详细信息
# z：使用gzip压缩
# f：指定归档文件的名称
# x：提起文件
tar -zcvf miaoyc.tar.gz miaoyc               # 压缩, 可同时压缩多个文件和目录
tar -zcvf miaoyc.tar.gz -C /folder/miaoyc .  # 不带目录压缩
tar -zxvf miaoyc.tar.gz -C miaoyc            # 解压缩指定的目录要保证已存在，例中miaoyc目录要存在
```

### zip解压缩
#### 目录
```bash
zip -r target.zip target    # 压缩 
unzip target.zip            # 解压缩
```
