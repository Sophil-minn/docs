

# CSS

两种盒模型（box-sizing）-<u>影响元素宽和高是否包含边框 border 和内边距 padding</u>：

1、标准盒模型-默认 content-box  ：在元素widht 和 height 外绘制border padding margin

2、IE盒模型-常用  border-box: 在元素 width 和 height 内绘制 border padding

![这里写图片描述](https://img-blog.csdn.net/20160317084303673)![这里写图片描述](https://img-blog.csdn.net/20160317084327455)

#### block, inline, inline-block
- 起新行
```
block元素会独占一行, 多个block元素会各自新起一行. 默认情况下, block元素宽度自动填满其父元素宽度
inline元素不会独占一行, 多个相邻的行内元素会排列在同一行里, 直到一行排列不下, 才会新换一行, 其宽度随元素的内容而变化
```
- 设置宽高
```
block元素可以设置width, height属性. 块级元素即使设置了宽度, 仍然独占一行
inline元素设置width, height无效
```
- 内外边距
```
block元素可以设置margin和padding属性
inline元素的margin和padding属性,水平方向的padding-left, padding-right, margin-left, margin-right都会产生边距效果. 但是数值方向的 margin/padding-top/bottom不会产生边距效果
```
- 包含
```
block可以包含inline和block元素,而inline元只能包含inline元素
而display: inline-block, 则是将对象呈现为inline对象, 但是对象的内容作为block对象呈现. 之后的内联对象会被排列到一行内. 比如我们可以给一个link(a元素)inline-block的属性, 使其既有block的高宽特性又有inline的同行特性
```


#### BFC
```
根元素
display的值为 inline-block, table-cell, table-caption
position的值为absolute或fixed
float的值不为none
overflow的值不为visible
```

#### Flex
> 非常适合缩放，对齐和重新排序元素，但避免 整体页面布局，也就是只局部使用，父级：display:flex;

[FLEX练习小游戏](http://flexboxfroggy.com/#zh-cn)
[CSS3 Flexbox 演示](http://www.css88.com/demo/flexbox-playground/)

> 弹性 盒子：伸展因子 flex-grow  收缩因子 flex-shrink

> 原理：简单的讲是通过设置 flex 的 API 参数的 值，实现 布局，详细的讲，渲染引擎 通过 flex 参数值，算法 实现渲染逻辑

**方向：** flex-direction

左->右：row

右->左：row-reverse

上->下：column

下->上：column-reverse

**主轴上的对齐方式** : `justify-content`

始点对齐：flex-start 

居中：center 

终点对齐：flex-end

两端靠边，中间有间隔：space-between   

周围都有间隔：space-around

**副轴上对齐方式：** `align-items`

顶对齐：flex-start 

居中：center 

底对齐：flex-end

上下拉伸：stretch

**调序：**order

默认：0

正数n：向前调整n个距离

负数n：向后调整n个距离

**单个项目对齐方式：** `align-self`（值同align-items）

**行间距：** align-content: flex-start | flex-end |center | space-between | space-around | stretch

**换行：** `flex-wrap: nowrap | wrap | wrap-reverse;`

**综合：** flex-flow: direction wrap;

**单个项目缩小比例：** `flex-shrink,默认为1`

**单个项目最初空间：** `flex-basis,默认auto|值`

**单个项目放大比例：** `flex-grow,默认0`

### CSS3 新增伪类
```
p:last-of-type 选
p:last-child
p:first-of-type
p:first-child
p:only-child
p:only-of-type
p:nth-child(n)
p:nth-last-child(n)
p:nth-of-type(n)
p:nth-last-of-type(n)
input:enabled
```
**display的值**

display:none|inline|inline-block|block|table|inline-table|table-cell|flex

![这里写图片描述](https://img-blog.csdn.net/20161225213004672?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY3J5c3RhbDY5MTg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](https://img-blog.csdn.net/20161225213809173?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY3J5c3RhbDY5MTg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### CSS3动画

**animation对关键帧动画设置 keyframes**

```
@-webkit-keyframes myfirst
@-o-keyframes myfirst
@-moz-keyframes myfirst
@keyframes myfirst{
    from {
        background: red;
    }
    to {
        background: blue;
    }
    或者
    0%   {background: red;}
    25%  {background: yellow;}
    50%  {background: blue;}
    100% {background: green;}
}

div {
    animation: myfirst 5s linear 2s infinite alternate;
	-moz-animation: myfirst 5s;	/* Firefox */
	-webkit-animation: myfirst 5s;	/* Safari 和 Chrome */
	-o-animation: myfirst 5s;	/* Opera */
	或者
	animation-name: myfirst;
    animation-duration: 5s;
    animation-timing-function: linear;
    animation-delay: 2s;
    animation-iteration-count: infinite;
    animation-direction: alternate;
    animation-play-state: running;
}
```

**[transition](http://www.w3school.com.cn/tiy/t.asp?f=css3_transition) 对元素属性动画**

```
请把鼠标指针移动到蓝色的 div 元素上，就可以看到过渡效果。
div
{
    width:100px;
    height:100px;
    background:blue;
    transition:width 2s;
    -moz-transition:width 2s; /* Firefox 4 */
    -webkit-transition:width 2s; /* Safari and Chrome */
    -o-transition:width 2s; /* Opera */
}

div:hover
{
	width:300px;
}
```

**[transform](http://www.w3school.com.cn/cssref/pr_transform.asp) 对元素整体矩阵动画**

```
.trans_effect:hover {
    -webkit-transform:rotate(720deg) scale(2,2);
    -moz-transform:rotate(720deg) scale(2,2);
    -o-transform:rotate(720deg) scale(2,2);
    -ms-transform:rotate(720deg) scale(2,2);
    transform:rotate(720deg) scale(2,2);        
}
```


### [CSS 清除浮动](http://www.jb51.net/css/173023.html)

```
1、父级div定义 height （不推荐使用）
缺点：只适合高度固定的布局，要给出精确的高度，如果高度和父级div不一样时，会产生问题 
2，结尾处加空div标签 clear:both （不推荐使用）
缺点：不少初学者不理解原理；如果页面浮动布局多，就要增加很多空div，让人感觉很不好
3，父级div定义 伪类:after 和 zoom（推荐使用 - 大型网站都有使用，如：腾迅，网易，新浪等等）
缺点：代码多、不少初学者不理解原理，要两句代码结合使用才能让主流浏览器都支持。
4，父级div定义 overflow:hidden
缺点：不能和position配合使用，因为超出的尺寸的会被隐藏
5，父级div定义 overflow:auto （不推荐使用）
缺点：内部宽高超过父级div时，会出现滚动条
6，父级div 也一起浮动 （不推荐使用）
缺点：会产生新的浮动问题
7，父级div定义 display:table （不推荐使用）
缺点：会产生新的未知问题
8，结尾处加 br标签 clear:both （不推荐使用）
```

#### [CSS 三角形原理](https://blog.csdn.net/pengjunlee/article/details/53002553)
```
其实使用CSS代码绘制三角形，只是对盒子模型中的"border"属性的简单应用。盒子模型将HTML元素划分为内容(Content)、填充(Padding)、边框(Border)和边界(Margin)四部分
1、每条边(以黄色边为例)与其邻边所成夹角A，tanA=n/m（n,m分别为自己和邻边的宽度），当邻边宽度为0px时，A角大小为90°。
2、当盒子模型中的内容(Content)+填充(Padding)的大小为0px时，Border边的形状将由梯形变为三角形。

eg.
height:0px;
width:0px;
border-left:20px transparent;
border-top:10px blue;
border-right:30px green;
border-bottom:40px yellow;
```
#### 三角形
```
1、css
2、Unicode字符
3、canvas
4、SVG
```

#### em rem
```
em: 字体大小是根据父元素字体大小设置的

rem: 根据html根目录下的字体大小进行计算的;不仅可以设置字体的大小，也可以设置元素宽、高等属性

```

#### CSS三大特性
```
继承(基础，初始值)：即子类元素继承父类的样式;

优先级（自定义）：是指不同类别样式的权重比较;

层叠（下一个自定义覆盖）：是说当数量相同时，通过层叠(后者覆盖前者)的样式。
```

#### CSS 优先级计算规则
> 总结排序：!important > 行内样式>ID选择器 > 类选择器 > 标签 > 通配符 > 继承 > 浏览器默认属性


```
CSS优先级：是由四个级别和各级别的出现次数决定的。

四个级别分别为：行内选择符、ID选择符、类别选择符、元素选择符。

!important:                1,0,0,0
ID选择器:                   0,1,0,0
类选择器、属性选择器或伪类:     0,0,1,0
元素和伪元素:                0,0,0,1
通配选择器*:                 0,0,0,0


a{color: yellow;} /*特殊性值：0,0,0,1*/
div a{color: green;} /*特殊性值：0,0,0,2*/
.demo a{color: black;} /*特殊性值：0,0,1,1*/
.demo input[type="text"]{color: blue;} /*特殊性值：0,0,2,1*/
.demo *[type="text"]{color: grey;} /*特殊性值：0,0,2,0*/
#demo a{color: orange;} /*特殊性值：0,1,0,1*/
div#demo a{color: red;} /*特殊性值：0,1,0,2*/

<a href="">第一条应该是黄色</a> <!--适用第1行规则-->
<div class="demo">
    <input type="text" value="第二条应该是蓝色" /><!--适用第4、5行规则，第4行优先级高-->
    <a href="">第三条应该是黑色</a><!--适用第2、3行规则，第3行优先级高-->
</div>
<div id="demo">
    <a href="">第四条应该是红色</a><!--适用第6、7行规则，第7行优先级高-->
</div>
```