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


#### npm 默认提供下面这些钩子。

prepublish，postpublish
preinstall，postinstall
preuninstall，postuninstall
preversion，postversion
pretest，posttest
prestop，poststop
prestart，poststart
prerestart，postrestart

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

