# Mysql
### ✅常用命令✅
#### 0.连接
```bash
mysql -h {host} -u {username} -P {port} -p -t {dbname}
```
#### 1.用户管理
#### 1.1 增
```sql
create user zhangsan identified by 'zhangsan';
create user misp identified by 'misp';
```
#### 1.2 授权
```sql
grant {privilegesCode 授权类型} on zhangsanDb.* to zhangsan@'%' identified by 'zhangsan'; flush privileges;
flush privileges;
```
```
privilegesCode授权类型枚举：
* all privileges：所有权限。
* select：读取权限。
* delete：删除权限。
* update：更新权限。
* create：创建权限。
* drop：删除数据库、数据表权限。
```
#### 1.3 改密
```sql
update mysql.user set password = password('zhangsannew') where user = 'zhangsan' and host = '%'; 
flush privileges;
```
#### 1.4 删
```sql
drop user zhangsan@'%';
```

### 2.curd
#### 2.1 增
#### 2.2 删
##### 2.2.1 删库
##### 2.2.2 删表

#### 2.3 改
##### 2.3.1 修改字段类型
```sql
alter table <table_name> modify <field_name> <field_type>;
```

##### 2.3.2 修改主键id为自增
```sql
alter table <table_name> modify id int auto_increment;
```

##### 2.3.3 修改自增字段起点
```sql
alter table <table_name> AUTO_INCREMENT=10000;
```
#### 2.4 查


### 🔶不常用命令🔶
#### 1.Online DDL
##### 更改表名
```sql
alter table <table_name> rename to <new_table_name>
```

#### 2.备份与恢复表
##### 2.1 表备份成sql文件

```bash
mysqldump -h {host} -u {username} -P {port} -p {password} -t {dbname} --tables {tb1} {tb2} ... > dump.sql # 不指定--tables参数则导出所有表
```
##### 2.2 sql文件恢复成表
```bash
mysql -h {host} -u {username} -P {port} -p {password} -t {dbname}  < dump.sql
```
##### 2.3 高效的本地库内复制
```sql
1. 复制表结构及数据到新表：
create table <new table> as select * from <old table>
或：
create table <new table> like <old table>;
insert into <new table> select * from <old table>;
2. 只复制表结构到新表（此时会默认使用innodb）
create table <new table> as select * from <old table> where 1 = 2 
```
#### 3.导入/导出csv
##### 3.1
```bash
mysqldump -h {host} -u {username} -P {port} -p {password} -t {dbname} --tables {tb1} {tb2} ... -T {$filepath}  mydb customers  --fields-terminated-by=',' --fields-enclosed-by='\"'
mysql -h 127.0.0.1 -u root -p XXXX -P 3306 -e "select * from table"  > /tmp/test/txt
```

### 🔶不常见的坑🔶
##### 1.唯一索引问题
联合唯一索引的字段中，当出现null值时，唯一性约束不会生效。


### 参考文档
* [官方文档](https://mongoing.com/docs/index.html)
* [菜鸟教程](https://www.runoob.com/mongodb/mongodb-tutorial.html)


