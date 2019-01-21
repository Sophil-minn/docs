


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