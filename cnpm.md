### docker mysql



### docker redis



### cnpm 

> git clone git://github.com/cnpm/cnpmjs.org 
> npm install
> 数据库名: cnpmjs
> mysql -uyixiang -p cnpmjs < docs/db.sql
> touch config/config.js
```
// config.js
module.exports = {

  debug: false,
  bindingHost: '192.168.2.172', // 设定只能用该IP访问cnpm服务器
  scopes: ['@bitor'],//指定你的私有包的前缀，你发布的包必须以此开头
  enableCluster: true, // enable cluster mode
  sourceNpmRegistry: 'https://registry.npm.taobao.org',
  database: {
          db:'cnpmjs',         // 数据库名
          host: '192.168.2.172',    // 你的数据库地址
          port:3306,           // 默认
          username:'root',     // 默认
          password:'root',  // 默认为空
          dialect:'mysql'      // 使用mysql，默认为sqlite,
　　},
    enablePrivate:true, // 开启私有库
    admins: {
      admin: 'xxxx@qq.com',
    },

    syncModel: 'none'//默认有none ，exist，all，此处设置为none，即不同步npm源已有的库至本地，如果设置为exist，则会同步线上npm源存在的模块，比如，当你执行安装某线上模块时，则会把线上该模块版本全部同步至本地库
}

```
### start cnpm
> $ npm run start

** open registry and web ** 
- registry
> open http://localhost:7001
- web
> open http://localhost:7002


### add 管理员用户
> npm adduser --registry=http://192.168.2.172:7001
```
Username: admin
Password: admin
Email: (this IS public) 必须为上面配置的邮箱，即ezen@qq.com
```

### login
> npm login --registry=http://192.168.8.200:7001

### publish && unpublish
> npm publish --registry=http://192.168.8.200:7001
> npm unpublish --registry=http://192.168.8.200:7001 包名@版本


### publish 权限



#### 配置字段参考

- `enableCluster`：是否启用 **cluster-worker** 模式启动服务，默认 `false`，生产环节推荐为 `true`;

- `registryPort`： API 专用的 registry 服务端口，默认 `7001`；

- `webPort`： Web 服务端口，默认 `7002`；

- `bindingHost`：监听绑定的 Host ，默认为 `127.0.0.1`，如果外面架了一层本地的 **Nginx** 反向代理或者 **Apache** 反向代理的话推荐不用改；

- `sessionSecret`：**session** 用的盐；

- `logdir`：日志目录；

- `uploadDir`：临时上传文件目录；

- `viewCache`：视图模板缓存是否开启，默认为 `false`；

- `enableCompress`：是否开启 **gzip** 压缩，默认为 `false`；

- `admins`：管理员们，这是一个 `JSON Object`，对应各键名为各管理员的用户名，键值为其邮箱，默认为 `{ fengmk2: 'fengmk2@gmail.com', admin: 'admin@cnpmjs.org', dead_horse: 'dead_horse@qq.com' }`；

- `logoURL`：**Logo** 地址，不过对于我这个已经把 CNPM 前端改得面目全非的人来说已经忽略了这个配置了；

- `adBanner`：广告 Banner 的地址；

- `customReadmeFile`：实际上我们看到的 [cnpmjs.org](http://cnpmjs.org/) 首页中间一大堆冗长的介绍是一个 Markdown 文件转化而成的，你可以设置该项来自行替换这个文件；

- `customFooter`：自定义页脚模板；

- `npmClientName`：默认为 `cnpm`，如果你有自己开发或者 fork 的 npm 客户端的话请改成自己的 CLI 命令，这个应该会在一些页面的说明处替换成你所写的；

- `backupFilePrefix`：备份目录；

- ```
  database：数据库相关配置，为一个对象，默认如果不配置将会是一个
  ```

   

  ```
  ~/.cnpmjs.org/data.sqlite
  ```

   

  的 SQLite ；

  - `db`：数据的库名；

  - `username`：数据库用户名；

  - `password`：数据库密码；

  - `dialect`：数据库适配器，可选 `"mysql"`、`"sqlite"`、`"postgres"`、`"mariadb"`，默认为 `"sqlite"`；

  - `hsot`：数据库地址；

  - `port`：数据库端口；

  - ```
    pool：数据库连接池相关配置，为一个对象；
    ```

    - `maxConnections`：最大连接数，默认为 `10`；
    - `minConnections`：最小连接数，默认为 `0`；
    - `maxIdleTime`：单条链接最大空闲时间，默认为 `30000` 毫秒；

  - `storege`：仅对 SQLite 配置有效，数据库地址，默认为 `~/.cnpmjs/data.sqlite`；

- `nfs`：包文件系统处理对象，为一个 Node.js 对象，默认是 [fs-cnpm](https://www.v2ex.com/t/292046) 这个包，并且配置在 `~/.cnpmjs/nfs` 目录下，也就是说默认所有同步的包都会被放在这个目录下；开发者可以使用别的一些文件系统插件（如上传到又拍云等）,又或者自己去按接口开发一个逻辑层，这些都是后话了；

- `registryHost`：暂时还未试过，我猜是用于 Web 页面显示用的，默认为 `r.cnpmjs.org`；

- ```
  enablePrivate：是否开启私有模式，默认为false；
  ```

  - 如果是私有模式则只有管理员能发布包，其它人只能从源站同步包；
  - 如果是非私有模式则所有登录用户都能发布包；

- `scopes`：非管理员发布包的时候只能用以 `scopes` 里面列举的命名空间为前缀来发布，如果没设置则无法发布，也就是说这是一个必填项，默认为 `[ '@cnpm', '@cnpmtest', '@cnpm-test' ]`，据苏千大大解释是为了便于管理以及让公司的员工自觉按需发布；更多关于 NPM scope 的说明请参见 [npm-scope](https://docs.npmjs.com/misc/scope)；

- `privatePackages`：就如该配置项的注释所述，出于历史包袱的原因，有些已经存在的私有包（可能之前是用 Git 的方式安装的）并没有以命名空间的形式来命名，而这种包本来是无法上传到 CNPM 的，这个配置项数组就是用来加这些例外白名单的，默认为一个空数组；

- `sourceNpmRegistry`：更新源 NPM 的 registry 地址，默认为 `https://registry.npm.taobao.org`；

- `sourceNpmRegistryIsCNpm`：源 registry 是否为 CNPM ，默认为 `true`，如果你使用的源是官方 NPM 源，请将其设为 `false`；

- `syncByInstall`：如果安装包的时候发现包不存在，则尝试从更新源同步，默认为 `true`；

- ```
  syncModel：更新模式（不过我觉得是个typo），有下面几种模式可以选择，默认为"none";
  ```

  - `"none"`：永不同步，只管理私有用户上传的包，其它源包会直接从源站获取；
  - `"exist"`：定时同步已经存在于数据库的包；
  - `"all"`：定时同步所有源站的包；

- `syncInterval`：同步间隔，默认为 `"10m"` 即十分钟；

- `syncDevDependencies`：是否同步每个包里面的 `devDependencies` 包们，默认为 `false`；

- `badgeSubject`：包的 **badge** 显示的名字，默认为 `cnpm`；

- `userService`：用户验证接口，默认为 `null`，即无用户相关功能也就是无法有用户去上传包，该部分需要自己实现接口功能并配置，如与公司的 **Gitlab** 相对接，这也是后话了；

- `alwaysAuth`：是否始终需要用户验证，即便是 `$ cnpm install` 等命令；

- `httpProxy`：代理地址设置，用于你在墙内源站在墙外的情况。