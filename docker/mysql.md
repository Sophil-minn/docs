docker pull mysql
docker run --name mysql2 -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d mysql:5.6 -e LANG=C.UTF-8 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

docker exec -it mysql bash

```javascript
$ docker exec -it mysql bash

# mysql -u root -p


# ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';flush privileges;

# flush privileges;  刷新权限
```

docker run --name mysql005 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=888888 -idt mysql:8 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci


### 乱码及编码问题
```
## 进入 MySQL

mysql -u root -p
## 输入密码

## 查看各种默认配置
show variables like '%char%';

## 会有一个表 大概如下
## 部分utf8 可能会是其他值，然后我们慢慢修改
## set character_set_client=utf8
## 也可以用以上方法设置，但重启 mysql 又会回到原点
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+

insert into saas_wiki_type value("4","测试",NULL,NULL);
## 退出数据库

vi /etc/my.cnf

## 编辑这个配置文件
## 在对应的区域添加、新增

[mysqld]
character-set-server=utf8

[client]
default-character-set=utf8

[mysql]
default-character-set=utf8

## 重启mysql服务
## 再去看 char 就都是uft8 真棒

```

### 当前mysql字符集情况
```
SHOW VARIABLES LIKE 'character_set_%';
SHOW VARIABLES LIKE 'collation_%';

先解决外部访问数据乱码的问题
SET NAMES 'utf8';
1
它相当于下面的三句指令：

SET character_set_client = utf8;
SET character_set_results = utf8;
SET character_set_connection = utf8;
```

docker exec -it mysql2 env LANG=C.UTF-8 /bin/bash

### my.cnf
```
# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

#
# The MySQL  Server configuration file.
#
# For explanations see
# http://dev.mysql.com/doc/mysql/en/server-system-variables.html

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
collation-server = utf8_unicode_ci
collation_connection = utf8_unicode_ci
collation_database = utf8_unicode_ci
init-connect='SET NAMES utf8'
character-set-server = utf8
secure-file-priv= NULL
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

# Custom config should go here
!includedir /etc/mysql/conf.d/

[mysql.server]
default-character-set = utf8

[mysqld_safe]

default-character-set = utf8

[mysql]
default-character-set=utf8

[client]
default-character-set=utf8




```

mac下navicat新建连接是编码选择auto而不是utf8即可，一试，果然可以，但是还是不清楚为什么mac下的navicat跟Windows下不一样，这个问题是比较奇葩。

至此，乱码问题已解决。