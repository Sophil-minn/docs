1. 基本结构
1. 基本命令
1. 定义变量
1. 定义入口


```
容器内部建议不要存储任何数据
当有多个CMD的时候，只有最后一个生效
```


```
设置环境变量 ENV
基础镜像信息	FROM
维护者信息	MAINTAINER
镜像操作指令	RUN、COPY、ADD、EXPOSE、WORKDIR、ONBUILD、USER、VOLUME等
容器启动时执行指令	CMD、ENTRYPOINT
```

#### 基本结构
```
From
...
ENTRYPOINT
```

#### 基本命令
```
WORKDIR
CD
COPY
ADD
RUN

// 与域外连接
VOLUME
CMD
ENTRYPOINT
EXPOSE
```

```shell
CMD ["/user/sbin/nginx"]
OR
ENTRYPOINT ["/user/sbin/nginx"]

作用是然后通过启动build之后的容器 docker run -ti image -g "daemon off"
```


eg.
```shell
RUN ["apt-get", "install", " -y", "vim"]
CMD ["/bin/echo","hello docker  微信公众号：编程坑太多"]
ENTRYPOINT ["/bin/echo","hello docker 微信公众号：编程坑太多"]
```