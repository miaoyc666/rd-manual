# Golang交叉编译

#### 交叉编译
GOOS 和GOARCH的有效组合:
- GOOS：目标平台的操作系统（darwin、freebsd、linux、windows）
- GOARCH：目标平台的体系架构（386、amd64、arm）

带CGO的交叉编译：
- CGO_ENABLED：是否使用cgo
- CGO_CFLAGS：编译参数
- CGO_LDFLAGS：链接参数

替换gcc编译器：
- CC：指定GCC编译器
- CC_FOR_TARGET：指定编译代码的目标平台

示例：
`CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -o demo main.go`
