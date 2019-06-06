### 一、BFC是什么？

　　在解释 BFC 是什么之前，需要先介绍 Box、Formatting Context的概念。通俗一点讲, BFC 是独门独院, 别人家事影响不到你家.
    怎么才能成家立业呢:

    body 根元素 (如果你是大家长了, 不用说也是独家独院了)
    浮动元素：float 除 none 以外的值 (如果说,你飘了,也就是说你脱离了家庭, 也可以独门独户了:如果家族要容纳他, 要家庭也要成为一个bfc)
    绝对定位元素：position (absolute、fixed)(如果说,你断绝关系了,无论是跟父母还是大家族,你也可以在外面独门独户了)
    display 为 inline-block、table-cells、flex(家庭内给你开一个地址cell\block, flex,让你成家)
    overflow 除了 visible 以外的值 (hidden、auto、scroll)  - 自己在家开盖楼了, 所有空间向上发展了

    解决问题(即,大家生活在一个空间内出现的问题)
    1. 相互挤压 
    1. 不小心占用空间

#### 　　Box: CSS布局的基本单位

　　Box 是 CSS 布局的对象和基本单位， 直观点来说，就是一个页面是由很多个 Box 组成的。元素的类型和 display 属性，决定了这个 Box 的类型。 不同类型的 Box， 会参与不同的 Formatting Context（一个决定如何渲染文档的容器），因此Box内的元素会以不同的方式渲染。让我们看看有哪些盒子：

- block-level box:display 属性为 block, list-item, table 的元素，会生成 block-level box。并且参与 block fomatting context；
- inline-level box:display 属性为 inline, inline-block, inline-table 的元素，会生成 inline-level box。并且参与 inline formatting context；
- run-in box: css3 中才有， 这儿先不讲了。

#### 　　Formatting context

　　Formatting context 是 W3C CSS2.1 规范中的一个概念。它是页面中的一块渲染区域，并且有一套渲染规则，它决定了其子元素将如何定位，以及和其他元素的关系和相互作用。最常见的 Formatting context 有 Block fomatting context (简称BFC)和 Inline formatting context (简称IFC)。

　　CSS2.1 中只有 `BFC `和 `IFC`, **CSS3** 中还增加了 `GFC `和 `FFC。`

#### 　　BFC 定义

　　BFC(Block formatting context)直译为"块级格式化上下文"。它是一个独立的渲染区域，只有Block-level box参与， 它规定了内部的Block-level Box如何布局，并且与这个区域外部毫不相干。

#### 　　BFC布局规则：

1. 内部的Box会在垂直方向，一个接一个地放置。
2. Box垂直方向的距离由margin决定。属于同一个BFC的两个相邻Box的margin会发生重叠
3. 每个元素的margin box的左边， 与包含块border box的左边相接触(对于从左往右的格式化，否则相反)。即使存在浮动也是如此。
4. BFC的区域不会与float box重叠。
5. BFC就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面的元素。反之也如此。
6. 计算BFC的高度时，浮动元素也参与计算



### 二、哪些元素会生成BFC?

1. 根元素
2. float属性不为none
3. position为absolute或fixed
4. display为inline-block, table-cell, table-caption, flex, inline-flex
5. overflow不为visible

即设置 [float|position|display|overflow] 都可以生成 BFC

### 总结

　　其实以上的几个例子都体现了`BFC`布局规则第五条：

> `BFC`就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面的元素。反之也如此。

　　因为`BFC`内部的元素和外部的元素绝对不会互相影响，因此， 当`BFC`外部存在浮动时，它不应该影响`BFC`内部Box的布局，`BFC`会通过变窄，而不与浮动有重叠。同样的，当`BFC`内部有浮动时，为了不影响外部元素的布局，`BFC`计算高度时会包括浮动的高度。避免margin重叠也是这样的一个道理。