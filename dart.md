# Dart 知识

#### 特点
- Dart 特别容易学习，因为它具有静态和动态语言用户都熟悉的特性
- 即时（JIT-Just in Time）编译器:开发周期异常快
- 预编译器 AOT(Ahead of Time) 编译器:编译成快速、可预测的本地代码

### 基本语法
- 所有东西都是对象，都继承自 Object： 包括数字、函数等， 默认值都是 null
- dynamic、Object、var 可代表所有数据类型
- 语句必须以分号结束
- 类型是可选的、动态的类型语言，可以使用 var 声明变量
- 非 bool 类型的对象都被当作 false， 如 1 生产模式下则认为是 false
- num = int + double

### 基本运算
- +、-、*、/
- 
- []
- ??、?. 、?:
- if...else if...else、switch...case...break、for、while、try...catch...finally

### [基础类型与正则](https://blog.csdn.net/hekaiyou/article/details/51310381)
```

```


### 函数
- 类型声明 可有可无，推荐有
- 无 function 声明
- 可使用 箭头函数 =>
- 默认返回值 null
- 参数选，有序参数[]，无序参数{}，有默认值参数
- 逻辑中表示 可选参数 ?xxxx,true 表示 输入了 xxxx 参数, false 表示 未输入 xxxx 参数

### 类
- 一个类可有多个命名构造函数，但只能有一个标准构造函数：即不能像其它强类型语言中构造函数的重载
```
class Point {
  num x, y; 
  Point(this.x, this.y); // 指定 x 和 y 的标准构造函数
  Point.zero() : x = 0, y = 0; // x 和 y 都为0的命名构造函数
}

var a = new Point(1, 2);
var b = new Point.zero();
```
- 字段 的 getter 和 setter 
- .. 可链式调用
- 可重载操作符
```
class Vector {
  num x, y;
  Vector(this.x, this.y);
  bool operator ==(other) {
  } 
}
```

### [Dart 中库的使用](http://han.guokai.blog.163.com/blog/static/1367182712012101495719194/)
```
import 'B.dart'; #导包dart库里面的包
import 'http://hello/hello.dart'; #使用网络资源
import'package:hello/hello.dart'; #严谨的做法:导入pubspec.yaml 的dependencies依赖的包
import 'package:base/components/swiper.dart'; #导入路径包 base为flutter根目录
import 'package:math' show Random; #选择导入
import 'package:math' hide Random; #选择不导入
import 'package:math' as mymath; #解决变量名冲突的办法
import 'package:greetings/hello.dart' deferred as hello; # 在需要时加载库

Part与import有什么区别
可见性：
如果说在A库中import了B库，A库对B库是不可见的，也就是说B库是无法知道A库的存在的。而part的作用是将一个库拆分成较小的组件。两个或多个part共同构成了一个库，它们彼此之间是知道互相的存在的。
作用域：
import不会完全共享作用域，而part之间是完全共享的。如果说在A库中import了B库，B库import了C库，A库是没有办法直接使用C库的对象的。而B,C若是A的part，那么三者共享所有对象。并且包含所有导入。

```

### 异步编程 
- async & await
```
getData() async {    //async关键字声明该函数内部有代码需要延迟执行
  return await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"}); //await关键字声明运算为延迟执行，然后return运算结果
}

#Dart规定有async标记的函数，只能由await来调用
String data;
setData() async {
  data = await getData();    //getData()延迟执行后赋值给data
}
or
String data;
getData() async {
  data = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"
  
只要记住两点：

await关键字必须在async函数内部使用
调用async函数必须使用await关键字});     //延迟执行后赋值给data
}
```
- Future
```

```

### [Dart编程语言入门](https://www.imooc.com/article/260329) 
```
支持基础的数据类型

int、double、bool、String、List（数组）、Map；

Map（与Python中的字典差不多），如Map gifts = {'first' : 'partridge'};

List
Runes(Unicode编码的字符串)
symbols(在Reflection/Mirrow的时候会用到，到时候再看)

函数可以有可选参数；

if-else、for 循环、while 循环、switch-case、try-catch 等知识与 Java 类似；

final关键字表示变量只能被赋值一次，赋值后不可再更改；
const表示变量是编译时常量，const变量默认为final变量，const标志的常量必须在编译时就确定了它的值 
```