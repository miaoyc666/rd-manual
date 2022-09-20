# Golang

#### 初始化空变量
map: `var a map[string]string`  
slice: `var b = make([]string, 0)`

#### 初始化赋值变量
map: `tmpMap := map[int]string{0 : "a", 1 : "b"}`  
slice: `slis := []int{1,2,3,4,5,6,7,8}`  
数组：`nums := [...]int{1,2,3,4,5,6,7,8}`
 
#### 遍历
数组
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

#### 字符串切分与拼接
```golang
s := "/home/a/a_2022.09.08.1019.dat"
a := strings.Split(s, ".")
b := a[:len(a)-1]
c := strings.Join(b, ".") + ".tar.gz"
```

#### 格式转换
##### 数据类型转换
```go
// interface转string
// value是interface类型
value.(string)

// interface转切片
newValue := v.([]string)

// float转string
strScore := strconv.FormatFloat(float64(score), 'f', 0, 32)
str_ := fmt.Sprintf("%f", floatVar)

// int转string
str := strconv.Itoa(score)
int_ := fmt.Sprintf("%d", intVar)

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
```

#### gotests
```bash
# 安装gotests
go get -u github.com/cweill/gotests/...

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
