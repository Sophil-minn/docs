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
