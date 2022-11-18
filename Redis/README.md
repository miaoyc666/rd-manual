Redis 
=

### 1.查询分析
#### 1.监控
```bash
monitor
echo "monitor" | redis-cli -h x.x.x.x -p xxx -a xxx
```

#### 2.查看慢查询
```bash
slowlog get
```


