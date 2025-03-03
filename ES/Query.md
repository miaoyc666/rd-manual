Query
=


#### 常见查询方法
| 查询类型             | 描述                                | 示例                                                                               | 常用场景       |
|------------------|-----------------------------------|----------------------------------------------------------------------------------|------------|
| **bool**         | 组合查询（must/should/must_not/filter） | `{"bool": {"must": [match_clause], "filter": [range_clause]}}`                   | 复杂逻辑条件组合   |
| **exists**       | 字段存在性检查                           | `{"exists": {"field": "timestamp"}}`                                             | 数据完整性校验    |
| **fuzzy**        | 模糊匹配（允许拼写错误）                      | `{"fuzzy": {"text": {"value": "elastik", "fuzziness": "AUTO"}}}`                 | 容错搜索       |
| **geo_distance** | 地理距离查询                            | `{"geo_distance": {"distance": "10km","location": {"lat":31,"lon":121}}}`        | 地理位置搜索     |
| **match**        | 全文检索，自动分词                         | `{"match": {"title": "elastic search"}}`                                         | 模糊匹配、关键词搜索 |
| **match_phrase** | 精确短语匹配                            | `{"match_phrase": {"message": "quick brown fox"}}`                               | 完整句子匹配     |
| **nested**       | 嵌套对象查询                            | `{"nested": {"path": "comments","query": {"match": {"comments.text": "good"}}}}` | 嵌套文档检索     |
| **prefix**       | 前缀匹配                              | `{"prefix": {"user.id": "dev"}}`                                                 | 分级编码查询     |
| **query_string** | 支持完整查询语法的搜索                       | `{"query_string": {"query": "(error AND server) OR timeout"}}`                   | 高级搜索界面     |
| **range**        | 范围查询                              | `{"range": {"price": {"gte": 100}}}`                                             | 数值/日期范围筛选  |
| **regexp**       | 正则表达式匹配                           | `{"regexp": {"error.code": "[0-9]{3}"}}`                                         | 复杂模式匹配     |
| **term**         | 精确值匹配（不分词）                        | `{"term": {"status": "active"}}`                                                 | 状态码、枚举值查询  |
| **terms**        | 多值精确匹配                            | `{"terms": {"tags": ["python", "java"]}}`                                        | 标签过滤、多选条件  |
| **wildcard**     | 通配符匹配（*,?）                        | `{"wildcard": {"host.name": "web-*-prod"}}`                                      | 日志模式匹配     |

### 官方文档
[Elasticsearch Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)

### 使用提示
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
