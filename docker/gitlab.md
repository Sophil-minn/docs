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
有两种runner，
一种是shared runner，可供全局使用，使用 admin/runner 上的token
一种是specific runner，为项目专用。使用 项目设置中CI/CD选项 的token

tags是gitlab-ci.yml文件中所要用到的，
executor我们输入docker

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

解决：
    5.1、
    docker exec -it gitlab-runner vi /etc/gitlab-runner/config.toml
    5.2、
    修改Runner的/etc/gitlab-runner/config.toml文件，
    在其中的[runner.docker]下增加：
    extra_hosts = ["localhost:192.168.8.108"]


6、
Using Docker executor with image node ...
ERROR: Preparation failed: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running? (executor_docker.go:1148:0s)

分析：docker 此时已确定Docker本身已经安装正常,问题是因为docker服务没有启动, 需要 dind

解决：
6.1、
docker exec -it gitlab-runner vi /etc/gitlab-runner/config.toml
6.2、
修改Runner的/etc/gitlab-runner/config.toml文件，
在其中的[runner.docker]下修改：
privileged = true
或者
在 docker run 运行时添加 --privileged 参数 和 -d docker:dind
::
The security implications of exposing docker.sock and enabling --privileged are the same.
Experimentally we enabled --privileged mode for all builds.
6.3、
在 .gitlab-ci.yml中添加：
# docker image 不添加时， docker: command not found
image: docker:latest
# dind service 不添加时，Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
services:
  - docker:dind


```
- gitlab API 文档
```
http://localhost/help/api/README.md
http://localhost/help/api/runners.md

https://docs.gitlab.com/ee/user/project/integrations/webhooks.html
```

- .gitlab-ci.yml
```
Image：https://docs.gitlab.com/ce/ci/docker/using_docker_images.html
1、
You can simply define an image that will be used for all jobs and a list of services that you want to use during build time.
2、
It is also possible to define different images and services per job

3、
When configuring the image or services entries, you can use a string or a map as options:

when using a string as an option, it must be the full name of the image to use (including the Registry part if you want to download the image from a Registry other than Docker Hub)
when using a map as an option, then it must contain at least the name option, which is the same name of the image as used for the string setting
4、
Starting multiple services from the same image
5、
Define image and services in config.toml
6、
cache

Gitlab Runner v0.7.0 开始引入。

cache用来指定需要在job之间缓存的文件或目录。只能使用该项目工作空间内的路径。

从GitLab 9.0开始，pipelines和job就默认开启了缓存

如果cache定义在jobs的作用域之外，那么它就是全局缓存，所有jobs都可以使用该缓存。

6、
Below、 is a high level overview of the steps performed by Docker during job time.

Create any service container.
Create cache container to store all volumes as defined in config.toml and Dockerfile of build image (ruby:2.1 as in above example).
Create build container and link any service container to build container.
Start build container and send job script to the container.
Run job script.
Checkout code in: /builds/group-name/project-name/.
Run any step defined in .gitlab-ci.yml.
Check exit status of build script.
Remove build container and all created service containers

```

- .gitlab-ci.yml DEMO
```
stages:
  - step1
  - step2
  - step3

job1:
  stage: step1
  script:
    - echo 'start...'

job2:
  stage: step2
  script:
    - id -
    - whoami
    - uname -a
    - pwd

job3:
  stage: step3
  script:
    - cd /bin && ls -l
```

- [gitlab-ci.yml](http://livedig.com/724)
```
image 关键字

image 关键字是本地 Docker Engine 中存在的 Docker 镜像的名称（docker image 可列出所有docker 镜像）

