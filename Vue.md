# Vue Demo

> 尽可能地梳理 Vue 项目开发时的知识点

## 项目命令行

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report

# run unit tests
npm run unit

# run e2e tests
npm run e2e

# run all tests
npm test
```

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).

### 项目结构

```
├── build --------------------------------- webpack相关配置文件
│   ├── build.js --------------------------webpack打包配置文件
│   ├── check-versions.js ------------------------------ 检查npm,nodejs版本
│   ├── dev-client.js ---------------------------------- 设置环境
│   ├── dev-server.js ---------------------------------- 创建express服务器，配置中间件，启动可热重载的服务器，用于开发项目
│   ├── utils.js --------------------------------------- 配置资源路径，配置css加载器
│   ├── vue-loader.conf.js ----------------------------- 配置css加载器等
│   ├── webpack.base.conf.js --------------------------- webpack基本配置
│   ├── webpack.dev.conf.js ---------------------------- 用于开发的webpack设置
│   ├── webpack.prod.conf.js --------------------------- 用于打包的webpack设置
├── config ---------------------------------- 配置文件
├── node_modules ---------------------------- 存放依赖的目录
├── src ------------------------------------- 源码
│   ├── assets ------------------------------ 静态文件
│   ├── components -------------------------- 组件 
│   ├── main.js ----------------------------- 主js
│   ├── App.vue ----------------------------- 项目入口组件
│   ├── router ------------------------------ 路由
├── package.json ---------------------------- node配置文件
├── .babelrc--------------------------------- babel配置文件
├── .editorconfig---------------------------- 编辑器配置
├── .gitignore------------------------------- 配置git可忽略的文件
```



### Eslint 代码质量检测

[规则说明](http://blog.csdn.net/helpzp2008/article/details/51507428)

```
需要安装 eslint 或者其它， 如 babel-eslint
配置文件 .eslintrc.js
忽略配置文件 .eslintignore.js
```





$route  route object



Eslint 规则说明


配置 path 的时候，以 " / " 开头的嵌套路径会被当作根路径，所以子路由的 path 不需要添加 " / "

路由是可以嵌套的，也就是 路由中 的 children 参数， 但要注意的是，嵌套的路由的 页面组件也 是要 同时嵌套，，比如， 子路由的组件 必须在 父组件 中渲染

这种只需要跳转页面，不需要添加验证方法的情况，可以使用 <router-link> 来实现导航的功能


要注意：
$route 与 $router 两个变量的使用区别


父组件向子组件传递数据

在 Vue 中，可以使用 props 向子组件传递数据。在 props 中添加了元素之后，就不需要在 data 中再添加变量了


子组件 向 父组件 传递数据 

this.$emit('props_event目标函数名', 参数);

组件的通讯，基本最常用的是这三种;

父传子: props
子传父: emit
兄弟通讯:
event bus: 就是找一个中间组件来作为信息传递中介
vuex: 信息树


组件可以缓存么?
可以,用keep-alive;

不过是有代码的..占有内存会多了...所以无脑的缓存所有组件!!!别说性能好了..切换几次,
有些硬件 hold不住的,浏览器直接崩溃或者卡死..

所以keep-alive一般缓存都是一些列表页,不会有太多的操作,更多的只是结果集的更换..

给路由的组件meta增加一个标志位,结合v-if就可以按需加上缓存了!

汇总 Vue 中大家最爱问的高频问题
http://blog.csdn.net/csdn_yudong/article/details/78866631

data functions should return an object??

data 1、写法不错 2、data必须得写


[vuex里面有什么？](https://www.cnblogs.com/xiaohuochai/p/7554127.html)

应用级的状态集中放在store中； 
改变状态的方式是提交mutations，这是个同步的事物； 
异步逻辑应该封装在action中

//=========
创建 state actions mutations getters
getters(): 是store的计算属性,getters接收state作为第一个参数
actions: 提交mutation,可以包含任意异步操作,不能直接修改state
mutations: action支持异步操作(setTimeout)，mutation必须是同步函数
更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
Action 提交的是 mutation，Action 通过 store.dispatch 方法触发


mapMutations
mapActions
mapGetters
mapState
把store传递给根组件，让所有子组件都能获取到。子组件通过this.$store访问

export default new Vuex.Store({
	state,
	mutations,
	actions,
	getters
})

===== store 可以分模块
store.state.a// -> moduleA 的状态

const store=new Vuex.Store({
   modules:{
	   	// store.state.a// -> moduleA 的状态
		a:modulesA,
		// store.state.b// -> moduleB 的状态
		b:modulesB
   }
})

```
<!-- 字符串 -->
<router-link to="home">Home</router-link>
<!-- 渲染结果 -->
<a href="home">Home</a>

