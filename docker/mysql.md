docker pull mysql
docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d mysql

```javascript
$ docker exec -it mysql bash

# mysql -u root -p


# ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';

# flush privileges;  刷新权限
```