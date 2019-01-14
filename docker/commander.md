
#### docker 操作
> 常用的8个Docker的真实使用场景，分别是简化配置、代码流水线管理、提高开发效率、隔离应用、整合服务器、调试能力、多租户环境、快速部署

- docker 安装
```
Mac:

Linux:

Win:

```

- docker 配置
```
1、加速器

2、


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
docker run 
docker start
docker stop
docker rm

2.2、容器创建
docker login [image domain]
docker tag [image_id] [image remote url]:[version]  
docker push [image remote url]:[version]

3、进入 docker 容器
3.1、
docker exec -it [docker container name] /bin/bash
# -t 分配一个伪终端
# -i 即使没有附件也保持Stdin打开
# -d 分离模式，后台运行
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