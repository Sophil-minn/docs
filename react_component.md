

1. Component
2. Purcomponent
```
PureComponent和Component几乎完全一样，唯一的区别是PureComponent为你处理shouldComponentUpdate事件
```
3. HOC
```js
// 高阶组件的概念应该是来源于JavaScript的高阶函数: 
// 1. 高阶函数就是接受函数作为输入或者输出的函数
// 2. 高阶组件仅仅只是是一个接受组件组作输入并返回组件的函数
function HOC(com) {
  return class extends React.Component {
    render(){

      return (
        <div>
          <com></com>
        </div>
      )
    }
  }
}

// HOC 优势 功能增强的效果
// 1. 代理 props : 按需对 传入的 props 进行 增加/删除/修改, 但尽量不要修改
// 2. 渲染劫持: render 函数中 可控制是否渲染 低阶组件
// 3. 代码复用，代码模块化

// 没有 this 和 ref
// Component上面绑定的Static方法会丢失
// Ref无法获取你想要的ref
```

类组件和函数式组件

1. 容器组件就是取数据，然后渲染子组件而已: 容器组件是应用的数据(逻辑)层, 必须是 类组件
1. 展示组件仅能从props中获取数据和回调函数，这些props由容器组件(父组件)提供。
1. 高阶组件是一种函数，它接受一个组件作为参数，然后返回一个新的组件。

React 实现
```jsx
 (1) state 数据
 (2) JSX模板
 (3) 数据 + 模板 生成虚拟DOM( 虚拟DOM 本质就是 JS对象 , 用来描述真实的DOM) (减少损耗)
     ['div', {id: 'abc'}, ['span', {}, 'Hello']]  --> js对象['标签名', {属性对象}, 子节点]的嵌套成虚拟DOM树
     
 (4) 用虚拟DOM, 生成真实的DOM, 显示
     <div id="abc"><span> Hello </span></div>  真实的DOM
 (5) state发生变化
 (6) 数据 + 模板 生成新的虚拟DOM, 只是比较 js对象 的差异, 进行改变(极大的提示性能)
 ['div', {id: 'abc'}, ['span', {}, 'Bye']]
 
 (7) 比较虚拟DOM(也即JS对象) 的差别
 (8) 直接操作DOM, 改变span 中的内容
 
 改进: 整个DOM的替换 -> 生成新的DOM(DocumentFragement), 比较DOM, 替换DOM -> 生成虚拟DOM(JS对象), 比较虚拟DOM(比较js对象), 替换DOM
 
 优点: 
  (1) 性能提升
  (2) 虚拟DOM 使得跨端应用得以实现, React Native, 虚拟DOM本身是js对象(web, 原生应用都可以识别), 网页里面渲染成DOM, 原生里面渲染成原生组件
```

虚拟DOM
```
 (1) render函数里面的  JSX -> React.createElement  -> 虚拟DOM(js对象) -> 真实的DOM
 
 (2) jsx: return ( <div> <span> hello </span> </div>  )  jsx就是React.createElement的语法糖
 
 (3) return ( React.createElement('div', {}, React.createElement('span', {}, 'hello')) )
```