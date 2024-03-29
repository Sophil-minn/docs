[推荐一些常用的 NPM 包](https://github.com/txd-team/awesome-npm)

vinyl-fs: sp
rimraf : rm -rf
chokidar : watch file
chalk: node color lib
through2: transform stream
update-notifier:
atool-monitor:
parse-json-pretty
strip-json-comments
af-webpack
debug
graceful-process
prettier
用husky 和 lint-staged 构建超溜的代码检查工作流
Got is for Node.js. For browsers, we recommend Ky.


rollup:
1. 能组合我们的脚本文件。
2. 移除未使用的代码(仅仅使用ES6语法中)。
3. 在浏览器中支持使用 Node modules。
4. 压缩文件代码使文件大小尽可能最小化。
[Babel doc](https://babeljs.io/docs/en/)
[Babel 用户手册](https://blog.csdn.net/sinat_34056695/article/details/74452558)

- Babel 能够让你提前（甚至数年）使用 JavaScript 新的特性。

Babel-types: Babel Types 是一个为 AST 节点提供的 lodash 类的实用程序库
Babel-register: require 钩子会将自己绑定到 node 的require 上并且能自动即时编译
Babel-template: 从一个字符串模板中生成 AST
Babel-helpers: Babel 转换的帮助函数集合
Babel-code-frame: 生成指向源位置包含代码帧的错误
Babylon: Babylon 是一个用于 Babel 的 JavaScript 解析器
babel-core:以编程的方式来使用 Babel，如果某些代码需要调用Babel的API进行转码
babel-polyfill:转换新的API，比如Iterator、Generator、Set、Maps、Proxy、Reflect、Symbol、Promise等
babel-runtime:作用也是模拟 ES2015 环境.只不过，babel-polyfill 是针对全局环境的引入它的，babel-runtime 更像是分散的 polyfill 模块，我们可以在自己的模块里单独引入，比如 require(‘babel-runtime/core-js/promise’) ，它们不会在全局环境添加未实现的方法，，只是，这样手动引用每个 polyfill 会非常低效。我们借助 Runtime transform 插件来自动化处理这一切。
npm install --save-dev babel-plugin-transform-runtime    
npm install --save babel-runtime;

#### readline
```
ctrl-c 发送 SIGINT 信号给前台进程组中的所有进程。常用于终止正在运行的程序。 
ctrl-z 发送 SIGTSTP 信号给前台进程组中的所有进程，常用于挂起一个进程。 
ctrl-d 不是发送信号，而是表示一个特殊的二进制值，表示 EOF。 
ctrl-\ 发送 SIGQUIT 信号给前台进程组中的所有进程，终止前台进程并生成 core 文件。 
kill -SIGCONT PID 发送 SIGCONT信号，让一个停止(stopped)的进程继续执行.
```

### nodejs 搜索路径修改 - 重写源码
- 每个js 文件为一个 module 实例，拥有自己独立的 module.paths 搜索路径 数组
- 修改某 module.paths 只影响此 module 的搜索路径 (module.paths.push(url))
- 所以，如果想实现全局修改 整个应用的 的搜索路径，可以重写 Module._initPath 方法 （npm 包：app-module-path 实现这种方法）
```
// 初始化全局的依赖加载路径
Module._initPaths = function() {
  ...
  var paths = [path.resolve(process.execPath, '..', '..', 'lib', 'node')];

  if (homeDir) {
    paths.unshift(path.resolve(homeDir, '.node_libraries'));
    paths.unshift(path.resolve(homeDir, '.node_modules'));
  }

  // 我们需要着重关注此处，获取环境变量“NODE_PATH”
  var nodePath = process.env['NODE_PATH'];
  if (nodePath) {
    paths = nodePath.split(path.delimiter).concat(paths);
  }

  // modulePaths记录了全局加载依赖的根目录，在Module._resolveLookupPaths中有使用
  modulePaths = paths;

  // clone as a read-only copy, for introspection.
  Module.globalPaths = modulePaths.slice(0);
};

// @params: request为加载的模块名 
// @params: parent为当前模块（即加载依赖的模块）
Module._resolveLookupPaths = function(request, parent) {
  ...
 
  var start = request.substring(0, 2);
  // 若为引用模块名的方式，即require('gulp')
  if (start !== './' && start !== '..') {
    // 此处的modulePaths即为Module._initPaths函数中赋值的变量
    var paths = modulePaths;
    if (parent) {
      if (!parent.paths) parent.paths = [];
      paths = parent.paths.concat(paths);
    }
    return [request, paths];
  }

  // 使用eval执行可执行字符串的情况下，parent.id 和parent.filename为空
  if (!parent || !parent.id || !parent.filename) {
    var mainPaths = ['.'].concat(modulePaths);
    mainPaths = Module._nodeModulePaths('.').concat(mainPaths);
    return [request, mainPaths];
  }
  
  ...
};
```

#### 不使用require缓存
- 在监听个性文件时，如果要求，require(file) 为最新，刚要不使用 require缓存
```
delete require.cache[file]
```