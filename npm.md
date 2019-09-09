npm i
npm i --save
npm i --save-dev
npm i -g

npm i -g npm@latest
npm i --production

npm run
npm bin

npm search
npm list
npm info

npm link
npm publish
npm adduser
npm whoami



$ npm set init-author-name 'Your name'
$ npm set init-author-email 'Your email'
$ npm set init-author-url 'http://yourdomain.com'
$ npm set init-license 'MIT'

npm info

### 原来镜像
```
npm config set registryhttps://registry.npmjs.org
```

### cnpm
```bash
npm install cnpm -g --registry=https://r.npm.taobao.org
```

### 镜像管理
> 后台如果有很多时候 需要处理很多的镜像, 比如我们使用 taobao , npmjs , 自己公司私服 等
```
npm i -g nrm
nrm add xxx url
nrm use xxx
nrm ls
```


#### npm 默认提供下面这些钩子。

prepublish，postpublish
preinstall，postinstall
preuninstall，postuninstall
preversion，postversion
pretest，posttest
prestop，poststop
prestart，poststart
prerestart，postrestart


### npm link 本地调试 - 最优文案
1. npm install .../modle 安装本地开发模块, 缺点是 更新时要重新 npm install
1. npm publish 发布, 缺点是 麻烦
1. npm link 只要两步, 一步是 npm link (如果在开发模板中), 一步是 npm link modelxxx (在项目中) - 之前以为只有一步, 把开发中的模块 npm link 到全局, 但在项目中还是找不到, 原因是没有执行第二步, npm link modelxxx
或者, 直接要项目中 npm link .../model/ 即可一步完

#### npm 版本管理

一般来说，我们会采用semver的方式进行版本的管理。

也就是三段的版本，分别是 major.minor.patch

npm 工具提供了 version 命令，可以用来方便地修改 package.json中的版本号，并自动commit，以及在本地创建对应的tag。

- 当有大版本更新，或不兼容之前版本时，应升级major字段 `npm version major`

- 当有小版本更新，加入新功能时，可升级 minor 版本 `npm version minor`

- 当有bug修复，小的调整时，则升级patch版本 `npm version patch`

npm version会同时创建时 `v版本号` 形式的tag，将tag push上去就可以自动触发构建了。

也可以简化这步操作，在npm version操作后自动 push

在 package.json中加入下面的代码，即可实现npm version操作后，自动push代码及tag，也就自动触发了 npm 发布操作。

```
  "scripts": {
    "postversion": "git push --follow-tags"
  }
```

锁定依赖之依赖的版本号 `npm shrinkwrap` 它会生成一个npm-shrinkwrap.json文件,运行npm install命令时，npm首先会找npm-shrinkwrap.json文件，依照其中的信息来准确地安装每一个依赖包，只有当这个文件不存在时，npm才会使用package.json

### 版本兼容
~ 会匹配最近的小版本依赖包，比如~1.2.3会匹配所有1.2.x版本，但是不包括1.3.0
^ 会匹配最新的大版本依赖包，比如^1.2.3会匹配所有1.x.x的包，包括1.3.0，但是不包括2.0.0
* 这意味着安装最新版本的依赖包


### sdf
"ui-axios": "file:plugins/ui-axios"
"ui-axios": "git"
"reflect-metadata": "^0.1.12"
"reflect-metadata": "~0.1.12"
"reflect-metadata": "*", 

### npm 公用包来说是比较方便的，直接引用即可。而内网的代码应该怎么引入呢？大概有以下几种方式：

npm 公有包
npm 私有包
搭建 npm 私有服务器
git 仓库

npm 对于安装 git 仓库的命令：

npm install <git remote url>
实际上就是直接 install 一个 URL 而已。对于一些公有仓库， npm 还是做了一些集成的，比如 github等(示例全部出自 npm 官方文档):

npm install github:mygithubuser/myproject
npm install bitbucket:mybitbucketuser/myproject
npm install gitlab:myusr/myproj#semver:^5.0
如果我们直接安装 github 上，使用网址的方式可以表示为：

npm install git+https://isaacs@github.com/npm/npm.git
看下 npm 安装 git 仓库的协议：

> <protocol>://[<user>[:<password>]@]<hostname>[:<port>][:][/]<path>[#<commit-ish> | #semver:<semver>]

```
直接写 #branch 表示需要安装的分支号。

所以在开发过程中我们可以这么写包：

npm i git+https://username:password@git.example.com/path/reposity#master
或者使用打的 tag

npm i git+https://username:password@git.example.com/path/reposity#1.0.0
```

#### package.json 与 package-lock.json 版本依赖逻辑 三次变化

自npm 5.0版本发布以来，npm i的规则发生了三次变化。

1、npm 5.0.x 版本，不管package.json怎么变，npm i 时都会根据lock文件下载
　　　　package-lock.json file not updated after package.json file is changed · Issue #16866 · npm/npm
　　　 这个 issue 控诉了这个问题，明明手动改了package.json，为啥不给我升级包！然后就导致了5.1.0的问题...

2、5.1.0版本后 npm install 会无视lock文件 去下载最新的npm
　　　　why is package-lock being ignored? · Issue #17979 · npm/npm
　　　 这个issue控诉这个问题，最后演变成5.4.2版本后的规则。

3、5.4.2版本后 why is package-lock being ignored? · Issue #17979 · npm/npm
　　　 大致意思是，如果改了package.json，且package.json和lock文件不同，那么执行`npm i`时npm会根据package中的版本号以及语义含义去下载最新的包，并更新至lock。

　　如果两者是同一状态，那么执行`npm i `都会根据lock下载，不会理会package实际包的版本是否有新。



### [Resolving EACCES permissions errors when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)

