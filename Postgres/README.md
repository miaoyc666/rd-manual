Postgres
=

#### 0.连接
`psql -h <host> -U <username> -p <port> -d <dbname>`

### 1.增

### 2.删

### 3.改

### 4.查
##### 4.1 查询指定表的所有索引
```sql
select * from pg_indexes where tablename='{tbname}';
select * from pg_statio_all_indexes where relname='{tbname}';
```
