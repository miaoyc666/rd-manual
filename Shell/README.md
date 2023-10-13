Shell
=

#### 传参默认值
```bash
#!/bin/bash

# 获取第一个参数，如果不存在则赋予默认值
param1=${1:-default_value}

echo "Parameter 1: $param1"
```