可在 Docker Hub (https://hub.docker.com/u/library/) 中找到的任何镜像

1、前缀 library, 后缀 latest 可以省落
image: ruby
image: library/ruby:latest
```

- [dind](https://www.colabug.com/3806452.html)
```
Docker In Docker 简称 dind，在 GitLab CI 的使用中，可能会常被用于 service 的部分。 dind 表示在 Docker 中实际运行了一个 Docker 容器, 或 Docker daemon。

其实如果只是在 Docker 中执行 docker 命令， 那装个二进制文件即可。 但是如果想要运行 Docker daemon (比如需要执行 docker info)或者访问任意的设备都是不允许的。

Docker 在 run 命令中提供了两个很重要的选项 --privileged 和 --device ， 另外的选项比如 --cap-add 和 --cap-drop 跟权限也很相关，不过不是今天的重点，按下不表。

--device 选项可以供我们在不使用 --privileged 选项时，访问到指定设备, 比如 docker run --device=/dev/sda:/dev/xvdc --rm -it ubuntu fdisk /dev/xvdc 但是这也只是有限的权限， 我们知道 docker 的技术实现其实是基于 cgroup 的资源隔离，而 --device 却不足于让我们在容器内有足够的权限来完成 docker daemon 的启动。
```

- .gitlab-ci.yml 问题
```
gitlab-ci 中 脚本可使用的命令
一、git 在以下情况可用： 
1、未设置 image 
2、设置 image: node | ruby ...

二、git 在以下情况不可用：
1、image: docker

三、git clone  git://username:password@gitlab.example.com/xxx.git 可以把用户名和密码带着

四、docker 命令可用
image: docker
service: docker:dind

```


- 其他一些思考
```
什么情况下需要注册Shared Runner？
比如，GitLab上面所有的工程都有可能需要在公司的服务器上进行编译、测试、部署等工作，这个时候注册一个Shared Runner供所有工程使用就很合适。

什么情况下需要注册Specific Runner？
比如，我可能需要在我个人的电脑或者服务器上自动构建我参与的某个工程，这个时候注册一个Specific Runner就很合适。

什么情况下需要在同一台机器上注册多个Runner？
比如，我是GitLab的普通用户，没有管理员权限，我同时参与多个项目，那我就需要为我的所有项目都注册一个Specific Runner，这个时候就需要在同一台机器上注册多个Runner。
```

- 历史记录
```
usermod -a -G root gitlab-runner
usermod -a -G group1 user1 添加用户user1到组group1里


如果你选择Docker作为Runner的executor，你还要选择默认的docker image来运行job（当然，你也可以在.gitlab-ci.yml里指明你需要用的image）：
Please enter the Docker image (eg. ruby:2.1):
alpine:latest


在初始的注册完成后，我们需要编辑/etc/gitlab-runner/config.tom并作出调整：

  concurrent限制了整个GitLab Runner能并发处理job的数量

  当我的Runner采用docker作为executor时，无法build docker image:
  volumes = [“/var/run/docker.sock:/var/run/docker.sock”, “/cache”]

  想要在拉取本地镜像时：
  pull_policy = never  # 该配置默认always，即只在线上拉取镜像
  always —— Runner始终从远程pull docker image。
  if-not-present —— Runner会首先检查本地是否有该image，如果有则用本地的，如果没有则从远程拉取。
  never —— Runner始终使用本地的image。

  localhost 与ip
  extra_hosts = ["hostname:ip"] #如果有需要添加一些hosts映射，仍然在 [runners.docker] 下，添加

这样在容器中装载/var/run/docker.sock，使得构建的容器保存在主机本身的镜像存储中。这是一个比Docker更好的方法。

config.toml的修改是由Runner自动执行的，因此无需重新启动。

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


- gitlab webhook
```
1、本地测试 webhook
管理员 设置(settting) ==》 外发请求(Outboound requests) ==》 Allow requests to the local network from hooks and services
2、webhook url 设置 ip 形式，而非 localhost

3、常用库
npm install --save node-gitlab-webhook

::
var http = require('http')
var createHandler = require('node-gitlab-webhook')
var handler = createHandler([ // multiple handlers
  { path: '/webhook1', secret: 'secret1' },
  { path: '/webhook2', secret: 'secret2' }
])
// var handler = createHandler({ path: '/webhook1', secret: 'secret1' }) // single handler

http.createServer(function (req, res) {
  handler(req, res, function (err) {
    res.statusCode = 404
    res.end('no such location')
  })
}).listen(7777)

handler.on('error', function (err) {
  console.error('Error:', err.message)
})

handler.on('push', function (event) {
  console.log(
    'Received a push event for %s to %s',
    event.payload.repository.name,
    event.payload.ref
  )
  switch (event.path) {
    case '/webhook1':
      // do sth about webhook1
      break
    case '/webhook2':
      // do sth about webhook2
      break
    default:
      // do sth else or nothing
      break
  }
})
```
