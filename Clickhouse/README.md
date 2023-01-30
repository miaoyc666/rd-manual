Clickhosue
=

### 一、基本操作
##### 官网文档-SQL语句
[clickhosue sql](https://clickhouse.com/docs/zh/sql-reference/statements/)
##### 连接
`clickhouse-client -h {$host} -d {$db} -u {$user} --password {$pasword}`
##### 导入导出数据表
```bash
# 导出时可指定format， Native为内置的最快的格式， 官方手册：https://clickhouse.com/docs/zh/interfaces/formats
clickhouse-client --database=test --query "SELECT * from table" --format Native > result.txt
# 导入
cat result.txt | clickhouse-client --database=test --query="insert into table format Native"
```



### 二、分布式表

##### 创建分布式表
```sql
CREATE TABLE ti.miaoyc_alter_test (`time` DateTime, `ioc` String) ENGINE = ReplicatedMergeTree('/clickhouse/tables/miaoyc_alter_test/{shard}', '{replica}') PARTITION BY toYYYYMM(time) ORDER BY (time, ioc) SETTINGS index_granularity = 8192;

CREATE TABLE ti.miaoyc_alter_test_all (`time` DateTime, `ioc` String) ENGINE = Distributed(cluster_2shards_2replicas, ti, miaoyc_alter_test, rand());│
```

##### 分布式表加字段
```bash
# 分别在基础表和分布式表上新增字段即可
```

##### 分布式表更新数据
```bash
# 对于分布式表，要分别在每个节点删除基础表的数据
```

##### 物化视图创建立刻生成数据
```bash
# 要添加 POPULATE 关键字
```
[POPULATE官方资料](https://clickhouse.com/docs/zh/sql-reference/statements/create/view/)



### 三、问题排查
##### 查看后台任务执行，mutations
```sql
select database, table, command latest_fail_reason, is_done from system.mutations;
```

##### 查看总行数和压缩率
```sql
SELECt
sum(rows) AS `总行数`,
formatReadableSize(sum(data_uncompressed_bytes)) AS `原始大小`,
formatReadableSize(sum(data_compressed_bytes)) AS `压缩大小`,
round((sum(data_compressed_bytes) / sum(data_uncompressed_bytes)) * 100, 0) AS `压缩率`
FROM system.parts;
```

##### 查看测试表的分区信息
```sql
SELECT
    partition AS `分区`,
    sum(rows) AS `总行数`,
    formatReadableSize(sum(data_uncompressed_bytes)) AS `原始大小`,
    formatReadableSize(sum(data_compressed_bytes)) AS `压缩大小`,
    round((sum(data_compressed_bytes) / sum(data_uncompressed_bytes)) * 100, 0) AS `压缩率`
FROM system.parts
WHERE (database IN ('test')) AND (table IN ('test')) AND (partition LIKE '2022-12-%')
GROUP BY partition
ORDER BY partition ASC
```

### 四、组建集群
[集群设置](https://github.com/miaoyc666/clickhouse-setup)
