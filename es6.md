知识回顾

JS知识点

函数表达式，函数声明，立即执行函数，变量提升，全局作用域，函数作用域，块级作用域

内层变量覆盖外层变量，循环变量泄露；；

顶级对象（global-node, self-webWork, window-browser）

闭包：有权访问另一函数作用域内变量的函数（1、是函数 2、此为函数内的函数，即内层函数）



### 域名IP与DNS

```
DNS 功能：
1、解析域名 ip 域名 一对多
	在DNS服务器中应该配置了多个A记录，如：
     www.a.com IN A 114.100.20.201;
     www.b.com IN A 114.100.20.201;
     www.c.com IN A 114.100.20.201;
2、负载均衡 ip 域名 多对一
	在DNS服务器中应该配置了多个A记录，如：
     www.a.com IN A 114.100.20.201;
     www.a.com IN A 114.100.20.202;
     www.a.com IN A 114.100.20.203;

```

[彻底理解浏览器缓存机制](https://www.cnblogs.com/shixiaomiao1122/p/7591556.html)

### Cookies

```
1、cookie默认的是临时存储的，当关闭整个浏览器后，cookie销毁；如果我们要cookie值长期存在，需要在设置cookie的时候需要设置一个过期的时间
2、服务器返回的 Cookies相关字段为： Set-Cookie
Set-Cookie: “name=value;domain=.domain.com;path=/;expires=Sat, 11 Jun 2016 11:29:42 GMT;HttpOnly;secure”
3、cookie 主要构成：

name:一个唯一确定的cookie名称。通常来讲cookie的名称是不区分大小写的。
value:存储在cookie中的字符串值。最好为cookie的name和value进行url编码
domain:cookie对于哪个域是有效的。所有向该域发送的请求中都会包含这个cookie信息。这个值可以包含子域(如：yq.aliyun.com)，也可以不包含它(如：.aliyun.com，则对于aliyun.com的所有子域都有效).
path: 表示这个cookie影响到的路径，浏览器跟会根据这项配置，像指定域中匹配的路径发送cookie。
expires:失效时间，表示cookie何时应该被删除的时间戳(也就是，何时应该停止向服务器发送这个cookie)。如果不设置这个时间戳，浏览器会在页面关闭时即将删除所有cookie；不过也可以自己设置删除时间。这个值是GMT时间格式，如果客户端和服务器端时间不一致，使用expires就会存在偏差。
max-age: 与expires作用相同，用来告诉浏览器此cookie多久过期（单位是秒），而不是一个固定的时间点。正常情况下，max-age的优先级高于expires。
HttpOnly: 告知浏览器不允许通过脚本document.cookie去更改这个值，同样这个值在document.cookie中也不可见。但在http请求张仍然会携带这个cookie。注意这个值虽然在脚本中不可获取，但仍然在浏览器安装目录中以文件形式存在。这项设置通常在服务器端设置。
secure: 安全标志，指定后，只有在使用SSL链接时候才能发送到服务器，如果是http链接则不会传递该信息。就算设置了secure 属性也并不代表他人不能看到你机器本地保存的 cookie 信息，所以不要把重要信息放cookie就对了
```

### 图片预览

```
1、FormData 先上传，再显示--用JQuery方式需要加两个参数 contentType: false 和processData: false，这两个参数是为了设置ajax对file文件对象进行序列化（async: false 同步设置）
2、对于 Chrome、Firefox、IE10 使用 FileReader 来实现
3、window.URL.createObjectURL 本地预览
4、对于 IE6~9 使用滤镜 filter:progid:DXImageTransform.Microsoft.AlphaImageLoader 来实现
 obj.select();  
 //ie9以上版本需加上blur  
 obj.blur();  
 var imgSrc = document.selection.createRange().text;  
 //图片异常的捕捉，防止用户修改后缀来伪造图片  
 try{
   img.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";  
   img.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;  
 }  
 catch(e)  
 {  
   alert("上传的图片格式不正确，请重新选择");  
   return false;  
 }  
 document.selection.empty();  
```


### [WEB安全](https://kb.cnblogs.com/page/564656/)

```
1、XSS(跨站脚本攻击)

2、CSRF(跨站点请求伪造)

3、Click.Jacking(点击劫持)

4、SQL注入

5、HTTP劫持



```





#### [SVG 操作库 raphael.js](https://github.com/DmitryBaranovskiy/raphael/)
#### [raphael.js 插件](http://www.internetke.com/jsEffects/2015011601/)


#### JS 安全（有无new的调用）的深度链式封装

```
var A = function(){
	return new A.fn.init();
}

A.fn = A.prototype = {
	constructor: A,

	init: function(){
		// return this;
		console.log("init",2, this);
		return this;
	}
}

A.fn.init.prototype = A.fn;


(new A()).init().init().init().init().init();
```

### JS设计模式

设计模式是啥，为啥用设计模式

比如，一般的操作：

```
无模式时-原始创建对象的方法：

var objA = {
  name:'a',
  getName: function(){ return this.name;}
}
var objB = {
  name: 'b',
  getName: function(){ return this.name;}
}

或者

var objA = new Object();
objA.name = 'a';
objA.getName = functon(){ return this.name;}

var objB = new Object();
objB.name = 'b';
objB.getName = functon(){ return this.name;}

简单小工厂封装-将原始方式封装到函数中：
// 同一类型对象可调用，不同类型的对象不能调用,且函数并未共享
function create( name ){
  var obj = new Object();
  
  obj.name = name;
  obj.getName = function(){ return this.name;}
}

// 简单小工厂升级版：-函数共享了,但这样组织不像是对象的方法，理解难度大
function getName(){ return this.name;}
function create(name){
  var obj = new Object();
  obj.name = name;
  obj.getName = getName;
}

// 大工厂
var factory = {
  create: function(model){
  	var ret;
  	switch(model){
  		case "":{};break;
  		case "":{};break;
  		...
	}
	return ret;
  }
}

构造函数模式
function Obj(name){
  this.name = name;
  this.getName = function(){ return this.name;}
}


如果有多个类型，需要创建多个实例，重复代码就会很多，所以为了进一步优化代码需要一定的代码组织模式，也就是所谓的代码设计模式::: 比如， name等属性放在构造函数模式中，getName等函数放在原型函数模式中
创建单一对象的设计模式：构造函数模式，原型模式（构造函数模式用来定义实例属性，原型模式用于定义方法和共享的属性）
创建多个对象的设计模式：工厂模式

组合模式：构造函数+原型函数

设计模式的根本原因是为了代码复用，增加可维护性。有如下原则：

【开闭原则】：对扩展开放，对修改关闭；
【里氏转换原则】：子类继承父类，单独调用完全可以运行；
【依赖倒转原则】：引用一个对象，如果这个对象有底层类型，直接引用底层；
【结构隔离原则】：每一个接口应该是一种角色；
【合成/聚合复用原则】：新对象应该使用一些已有的对象，使之成为新对象的一部分；
【迪米特原则】：一个对象应该对其它对象有尽可能少的了解；

单一职责原则告诉我们实现类要职责单一，
	一个类（大到模块，小到方法）不能太“累”！，承担的职责越多，它被复用的可能性就越小，而且一个类承担的职责过多，就相当于将这些职责耦合在一起，当其中一个职责变化时，可能会影响其他职责的运作，因此要将这些职责进行分离，将不同的职责封装在不同的类中，即将不同的变化原因封装在不同的类中，如果多个职责总是同时发生改变则可将它们封装在同一类中。

里氏替换原则告诉我们不要破坏继承关系：
  里氏替换原则为良好的继承定义了一个规范，主要有下面四个方面：
  子类必须完全实现父类的方法
  子类可以有自己的个性
  覆盖或实现父类的方法时输入参数可以被放大
  覆盖或实现父类的方法时输出结果可以被缩小


依赖倒置原则告诉我们要面向接口编程；
接口隔离原则告诉我们在设计接口的时候要精简单一；
迪米特法则告诉我们要降低耦合
开闭原则告诉我们要对扩展开发，对修改关闭；面向对象的可复用设计的第一块基石，它是最重要的面向对象设计原则

```



**设计模式涉及的问题：**

1、在何种情况使用哪种模式  2、我们要解决什么问题 3、各种模式解决什么问题 4、实现

**设计模式的分类：**

创建型设计模式（单函数封装）：构造器模式（Constructor）,原型模式 （Prototype）,单例模式 （Singleton）,工厂模式（Factory）,抽象工厂模式 （Abstract）以及 建造者模式（Builder）

   结构设计模式（多函数封装）：装饰模式，外观模式，享元模式，适配器模式和代理模式。

   行为设计模式（多函数封装）：迭代模式，中介者模式，观察者模式和访问者模式。



##### Module模式：

(function(){

// 在此声明私有变量或者函数

return {// 在此声明公共变量或者函数 

}

})();



**构造函数模式：**

function Animal(name){

​	this.name=name;

}

**原型函数模式：**

Animal.prototype.getInfo = function(){

}

**混合模式：**= 原型模式 + 构造函数模式

function Animal(){}

Animal.prototype.getInfo = function(){}

**单例模式：**

var Single = ({

​	var instance;

​	function init() {		

​		return null;

​	}

​	return {

​		getInstance: function(){

​			if(!instance){

​				instance = init();	

​			}

​			return instance;

​		}

​	}

})();

**工厂模式：**批量传参，返回对象（传入产品参数，生产产品）

function Animal(opts) {

​	var obj = new Object();

​	obj.name = opts.name;

​	return obj;

}

**发布订阅模式：**

var EventCenter = (function(){

​	var events = [];

​	return {

​		// subscribe 订阅事件

​		on: function(evt, handler){    	        

​			events[evt] = events[evt] || [];

  			events[evt].push({    handler:handler })

​	        },

​		// _publish 发布事件

​		fire: function(evt, arg){

​			if(!events[evt]) return;

​			for(var i=0; i<events[evt].length; i++) {

​				events[evt][i.handler(arg);

​			}

​		},

​		// unsubscribe 退订事件

​		off: function(evt){

​			delete events[evt];

​		}

​	};

})();

**监听(观察者)模式：**

```
var Subject = function() { // 观察者
  this.observers = [];
  
  return {
  	subscribeObserver: function(observer){
  		this.observers.push(observer);
	},
  	unsubscribeObserver: function(observer){},
  	notifyObserver: function(observer){
  		...
  		observer.nofity()
  		...
	},
  	notifyAllObserver: function(){}
  }
}
var Observer = function(){// 被观察者
  return {
  	notify:function(){
  	
	}
  }
}

// 
var subject = new Subject();
var ob1 = new Observer();  subject.subscribeObserver(ob1);
var ob2 = new observer();  subject.subscribeObserver(ob2);

subject.notifyObserver(ob1);
subject.nofityAllObserver();
```

**状态模式：**:避免使用大量if else

```
var Result = (function(){
	var States={
  		state0:function(){},
  		state1:function(){},
  		state2:function(){},
  		...
	}
    function show(ret){
  		var func = States['state'+ret];
        func && func();
	}
	
	return {
  		show: show
	}
})();
```

**策略模式：**

```
var PriceState = (function(){
  // 策略 内部算法
  var States = {
  	algo0: function(price){},
  	algo1: function(price){},
  	algo2: function(price){},
  	...
  };
  
  return function(algorithm, price){
  	var func = States[algorithm];
  	return func && func(price);
  }
})();
```

**建造者模式（有步骤性，需要组装步骤）：**

### 响应式：

http://blog.csdn.net/sunshine940326/article/details/54139592

1、百分比布局

2、固定设备宽度 

3、rem布局

​	统一的 viewport

```
<meta name="viewport" content="initial-scale=1,maximum-scale=1, minimum-scale=1">
```



​	统一的 fontsize 算法（根据deviceWidth设置字体大小）:

```
(function () {
   document.addEventListener('DOMContentLoaded', function () {
var deviceWidth = document.documentElement.clientWidth;
document.documentElement.style.fontSize = deviceWidth / 10 + 'px';
   }, false);
window.onresize = function(){
var deviceWidth = document.documentElement.clientWidth;
document.documentElement.style.fontSize = deviceWidth / 10 + 'px';
};
})();
```

​	统一的设计稿尺寸要求 

```

@function px2rem($x) {
  @return $x / 108 * 1rem; //如按1080px 的设计稿，统一宽度10rem;
}
```

无响应式的网站

- [淘宝网](https://www.taobao.com/)
- [京东网](http://www.jd.com/)
- [腾讯课堂](http://zx.ke.qq.com/)
- [百度传课](http://www.chuanke.com/s3885380.html)

响应式网站

- [知创科技的官网](http://www.0755zcit.com/)
- [bootstrap官网](http://getbootstrap.com/)
- [36氪](https://36kr.com/)
- [阿里Web App开发框架 SUI](http://sui.taobao.org/sui/docs/index.html)

Web App网站

- [  联想手机官网](http://m.lenovo.com.cn/)
- [  小米商城](http://m.mi.com/)
- [  一元云购](http://weixin.1yyg.com/)
- [  京东手机网](http://m.jd.com/)


### Mysql

**1，在大型系统中（性能要求不高，安全要求高, 且可以利用外键检测数据还能减少程序开发量InnoDB类型），使用外键；在大型系统中（性能要求高，安全自己控制，对数据并不是非常严格，选择MyISAM类型），不用外键；小系统随便，最好用外键。**

**2，用外键要适当，不能过分追求**

**3，不用外键而用程序控制数据一致性和完整性时，应该写一层来保证，然后个个应用通过这个层来访问数据库（外键会使表之间耦合太大且容易造成死锁）。**

**4、当然也要看你的系统，如银行系统等需要很高的安全性和可靠性还是建议使用外键；但是大部分web项目都是追求体验、性能，还是不建议使用；**




### ES6：ES6模块默认使用严格模式，无论是否声明“use strict”

let const 替换 var

块级作用域：函数内部、代码块内部（如{ }）-------es5中js没有块级作用域，只有函数作用域

没有声明提前



解构、解构赋值：[a, b]=[1, [2]]

扩展参数：[a, ...b] = [1, 2, 3]

扩展对象：键值值重名{name: name, age: age} 或 {name, age}

函数：(x=54)=>{return x+1;} 或 x=> x+1

1、默认参数 

2、箭头函数 （仅有一个参数时可以省略括号）--this自动绑定，可省略return

import 和 export：export default 有且仅一个，export 可多个

Promise(Async/await)、Generators

| 加载方式  |      规范      |   命令    |
| :---: | :----------: | :-----: |
| 运行时加载 | CommonJS/AMD | require |
| 编译时加载 | ESMAScript6+ | import  |

1. async 表示`这是一个async函数`，`await只能用在这个函数里面`。
2. await 表示在这里`等待promise返回结果`了，再继续执行。
3. await 后面跟着的`应该是一个promise对象`（当然，其他返回值也没关系，只是会立即执行，不过那样就没有意义了…）


### Promise方法 -**多个异步请求**处理：

then: 链式执行回调函数

reject: 设置promise状态为已失败，并执行catch失败回调

resolve: 设置promise 状态为成功， 并执行then 成功回调

catch:  指定reject 回调



ES6 添加了两个好东西  Set 和 Array.from 。Set会自动去重后返回一个Set对象，而Array.from 把类数组/可迭代等对象 转化为 数组： Array.from(new Set(arr));




### use strict  检查作用

作用：es6的过渡，在es5下为javascript的运行使用添加更多的约束，让代码在更严格的模式下运行，向更合理、更安全、更严谨的发展方向

重复性检查，未声明定义性，限制性，禁止this指全局，新增关键字

1、函数中重复参数

2、对象中重复键

3、重复声明或定义的变量、函数、对象

3、未声明或未定义的变量、函数、对象

5、限制函数中的arguments修改（修改时不报错提醒，但修改不成功）

6、限制使用八进制（使用时报错）

7、限制使用转义字符（使用时报错）

8、限制修改只读或getter属性（修改时报错）

9、默认限制删除任何变量，要删除时设置configurable为true（删除时报错）

10、限制eval、arguments被重写（重写时报错）

11、限制使用 with 关键字

12、禁止this关键字指向全局对象

13、新增了一些关键字，不能被覆盖重写：

- implements
- interface
- let
- package
- private
- protected
- public
- static
- yield


#### 如何描述 双向绑定
```
双向：数据层（Model) + 视图层（View）
绑定：数据 与 视图层 映射
完成步骤：
1、数据变化监听
2、变化数据 更新 到 视图层
3、视图变化监听
4、变化的视图 更新 到 数据层

实现：
逻辑都是通过 js 做人，所以，数据层 / （Virtual DOM）视图层 都要在 js 中完成 构建 模拟

1、构建 两颗树：model\view
```


数据绑定

在react中是单向数据绑定，而在vue和augular中的特色是双向数据绑定

双向绑定 = 单向绑定 + UI事件监听

单向数据绑定的实现思路：

1. 所有数据只有一份
2. 一旦数据变化，就去更新页面(data-页面)，但是没有(页面-data)
3. 如果用户在页面上做了变动，那么就手动收集起来(双向是自动)，合并到原有的数据中。

对于数据双向绑定，我们需要考虑的问题如下：

- 如何监听页面View的变化？数据劫持
- 如何将View的变化更新到Model？
- 如何监听Model的变化？数据劫持
- 如何将Model的更新到View？


### 通过【数据劫持】实现 双向数据绑定不同

```
Angularjs 双向绑定  - markForCheck：
AngularJS 采用“脏值检测”的方式，数据发生变更后，对于所有的数据和视图的绑定关系进行一次检测，识别是否有数据发生了改变，有
变化进行处理，可能进一步引发其他数据的改变，所以这个过程可能会循环几次，一直到不再有数据变化发生后，将变更的数据发送到视图，更新页面展现。
如果是手动对 ViewModel 的数据进行变更，为确保变更同步到视图，需要手动触发一次“脏值检测”。

React 双向绑定 - setState:


Vue 双向绑定 - property setter 数据劫持+发布订阅者模：
VueJS 则使用 ES5 提供的 Object.defineProperty() 方法，监控对数据的操作，从而可以自动触发数据同步。并且，由于是在不同的数据上触发同步，
可以精确的将变更发送给绑定的视图，而不是对所有的数据都执行一次检测。
Vue v2.5.2 最新版中已经不再使用`MuationObserver`了，而改用MessageChannel 监听DOM结构变化
```

### 监听 JS 中变量变化实现方式

```
1、angular使用的就是脏值检测，原理是比较新值和旧值


2、ES5的getter与setter 观察者模式
在ES5中新增了一个Object.defineProperty，直接在一个对象上定义一个新属性，或者修改一个已经存在的属性， 并返回这个对象。

var a = { zhihu:0 };

Object.defineProperty(a, 'zhihu', {
  get: function() {
    console.log('get：' + zhihu);
    return zhihu;
  },
  set: function(value) {
    zhihu = value;
    console.log('set:' + zhihu);
  }
});


3、ES5的getter与setter 修改数组的length，直接用索引设置元素如items[0] = {}，以及数组的push等变异方法是无法触发setter的。

Vue直接修改了数组的原型方法：const arrayProto = Array.prototype
export const arrayMethods = Object.create(arrayProto)

/**
 * Intercept mutating methods and emit events
 */

;[
  'push',
  'pop',
  'shift',
  'unshift',
  'splice',
  'sort',
  'reverse'
]
.forEach(function (method) {
  // cache original method
  var original = arrayProto[method]
  def(arrayMethods, method, function mutator () {
    // avoid leaking arguments:
    // http://jsperf.com/closure-with-arguments
    var i = arguments.length
    var args = new Array(i)
    while (i--) {
      args[i] = arguments[i]
    }
    var result = original.apply(this, args)
    var ob = this.__ob__
    var inserted
    switch (method) {
      case 'push':
        inserted = args
        break
      case 'unshift':
        inserted = args
        break
      case 'splice':
        inserted = args.slice(2)
        break
    }
    if (inserted) ob.observeArray(inserted)
    // notify change
    ob.dep.notify()
    return result
  })
})
这样重写了原型方法，在执行数组变异方法后依然能够触发视图的更新。

4、Vue 修改数据值时，可使用

// Vue.set
Vue.set(example1.items, indexOfItem, newValue)
// Array.prototype.splice`
example1.items.splice(indexOfItem, 1, newValue)


```

3 Virtual DOM 算法
4 算法实现
4.1 步骤一：用JS对象模拟DOM树：记录它的节点类型、属性，还有子节点
4.2 步骤二：比较两棵虚拟DOM树的patch(差异化结果)-统计比较（复杂度降为On）：算法最核心
4.3 步骤三：把patch(差异化结果)应用到真正的DOM树上

避免了整棵 DOM 树变更

维护状态，更新视图局部

Virtual DOM 本质上就是在 JS 和 DOM 之间做了一个缓存。既然 DOM 这么慢，我们就在它们 JS 和 DOM 之间加个缓存。JS只操作Virtual DOM，最后的时候再把变更写入DOM。

回到为什么Virtual Dom快这个问题上。
其实是由于每次生成virtual dom很快，diff生成patch也比较快，而在对DOM进行patch的时候，虽然DOM的变更比较慢，但是React能够根据Patch的内容，优化一部分DOM操作，比如之前的那个例子。

　　重点就在最后，哪怕是我生成了virtual dom(需要耗费时间)，哪怕是我跑了diff（还需要花时间），但是我根据patch简化了那些DOM操作省下来的时间依然很可观（这个就是时间差的问题了，即节省下来的时间 > 生成 virtual dom的时间 + diff时间）。所以总体上来说，还是比较快。

　　
简单发散一下思路，如果哪一天，DOM本身的已经操作非常非常非常快了，并且我们手动对于DOM的操作都是精心设计优化过后的，那么加上了VirtualDom还会快吗？
当然不行了，毕竟你多做了这么多额外的工作。

但是那一天会来到吗？
诶，大不了到时候不用Virtual DOM。

**优点：** 
1.分离前后端关注点，前端负责view，后端负责model，各司其职； 
2.服务器只接口提供数据，不用展示逻辑和页面合成，提高性能； 
3.同一套后端程序代码，不用修改兼容Web界面、手机； 
4.用户体验好、快，内容的改变不需要重新加载整个页面 
5.可以缓存较多数据，减少服务器压力 
6.单页应用像网络一样，几乎随处可以访问—不像大多数的桌面应用，用户可以通过任务网络连接和适当的浏览器访问单页应用。如今，这一名单包括智能手机、平板电脑、电视、笔记本电脑和台式计算机。 

**缺点：** 
1.SEO问题没有html抓不到什么。。。 
2.刚开始的时候加载可能慢很多 
3.用户操作需要写逻辑，前进、后退等； 
4.页面复杂度提高很多，复杂逻辑难度成倍



优点：spa（单页面应用）
1、用户体验好、快，内容的改变不需要重新加载整个页面，避免了不必要的跳转和重复渲染。
2、基于上面一点，SPA相对对服务器压力小。

缺点：
1： seo 不利于搜索引擎优化
2： 初次加载页面更耗时
3：前进、后退、地址栏等，需要程序进行管理；
4、书签，需要程序来提供支持；

 显然，实现SPA的全部技术（PushState+ajax实现路由控制和视图转换框架）：  

       一是处理#后面的字符， 常说的URL 的锚部分
       二是局部刷新，AJAX 
       总共就两个技术，那我们就悠着来。 

#### 实现原理

1. SPA路由的实现方式有哪些？

　　目前来说，无论是vue，还是react，spa的路由实现方式无非就是以下两者：

- hash方式。 使用location.hash和hashchange事件实现路由。 
- history api。使用html5的history api实现，主要就是popState事件等。

2. 使用Ajax请求新页面。
3. 将返回的Html替换到页面中。
4. 使用HTML5的History API或者Url的Hash修改Url。

### 

### [单页应用 WebApp SPA 骨架 框架 路由 页面切换 转场](https://segmentfault.com/a/1190000004186135)

这里收录三个同类产品，找到他们花了我不少时间呢。

1. 张鑫旭写的`mobilebone`
   自述：mobile移动端，PC桌面端页面无刷新过场JS骨架，简单、专注！
   [http://www.zhangxinxu.com/wordpress/2014/10/mobilebone-js-mobile-web-app-core/](http://www.zhangxinxu.com/wordpress/2014/10/mobilebone-js-mobile-web-app-core/)
   [https://github.com/zhangxinxu/mobilebone/](https://github.com/zhangxinxu/mobilebone/)
2. 赵达写的`spa`
   自述：SPA是为构建WebApp设计的路由控制和视图转换框架
   [http://zhaoda.net/spa/docs/](http://zhaoda.net/spa/docs/)
   [https://github.com/zhaoda/spa/](https://github.com/zhaoda/spa/)
3. dolymood的`mobile-router`
   自述：轻量级web端单页面骨架
   [http://mrdocs.aijc.net/](http://mrdocs.aijc.net/)
   [https://github.com/mobile-router/mobile-router.js](https://github.com/mobile-router/mobile-router.js)

但是我还没决定用哪个，我再比较比较，或者看看还有没有别的


### JSON与XML

```
xml: 描述性多，体积大，传输速度慢，解析慢，交互繁琐
json:描述性差，体积小，传输速度快，解析快，交互方便
```



### WebPack 介绍

```
一款 模块 打包工具，管理分析 模块 依赖关系，编译输出 优化且合并的 静态文件，让开发高效。
特色：
1、code splitting
2、loader 
新特性：
1. 对 CommonJS 、 AMD 、ES6的语法做了兼容
2. 对js、css、图片等资源文件都支持打包
3. 串联式模块加载器以及插件机制，让其具有更好的灵活性和扩展性，例如提供对CoffeeScript、ES6的支持
4. 有独立的配置文件webpack.config.js
5. 可以将代码切割成不同的chunk，实现按需加载，降低了初始化时间
6. 支持 SourceUrls 和 SourceMaps，易于调试
7. 具有强大的Plugin接口，大多是内部插件，使用起来比较灵活
8. webpack 使用异步 IO 并具有多级缓存。这使得 webpack 很快且在增量编译上更加快
```

**webpack 打包后的文件**

```
立即执行函数，简化一下就是：
(function(module){})([function(){},function(){}]);
```

### defer / async

```
defer/async 都是异步的（相对于 HTML 解析，不会暂停DOM的解析），差别在于脚本下载完后何时执行
无defer/async: 加载时会立即加载并执行
defer 加载顺序执行
async 乱序执行，即加载完了就执行
浏览器支持：除了基于Webkit的新版本浏览器,FireFox已经支持defer和onload属性很长时间了，而且从FF3.6开始添加了async属性。IE同样支持defer属性,但还不支持async属性，从IE9开始，onload属性也将被支持。  
```

### javaScript中一些常见的兼容性问题整理

**1） 滚动条：**

document.documentElement.scrollTop||document.body.scrollTop

**2) 获取样式兼容**

function getStyle(dom, styleName){

  return dom.currentStyle?dom.currentStyle[styleName] ：getComputedStyle(dom)[styleName];

}

 document.body.offsetHeight  

**3-1)获得屏幕的分辨率：** 
screen.width 
screen.height 

**3-2)获得窗口大小：** 
document.body.clientWidth 
document.body.clientHeight 

**3-3)获得窗口大小（包含Border、Scroll等元素）** 
document.body.offsetWidth 

**3-4) 网页可视区域兼容**

window.innerHeight || document.documentElement.clientHeight

window.innerWidth || document.documentElement.clientWidth

**4） 事件对象兼容**

evt = evt || window.event;

**5） 阻止事件冒泡兼容**

event.stopPropagation?event.stopPropagation():event.cancelBubble=true;

**6）阻止默认行为兼容**

evt.preventDefault?evt.preventDefault():evt.returnValue=false;

**7）事件监听兼容**

if(document.all){

    dom.attactEvent(“onclick”, fn);

} else {

    dom.addEventListener(“click”, fn);

}

**8）事件目标对象兼容**

var t = event.target || event.srcElement;

**9）检测bar是否是对象的可靠方法**

(bar !== null) && (typeof bar === "object")



### px,em,rem
```
font-size: 16px
1 em = 16 px;
rem = root em
```

### webpack 与 gulp 区别

常有人拿gulp与webpack来比较，知道这两个构建工具功能上有重叠的地方，可单用，也可一起用，但本质的区别就没有那么清晰。

**gulp**

gulp强调的是前端开发的工作流程，我们可以通过配置一系列的task，定义task处理的事务（例如文件压缩合并、雪碧图、启动server、版本控制等），然后定义执行顺序，来让gulp执行这些task，从而构建项目的整个前端开发流程。

PS：简单说就一个Task Runner

**webpack**

webpack是一个前端模块化方案，更侧重模块打包，我们可以把开发中的所有资源（图片、js文件、css文件等）都看成模块，通过loader（加载器）和plugins（插件）对资源进行处理，打包成符合生产环境部署的前端资源。

PS：webpack is a module bundle

**相同功能**

gulp与webpack可以实现一些相同功能，如下（列举部分）：

| 功能                  | gulp                                                         | webpack                                                      |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 文件合并与压缩（css） | 使用gulp-minify-css模块gulp.task('sass',function(){     gulp.src(cssFiles)     .pipe(sass().on('error',sass.logError))     .pipe(require('gulp-minify-css')())     .pipe(gulp.dest(distFolder));}); | 样式合并一般用到extract-text-webpack-plugin插件，压缩则使用webpack.optimize.UglifyJsPlugin。 |
| 文件合并与压缩（js）  | 使用gulp-uglify和gulp-concat两个模块                         | js合并在模块化开始就已经做，压缩则使用webpack.optimize.UglifyJsPlugin |
| sass/less预编译       | 使用gulp-sass/gulp-less 模块                                 | sass-loader/less-loader 进行预处理                           |
| 启动server            | 使用gulp-webserver模块var webserver =require('gulp-webserver');gulp.task('webserver',function(){     gulp.src('./')     .pipe(webserver({          host:'localhost',          port:8080,          livereload:true, //自动刷新          directoryListing:{               enable: true,               path:'./'          },     }));}); | 使用webpack-dev-server模块module.exports = {     ......     devServer: {          contentBase: "build/",          port:8080,          inline: true //实时刷新     }} |
| 版本控制              | 使用gulp-rev和gulp-rev-collector两个模块                     | 将生成文件加上hash值module.exports = {     ......    output: {        ......        filename: "[name].[hash:8].js"    },     plugins:[          ......          new ExtractTextPlugin(style.[hash].css")     ]} |

**两者区别**

虽然都是前端自动化构建工具，但看他们的定位就知道不是对等的。

gulp严格上讲，模块化不是他强调的东西，他旨在规范前端开发流程。

webpack更是明显强调模块化开发，而那些文件压缩合并、预处理等功能，不过是他附带的功能。

**总结**

gulp应该与grunt比较，而webpack应该与browserify（网上太多资料就这么说，这么说是没有错，不过单单这样一句话并不能让人清晰明了）。

gulp与webpack上是互补的，还是可替换的，取决于你项目的需求。如果只是个vue或react的单页应用，webpack也就够用；如果webpack某些功能使用起来麻烦甚至没有（雪碧图就没有），那就可以结合gulp一起用。

```
首先从概念上，我们可以清楚的看出，Gulp和Webpack的侧重点是不同的。

Gulp侧重于前端开发的整个过程的控制管理（像是流水线），我们可以通过给gulp配置不通的task（通过Gulp中的gulp.task()方法配置，比如启动server、sass/less预编译、文件的合并压缩等等）来让gulp实现不同的功能，从而构建整个前端开发流程。

Webpack有人也称之为模块打包机，由此也可以看出Webpack更侧重于模块打包，当然我们可以把开发中的所有资源（图片、js文件、css文件等）都可以看成模块，最初Webpack本身就是为前端JS代码打包而设计的，后来被扩展到其他资源的打包处理。Webpack是通过loader（加载器）和plugins（插件）对资源进行处理的。

```

### gulp 与 grunt 区别

```
gulp 核心api只有 5 个， 易学
gulp 可以通过设置 task 实现不同功能， 易用
gulp/grunt 是一种能够优化前端的开发流程，
webpack 是一种模块化解决方案
特点：
grunt 社区完善，插件丰富， 配置复杂
gulp 简单易用，配置轻

```

### 语义化

语义化的主要目的就是让大家直观的认识标签 (markup) 和属性(attribute) 的用途和作用

1）、为了在没有css代码时，也能呈现很好的内容结构，代码结构，以至于达到没有编程基础的非技术人员，也能看懂一二。（其实，就是为了不穿CSS外衣，裸奔依然好看）。
2）、提高用户体验，比如：title，alt用于解释名词和图片信息。
3）、利于SEO，语义化能和搜索引擎建立良好的联系，有利于爬虫抓取更多的有效信息。爬虫依赖于标签来确定上下文和各个关键字的权重。
4）、方便其他设备解析（如屏幕阅读器、盲人阅读器、移动设备）以语义的方式来渲染网页。
5）、便于团队开发和维护，语义化更具可读性，如果遵循W3C标准的团队都遵循这个标准，可以减少差异化，利于规范化。

语义化标签：title, hn, header, footer, nav, main, article, section, aside, small, strong, mark, figure, cite, blockquoto, q, address, del, pre, code, progress

无语议标签：div, span

### How absolute ,relative ,fixed and static position differ? 

absolute ,relative ,fixed and static 之间的区别
Absolute ：生成绝对定位的元素，相对于 static 定位【以外】的【第一个父元素】进行定位
Fixed ：生成绝对定位的元素，相对于浏览器窗口进行定位。
Relative ：生成相对定位的元素，相对于其正常位置进行定位。
Static ：默认值。没有定位，元素出现在正常的流中（忽略 top, bottom, left, right 或者 z-index 声明

### CSS 单位

任意浏览器的默认字体高都是 16px

### 区块链

本质：是一种特殊（无人管理）的分布式数据库

特点：（没有管理员，彻底无中心：：：即无法管理，无法被控制。但之所以安全，就是区块链的奇妙所在）

1、任何人都可以加入区块链网络，成为一个节点。

2、每个节点都是平等的，都保存着整个数据库。

3、你可以读写任何一个节点数据，最后节点信息同步，保证区块链一致。

其它特点：

1、故意生成新区块较困难，每 10 分钟一个，每小时才 6 个

2、故意让 Hash 通过极其大量计算才可获取当前区块数据

安全可靠：

1、效率低：：数据写入时，最少等待 10 分钟；所以节点同步，需要更多时间

2、能耗大：：区块进行无数无意义的计算，非常耗费能源

不适用场景：

**钱的本质，或者说货币的本质，就是它的可信性。**它必须使人们相信，它是有价值的，然后才能成为钱，才能被收藏和支付。

**一样东西能否成为钱，只取决于人们是否相信它的价值，至于它是不是真的有价值，根本不重要。**

比特币也是如此，它是什么，其实不太重要。重要的是，它必须保证自己是可信的，这样才能让足够的人相信它的价值，然后才能成为钱。

**比特币要解决的核心问题，就是创造一种可信的数字凭证。**由于这种凭证可信，所以能够当做货币。

技术人员对比特币感兴趣，还有一个重要原因。任何需要可靠的数字凭证的场合，也许都可以用到这种技术。

**钱就应该是无形的，那些实体的钱其实是对物质材料的浪费，由于技术不够发达，不得不做成实体。**