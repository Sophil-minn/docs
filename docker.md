
#### docker 操作

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
docker run 
docker start
docker stop
docker rm

3、docker 网络



4、其他
docker exec -it [docker container name] /bin/bash
```

### gitlab Docker

- gitlab 安装
```
1、
docker pull gitlab/gitlab-ce
2、
docker pull gitlab/gitlab-runner
```

- gitlab 配置
```
1、
docker run -d  -h localhost  -p 443:443 -p 80:80 -p 22:22  --name gitlab --restart always gitlab/gitlab-ce:latest
2、
docker run -d -v /var/run/docker.sock:/var/run/docker.sock --link gitlab --name gitlab-runner --restart always  gitlab/gitlab-runner:latest
3、
docker exec -it gitlab-runner gitlab-runner register
4、
按照提示输入即可，前两项可以在指定项目设置中CI/CD选项里的Runners settings选项中的Specific Runners里看到，
tags是gitlab-ci.yml文件中所要用到的，executor我们输入docker

配置成功后，我们可以在设置中CI/CD选项里的Runners settings选项中的Specific Runners里看到runner信息 
```

- gitlab 配置中常遇到的 问题
```
1、gitlab-ce 配置 -h


2、gitlab-runner 配置 --link[*]

不加 --link 时，报错：
ERROR: Registering runner... failed                 runner=Jq6omeRE status=couldn't execute POST against http://localhost/api/v4/runners: Post http://localhost/api/v4/runners: dial tcp [::1]:80: getsockopt: connection refused
PANIC: Failed to register this runner. Perhaps you are having network problems 

3、gitlab-runner 配置 docker.sock[？]

4、提交了代码没有触发，一直停留在pending
报错：This job is stuck, because you don't have any active runners that can run this job.

Can run untagged jobs: [false/true]: 

默认值为false。这句话的意思是：是否在没有标记tag的job上运行，如果选择默认值false，那没有标记tag的代码提交是不会触发gitlab runner的，如果做测试，最好填true。

解决：在运行如 gitlab-runner 中， 设置为 untagged

5、运行 runner 时，报错：
fatal: unable to access 'http://gitlab-ci-token:xxxxxxxxxxxxxxxxxxxx@localhost/root/html5.git/': Failed to connect to localhost port 80: Connection refused

解决：docker exec -it gitlab-runner vi /etc/gitlab-runner/config.toml
修改Runner的/etc/gitlab-runner/config.toml文件，在其中的[runner.docker]下增加：
extra_hosts = ["localhost:172.17.0.1"]


6、
Using Docker executor with image node ...
ERROR: Preparation failed: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running? (executor_docker.go:1148:0s)

解决：
Using Docker executor with image ruby ...
Pulling docker image ruby ...

```




- 历史记录
```
docker exec -it gitlab cat /opt/gitlab/embedded/service/gitlab-rails/VERSION
docker exec -it gitlab-runner gitlab-runner register


# 挂载宿主机的 sock
docker run -d --name gitlab-runner --restart always  -v $(which docker):/bin/docker -v /var/run/docker.sock:/var/run/docker.sock --link gitlab gitlab/gitlab-runner:latest
docker run -d --name gitlab-runner --restart always  -v /var/run/docker.sock:/var/run/docker.sock --link gitlab gitlab/gitlab-runner:latest
curl --header "PRIVATE-TOKEN: 9koXpg98eAheJpvBs5tK" "http://localhost/api/v4/runners"
docker run -d  -h localhost  -p 443:443 -p 80:80 -p 22:22  --name gitlab --restart always gitlab/gitlab-ce:latest
docker exec -it gitlab-runner vi /etc/gitlab-runner/config.toml

which docker:
/usr/local/bin/docker

usermod -a -G root gitlab-runner
usermod -a -G group1 user1 添加用户user1到组group1里

在初始的注册完成后，我们需要编辑/etc/gitlab-runner/config.tom并作出调整：

volumes = [“/var/run/docker.sock:/var/run/docker.sock”, “/cache”]

这样在容器中装载/var/run/docker.sock，使得构建的容器保存在主机本身的镜像存储中。这是一个比Docker更好的方法。

config.toml的修改是由Runner自动执行的，因此无需重新启动。


ERROR:
fatal: unable to access 'http://gitlab-ci-token:xxxxxxxxxxxxxxxxxxxx@localho
docker exec -it gitlab-runner vi /etc/gitlab-runner/config.toml
修改Runner的/etc/gitlab-runner/config.toml文件，在其中的[runner.docker]下增加：
extra_hosts = ["localhost:172.17.0.1"]


ERROR:
docker exec -it gitlab-ci-multi-runner bash
curl -sSL https://get.docker.com/ | sudo sh
sudo usermod -aG docker gitlab-runner
sudo -u gitlab-runner -H docker info


Running in system-mode.                            
                                                   
Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
http://localhost/
Please enter the gitlab-ci token for this runner:
BMXMVyLG5cRzrjJf6N8N
Please enter the gitlab-ci description for this runner:
[83ef31c77f31]: shared
Please enter the gitlab-ci tags for this runner (comma separated):
tag1 
Registering runner... succeeded                     runner=BMXMVyLG
Please enter the executor: docker-ssh, shell, docker-ssh+machine, kubernetes, docker, ssh, virtualbox, docker+machine, parallels:
docker
Please enter the default Docker image (e.g. ruby:2.1): 
#Docker image：构建Docker image时填写的image名称，根据项目代码语言不同，指定不同的镜像。我这里项目是java语言的，所以我使用官方maven:3-jdk-8镜像。
ruby:2.1
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

启动runner

　　 单次运行：gitlab-ci-multi-runner run

 　　作为服务运行：

　　gitlab-runner install --user "root" --service "shell-001" --working-directory="/data" # 这里安装一个服务

　　gitlab-runner start --service shell-001 #启动这个服务

常用命令介绍

1、gitlab-runner --debug run，如果你遇到一些错误，可以使用这个命令来在前端（控制台运行），查看log
2、gitlab-runner run --user jafir(普通用户)，如果需要切换用户可以使用这个
3、sudo chmod -x xxx，修改用户权限
4、gitlab-runner uninstall，如果想从头再来
5、gitlab-runner status，查看状态
6、sudo gitlab-runner verify，查看runner是否在运行后
7、sudo gitlab-runner verify --delete，删除注册的用户，如果想要从头再来
8、删除 ~/.gitlab-runner/config.toml(注册的用户的配置文件)，和/etc/gitlab-runner/config.toml，如果想要从头再来

```