<!-- 使用 v-bind 的 JS 表达式 -->
<router-link v-bind:to="'home'">Home</router-link>

<!-- 不写 v-bind 也可以，就像绑定别的属性一样 -->
<router-link :to="'home'">Home</router-link>

<!-- 同上 -->
<router-link :to="{ path: 'home' }">Home</router-link>

<!-- 命名的路由 -->
<router-link :to="{ name: 'user', params: { userId: 123 }}">User</router-link>

<!-- 带查询参数，下面的结果为 /register?plan=private -->
<router-link :to="{ path: 'register', query: { plan: 'private' }}">Register</router-link>
```


六、路由信息对象
1.$route.path
字符串，对应当前路由的路径，总是解析为绝对路径，如 "/foo/bar"。
2.$route.params
一个 key/value 对象，包含了 动态片段 和 全匹配片段，如果没有路由参数，就是一个空对象。
3.$route.query
一个 key/value 对象，表示 URL 查询参数。例如，对于路径 /foo?user=1，则有 $route.query.user == 1，如果没有查询参数，则是个空对象。
4.$route.hash
当前路由的 hash 值 (不带 #) ，如果没有 hash 值，则为空字符串。
5.$route.fullPath
完成解析后的 URL，包含查询参数和 hash 的完整路径。
6.$route.matched
一个数组，包含当前路由的所有嵌套路径片段的 路由记录 。路由记录就是 routes 配置数组中的对象副本（还有在 children 数组）。

http://blog.csdn.net/hsany330/article/details/53411937



首先对于vue考察，我觉得题主你应该先问下面试者vue对于mvvm的一个实现，这是一个通透的理解，不仅能考察对vue的理解，还能了解到求职者在前端这一块整体的一个把关。其次，对于vue，你还能问下项目开发中经常出现的一些点，比如什么时候适合用methods，什么时候适合用computed，什么时候适合用watch。再比如钩子函数你怎么理解，事件修饰符等等。这些能考察到求职者对vue的基础的一些掌握。再稍微高级点的就是vue组件开发这一点了，如何合理的抽离出组件，各组件如何通信（父传子，子传父，同级组件），公用方法mixin处理，全局状态该如何存储（这又可以牵扯到vuex），如何自定义组件的指令，内置组件等等等等。然后你就可以问全家桶了。再高级点的就是vue-cli脚手架了，vue是如何通过使用webpack进行测试和生产环境进行一个构建处理的（这里题主你还能拉出grunt，gulp让求职者去分析一下三者）。最后你就可以闲聊一下了，比如问问求职者是不是研究过源码，vue是如何实现一些指令，对于指令解析，vue又是如何获取到指令的expression去做这么一个解析的（如果只说正则处理那就太不负责了，应该听到的是：解析具体expression的处理，比如test.xxx.a["asa"][test1[idx]]的一个处理对于解析的处理，给你两地址
parseText-https://github.com/vuejs/vue/blob/dev/dist/vue.js#L7948
parseModel-https://github.com/vuejs/vue/blob/dev/dist/vue.js#L5888对于mvvm的理解，也给你两

[合格前端系列第三弹-实现一个属于我们自己的简易MVVM库 - 知乎专栏](https://zhuanlan.zhihu.com/p/27028242) [合格前端系列第四弹-如何监听一个数组的变化 - 知乎专栏](https://zhuanlan.zhihu.com/p/27166404)

github上找到的一个开源库：[点我访问github地址](https://link.zhihu.com/?target=https%3A//github.com/yoshuawuyts/virtual-html) 来生成虚拟DOMhttp://me.ivydom.com/archives/data-binding-events-binding.html



https://zhuanlan.zhihu.com/p/24475845?refer=mirone
1.Vue用“依赖收集”去描述应该更加准确

1. 对于node节点，是需要区分文本节点、注释节点和一般的节点的，不是每一个节点都有children的。。。
2. 很多地方都需要注意判空处理，比如observe方法的obj传入一个null进去
3. 用“：”作为分隔符也是挺新颖的


vue的组件之间是独立的，为了在组件之间传递数据，我们需要用到不同的手段。
父组件->子组件：props
子组件->父组件：触发事件

#### provide / inject 解决多层级组件通信的不足
```
1.provide就相当于加强版父组件prop

