Postgres
=

#### 准备工作
[安装](./Install.md)


#### 0.连接
```bash
psql -h <host> -U <username> -p <port> -d <dbname>
或
psql postgresql://<username>:<passwd>@<host>:<port>
```

### 1.增
#### 
```sql
# 创建用户
REATE USER admin WITH PASSWORD 'Admin123!';
# 赋予库权限
GRANT ALL PRIVILEGES ON DATABASE xxx TO admin;
# 赋予表权限
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
# 新建表
CREATE TABLE test_table (
    id serial PRIMARY KEY,
    name varchar(255),
    age integer
);
# 新增索引
CREATE INDEX idx_name ON test_table(field_name);
```

### 2.删
```sql
# 删除活动连接，先通过pg_stat_activity表查询活动连接获取pid，再根据pid进行删除
SELECT pg_terminate_backend(<pid>);
```
### 3.改
#### 重命名
```sql
ALTER TABLE test_table RENAME TO new_test_table;
```

### 4.查
##### 查询指定表的所有索引
```sql
SELECT * FROM pg_indexes where tablename='{tbname}';
SELECT * FROM pg_statio_all_indexes where relname='{tbname}';
SELECT
    i.relname AS index_name,
    a.attname AS column_name,
    am.amname AS index_type
FROM
    pg_index idx
JOIN
    pg_class t ON t.oid = idx.indrelid
JOIN
    pg_class i ON i.oid = idx.indexrelid
JOIN
    pg_attribute a ON a.attnum = ANY(idx.indkey) AND a.attrelid = t.oid
JOIN
    pg_am am ON i.relam = am.oid
WHERE
    t.relname = 'test_table';
```
##### 查询数据库活动连接数
```sql
SELECT count(*) FROM pg_stat_activity;
SELECT pid, usename, query FROM pg_stat_activity;
```
