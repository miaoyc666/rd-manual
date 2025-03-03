Query
=


#### 常见查询方法
| 查询类型             | 描述                                | 示例                                                                               | 常用场景       |
|------------------|-----------------------------------|----------------------------------------------------------------------------------|------------|
| **match**        | 全文检索，自动分词                         | `{"match": {"title": "elastic search"}}`                                         | 模糊匹配、关键词搜索 |
| **term**         | 精确值匹配（不分词）                        | `{"term": {"status": "active"}}`                                                 | 状态码、枚举值查询  |
| **range**        | 范围查询                              | `{"range": {"price": {"gte": 100}}}`                                             | 数值/日期范围筛选  |
| **exists**       | 字段存在性检查                           | `{"exists": {"field": "timestamp"}}`                                             | 数据完整性校验    |
| **bool**         | 组合查询（must/should/must_not/filter） | `{"bool": {"must": [match_clause], "filter": [range_clause]}}`                   | 复杂逻辑条件组合   |
| **wildcard**     | 通配符匹配（*,?）                        | `{"wildcard": {"host.name": "web-*-prod"}}`                                      | 日志模式匹配     |
| **prefix**       | 前缀匹配                              | `{"prefix": {"user.id": "dev"}}`                                                 | 分级编码查询     |
| **regexp**       | 正则表达式匹配                           | `{"regexp": {"error.code": "[0-9]{3}"}}`                                         | 复杂模式匹配     |
| **geo_distance** | 地理距离查询                            | `{"geo_distance": {"distance": "10km","location": {"lat":31,"lon":121}}}`        | 地理位置搜索     |
| **nested**       | 嵌套对象查询                            | `{"nested": {"path": "comments","query": {"match": {"comments.text": "good"}}}}` | 嵌套文档检索     |

#### 使用提示
```json
{
  "优化建议": [
    "过滤条件优先使用 filter 上下文",
    "避免在大型文本字段使用 wildcard 查询",
    "数值范围查询使用 keyword 类型更高效"
  ]
}
```

#### 分词器
#### 分词模式
ik_max_word

#### 参考文档
- [ES Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)
- [Elasticsearch SQL官方文档](https://www.elastic.co/cn/elasticsearch/sql)
