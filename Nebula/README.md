# Nebula
图数据局

### 核心组成
- 点（Vertex）	表示现实世界中的实体。一个点可以有一个或多个标签。
- 标签（Tag）	点的类型，定义了一组描述点类型的属性。
- 边（Edge）	表示两个点之间有方向的关系。
- 边类型（Edge type）	边的类型，定义了一组描述边的类型的属性。

### 基础语法
```nebula
-- 列出所有图空间
SHOW SPACES;

-- 产看所有标签（表）
SHOW TAGS;

-- 查看所有边类型
SHOW EDGES;
```

### 查询语法
```nebula
-- 查询点
FETCH PROP ON <tag> <vid>;

-- 查询边
FETCH PROP ON <edge_type> <src_vid>-><dst_vid>;
```

### 图查询
```nebula
-- 单跳查询
GO FROM <vid> OVER <edge_type>;

-- 多跳查询
GO FROM <vid> OVER <edge_type> YIELD <fields> | GO FROM $-.<dst_id> OVER <edge_type2>;

-- 条件查询
GO FROM <vid> OVER <edge_type> WHERE <condition> YIELD <fields>;
```
