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

作者：Jafir
链接：https://www.jianshu.com/p/a67270d91fbd
來源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
