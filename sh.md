

用户权限管理
- 每个用户创建时都会自动创建一个组，且这个组只此用户一个用户 （此用户为户主，此组为此用户的主组）
- 用户除了主组也可以有多个附加组（uid=1(bin) gid=1(bin) groups=1(bin),2(daem),3(sys)）
![](https://s3.51cto.com/wyfs02/M01/8D/72/wKioL1ichHby9VfGAAAgEgTv0EY748.png)
- 用户及主组配置文件 /etc/passwd
- 用户及密码配置 /etc/shadow
- 附加组及其属性信息 /etc/group
- 

1、脚本的创建 xxx.sh
2、开头 #!/bin/sh  or #!/bin/bash
```
可以说，#!/bin/sh是#!/bin/bash的缩减版
也就是说 /bin/sh 相当于 /bin/bash --posix
所以，sh跟bash的区别，实际上就是bash有没有开启posix模式的区别
如果第一行写成 #!/bin/bash --posix，那么脚本执行效果跟#!/bin/sh是一样的
```
3、增加可执行权限 chmod a+x xxx.sh
```
a: all
u: user 文件所有者
o: other 其他用户
g: group 同组用户

r,w,x 可读可写可执行
r=4，w=2，x=1 

+ 增加权限 u+r
- 减少权限 u-r
= 唯一权限 u=r
```

4、语法
```
break for、while、until、case、cd 、continue 、

echo、eval 、exec 执行命令，但不在当前shell
exit 退出当前shell
export 导出变量，使当前shell可利用它
pwd 显示当前目录
read 从标准输入读取一行文本
readonly 使变量只读
return 退出函数并带有返回值
set 控制各种参数到标准输出的显示
shift 命令行参数向左偏移一个
test 评估条件表达式
times 显示shell运行过程的用户和系统时间
trap 当捕获信号时运行指定命令
ulimit 显示或设置shell资源
umask 显示或设置缺省文件创建模式
unset 从shell内存中删除变量或函数
wait 等待直到子进程运行完毕
```