
#### docker 操作
> 常用的8个Docker的真实使用场景，分别是简化配置、代码流水线管理、提高开发效率、隔离应用、整合服务器、调试能力、多租户环境、快速部署

- docker 安装
```
Mac:

Linux:

Win:

```
[学习文档](https://blog.csdn.net/zhugeaming2018/article/details/82535130)
- docker 加速
```
0. hub
0.0 https://hub.docker.com/
0.1 http://get.daocloud.io/

1、加速器: 官方 Docker Hub 太慢, 需要进行
1.1 在 /etc/docker/daemon.json 文件中添加镜像配置
1.2 

docker-cn镜像：
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}

腾讯云的服务器
{
  "registry-mirrors": ["https://mirror.ccs.tencentyun.com"]
}
阿里云的服务器
阿里云登录容器Hub服务的控制台，左侧的加速器帮助页面就会显示为你独立分配的加速地址。
例如：
公网Mirror：[系统分配前缀].mirror.aliyuncs.com


wq保存退出：

执行命令生效：

systemctl daemon-reload
systemctl restart docker

```

- docker 基本操作
```
1、dokcer 镜像
docker images
docker search
docker pull
docker rmi

2、docker 容器
2.1、容器运行
docker run  [容器]
docker start [容器]
docker stop [容器]
docker restart [容器]
docker rm [容器]
docker inspect [容器]
docker logs  [容器]
docker exec [容器] ip a

3. network 网络
docker network ls  查看所有网络
docker network create 创建网络
docker network rm 
docker network inspect [one network] 查看某个网络信息
docker network connet [network] [container] 把某个容器连接到某个网络上

4. 数据持久化
docker volume ls
docker volume inspect 

```sh
# 查看 无用 volume
docker volume ls -qf dangling=true
# 删除无用 volume
docker volume rm $(docker volume ls -qf dangling=true)
```

5. 日志
docker logs [容器]

2.2、容器创建
docker login [image domain]
docker build -t [name] .
docker tag [image_id] [image remote url]:[version]  
docker push [image remote url]:[version]

3、进入 docker 容器
3.1、
docker exec -it [docker container name] /bin/bash
# -t 分配一个伪终端
# -i 即使没有附件也保持Stdin打开
# -d 分离模式，后台运行
```
# 容器互通测试
docker exec [容器1] ping -c 2 [容器2]
```

3.2、
docker attach container_id
4、用户相关

宿主机 与 容器 交互
1、docker cp [from ] [to]
1.1 
docker cp container_ID:path  path
1.2
docker cp path container_ID:path

```