ubuntu控制台支持中文
=

###### 目的：使ubuntu server支持中文，正常显示中文名称

#### 1、安装中文支持包language-pack-zh-hans
```bash
sudo apt install language-pack-zh-hans
```

#### 2、修改/etc/environment, 在文件末追加以下内容
```bash
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh:en_US:en"
```

#### 3、修改/var/lib/locales/supported.d/local
```bash
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
zh_CN.GBK GBK
zh_CN GB2312
```

#### 4、执行命令
```bash
sudo locale-gen
```

#### 5、reboot
