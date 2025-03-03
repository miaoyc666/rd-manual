Query
=


### 常见查询方法
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


#### 查询时间复杂度
| 查询类型             | 时间复杂度         | 适用场景          | 缓存支持 | 典型响应时间（百万数据） |
|------------------|---------------|---------------|------|--------------|
| **bool**         | O(M) (M=子查询数) | 组合多个查询条件      | 部分   | 10-100ms     |
| **exists**       | O(1)          | 检测字段是否存在      | ✅    | 1-5ms        |
| **fuzzy**        | O(N)          | 容错搜索（拼写纠错）    | ❌    | 50-200ms     |
| **geo_distance** | O(N·logN)     | 地理围栏搜索        | ✅    | 20-100ms     |
| **match**        | O(logN)       | 全文检索（自动分词）    | ❌    | 5-30ms       |
| **match_phrase** | O(N)          | 精确短语匹配        | ❌    | 20-100ms     |
| **nested**       | O(N²)         | 嵌套文档查询        | ❌    | 100-500ms    |
| **prefix**       | O(logN)       | 前缀匹配（如编码查询）   | ✅    | 5-20ms       |
| **query_string** | O(N·logN)     | 复杂语法搜索（专家模式）  | ❌    | 50-300ms     |
| **range**        | O(logN)       | 数值/日期范围筛选     | ✅    | 5-20ms       |
| **regexp**       | O(N)          | 复杂模式匹配（需慎用）   | ❌    | 100-500ms    |
| **term**         | O(1)          | 精确值匹配（状态码/枚举） | ✅    | 1-10ms       |
| **terms**        | O(K) (K=词项数)  | 多值精确匹配（标签过滤）  | ✅    | 5-30ms       |
| **wildcard**     | O(N)          | 通配符模式匹配（日志分析） | ❌    | 100-1000ms   |

#### 关键说明
1. **时间复杂度**：
    - O(1)：哈希查找
    - O(logN)：倒排索引二分查找
    - O(N)：线性扫描
    - O(N·logN)：需要排序的计算

2. **缓存支持**：
    - ✅：支持 filter 上下文缓存（term/terms/range等）
    - ❌：不缓存（评分查询/复杂查询）

3. **响应时间基准**：
    - 测试环境：SSD存储，16核CPU，32GB内存
    - 数据量：100万文档级别
    - 索引：默认配置（1分片）


### 核心机制
#### 逻辑关系
must 子句中的多个查询是**逻辑与（AND）**关系，所有条件必须同时满足。

#### 执行顺序
Elasticsearch 会通过以下策略优化执行顺序：
优先执行能快速缩小结果集的查询（如 term 或 range）
后执行计算成本高的查询（如 match_phrase 或 script）

#### 评分影响
所有 must 子句的匹配贡献会累加到最终相关性评分（_score），但评分权重与条件顺序无关。

#### 性能优化建议
1. 高频过滤条件使用 `filter` 上下文
2. 避免在大文本字段使用 `wildcard`/`regexp`
3. 地理查询使用 `geo_shape` 替代 `geo_distance`（预计算场景）
4. 数值范围查询使用 keyword 类型更高效

#### 分词器
#### 分词模式
ik_max_word

### 参考文档
- [ES Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)
- [Elasticsearch SQL官方文档](https://www.elastic.co/cn/elasticsearch/sql)
