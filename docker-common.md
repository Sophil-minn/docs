### mysql
data目录将映射为mysql容器配置的数据文件存放路径

logs目录将映射为mysql容器的日志目录

conf目录里的配置文件将映射为mysql容器的配置文件

--name mysql001 

-e MYSQL_USER=”fengwei”：添加用户fengwei
-e MYSQL_PASSWORD=”pwd123”：设置fengwei的密码伟pwd123
-e MYSQL_ROOT_PASSWORD=”rootpwd123”：设置root的密码伟rootpwd123

–-character-set-server=utf8：设置字符集为utf8
–-collation-server=utf8_general_ci：设置字符比较规则为utf8_general_ci
--default-authentication-plugin=mysql_native_password
–restart always：开机启动
–privileged=true：提升容器内权限
-v=/mysqltest/config/my.cnf:/etc/my.cnf：映射配置文件
-v=/mysqltest/data:/var/lib/mysql：映射数据目录
mysql/mysql-server 

-v -v $PWD/conf:/etc/mysql/conf.d：将主机当前目录下的 conf/my.cnf 挂载到容器的 /etc/mysql/my.cnf。
-v $PWD/logs:/logs：将主机当前目录下的 logs 目录挂载到容器的 /logs。
-v $PWD/data:/var/lib/mysql ：将主机当前目录下的data目录挂载到容器的 /var/lib/mysql 。
