
### BOM 浏览器对象模型

解析渲染流程：

```
1、解析构建 DOM 树(分析 html、分析 css)
2、构建 render 树(组合 Dom Tree 和 Css Rule Tree)
3、布局 render 树(全局布局 size, 增量布局 dirty)
4、绘制 render 树
解析DOM（DOM树和CSS树）----->渲染DOM树（结合DOM与CSS）----->布局DOM树----->绘制DOM树

特点：
1、自上而下
2、样式（link、style）与脚本文件（script）（除async/defer）等资源加载、解析、执行会阻塞解析
```

### reflow(回流重排)和repaint(重绘)理解总结

```
重排（空间 - 布局树）：布局
重绘（外观 - 渲染树）：上色

reflow: 所有引起元素空间变化的事件都会引起 reflow
repaint: 所有引起元素外观变化的事件都会引起 repaint

区别：
1、repaint是某个dom元素进行重绘，reflow是整个页面进行重排，也就是对页面所有的dom元素渲染。
2、在性能优先的前提下，reflow的性能消耗要比repaint的大。

简介：
 1）增加、删除、修改DOM节点时，会导致Reflow或Repaint。
 2）移动DOM位置，或者搞个动画的时候；
 3）修改CSS样式的时候；
 4）Resize窗口 或 滚动的时候；
 5）修改网页默认字体的时候；

注意： 
 display:none 会触发 reflow;
 visibility:hidden 只会触发repaint。


如何触发reflow和repaint
repaint的触发-元素的外观，内容：
  1）不涉及任何dom元素的排版问题的变动为repaint，例如元素的color、text-align等改变。
  2）color的修改，text-align的修改，a：hover也会造成重绘，伪类引起的颜色等变化不会导致页面的回流，仅仅会触发重绘。

reflow: 大小（元素大小，字体大小，内容改变，窗口大小），增删除，位置改变
reflow的触发-涉及元素尺寸，占位情况显隐性，元素的增添：
 1）width、height、border、margin、padding的修改
 2）通过hover造成元素表现的改动，如display:none会导致回流
 3）appendChild等dom元素操作。
 4）font类style 的修改。
 5)background的修改，现在经过浏览器厂家的优化，部分background的修改只会触发repaint。
 1.改变窗囗大小
2.改变文字大小
3.添加/删除样式表
4.脚本操作DOM
5.设置style属性

如何尽量避免回流reflow：
a、尽可能在dom末稍通过修改class来修改元素的style属性，尽可能减少受影响的dom元素。
b、避免设置多项内联样式，使用常用的class方式进行设置样式，以避免设置样式时访问dom的低效率。
c、设置动画元素position属性为fixed或absolute：由于当前元素从dom流中独立出来，因此受影响的只有当前元素。
d、牺牲平滑度满足性能：动画精度太强，会造成更多的repaint/reflow，牺牲精度，能满足性能的损耗，获取性能和平滑度的平衡。
f、避免使用table进行布局，table每个元素的大小以及内容的改变，都会导致整个table进行重新计算，造成大幅度的repaint或者reflow。改用div则可以针对性的repaint和避免不必要的reflow。
g、避免在css中使用运算式

优化：
1）把DOM离线后修改；
2）不要把DOM节点的属性值放在一个循环里当成循环的变量。
3）尽可能的修改层级比较低的DOM节点
4）为动画HTML元件使用fixed或absoult的position。
5）千万不要使用table布局。可能很小的一个改动会造成整个table重新布局。
```

### 域名解析，DNS解析

```
一些大型网站或CDN服务商为了实现负载均衡，他们的DNS服务器会动态改变多个IP地址的顺序，使得每个IP地址都有机会成为解析结果中的第一个IP地址。
-----------
以DNSPOD为例，支持为同一个主机名设置多条A记录。下图中，为某个域名的www设置了3条A记录，分别为1.1.1.1, 2.2.2.2, 3.3.3.3
---------------------
nslookup根据主机名反查IP
ipconfig /displaydns 查找dns缓存
ipconfig /flushdns 清除dns缓存
=======dns 过程；浏览器缓存→系统缓存→路由器缓存→ISP DNS 缓存→递归搜索
chrome://net-internals/#dns 浏览器dns缓存
hosts 本机dns缓存
```

![preview](https://pic2.zhimg.com/80/c918cfe1647ec0cfc68d98f91cb5a6a5_hd.jpg)


### 多域名 共享 登陆 状态（单点登录 SSO）
```
原理： cookies 可以设置 Domain，所以，登陆服务可以同时设置 多个 域名 cookies, 这样就可以
      一处登陆，处处登陆

passport(用户服务器、登陆服务器))  -》》》》 其他域名

单点登陆 sso

采用ucenter 那套机制，一个站点登陆后，往其他站点写cookie，服务端session 存储到一个节点，cookie里存储sessionId
```