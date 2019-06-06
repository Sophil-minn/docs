


#### [基本配置](https://www.cnblogs.com/Leo_wl/p/8033738.html)
```
modules.export={
    entry:{
        /* 入口文件 */
    },
    output:{
        /* 出口文件 */
    },
    module:{
        /* Loader */
        rules:[{},{},{}]
    },
    plugins:[ 
        /* 插件 */ 
    ],
    devtool: ...
    devServer: {...}
    resolve:{...}
}
```

#### 常用插件
```
1、clean-webpack-plugin
主要用于 打包之前 先清空 打包目录下的文件，防止文件混乱。

2、html-webpack-plugin
主要用于生成HTML，可以规定 模板HTML，也可以为 模板传入参数，压缩文件等

3、open-browser-webpack-plugin
打开服务器后 会自动打开浏览器端口，用起来 很方便

4、HotModuleReplacementPlugin
热更新插件

5、CommonsChunkPlugin（webpack.optimize.CommonsChunkPlugin）
webpack自带，删除代码分离不同js中的重复模块

6、DefinePlugin（webpack.DefinePlugin）
webpack自带，设置环境变量

7、webpack-manifest-plugin

8、webpack.HotModuleReplacementPlugin
webpack自带，热替换插件

9、webpack.optimize.UglifyJsPlugin
webpack自带，运行 UglifyJS 来压缩输出文件
```


#### WebPack 进阶
```
1、控制 代码分割（利用webpack的api去帮我们完成异步加载）
require.ensure([其他依赖模块], function() {
    // 把baidumap.js分割出去，形成一个 webpack 打包的单独js文件
    var baidumap = require('./baidumap.js')

})
```


### eg.
```
var path = require('path')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var webpack = require('webpack')

module.exports = {

	entry: {
	 	index: ['./src/js/entry.js'],   //配置两个入口
		index2: ['./src/js/entry2.js']
	},
	output: {
		path: path.resolve(__dirname, './dist/static'),
		publicPath: 'static/',
		filename: '[name].[chunkhash].js'
	},
	resolve: {
		extensions: ['', '.js', '.less', '.swig', '.html']
	},
	module: {
		loaders: [
			{
				test: /\.css$/,
				// loader: 'style!css'
				loader: ExtractTextPlugin.extract('style-loader', ['css-loader'])
			},
			{
				test: /\.less$/,
				// loader: 'style!css!less'
				loader: ExtractTextPlugin.extract('style-loader', ['css-loader', 'less-loader'])
			},
			{
				test: /\.swig/,
				loader: 'swig'
			}
		]
	},
	plugins: [
		new ExtractTextPlugin('[name].[chunkhash].css'),

		new webpack.optimize.CommonsChunkPlugin('common.js'), 
		//提取所有入口的公共资源,
		//新的定义为common.js入口
		/**
		 * 把chunks入口文件的资源导出到html中
		 * 资源可能是 css 或者 js等
		 * css的话 使用配合ExtractTextPlugin使用
		 */
		new HtmlWebpackPlugin({
			chunks: ['index', 'index2', 'common.js'], 
			//放入口文件的key即可 因为每个key对应一个输出对象js
			// 这样配置话，会把index index2连个入口的输出js css都打包进html
			// 再提醒一下 每个入口对应的 js css都会插入进html哦
			// 必须还加入入口公共入口的部分 common 它会自动把它对应的 js css加入html
			filename: '../index.html',  //这个路径是相对于path
			template: './src/tpl/index.html',
			inject: true
		})
	]
}
```

## loader 与 plugin区别
loader 文件加载器, 它主要关注转化文件;是一个函数,返回值为字符串
```
module.exports = function(content) {
  this.cacheable && this.cacheable();
  this.value = content;
  return "module.exports = " + JSON.stringify(content);
}
```
plugin 插件, 功能 更加丰富, 不仅局限于资源加载, 也可在处理工程处理中的各个生命周期中的数据流进行处理; 插件是一个拥有 apply 属性的 JS 对象.

## webpack 优化
- 提高编译速度
	增量编译
	加缓存
	-	webpack 全局缓存
	-	loader 缓存
	-	模块缓存
	- 任务并行
- 减小编译输出的文件体积

- 帮助提升页面性能
	- 使用HTTP缓存
	- 预加载
	- 按需加载
	- 首屏CSS内嵌
	- DNS预拉取

1. 优化构建速度 : 线程happypack , 缓存 cache
1. 优化配置
1. 打包时间优化
1. 优化开发体验


