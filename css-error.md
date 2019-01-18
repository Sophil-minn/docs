
- inline元素间的空隙或错位的方法
```
解决： 
1、一般给元素一个固定的height就没有这个现象

但是当高度不一致时，就需要想别的办法来解决了：

2、给父元素定义font-size:0; 
浮动子元素定义需要的font-size（不需要可不加）， 再定义display:inline-block;vertical-align:top;
```

-  浮动的子元素 造成的 塌陷
```
清理浮动一般有两种思路
  方法一 利用 clear属性，清除浮动
  方法二 使父容器形成BFC


塌陷元素:after{
    content:"."; 
    display:block; 
    height:0; 
    visibility:hidden; 
    clear:left;
}
```
