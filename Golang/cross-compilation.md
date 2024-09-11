# Golang交叉编译

### 交叉编译

#### GOOS 和GOARCH的有效组合:
- GOOS：目标平台的操作系统（darwin、freebsd、linux、windows）
- GOARCH：目标平台的体系架构（amd64、arm、arm64)

#### 带CGO的交叉编译：
- CGO_ENABLED：是否使用cgo
- CGO_CFLAGS：编译参数
- CGO_LDFLAGS：链接参数

#### 替换gcc编译器：
- CC：指定GCC编译器
- CC_FOR_TARGET：指定编译代码的目标平台

##### 示例：
`CGO_ENABLED=1 GOOS=linux GOARCH=arm go build -o demo main.go`

#### 获取所有GOOS和GOARCH组合
```bash 
go tool dist list
```

##### 示例
```bash 
# go verison: 1.21.9
aix/ppc64
android/386
android/amd64
android/arm
android/arm64
darwin/amd64
darwin/arm64
dragonfly/amd64
freebsd/386
freebsd/amd64
freebsd/arm
freebsd/arm64
freebsd/riscv64
illumos/amd64
ios/amd64
ios/arm64
js/wasm
linux/386
linux/amd64
linux/arm
linux/arm64
linux/loong64
linux/mips
linux/mips64
linux/mips64le
linux/mipsle
linux/ppc64
linux/ppc64le
linux/riscv64
linux/s390x
netbsd/386
netbsd/amd64
netbsd/arm
netbsd/arm64
openbsd/386
openbsd/amd64
openbsd/arm
openbsd/arm64
plan9/386
plan9/amd64
plan9/arm
solaris/amd64
wasip1/wasm
windows/386
windows/amd64
windows/arm
windows/arm64
```