### webpack 中比较核心的两个对象
- Compile 对象：负责文件监听和启动编译。Compiler 实例中包含了完整的 webpack 配置，全局只有一个 Compiler 实例。
- compilation 对象：当 webpack 以开发模式运行时，每当检测到文件变化，一次新的 Compilation 将被创建。一个 Compilation 对象包含了当前的模块资源、编译生成资源、变化的文件等。Compilation 对象也提供了很多事件回调供插件做扩展。
```js

const {
	Tapable,
	SyncHook,
	SyncBailHook,
	AsyncParallelHook,
	AsyncSeriesHook
} = require("tapable");

class Compiler extends Tapable {
	constructor(context) {
		super();
		this.hooks = {
		/** @type {SyncBailHook<Compilation>} */
		//所有需要输出的文件已经生成好，询问插件哪些文件需要输出，哪些不需要。
		shouldEmit: new SyncBailHook(["compilation"]),
		/** @type {AsyncSeriesHook<Stats>} */
		//成功完成一次完成的编译和输出流程。
		done: new AsyncSeriesHook(["stats"]),
		/** @type {AsyncSeriesHook<>} */
		additionalPass: new AsyncSeriesHook([]),
		/** @type {AsyncSeriesHook<Compiler>} */
		beforeRun: new AsyncSeriesHook(["compiler"]),
		/** @type {AsyncSeriesHook<Compiler>} */
		//启动一次新的编译
		run: new AsyncSeriesHook(["compiler"]),
		/** @type {AsyncSeriesHook<Compilation>} */
		// 确定好要输出哪些文件后，执行文件输出，可以在这里获取和修改输出内容。
		emit: new AsyncSeriesHook(["compilation"]),
		/** @type {AsyncSeriesHook<Compilation>} */
		// 输出完毕
		afterEmit: new AsyncSeriesHook(["compilation"]),
									// 以上几个事件(除了run，beforerun为编译阶段)其余为输出阶段的事件
		/** @type {SyncHook<Compilation, CompilationParams>} */
		// compilation 创建之前挂载插件的过程
		thisCompilation: new SyncHook(["compilation", "params"]),
		/** @type {SyncHook<Compilation, CompilationParams>} */
		// 创建compilation对象
		compilation: new SyncHook(["compilation", "params"]),
		/** @type {SyncHook<NormalModuleFactory>} */
		// 初始化阶段：初始化compilation参数
		normalModuleFactory: new SyncHook(["normalModuleFactory"]),
		/** @type {SyncHook<ContextModuleFactory>}  */
		// 初始化阶段：初始化compilation参数
		contextModuleFactory: new SyncHook(["contextModulefactory"]),

		/** @type {AsyncSeriesHook<CompilationParams>} */
		beforeCompile: new AsyncSeriesHook(["params"]),
		/** @type {SyncHook<CompilationParams>} */
		// 该事件是为了告诉插件一次新的编译将要启动，同时会给插件带上 compiler 对象
		compile: new SyncHook(["params"]),
		/** @type {AsyncParallelHook<Compilation>} */
		//一个新的 Compilation 创建完毕，即将从 Entry 开始读取文件，根据文件类型和配置的 Loader 对文件进行编译，编译完后再找出该文件依赖的文件，递归的编译和解析。
		make: new AsyncParallelHook(["compilation"]),
		/** @type {AsyncSeriesHook<Compilation>} */
		// 一次Compilation执行完成
		afterCompile: new AsyncSeriesHook(["compilation"]),

		/** @type {AsyncSeriesHook<Compiler>} */
		//监听模式下启动编译（常用于开发阶段）
		watchRun: new AsyncSeriesHook(["compiler"]),
		/** @type {SyncHook<Error>} */
		failed: new SyncHook(["error"]),
		/** @type {SyncHook<string, string>} */
		invalid: new SyncHook(["filename", "changeTime"]),
		/** @type {SyncHook} */
		// 如名字所述
		watchClose: new SyncHook([]),

		// TODO the following hooks are weirdly located here
		// TODO move them for webpack 5
		/** @type {SyncHook} */
		//初始化阶段：开始应用 Node.js 风格的文件系统到compiler 对象，以方便后续的文件寻找和读取。
		environment: new SyncHook([]),
		/** @type {SyncHook} */
		// 参照上文
		afterEnvironment: new SyncHook([]),
		/** @type {SyncHook<Compiler>} */
		// 调用完内置插件以及配置引入插件的apply方法，完成了事件订阅
		afterPlugins: new SyncHook(["compiler"]),
		/** @type {SyncHook<Compiler>} */
		afterResolvers: new SyncHook(["compiler"]),
		/** @type {SyncBailHook<string, EntryOptions>} */
		// 读取配置的 Entrys，为每个 Entry 实例化一个对应的 EntryPlugin，为后面该 Entry 的递归解析工作做准备。
		entryOption: new SyncBailHook(["context", "entry"])
};
```