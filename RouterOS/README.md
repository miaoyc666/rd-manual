RouterOS
=

#### DDNS
ROS脚本(精简版)
```bash 
#更新ALIDDNS脚本精简版#    
#定义更新的域名#    
:global ddns1 "a.myc.ink"    
#定义阿里云ID#    
:global id1 "16字节长度AccessKey ID"    
#定义阿里云Secret#    
:global secret1 "30字节长度的密匙"    
#下面内容请勿修改#    
#更新IPV4#    
:local results [/tool fetch url=("https://mail.ros6.com:6180/id=$id1&secret=$secret1&domain=$ddns1") check-certificate=no as-value output=user]  
:if ($results->"status" = "finished") do={  
:local result ($results->"data")  
:log warning $result  
} 
```
ROS脚本完整版
```bash 
#更新ALIDDNS脚本完整版#  
#定义更新的接口名#  
:global ddnsint1 "pppoe-out1"  
#定义更新的域名#  
:global ddns1 "a.myc.ink"  
#定义更新的线路类型(default,unicom,telecom,mobile)#  
:global ddnsline1 "default"  
#定义TTL参数#  
:global ttl1 600  
#定义更新接口对应的DNS#  
:global ddnsd1 114.114.114.114  
#获取更新域名对应的IP#  
:global ddnsres1  
:do {:set ddnsres1 [resolve $ddns1 server=$ddnsd1]} on-error={:set ddnsres1 ""}  
#定义阿里云ID#  
:global id1 "16字节长度AccessKey ID"  
#定义阿里云Secret#  
:global secret1 "30字节长度的密匙"  
#下面内容请勿修改#  
#更新IPV4#  
:global ddnsip1 [/ip address get [find interface=$ddnsint1] address]  
:set ddnsip1 [:pick $ddnsip1 0 [:find $ddnsip1 "/"]]  
:if ($ddnsres1 != $ddnsip1) do={  
:local results [/tool fetch url=("https://mail.ros6.com:6180/id=$id1&secret=$secret1&domain=$ddns1&ip=$ddnsip1&line=$ddnsline1&ttl=$ttl1") check-certificate=no as-value output=user]  
:if ($results->"status" = "finished") do={  
:local result ($results->"data")  
:log warning ("ALIDDNS:IPV4 ".$result)  
}  
#更新IPV6#  
:if ([/system package find name="ipv6" disabled=no] !="") do={  
:if ([/ipv6 dhcp-client find interface=$ddnsint1] !="") do={  
:global ddnsipv61 [/ipv6 dhcp-client get [/ipv6 dhcp-client find interface=$ddnsint1] prefix]  
:set ddnsipv61 [:pick $ddnsipv61 0 [:find $ddnsipv61 "/"]]  
:if ($ddnsipv61 !="") do={  
:local results [/tool fetch url=("https://mail.ros6.com:6180/id=$id1&secret=$secret1&domain=$ddns1&ip=$ddnsipv61&line=$ddnsline1&ttl=$ttl1") check-certificate=no as-value output=user]  
:if ($results->"status" = "finished") do={  
:local result ($results->"data")  
:log warning ("ALIDDNS:IPV6 ".$result)  
}  
}}}  
} 
```

