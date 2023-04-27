Postgres
=

#### 0.连接
`psql -h <host> -U <username> -p <port> -d <dbname>`

### 1.增
#### 
```sql
# 创建用户
REATE USER admin WITH PASSWORD 'Admin123!';
# 赋予库权限
GRANT ALL PRIVILEGES ON DATABASE xxx TO admin;
# 赋予表权限
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;

# 新增索引
CREATE INDEX idx_name ON tb_name(field_name);
```

### 2.删

### 3.改

### 4.查
##### 4.1 查询指定表的所有索引
```sql
select * from pg_indexes where tablename='{tbname}';
select * from pg_statio_all_indexes where relname='{tbname}';
```