2.inject就相当于加强版子组件的props 

因为以上两者可以在父组件与子组件、孙子组件、曾孙子...组件数据交互，也就是说不仅限于prop的父子组件数据交互，只要在上一层级的声明的provide，那么下一层级无论多深都能够通过inject来访问到provide的数据

1.父级组件如下

<template>
	<div class="test">
		<son prop="data"></son>
	</div>
</template>
 
<script>
export default {
	name: 'Test',
	provide: {
		name: 'Garrett'
	}
}
 2.孙子组件，注意这里是孙子组件，父级 -> 子组件 -> 孙子组件三个层级关系

<template>
	<div>
		{{name}}
	</div>
</template>
 
<script>
export default {
	name: 'Grandson',
	inject: [name]
}
</script>
这里可以通过inject直接访问其两个层级上的数据，其用法与props完全相同，同样可以参数校验等

缺点
这么做也是有明显的缺点的，在任意层级都能访问导致数据追踪比较困难，不知道是哪一个层级声明了这个或者不知道哪一层级或若干个层级使用了，因此这个属性通常并不建议使用能用vuex的使用vuex，不能用的多传参几层，但是在做组件库开发时，不对vuex进行依赖，且不知道用户使用环境的情况下可以很好的使用
```

#### 
```
1.删除数组索引

//在数组中删除一项标准做法是用 <br>Array.splice(index,1)
del( index ) { this.arr.splice(index,1)  }
//Vue.js2.2.0+版本中 可以直接使用Vue.delete
del ( index ) { this.$delete ( this.arr , index ) }
demo:

https://ccforward.github.io/demos/vue-tips/delete.html

2.选中input框中文字

调用select()方法即可

<input @focus="$event.target.select()">
组件中调用就需要加上native属性

<component @focus.native="$event.target.select()"></component>
demo:https://ccforward.github.io/demos/vue-tips/select.html

3.私有属性

data: {
  name: 'name',
  _name: 'name'
},
mounted() {
    console.log(this.name);     //name
    console.log(this._name);        //undefined
}
以_或者$开头的属性只能Vue自身使用

demo https://codepen.io/ccforward/pen/BZqrNj

4.debounce延迟计算watch属性

debounce去抖 尤其适合在输入这种高频的操作中实时计算属性值

text: _.debounce(function () {
    this.inputing = false
  }, 1000)

5.
 watch 可监视变量 和 函数、 $route

 method
 watch:{
	'fristName':{},
	 'fun_method':{
		 handler(val, oldVal){},
		 immediate: true,
		 deep: true
	 },
	 'route'(to, from) {}
 }

 6. 不用箭头的函数类型
 生命周期、method 函数、计算属性函数、watcher 函数、data 属性函数

```