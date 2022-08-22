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
#### 压缩文件夹
```bash
tar -zcf blog.tar.gz blog
```

#### 解压文件夹
```bash
# 解压缩指定的目录要保证已存在，例中miaoyc目录要存在
tar -zxvf blog.tar.gz -C miaoyc
```

### zip解压缩
#### 压缩目录
```bash
zip -r target.zip target
```

#### 解压缩
```bash
unzip target.zip
```
