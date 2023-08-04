Gotest
=

#### gotests
```bash
# 安装gotests
go get github.com/cweill/gotests/...

# env
export PATH=$PATH:$GOPATH/bin

# 生成所有测试用例
gotests -all {$filename}
```

#### go test
```bash
go test -v {$testfile} {$sourcefile}
go test -v {$testfile} {$sourcefile} -test.run {$test case name}
```
