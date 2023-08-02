# Golang

#### 打印调用堆栈
```go
import "runtime/debug"
fmt.Printf("%s", debug.Stack())
```

#### 初始化空变量
```go
// map
var a map[string]string 
a = make(map[string]string)
// slice
var b = make([]string, 0)
```

#### 初始化赋值变量
```go
// map
tmpMap := map[int]string{0 : "a", 1 : "b"}
// slice
slis := []int{1,2,3,4,5,6,7,8}
// array
nums := [...]int{1,2,3,4,5,6,7,8}
```

#### sync.map赋值读取
```go
aaa := sync.Map{}
ids := []string{}
aaa.Store("1", ids)
info, ok := aaa.Load("1")
if ok {
    ids = info.([]string)
    fmt.Println(ids)
}
ids = append(ids, "2")
ids.Store("1", ids)
```
 
#### 遍历
array
```go
for k, v:= range nums{
    // k 为下标，v 为对应的值
    fmt.Println(k, v, " ")
}
```
slice
```go
for k, v:= range slis{
    // k 为下标，v 为对应的值
    fmt.Println(k, v, " ")
}
```
map
```go
for k, v:= range tmpMap{
    // k 为键值，v 为对应值
    fmt.Println(k, v, " ")
}
```
模拟while循环
```go
for i < l {
	if i == l - 1 {
		break
	} else {
		i += 1
	}
}
```

#### 字符串操作
```go
// 切分
s := "/home/a/a_2022.09.08.1019.dat"
a := strings.Split(s, ".")
// 拼接
b := a[:len(a)-1]
c := strings.Join(b, ".") + ".tar.gz
// 包含
strings.Contains(fileName, ".tar.gz")
```

#### 格式转换
##### 数据类型转换
```go
// interface转string
// value是interface类型
value.(string)

// interface to slice
newValue := v.([]string)

// interface to pointer
x := v.(*unsafe.Pointer)

// float转string
strScore := strconv.FormatFloat(float64(score), 'f', 0, 32)
str_ := fmt.Sprintf("%f", floatVar)

// int转string
str := strconv.Itoa(score)
int_ := fmt.Sprintf("%d", intVar)

// string转int
int, err := strconv.Atoi(string)

// string转long
n, _ := strconv.ParseInt(tid, 10, 64)

// []byte转string
a := string(b)

// string转[]byte
a := []byte(b)
```

##### 时间转换
```go
// 获取当前时间
t := time.Now()

// 获取时间戳
t.Unix()

// unix时间戳转标准时间字符串
timeString := t.Unix().Format("2006-01-02 15:04:05")

// 标准时间字符串转unix时间戳
loc, _ := time.LoadLocation("Asia/Shanghai")
tt, _ := time.ParseInLocation("2006-01-02 15:04:05", timeString, loc)
timeStamp := tt.Unix()

//获取两天前的时间
currentTime := time.Now()
oldTime := currentTime.AddDate(0, 0, -2)
```

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
