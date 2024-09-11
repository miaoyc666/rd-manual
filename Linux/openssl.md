openssl
=


#### 查看 PEM 格式的证书信息：
```bash
openssl x509 -in certificate.pem -text -noout
```

#### 查看 DER 格式的证书信息：
```bash 
openssl x509 -in certificate.der -inform DER -text -noout
```

#### 查看 CSR（证书签名请求）信息：
```bash 
openssl req -in request.csr -text -noout
```

#### 查看 PFX/P12 格式的证书信息：
```bash 
openssl pkcs12 -in certificate.pfx -info -nodes
```

在使用这些命令时，确保将 certificate.pem、certificate.der、request.csr 和 certificate.pfx 替换为你的证书文件的实际路径。执行命令后，终端将显示证书的详细信息，包括有效期、颁发者、公钥信息等。
