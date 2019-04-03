[安装](https://flutter.dev/docs/get-started/install/macos)
```
1. Determine the directory where you placed the Flutter SDK. You will need this in Step 3.
1. Open (or create) $HOME/.bash_profile. The file path and filename might be different on your machine.
1. Add the following line and change [PATH_TO_FLUTTER_GIT_DIRECTORY] to be the path where you cloned Flutter’s git repo:

 export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
1. Run  to refresh the current window.

  source $HOME/.bash_profile
1. Verify that the flutter/bin directory is now in your PATH by running:

 echo $PATH
```


### install
- Anroid 下载
- Android Studio安装目录下的bin/idea.properties文件
- 重新安装 AS(不使用代理,disable.android.first.run=true)、Java、flutter(git clone -b beta)
- AS预设中 Android sdk 设置即下载sdk
- 打开android studio, 打开plugin ,输入 flutter

打开 $HOME/.bash_profile , 在下方添加两行变量
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

然后 source $HOME/.bash_profile 使之在当前 terminal 生效.

```
Waiting for another flutter command to release the startup lock
打开flutter的安装目录/bin/cache/
删除lockfile文件
```
- XCode 安装
- flutter 插件安装（AS 或 VS 或 XCode）
- ~/.bash_profile 环境变量配置
- flutter doctor
- 创建 Android|IOS 模拟器  
- AS|VS|XCode 开发

> 注意： flutter 开发中有热加载，但不是所有文件的修改都是进行热加载，仅有带有页面布局的页面才会进行热加载; 虽然不会进行热重载但依然进语法检测。



### [search packages](https://pub.dartlang.org/)
> https://pub.dartlang.org/
> https://pub.flutter-io.cn/

### [Flutter 开发文档](https://book.flutterchina.club/)

### [Flutter常见问题FAQ](https://blog.csdn.net/zhangxiangliang2/article/details/75675693)

### [flutter 资料整理](https://www.jianshu.com/p/625ed3624301)

### [flutter 学习记录](https://github.com/lizhuoyuan/flutter_study)

### [Flutter 布局控件完结篇](https://www.cnblogs.com/holy-loki/p/9735071.html)
### [Flutter 布局控件完结篇](https://github.com/bitores/flutter-study)

- 参数类型
- 默认参数
- 可选参数
- 存在判定 ??= 
- 留白（padding,margin） EdgeInsets
- 背景 BoxDecoration
- 边框 BoxDecoration
- 阴影 BoxDecoration
- 三维控件 Container - matrix
- 文本及样式 Text
- 各种形状遮罩 ClipOval
- 触控组件 GestureDetector
- 最值 double.infinity|MainAxisSize.max
- 最大高最大宽限定 LimitedBox
- 最大最小高宽限定 OverflowBox
- 具体尺寸设定 SizeBox
- SizeOverflowBox 同 OverflowBox
- 设置宽高占百比（0-1，让子控件尺寸失效，默认子控件撑满此控件） FractionallySizedBox
- 继承的宽高 IntrinsicHeight， IntrinsicWidth
- Transform 三维变换组件
- 代理其它组件来布局（常用来封装组件时使用，传入参数为其它组件）CustomSingleChildLayout
- 同上，多子组件 CustomMultiChildLayout
- 隐藏显示(隐藏时通过调整自身尺寸来达到不占用空间不渲染) offstage
- 滚动区域
- 固定宽 + 自动占满 （SizedBox + Expanded）
- 填充剩余的空间 Expanded(若有多个可用 flex控制比例)
- 行布局（X）
- 列布局 (Y)
- 层叠布局 (Z)

- 定位控件：Container、Align、Center、FittedBox、Baseline、Transform。
- 尺寸控件：Container、FittedBox、AspectRatio、ConstrainedBox、FractionallySizedBox、IntrinsicHeight、IntrinsicWidth、LimitedBox、SizedBox、SizedOverflowBox。
- 绘制控件：Container、Padding、Offstage、OverflowBox、SizedOverflowBox、Transform。

- 列表：GridView、ListView；
- 单列单行或者多列多行：Row、Column、Flow、Wrap、ListBody、Table；
- 显示位置相关：Stack、IndexedStack、CustomMultiChildLayout。




### class

- MaterialApp (title, routes, home)
- Scaffold (appBar, body, floatingActionButton,persistentFooterButtons, drawer,bottomNavigationBar)
- Widget
- StatelessWidget
- StatefulWidget

### [Flutter 更多布局-en](https://flutter.io/docs/development/ui/widgets/layout)
> [Flutter 布局控件完结篇- 完全介绍](https://www.jianshu.com/p/01bf6da35b96)
> [Flutter 更多布局-zh](https://www.jianshu.com/p/1836d8d23926)
> 在flutter中，一切皆控件！一切皆控件！一切皆控件！包括：空间，留白padding，位置position，对齐方式align，文本text，图标图片icon/img等

标准组件 - Standard widgets

Container 给一个组件添加 padding, margins, 边界（borders）, 背景(background)、边线(border)、阴影(shadow)或其它装饰（BoxDecoration）。
GridView 将多个widget放在一个可滑动的表格中。
ListView 将多个widget放在一个可滑动的列表中。
Stack 在一个widget上面盖上另一个widget。

Material Components

Card 将一些相近的信息装进一个有圆角和阴影的盒子里。
ListTile 一个Row中装载最多3行文字；可选则在前面或尾部添加图标。




### 容器(布局控件-架子)
> 仅单个子组件容器：Center,Alignment,Container,Flexible,Expanded
> 多个子组件容器：Row,Column,Statck

> 对齐(align)、缩放(size)、包装(pack)和嵌套(Nest)

- Container组件
Container是使用非常多的一个布局容器，关于Container容器的显示规则，有如下几条： 
1. 如果Container中没有子组件，则Container会尽可能的大 
2. 如果Container中有子组件，则Container会适应子组件的大小 
3. 如果给Container设置了大小，则Container按照设置的大小显示 
4. Container的显示规则除了跟自身约束和子组件有关，跟它的父组件也有关


- Flutter中淡化了margin以及padding的区别，margin实质上也是由Padding实现的。
Padding的布局分为两种情况：

当child为空的时候，会产生一个宽为left+right，高为top+bottom的区域；
当child不为空的时候，Padding会将布局约束传递给child，根据设置的padding属性，缩小child的布局尺寸。然后Padding将自己调整到child设置了padding属性的尺寸，在child周围创建空白区域。


-Align的布局行为分为两种情况：

当widthFactor和heightFactor为null的时候，当其有限制条件的时候，Align会根据限制条件尽量的扩展自己的尺寸，当没有限制条件的时候，会调整到child的尺寸；
当widthFactor或者heightFactor不为null的时候，Aligin会根据factor属性，扩展自己的尺寸，例如设置widthFactor为2.0的时候，那么，Align的宽度将会是child的两倍。

Align为什么会有这样的布局行为呢？原因很简单，设置对齐方式的话，如果外层元素尺寸不确定的话，内部的对齐就无法确定。因此，会有宽高因子、根据外层限制扩大到最大尺寸、外层不确定时调整到child尺寸这些行为。

-Center继承自Align，只不过是将alignment设置为Alignment.center，其他属性例如widthFactor、heightFactor，布局行为，都与Align完全一样，在这里就不再单独做介绍了。Center源码如下，没有设置alignment属性，是因为Align默认的对齐方式就是居中


- Row Flex 布局
- Column Flex 布局
Row的布局有六个步骤，这种布局表现来自Flex（Row和Column的父类）：

首先按照不受限制的主轴（main axis）约束条件，对flex为null或者为0的child进行布局，然后按照交叉轴（ cross axis）的约束，对child进行调整；
按照不为空的flex值，将主轴方向上剩余的空间分成相应的几等分；
对上述步骤flex值不为空的child，在交叉轴方向进行调整，在主轴方向使用最大约束条件，让其占满步骤2所分得的空间；
Flex交叉轴的范围取自子节点的最大交叉轴；
主轴Flex的值是由mainAxisSize属性决定的，其中MainAxisSize可以取max、min以及具体的value值；
每一个child的位置是由mainAxisAlignment以及crossAxisAlignment所决定。


Flexible和 Expanded的区别是：
Expanded 这是个用来让子项具有伸缩能力的widget
Expanded继承自Flexible

Flexible是一个控制Row、Column、Flex等子组件如何布局的组件。

Flexible组件可以使Row、Column、Flex等子组件在主轴方向有填充可用空间的能力(例如，Row在水平方向，Column在垂直方向)，但是它与Expanded组件不同，它不强制子组件填充可用空间。

Flexible组件必须是Row、Column、Flex等组件的后裔，并且从Flexible到它封装的Row、Column、Flex的路径必须只包括StatelessWidgets或StatefulWidgets组件(不能是其他类型的组件，像RenderObjectWidgets)。

Row、Column、Flex会被Expanded撑开，充满主轴可用空间。
Expanded组件必须用在Row、Column、Flex内，并且从Expanded到封装它的Row、Column、Flex的路径必须只包括StatelessWidgets或StatefulWidgets组件(不能是其他类型的组件，像RenderObjectWidget，它是渲染对象，不再改变尺寸了，因此Expanded不能放进RenderObjectWidget)。


```
x: Row
y: Column
z: Stack - web:absolute
```
- Flexible
- Expanded (继承自 Flexible,默认要占满分配的空间)
- Flexible组件可以使Row、Column、Flex等子组件在主轴方向有填充可用空间的能力(例如，Row在水平方向，Column在垂直方向)，但是它与Expanded组件不同，它不强制子组件填充可用空间。

### 可视组件
- Text
- Icon
- RaisedButton、FlatButton...

- launch(url) # 打开默认浏览器

### 
```
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
debugPaintSizeEnabled = true;      //打开视觉调试开关
```

### [flutter 生命周期](https://www.jianshu.com/p/c3c9beacbb94)
![生命周期](5316822-c9777f9315c20b2a.png)



### 请求拦截
- 统一拦截
- 统一设置
- 统一处理

### 组件通信
- 父子通信
- 兄弟通信
- 状态管理


### [手势识别器分类](https://www.jianshu.com/p/3b87ddb022af)
- Flutter中的GestureDetector一共有 7大类25种。
```
Tap：
onTapDown: (details) {},
onTapUp: (details) {},
onTap: () {},
onTapCancel: () {},

双击：
onDoubleTap: () {},

长按：
onLongPress: () {},
onLongPressUp: () {},

垂直滑动：
onVerticalDragDown: (details) {},
onVerticalDragStart: (details) {},
onVerticalDragUpdate: (details) {},
onVerticalDragEnd: (details) {},
onVerticalDragCancel: () {},

水平滑动：
onHorizontalDragDown: (details) {},
onHorizontalDragStart: (details) {},
onHorizontalDragUpdate: (details) {},
onHorizontalDragEnd: (details) {},
onHorizontalDragCancel: () {},

Pan事件：
指针已接触屏幕并可能开始移动。
onPanDown: (details) {},
指针已经接触屏幕并开始移动。
onPanStart: (details) {},
与屏幕接触并移动的指针再次移动。
onPanUpdate: (details) {}, 
先前与屏幕接触并移动的指针不再与屏幕接触，并且当它停止接触屏幕时以特定速度移动。
onPanEnd: (details) {},
先前触发 onPanDown 的指针未完成。
onPanCancel: () {},

Scale事件：
onScaleStart: (details) {},
onScaleUpdate: (details) {},
onScaleEnd: (details) {},

```

### [Material Design](https://material.io/tools/icons)
![Material Design视觉布局结构](http://upload-images.jianshu.io/upload_images/6218810-b8e52962dcae7312.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![应用栏 AppBar](http://upload-images.jianshu.io/upload_images/6218810-f0dd9afd169c166b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



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



### common command

```
flutter -h
fluter doctor
fluter doctor --android-licenses

flutter devices # 真机
flutter emulators # 模拟器
flutter emulators --launch [id] #启动某个模拟器
flutter create demo # 创建项目

flutter logs
flutter packages get

flutter run
flutter run --release

flutter build apk
flutter build ios --no-codesign

#发布之前，检查pubspec.yaml、README.md以及CHANGELOG.md文件内容的完整性和正确性
flutter packages pub publish --dry-run
flutter packages pub publish
```


- [For Web dev](https://flutter.io/docs/get-started/flutter-for/web-devs)
### bug 收集
```
1、超过一屏会出现边界溢出 异常
2、一般有软键盘的，都有可能会有出现 边界溢出的 问题
3、TextField 会出现 renderbox 问题
4、
```

### 
- toast
- store_redirect: A Flutter plugin to redirect users to an app page in Google Play Store and Apple App Store.
device_info: 