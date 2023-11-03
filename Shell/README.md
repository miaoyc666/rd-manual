Shell
=

#### 传参默认值
```bash
#!/bin/bash

# 获取第一个参数，如果不存在则赋予默认值
param1=${1:-default_value}

echo "Parameter 1: $param1"
```

#### 关于exit
exit会退出进程。  
source引用的脚本内出现exit会退出整个进程；sh调用执行的脚本只会退出子进程。  
