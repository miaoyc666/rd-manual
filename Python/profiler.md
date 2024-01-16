Python性能分析
=

## CPU
### py-spy
使用py-spy分析cpu占用，将展示一个实时更新的列表，其中包含了消耗CPU最多的Python函数。
```bash
pip install py-spy
py-spy top --pid <PID>
```