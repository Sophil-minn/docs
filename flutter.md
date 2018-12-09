

### install
- 重新安装 AS(不使用代理,disable.android.first.run=true)、Java、flutter(git clone -b beta)
- flutter 插件安装（AS 或 VS ）
- ~/.bash_profile 环境变量配置
- flutter doctor
- AS 中创建 VM , VS中开发

### class

- MaterialApp (title, routes, home)
- Scaffold (appBar, body, floatingActionButton,persistentFooterButtons, drawer,bottomNavigationBar)
- Widget
- StatelessWidget
- StatefulWidget

### 布局
```
x: Row
y: Column
z: Stack - web:absolute
```
- Flexible
- Expanded (继承自 Flexible,默认要占满分配的空间)

### 
- Text
- TextStyle
- RaisedButton


### 
```
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
debugPaintSizeEnabled = true;      //打开视觉调试开关
```

### [flutter 生命周期](https://www.jianshu.com/p/c3c9beacbb94)
![生命周期](5316822-c9777f9315c20b2a.png)


### 文件导入导出
```
import 'B.dart';
import 'http://hello/hello.dart'; #使用网络资源
import'package:hello/hello.dart'; #严谨的做法
import 'package:math' show Random; #选择导入
import 'package:math' hide Random; #选择不导入
import 'package:math' as mymath; #解决变量名冲突的办法

Part与import有什么区别
可见性：
如果说在A库中import了B库，A库对B库是不可见的，也就是说B库是无法知道A库的存在的。而part的作用是将一个库拆分成较小的组件。两个或多个part共同构成了一个库，它们彼此之间是知道互相的存在的。
作用域：
import不会完全共享作用域，而part之间是完全共享的。如果说在A库中import了B库，B库import了C库，A库是没有办法直接使用C库的对象的。而B,C若是A的part，那么三者共享所有对象。并且包含所有导入。

```

### 请求拦截


### 组件通信

### [Material Design](https://material.io/tools/icons)

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

### [Flutter 中文网](https://book.flutterchina.club/)


### [Flutter 常用工具类库](https://www.jianshu.com/p/425a7ff9d66e)
[common_utils](https://github.com/Sky24n/common_utils)

1. TimelineUtil : 时间轴.(新)
1. TimerUtil    : 倒计时，定时任务.(新)
1. MoneyUtil    : 精确转换,防止精度丢失，分元互转，支持格式输出.(新)
1. LogUtil      : 简单封装打印日志.(新)
1. DateUtil     : 日期转换格式化输出.
1. RegexUtil    : 正则验证手机号，身份证，邮箱等等.
1. NumUtil      : 保留x位小数.精确加、减、乘、除, 防止精度丢失.
1. ObjectUtil  : 判断对象是否为空(String List Map),判断两个List是否相等.

[Flutter工具类库](https://github.com/Sky24n/flustars)

1. SpUtil : SharedPreferences 工具类.
1. ScreenUtil : 获取屏幕宽、高、密度，AppBar高，状态栏高度，屏幕方向.
1. WidgetUtil : Widget渲染监听，获取Widget宽高，在屏幕上的坐标.



### [search packages](https://pub.dartlang.org/)

> https://pub.dartlang.org/


### common command

```
flutter -h
fluter doctor
fluter doctor --android-licenses

flutter devices
flutter emulatprs
flutter emulatprs --launch [id]
flutter create demo

flutter logs
flutter packages get

flutter run
flutter run --release
```