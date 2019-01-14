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

