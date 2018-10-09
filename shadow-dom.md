
#### shadow dom 

##### 影子DOM由下列部分组成：

Element.attachShadow()
Element.getDestinationInsertionPoints()
Element.shadowRoot
<content> 元素
<shadow> 元素
这些元素已从规范中移除： <content>, <element> 和<decorator>
相关API接口：ShadowRoot, HTMLTemplateElement and HTMLSlotElement
CSS 选择器：
伪类：:host, :host(), :host-context()
伪元素：::shadow and ::content
组合器：>>> (formerly /deep/)*


##### e.g.
```
var host = document.querySelector('#con');
var root = host.attachShadow({mode:'open'});//为宿主附加一个影子元素

root.innerHTML = "我来自shadow dom";//为影响元素附上内容，shadow dom的api和普通dom的大致相同

作者：楼兰之风
链接：https://www.jianshu.com/p/9293cac60920
來源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
```



##### web components的提出，旨在
- 解决UI重用的问题、
- 解决相同功能接口各异的问题，

大规模的用于生产似乎不太接地气，但是shadow dom技术对于webapp却是个好东西。

上文还只是在UI层面上应用shadow dom技术，webapp中每个view页面片如果可以应用shadow dom技术的话，
各个View将不必考虑
- id重复污染、
- css样式污染、
- javascript变量污染，
- 并且效率还比原来高多了，
因为对于页面来说，他就仅仅是一个标签而已，如此一来，大规模的webapp的网站可能真的会到来了！

demo地址：http://yexiaochai.github.io/cssui/demo/debug.html#num

代码地址：https://github.com/yexiaochai/cssui/tree/gh-pages

