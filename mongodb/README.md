# Mongodb
#### 连接
```bash
# mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]
mongodb://{username}:{password}@{host}:{port}
```

#### 1.增
##### 常用新增（库，表，数据）
```bash
use {$dbname}   # 切换数据库后会自动创建数据库
db.createCollection({$collectionName})
db.{$collectionName}.insert({$jsondata})   # jsondata示例 {"name":"test"}  
```

##### 新增索引
```bash
db.{$collectionName}.createIndex({"{$fieldName}":1})
```


#### 2.删
##### 常规删
```bash
db.dropDatabase()       # 在数据库内部（先切换到要删除的db）
db.{$collectionName}.drop()     # 删除集合
db.{$collectionName}.remove({$con})     # con为查询条件，格式是json，默认查询条件为空{}
```

#### 3.改
##### 常规
```bash
db.{$collectionName}.update(
   <query>,
   <update>,
   {
     upsert: <boolean>,
     multi: <boolean>,
     writeConcern: <document>
   }
)
```
##### 局部更新
```bash
# 局部更新需要添加 $set 
db.{$collectionName}.update({'title': 'MongoDB 教程'}, {$set:{'title':'MongoDB'}})
```



#### 4.查
##### 常用查询
```bash
db.{$collectionName}.find({$con})   # con为查询条件，格式是json，默认查询条件为空{}
db.{$collectionName}.find().pretty()
```

##### 查询索引
```bash

```

##### 聚合查询
```bash
# db.COLLECTION_NAME.aggregate(AGGREGATE_OPERATION)
db.{$collectionName}.aggregate([
{ $group: {_id:"$category", count: { $op: $field}}}
]);
# category为实际分组字段名，op为实际表达式, field为实际统计的字段
# 聚合查询支持的表达式见下表
```

###### 支持表达式
| 表达式 | 描述 | 
| --- | --- | 
| $sum | 计算总和 | 
| $avg | 计算平均值 |
| $min | 获取集合中所有文档对应值得最小值 |
| $max | 获取集合中所有文档对应值得最大值 |

#### 5.运维
##### 5.1 导入
```bash
mongoimport --host 10.48.25.9 --port 27017 -u tip -p QAxTipMongo99# -c ioc --type json --file ioc20190904.json
```
##### 5.2 导出
```bash
pass
```

#### 5.



#### 参考文档：
* [官方文档](https://mongoing.com/docs/index.html)
* [菜鸟教程](https://www.runoob.com/mongodb/mongodb-tutorial.html)
