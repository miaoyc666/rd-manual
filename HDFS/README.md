
### Hadoop命令

#### 1、查看指定目录下内容
```bash
hadoop dfs –ls [文件目录]
# eg: hadoop dfs –ls /user/miaoyc.pt
```

#### 2、打开某个已存在文件
```bash
hadoop dfs –cat [file_path]
# eg:hadoop dfs -cat /user/wangkai.pt/data.txt
```

#### 3、将本地文件存储至hadoop
```bash
hadoop fs –put [本地地址] [hadoop目录]
hadoop fs –put /home/t/file.txt  /user/t   
(file.txt是文件名)
```

#### 4、将本地文件夹存储至hadoop
```bash
hadoop fs –put [本地目录] [hadoop目录] 
hadoop fs –put /home/t/dir_name /user/t
(dir_name是文件夹名)
```

#### 5、将hadoop上某个文件down至本地已有目录下
```bash
hadoop fs -get [文件目录] [本地目录]
hadoop fs –get /user/t/ok.txt /home/t
```
