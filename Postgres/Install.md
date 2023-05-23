安装
=


### docker-compose
#### 配置
```yaml
version: '3'
services:
  db:
    image: postgres:10.6
    restart: always
    environment:
      POSTGRES_PASSWORD: postgres
    volumes:
      - ./data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
```
