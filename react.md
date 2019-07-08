
[redux教程](http://www.ruanyifeng.com/blog/2016/09/redux_tutorial_part_one_basic_usages.html)

> 普通项目 STEPS

```
 安装命令行
cnpm install -g create-react-app

 创建新项目
create-react-app my-project

 进行项目目录
cd my-project

 项目运行
cnmp start

 解压配置
cnpm run eject
```


> cnpm run eject 把 webpack 配置暴露出来时，报错：

```
Remove untracked files, stash or commit any changes, and try again.
npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! react-demo@0.1.0 eject: `react-scripts eject`
npm ERR! Exit status 1
npm ERR!
npm ERR! Failed at the react-demo@0.1.0 eject script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

npm ERR! A complete log of this run can be found in:
```

> 解决方案

```
因使用了git ,修改后的文件未及时提交，所以造成了 执行 npm run eject 时报错，所以解决方案是 先提交项目文件
```


执行 run eject 还会出现 其它错误，因 react-scripts 执行时 ，最后一步 是执行 npm run ... 这个由于网络原因也会报错

所以 要修改下 npm -> cnpm

> 添加 less 解析配置

```
使用create-react-app 创建的项目默认不支持less，以下增加less配置的步骤

暴露配置文件
create-react-app生成的项目文，看不到webpack相关的配置文件，需要先暴露出来，使用如下命令即可：

npm run eject
安装less-loader 和 less
npm install less-loader less --save-dev
修改webpack配置
修改 webpack.config.dev.js 和 webpack.config-prod.js 配置文件
改动1：

/\.css$/ 改为 /\.(css|less)$/,, 修改后如下：

改动2：

test: /\.css$/ 改为 /\.(css|less)$/
test: /\.css$/ 的 use 数组配置增加 less-loader

修改后如下：
{
  loader: require.resolve('less-loader') // compiles Less to CSS
}
```

> px to rem

```
npm install postcss-pxtorem --save-dev

// webpack.config.dev.js 添加以下这句
pxtorem({ rootValue: 100, propWhiteList: [] })
```

> [eslint 配置](https://www.cnblogs.com/hahazexia/p/6393212.html)、[使用教程](http://blog.csdn.net/walid1992/article/details/54633760)

```
"eslintConfig": {
	"extends": "react-app",
	"rules":{
	  "no-script-url": 0,
	  "no-multi-spaces": 1,
	  "react/jsx-space-before-closing": 1,        // 总是在自动关闭的标签前加一个空格，正常情况下也不需要换行
	  "jsx-quotes": 1,
	  "react/jsx-closing-bracket-location": 1,    // 遵循JSX语法缩进/格式
	  "react/jsx-boolean-value": 1,               // 如果属性值为 true, 可以直接省略
	  "react/no-string-refs": 1,      // 总是在Refs里使用回调函数
	  "react/self-closing-comp": 1,    // 对于没有子元素的标签来说总是自己关闭标签
	  "react/jsx-no-bind": 1,          // 当在 render() 里使用事件处理方法时，提前在构造函数里把 this 绑定上去
	  "react/sort-comp": 1,            // 按照具体规范的React.createClass 的生命周期函数书写代码
	  "react/jsx-pascal-case": 1        // React模块名使用帕斯卡命名，实例使用骆驼式命名
	}
},
```

> v4 与 v2 版本的 react、[Migrating from v2/v3 to v4](https://github.com/ReactTraining/react-router/blob/master/packages/react-router/docs/guides/migrating.md)

```
//v2
import {Router, Route, hashHistory} from 'react-router';

//v4
import {BrowserRouter, Route, Switch} from 'react-router-dom';

细心的你发现,这里的代码不仅仅是将Router替换为BrowserRouter,而且还把所有的Route中用Switch包裹起来. 下面就是v4的另一个修改.

<BroserRouter>只能有一个子节点,所以官网建议的是使用<Switch>进行包裹

最坑的地方:在当前目录下的文件路径不再使用./, 而是直接用/.
```




> 总结react中遇到的坑和一些小的知识点

```
在使用react 中经常会遇到各种个样的问题，如果对react不熟悉则会对遇到的问题感到莫名其妙而束手无策，接下来分析一下react中容易遇到的问题和注意点。

1、setState()是异步的
this.setState()会调用render方法，但并不会立即改变state的值，state是在render方法中赋值的。所以执行this.setState()后立即获取state的值是不变的。同样的直接赋值state并不会出发更新，因为没有调用render函数。

2、组件的生命周期
componentWillMount，componentDidMount 只有在初始化的时候才调用。
componentWillReceivePorps，shouldComponentUpdate，componentWillUpdate，componentDidUpdate 只有组件在更新的时候才被调用，初始化时不调用。

3、reducer必须返回一个新的对象才能出发组件的更新
因为在connect函数中会对新旧两个state进行浅对比，如果state只是值改变但是引用地址没有改变，connect会认为它们相同而不触发更新。

4、无论reducer返回的state是否改变，subscribe中注册的所有回调函数都会被触发。

5、组件命名的首字母必须是大写，这是类命名的规范。

6、组件卸载之前，加在dom元素上的监听事件，和定时器需要手动清除，因为这些并不在react的控制范围内，必须手动清除。

7、按需加载时如果组件是通过export default 暴露出去，那么require.ensure时必须加上default。


require.ensure([], require => {
    cb(null, require('../Component/saleRecord').default)
},'saleRecord')



8、react的路由有hashHistory和browserHistory，hashHistory由hash#控制跳转，一般用于正式线上部署，browserHistory就是普通的地址跳转，一般用于开发阶段。

9、标签里用到的，for 要写成htmlFor，因为for已经成了关键字。

10、componentWillUpdate中可以直接改变state的值，而不能用setState。

11、如果使用es6class类继承react的component组件，constructor中必须调用super，因为子类需要用super继承component的this，否则实例化的时候会报错。
```


>
## 技术栈：
  react + redux + webpack + react-router + ES6/7/8 + immutable


## 运行项目（nodejs 6.0+）

```
 git clone https://github.com/bailicangdu/react-pxq.git

 cd react-pxq

 npm i
  
 npm start

 npm run build （发布）
```


## 说明

>  本项目主要用于理解 react 和 redux 的编译方式，以及 react + redux 之间的配合方式

>  如果觉得不错的话，您可以点右上角 "Star" 支持一下 谢谢！ ^_^

>  或者您可以 "follow" 一下，我会不断开源更多的有趣的项目

>  如有问题请直接在 Issues 中提，或者您发现问题并有非常好的解决方案，欢迎 PR 👍

>  开发环境 macOS 10.13.1  Chrome 63  nodejs 8.9.1

>  推荐一个 vue2 + vuex 构建的 45 个页面的大型开源项目。[地址在这里](https://github.com/bailicangdu/vue2-elm)

>  另外一个 vue2 + vuex 的简单项目，非常适合入门练习。[地址在这里](https://github.com/bailicangdu/vue2-happyfri)


## 演示

[查看演示效果](http://cangdu.org/pxq/)（请用chrome的手机模式预览）

### 移动端扫描下方二维码
![](https://github.com/bailicangdu/pxq/blob/master/screenshot/demo.png)


### setState 异步更新问题
```
1、传入 State 对象，异步的，但批量会被覆盖合并
setState({
 key1: value,
})

2、防止 批量更新 被合并，函数会加入 quene 队列
setState((preState, props)=>{

})

3、state 回调函数
setState({key1:value}, ()=>{
  console.log(key1)
}) 

4、[] {} 更改不变 问题
[].concat\filter\slice ，Object.assain() 创建新的 数组 和 新的 对象

```

###  数据传
```
父->子：
通过props将数据传递给子组件

子->父
父组件通过props讲一个callback传给子组件，子组件内调用这个callback即可改变父组件的数据

context可以让子组件直接访问组件的数据，无需从祖先组件一层层地传递数据到子组件中
React自动地将color传递给子树中的任何组件。不过这个子组件必须定义contextTypes属性，不然获取到context为空。

getChildContext() {
  return {color: "purple"};
}

```

### state 与 props

```
1、state 对内，props 对外
2、state 变量要变，props 变量不变
```

### setState 调用后发生了什么

```
在代码中调用setState函数之后，React 会将传入的参数对象与组件当前的状态合并，然后触发所谓的调和过程(Reconciliation)。
经过调和过程，React 会以相对高效的方式根据新的状态构建 React 元素树并且着手重新渲染整个UI界面。
在 React 得到元素树之后，React 会自动计算出新的树与老树的节点差异，然后根据差异对界面进行最小化重渲染。
在差异计算算法中，React 能够相对精确地知道哪些位置发生了改变以及应该如何改变，这就保证了按需更新，而不是全部重新渲染。
```

#### 功能组件(Function Component) ，类组件(Class Component)
```
如果您的组件具有状态( state )或生命周期方法，请使用 Class 组件。否则，使用功能组件；；
补充：ref 接受一个回调函数，参数为 真实 Dom 元素

1、类组件
class UnControlledForm extends Component {
  handleSubmit = () => {
    console.log("Input Value: ", this.input.value)
  }
  render () {
    return (
      <form onSubmit={this.handleSubmit}>
        <input
          type='text'
          ref={(input) => this.input = input} />
        <button type='submit'>Submit</button>
      </form>
    )
  }
}

2、功能组件
function CustomForm ({handleSubmit}) {
  let inputElement
  return (
    <form onSubmit={() => handleSubmit(inputElement.value)}>
      <input
        type='text'
        ref={(input) => inputElement = input} />
      <button type='submit'>Submit</button>
    </form>
  )
}
```

#### React.Children.map
```
为什么要使用 React.Children.map（props.children，（）=>） 而不是 props.children.map（（）=>）

因为不能保证props.children将是一个数组，即， props.children = Object|Array

以此代码为例，

<Parent>
  <h1>Welcome.</h1>
</Parent>
在父组件内部，如果我们尝试使用 props.children.map 映射孩子，则会抛出错误，因为 props.children 是一个对象，而不是一个数组。
```

#### rudex,vuex(变量存内存) and localStorage
```
确切来说redux和vuex不应该和sessionStorage相比较。
redux和vuex更多的算作一种思想或是规范。
就算你不用redux。你完全可以自己定义一个全局变量store。
只要你维护的好。也是完全可以的。单页应用。会话状态始终存在。
sessionStorage除了增加读取的消耗之外。似乎并没有太大优势。嗯。。。同时打开多个此单页应用想来也是有用的。
```

### DVA

```
dva 是基于现有应用架构 (redux + react-router + redux-saga 等)的一层轻量封装，没有引入任何新概念，全部代码不到 100 行。
( Inspired by elm and choo. )dva 是 框架，不是 library，类似 emberjs，会很明确地告诉你每个部件应该怎么写，这对于团队而言，会更可控。
另外，除了 react 和 react-dom 是 peerDependencies 以外，dva 封装了所有其他依赖。dva 实现上尽量不创建新语法，而是用依赖库本身的语法，
比如 router 的定义还是用 react-router 的 JSX 语法的方式。

```

## 做React需要会什么？
react的功能其实很单一，主要负责渲染的功能，现有的框架，比如angular是一个大而全的框架，用了angular几乎就不需要用其他工具辅助配合，但是react不一样，他只负责ui渲染，想要做好一个项目，往往需要其他库和工具的配合，比如用redux来管理数据，react-router管理路由，react已经全面拥抱es6，所以es6也得掌握，webpack就算是不会配置也要会用，要想提高性能，需要按需加载，immutable.js也得用上，还有单元测试。。。。


## React 是什么
用脚本进行DOM操作的代价很昂贵。有个贴切的比喻，把DOM和JavaScript各自想象为一个岛屿，它们之间用收费桥梁连接，js每次访问DOM，都要途径这座桥，并交纳“过桥费”,访问DOM的次数越多，费用也就越高。 因此，推荐的做法是尽量减少过桥的次数，努力待在ECMAScript岛上。因为这个原因react的虚拟dom就显得难能可贵了，它创造了虚拟dom并且将它们储存起来，每当状态发生变化的时候就会创造新的虚拟节点和以前的进行对比，让变化的部分进行渲染。整个过程没有对dom进行获取和操作，只有一个渲染的过程，所以react说是一个ui框架。

```
Virtal DOM
组件和生命周期
diff算法

```

React 从诞生之初就不支持双向绑定，React一直提倡的是单向数据流
onChange/setState()

在 Vue 中我们组合不同功能的方式是通过 mixin，而在React中我们通过 HoC (高阶组件）。

## React的组件化

react的一个组件很明显的由dom视图和state数据组成，两个部分泾渭分明。state是数据中心，它的状态决定着视图的状态。这时候发现似乎和我们一直推崇的MVC开发模式有点区别，没了Controller控制器，那用户交互怎么处理，数据变化谁来管理？然而这并不是react所要关心的事情，它只负责ui的渲染。与其他框架监听数据动态改变dom不同，react采用setState来控制视图的更新。setState会自动调用render函数，触发视图的重新渲染，如果仅仅只是state数据的变化而没有调用setState，并不会触发更新。 组件就是拥有独立功能的视图模块，许多小的组件组成一个大的组件，整个页面就是由一个个组件组合而成。它的好处是利于重复利用和维护。


## React的 Diff算法
react的diff算法用在什么地方呢？当组件更新的时候，react会创建一个新的虚拟dom树并且会和之前储存的dom树进行比较，这个比较多过程就用到了diff算法，所以组件初始化的时候是用不到的。react提出了一种假设，相同的节点具有类似的结构，而不同的节点具有不同的结构。在这种假设之上进行逐层的比较，如果发现对应的节点是不同的，那就直接删除旧的节点以及它所包含的所有子节点然后替换成新的节点。如果是相同的节点，则只进行属性的更改。

对于列表的diff算法稍有不同，因为列表通常具有相同的结构，在对列表节点进行删除，插入，排序的时候，单个节点的整体操作远比一个个对比一个个替换要好得多，所以在创建列表的时候需要设置key值，这样react才能分清谁是谁。当然不写key值也可以，但这样通常会报出警告，通知我们加上key值以提高react的性能。

![](https://github.com/bailicangdu/pxq/blob/master/screenshot/diff.png)

```
Virtal DOM (1核心) + diff
为了减少DOM更新，我们需要找渲染前后真正变化的部分，只更新这一部分DOM。而对比变化，找出需要更新部分的算法我们称之为diff算法。
diff算法不仅仅是找出节点类型的变化，它还要找出来节点的属性以及事件监听的变化。
虚拟DOM的结构可以分为三种，分别表示文本、原生DOM节点以及组件
// 原生DOM节点的vnode
{
    tag: 'div',
    attrs: {
        className: 'container'
    },
    children: []
}
对比策略
1对比文本节点
2对比非文本DOM节点
3对比属性
4对比子节点
5对比组件
```


## React组件是怎么来的

组件的创造方法为React.createClass() ——创造一个类，react系统内部设计了一套类系统，利用它来创造react组件。但这并不是必须的，我们还可以用es6的class类来创造组件,这也是Facebook官方推荐的写法。

![](https://github.com/bailicangdu/pxq/blob/master/screenshot/icon_class.png)

这两种写法实现的功能一样但是原理却是不同，es6的class类可以看作是构造函数的一个语法糖，可以把它当成构造函数来看，extends实现了类之间的继承 —— 定义一个类Main 继承React.Component所有的属性和方法，组件的生命周期函数就是从这来的。constructor是构造器，在实例化对象时调用，super调用了父类的constructor创造了父类的实例对象this，然后用子类的构造函数进行修改。这和es5的原型继承是不同的，原型继承是先创造一个实例化对象this，然后再继承父级的原型方法。了解了这些之后我们在看组件的时候就清楚很多。

当我们使用组件< Main />时，其实是对Main类的实例化——new Main，只不过react对这个过程进行了封装，让它看起来更像是一个标签。

有三点值得注意：1、定义类名字的首字母必须大写 2、因为class变成了关键字，类选择器需要用className来代替。 3、类和模块内部默认使用严格模式，所以不需要用use strict指定运行模式。


## 组件的生命周期

![](https://github.com/bailicangdu/pxq/blob/master/screenshot/react-lifecycle.png)

**组件在初始化时会触发5个钩子函数：**

  **1、getDefaultProps()**
> 设置默认的props，也可以用dufaultProps设置组件的默认属性。


  **2、getInitialState()**  
> 在使用es6的class语法时是没有这个钩子函数的，可以直接在constructor中定义this.state。此时可以访问this.props。


 **3、componentWillMount()**
> 组件初始化时只调用，以后组件更新不调用，整个生命周期只调用一次，此时可以修改state。


 **4、 render()**
>  react最重要的步骤，创建虚拟dom，进行diff算法，更新dom树都在此进行。此时就不能更改state了。


 **5、componentDidMount()**
> 组件渲染之后调用，可以通过this.getDOMNode()获取和操作dom节点，只调用一次。


**在更新时也会触发5个钩子函数：**

  **6、componentWillReceivePorps(nextProps)**
> 组件初始化时不调用，组件接受新的props时调用。


  **7、shouldComponentUpdate(nextProps, nextState)**
> react性能优化非常重要的一环。组件接受新的state或者props时调用，我们可以设置在此对比前后两个props和state是否相同，如果相同则返回false阻止更新，因为相同的属性状态一定会生成相同的dom树，这样就不需要创造新的dom树和旧的dom树进行diff算法对比，节省大量性能，尤其是在dom结构复杂的时候。不过调用this.forceUpdate会跳过此步骤。


  **8、componentWillUpdate(nextProps, nextState)**
> 组件初始化时不调用，只有在组件将要更新时才调用，此时可以修改state


  **9、render()**
> 不多说


  **10、componentDidUpdate()**
> 组件初始化时不调用，组件更新完成后调用，此时可以获取dom节点。


还有一个卸载钩子函数

  **11、componentWillUnmount()**
> 组件将要卸载时调用，一些事件监听和定时器需要在此时清除。


以上可以看出来react总共有10个周期函数（render重复一次），这个10个函数可以满足我们所有对组件操作的需求，利用的好可以提高开发效率和组件性能。


## React-Router路由

Router就是React的一个组件，它并不会被渲染，只是一个创建内部路由规则的配置对象，根据匹配的路由地址展现相应的组件。Route则对路由地址和组件进行绑定，Route具有嵌套功能，表示路由地址的包涵关系，这和组件之间的嵌套并没有直接联系。Route可以向绑定的组件传递7个属性：children，history，location，params，route，routeParams，routes，每个属性都包涵路由的相关的信息。比较常用的有children（以路由的包涵关系为区分的组件），location（包括地址，参数，地址切换方式，key值，hash值）。react-router提供Link标签，这只是对a标签的封装，值得注意的是，点击链接进行的跳转并不是默认的方式，react-router阻止了a标签的默认行为并用pushState进行hash值的转变。切换页面的过程是在点击Link标签或者后退前进按钮时，会先发生url地址的转变，Router监听到地址的改变根据Route的path属性匹配到对应的组件，将state值改成对应的组件并调用setState触发render函数重新渲染dom。

当页面比较多时，项目就会变得越来越大，尤其对于单页面应用来说，初次渲染的速度就会很慢，这时候就需要按需加载，只有切换到页面的时候才去加载对应的js文件。react配合webpack进行按需加载的方法很简单，Route的component改为getComponent，组件用require.ensure的方式获取，并在webpack中配置chunkFilename。

```javascript
const chooseProducts = (location, cb) => {
    require.ensure([], require => {
        cb(null, require('../Component/chooseProducts').default)
    },'chooseProducts')
}

const helpCenter = (location, cb) => {
    require.ensure([], require => {
        cb(null, require('../Component/helpCenter').default)
    },'helpCenter')
}

const saleRecord = (location, cb) => {
    require.ensure([], require => {
        cb(null, require('../Component/saleRecord').default)
    },'saleRecord')
}

const RouteConfig = (
    <Router history={history}>
        <Route path="/" component={Roots}>
            <IndexRoute component={index} />//首页
            <Route path="index" component={index} />
            <Route path="helpCenter" getComponent={helpCenter} />//帮助中心
            <Route path="saleRecord" getComponent={saleRecord} />//销售记录
            <Redirect from='*' to='/'  />
        </Route>
    </Router>
);

```
## 组件之间的通信


react推崇的是单向数据流，自上而下进行数据的传递，但是由下而上或者不在一条数据流上的组件之间的通信就会变的复杂。解决通信问题的方法很多，如果只是父子级关系，父级可以将一个回调函数当作属性传递给子级，子级可以直接调用函数从而和父级通信。

组件层级嵌套到比较深，可以使用上下文getChildContext来传递信息，这样在不需要将函数一层层往下传，任何一层的子级都可以通过this.context直接访问。

兄弟关系的组件之间无法直接通信，它们只能利用同一层的上级作为中转站。而如果兄弟组件都是最高层的组件，为了能够让它们进行通信，必须在它们外层再套一层组件，这个外层的组件起着保存数据，传递信息的作用，这其实就是redux所做的事情。

组件之间的信息还可以通过全局事件来传递。不同页面可以通过参数传递数据，下个页面可以用location.param来获取。其实react本身很简单，难的在于如何优雅高效的实现组件之间数据的交流。

## Redux


首先，redux并不是必须的，它的作用相当于在顶层组件之上又加了一个组件，作用是进行逻辑运算、储存数据和实现组件尤其是顶层组件的通信。如果组件之间的交流不多，逻辑不复杂，只是单纯的进行视图的渲染，这时候用回调，context就行，没必要用redux，用了反而影响开发速度。但是如果组件交流特别频繁，逻辑很复杂，那redux的优势就特别明显了。我第一次做react项目的时候并没有用redux，所有的逻辑都是在组件内部实现，当时为了实现一个逻辑比较复杂的购物车，洋洋洒洒居然写了800多行代码，回头一看我自己都不知道写的是啥，画面太感人。

先简单说一下redux和react是怎么配合的。react-redux提供了connect和Provider两个好基友，它们一个将组件与redux关联起来，一个将store传给组件。组件通过dispatch发出action，store根据action的type属性调用对应的reducer并传入state和这个action，reducer对state进行处理并返回一个新的state放入store，connect监听到store发生变化，调用setState更新组件，此时组件的props也就跟着变化。




#### 流程是这个样子的：


![](https://github.com/bailicangdu/pxq/blob/master/screenshot/simple_redux.jpg)

值得注意的是connect，Provider，mapStateToProps,mapDispatchToProps是react-redux提供的，redux本身和react没有半毛钱关系，它只是数据处理中心，没有和react产生任何耦合，是react-redux让它们联系在一起。


#### 接下来具体分析一下，redux以及react-redux到底是怎么实现的。


#### 先上一张图

![](https://github.com/bailicangdu/pxq/blob/master/screenshot/all_redux.png)

明显比第一张要复杂，其实两张图说的是同一件事。从上而下慢慢分析：

### 先说说redux：

#### redux主要由三部分组成：store，reducer，action。


**store**是一个对象，它有四个主要的方法：

**1、dispatch:**
>  用于action的分发——在createStore中可以用middleware中间件对dispatch进行改造，比如当action传入dispatch会立即触发reducer，有些时候我们不希望它立即触发，而是等待异步操作完成之后再触发，这时候用redux-thunk对dispatch进行改造，以前只能传入一个对象，改造完成后可以传入一个函数，在这个函数里我们手动dispatch一个action对象，这个过程是可控的，就实现了异步。

**2、subscribe：**
> 监听state的变化——这个函数在store调用dispatch时会注册一个listener监听state变化，当我们需要知道state是否变化时可以调用，它返回一个函数，调用这个返回的函数可以注销监听。
let unsubscribe = store.subscribe(() => {console.log('state发生了变化')})

**3、getState：**
> 获取store中的state——当我们用action触发reducer改变了state时，需要再拿到新的state里的数据，毕竟数据才是我们想要的。getState主要在两个地方需要用到，一是在dispatch拿到action后store需要用它来获取state里的数据，并把这个数据传给reducer，这个过程是自动执行的，二是在我们利用subscribe监听到state发生变化后调用它来获取新的state数据，如果做到这一步，说明我们已经成功了。

**4、replaceReducer:**
> 替换reducer，改变state修改的逻辑。

store可以通过createStore()方法创建，接受三个参数，经过combineReducers合并的reducer和state的初始状态以及改变dispatch的中间件，后两个参数并不是必须的。store的主要作用是将action和reducer联系起来并改变state。


**action:**
>action是一个对象，其中type属性是必须的，同时可以传入一些数据。action可以用actionCreactor进行创造。dispatch就是把action对象发送出去。

**reducer:**
>reducer是一个函数，它接受一个state和一个action，根据action的type返回一个新的state。根据业务逻辑可以分为很多个reducer，然后通过combineReducers将它们合并，state树中有很多对象，每个state对象对应一个reducer，state对象的名字可以在合并时定义。

像这个样子：
```javascript
const reducer = combineReducers({
     a: doSomethingWithA,
     b: processB,
     c: c
})
```
**combineReducers:**
>其实它也是一个reducer，它接受整个state和一个action，然后将整个state拆分发送给对应的reducer进行处理，所有的reducer会收到相同的action，不过它们会根据action的type进行判断，有这个type就进行处理然后返回新的state，没有就返回默认值，然后这些分散的state又会整合在一起返回一个新的state树。

接下来分析一下整体的流程，首先调用store.dispatch将action作为参数传入，同时用getState获取当前的状态树state并注册subscribe的listener监听state变化，再调用combineReducers并将获取的state和action传入。combineReducers会将传入的state和action传给所有reducer，并根据action的type返回新的state，触发state树的更新，我们调用subscribe监听到state发生变化后用getState获取新的state数据。

redux的state和react的state两者完全没有关系，除了名字一样。

**上面分析了redux的主要功能，那么react-redux到底做了什么？**


## React-Redux

如果只使用redux，那么流程是这样的：
> component --> dispatch(action) --> reducer --> subscribe --> getState --> component

用了react-redux之后流程是这样的：
> component --> actionCreator(data) --> reducer --> component

store的三大功能：dispatch，subscribe，getState都不需要手动来写了。react-redux帮我们做了这些，同时它提供了两个好基友Provider和connect。

**Provider**是一个组件，它接受store作为props，然后通过context往下传，这样react中任何组件都可以通过context获取store。也就意味着我们可以在任何一个组件里利用dispatch(action)来触发reducer改变state，并用subscribe监听state的变化，然后用getState获取变化后的值。但是并不推荐这样做，它会让数据流变的混乱，过度的耦合也会影响组件的复用，维护起来也更麻烦。

__connect --connect(mapStateToProps, mapDispatchToProps, mergeProps, options)__ 是一个函数，它接受四个参数并且再返回一个函数--wrapWithConnect，wrapWithConnect接受一个组件作为参数wrapWithConnect(component)，它内部定义一个新组件Connect(容器组件)并将传入的组件(ui组件)作为Connect的子组件然后return出去。

所以它的完整写法是这样的：connect(mapStateToProps, mapDispatchToProps, mergeProps, options)(component)

**mapStateToProps(state, [ownProps])：**
>mapStateToProps 接受两个参数，store的state和自定义的props，并返回一个新的对象，这个对象会作为props的一部分传入ui组件。我们可以根据组件所需要的数据自定义返回一个对象。ownProps的变化也会触发mapStateToProps

```javascript
function mapStateToProps(state) {
   return { todos: state.todos };
}
```

**mapDispatchToProps(dispatch, [ownProps])：**

> mapDispatchToProps如果是对象，那么会和store绑定作为props的一部分传入ui组件。如果是个函数，它接受两个参数，bindActionCreators会将action和dispatch绑定并返回一个对象，这个对象会和ownProps一起作为props的一部分传入ui组件。所以不论mapDispatchToProps是对象还是函数，它最终都会返回一个对象，如果是函数，这个对象的key值是可以自定义的

```javascript
function mapDispatchToProps(dispatch) {
   return {
      todoActions: bindActionCreators(todoActionCreators, dispatch),
      counterActions: bindActionCreators(counterActionCreators, dispatch)
   };
}
```

mapDispatchToProps返回的对象其属性其实就是一个个actionCreator，因为已经和dispatch绑定，所以当调用actionCreator时会立即发送action，而不用手动dispatch。ownProps的变化也会触发mapDispatchToProps。

**mergeProps(stateProps, dispatchProps, ownProps)：**
> 将mapStateToProps() 与 mapDispatchToProps()返回的对象和组件自身的props合并成新的props并传入组件。默认返回 Object.assign({}, ownProps, stateProps, dispatchProps) 的结果。

**options：**
> pure = true 表示Connect容器组件将在shouldComponentUpdate中对store的state和ownProps进行浅对比，判断是否发生变化，优化性能。为false则不对比。

其实connect函数并没有做什么，大部分的逻辑都是在它返回的wrapWithConnect函数内实现的，确切的说是在wrapWithConnect内定义的Connect组件里实现的。

### 下面是一个完整的 react --> redux --> react 流程：


一、Provider组件接受redux的store作为props，然后通过context往下传。

二、connect函数在初始化的时候会将mapDispatchToProps对象绑定到store，如果mapDispatchToProps是函数则在Connect组件获得store后，根据传入的store.dispatch和action通过bindActionCreators进行绑定，再将返回的对象绑定到store，connect函数会返回一个wrapWithConnect函数，同时wrapWithConnect会被调用且传入一个ui组件，wrapWithConnect内部使用class Connect extends Component定义了一个Connect组件，传入的ui组件就是Connect的子组件，然后Connect组件会通过context获得store，并通过store.getState获得完整的state对象，将state传入mapStateToProps返回stateProps对象、mapDispatchToProps对象或mapDispatchToProps函数会返回一个dispatchProps对象，stateProps、dispatchProps以及Connect组件的props三者通过Object.assign()，或者mergeProps合并为props传入ui组件。然后在ComponentDidMount中调用store.subscribe，注册了一个回调函数handleChange监听state的变化。

三、此时ui组件就可以在props中找到actionCreator，当我们调用actionCreator时会自动调用dispatch，在dispatch中会调用getState获取整个state，同时注册一个listener监听state的变化，store将获得的state和action传给combineReducers，combineReducers会将state依据state的key值分别传给子reducer，并将action传给全部子reducer，reducer会被依次执行进行action.type的判断，如果有则返回一个新的state，如果没有则返回默认。combineReducers再次将子reducer返回的单个state进行合并成一个新的完整的state。此时state发生了变化。dispatch在state返回新的值之后会调用所有注册的listener函数其中包括handleChange函数，handleChange函数内部首先调用getState获取新的state值并对新旧两个state进行浅对比，如果相同直接return，如果不同则调用mapStateToProps获取stateProps并将新旧两个stateProps进行浅对比，如果相同，直接return结束，不进行后续操作。如果不相同则调用this.setState()触发Connect组件的更新，传入ui组件，触发ui组件的更新，此时ui组件获得新的props，react --> redux --> react 的一次流程结束。


**上面的有点复杂，简化版的流程是：**

一、Provider组件接受redux的store作为props，然后通过context往下传。

二、connect函数收到Provider传出的store，然后接受三个参数mapStateToProps，mapDispatchToProps和组件，并将state和actionCreator以props传入组件，这时组件就可以调用actionCreator函数来触发reducer函数返回新的state，connect监听到state变化调用setState更新组件并将新的state传入组件。

connect可以写的非常简洁，mapStateToProps，mapDispatchToProps只不过是传入的回调函数，connect函数在必要的时候会调用它们，名字不是固定的，甚至可以不写名字。

简化版本：
```javascript
connect(state => state, action)(Component);
```



## 项目搭建

上面说了react，react-router和redux的知识点。但是怎么样将它们整合起来，搭建一个完整的项目。

1、先引用 react.js，redux，react-router 等基本文件，建议用npm安装，直接在文件中引用。

2、从 react.js，redux，react-router 中引入所需要的对象和方法。
```javascript
import React, {Component, PropTypes} from 'react';
import ReactDOM, {render} from 'react-dom';
import {Provider, connect} from 'react-redux';
import {createStore, combineReducers, applyMiddleware} from 'redux';
import { Router, Route, Redirect, IndexRoute, browserHistory, hashHistory } from 'react-router';
```
3、根据需求创建顶层ui组件，每个顶层ui组件对应一个页面。

4、创建actionCreators和reducers，并用combineReducers将所有的reducer合并成一个大的reduer。利用createStore创建store并引入combineReducers和applyMiddleware。

5、利用connect将actionCreator，reuder和顶层的ui组件进行关联并返回一个新的组件。

6、利用connect返回的新的组件配合react-router进行路由的部署，返回一个路由组件Router。

7、将Router放入最顶层组件Provider，引入store作为Provider的属性。

8、调用render渲染Provider组件且放入页面的标签中。

可以看到顶层的ui组件其实被套了四层组件，Provider，Router，Route，Connect，这四个组件并不会在视图上改变react，它们只是功能性的。

通常我们在顶层的ui组件打印props时可以看到一堆属性：

![](https://github.com/bailicangdu/pxq/blob/master/screenshot/react_props.png)

上图的顶层ui组件属性总共有18个，如果刚刚接触react，可能对这些属性怎么来的感到困惑，其实这些属性来自五个地方：

组件自定义属性1个，actionCreator返回的对象6个，reducer返回的state4个，Connect组件属性0个，以及Router注入的属性7个。


### React 重新渲染问题
```
PureRenderMixin

import PureRenderMixin from 'react-addons-pure-render-mixin';
class FooComponent extends React.Component {
  constructor(props) {
    super(props);
    this.shouldComponentUpdate = PureRenderMixin.shouldComponentUpdate.bind(this);
  }

  render() {
    return <div className={this.props.className}>foo</div>;
  }
}

在组件中重写 shouldComponentUpdate，PureRenderMixin源码中对PureRenderMixin.shouldComponentUpdate的定义是这样

shouldComponentUpdate(nextProps, nextState) {
    return shallowCompare(this, nextProps, nextState);
}


在 React 的最新版本里面，提供了 React.PureComponent 的基础类，而不需要使用这个插件。
```

### [React SSR](https://www.jianshu.com/p/47c8e364d0bc?appinstall=1&mType=Group)
```
我们已经学会了React15 和 React16的服务端渲染，并可以做小小的seo优化。
大概可以总结为两点：
1.搭建node环境，可以正式访问到线上文件（build包）
2.使用renderToString 把骨架拼接好返回给前端
但是中间需要注意的点很多处理css jsx 图片 babel 。

为什么要实现服务端渲染(SSR):
1、解决单页面应用的 SEO 
单页应用页面大部分主要的 HTML并不是服务器返回，服务器只是返回一大串的 脚本，页面上看到的大部分内容都是由脚本生成，对于一般网站影响不大，但是对于一些依赖搜索引擎带来流量的网站来说则是致命的，搜索引擎无法抓取页面相关内容，也就是用户搜不到此网站的相关信息，自然也就无流量可言。 
 
2、解决渲染白屏 
因为页面 HTML由服务器端返回的脚本生成，一般来说这种脚本的体积都不会太小，客户端下载需要时间，浏览器解析以生成页面元素也需要时间，这必然会导致页面的显示速度比传统服务器端渲染得要慢，很容易出现首页白屏的情况，甚至如果浏览器禁用了 JS，那么将直接导致页面连基本的元素都看不到。
```

#### 高阶函数 ref
```
function logProps(Component) {
  class LogProps extends React.Component {
    render() {
      const {forwardedRef, ...rest} = this.props;

      // Assign the custom prop "forwardedRef" as a ref
      return <Component ref={forwardedRef} {...rest} />;
    }
  }

  // Note the second param "ref" provided by React.forwardRef.
  // We can pass it along to LogProps as a regular prop, e.g. "forwardedRef"
  // And it can then be attached to the Component.
  return React.forwardRef((props, ref) => {
    return <LogProps {...props} forwardedRef={ref} />;
  });
}


const ref = React.createRef();

// The FancyButton component we imported is the LogProps HOC.
// Even though the rendered output will be the same,
// Our ref will point to LogProps instead of the inner FancyButton component!
// This means we can't call e.g. ref.current.focus()
<FancyButton
  label="Click Me"
  handleClick={handleClick}
  ref={ref}
/>;


```

#### react vue 比较
```
Vue性能上更有优势，因为 Vue 的 Virtual DOM 实现相对更为轻量一些，整体大小比react.js更小更轻便

在VUE.20更新以后。它更是吸取了 React 和 Angular 的教训，同时也吸收了它们的成功之处。我们看到的 Vue.js 是轻量级且容易学习掌握的新型mvvm框架。

1\Vue 的这个特点使得开发者不再需要考虑此类优化，从而能够更好地专注于应用本身。


计算差异的算法是高性能框架的秘密所在，React和Vue在实现上有点不同。

Vue宣称可以更快地计算出Virtual DOM的差异，这是由于它在渲染过程中，会跟踪每一个组件的依赖关系，不需要重新渲染整个组件树。

而对于React而言，每当应用的状态被改变时，全部子组件都会重新渲染。当然，这可以通过shouldComponentUpdate这个生命周期方法来进行控制，但Vue将此视为默认的优化。

小结：如果你的应用中，交互复杂，需要处理大量的UI变化，那么使用Virtual DOM是一个好主意。如果你更新元素并不频繁，那么Virtual DOM并不一定适用，性能很可能还不如直接操控DOM。
```

Vuex 和 Redux 的区别
从表面上来说，store 注入和使用方式有一些区别。

在 Vuex 中，$store 被直接注入到了组件实例中，因此可以比较灵活的使用：

使用 dispatch 和 commit 提交更新
通过 mapState 或者直接通过 this.$store 来读取数据
在 Redux 中，我们每一个组件都需要显示的用 connect 把需要的 props 和 dispatch 连接起来。

另外 Vuex 更加灵活一些，组件中既可以 dispatch action 也可以 commit updates，而 Redux 中只能进行 dispatch，并不能直接调用 reducer 进行修改。

从实现原理上来说，最大的区别是两点：

Redux 使用的是不可变数据，而Vuex的数据是可变的。Redux每次都是用新的state替换旧的state，而Vuex是直接修改
Redux 在检测数据变化的时候，是通过 diff 的方式比较差异的，而Vuex其实和Vue的原理一样，是通过 getter/setter来比较的（如果看Vuex源码会知道，其实他内部直接创建一个Vue实例用来跟踪数据变化）
而这两点的区别，其实也是因为 React 和 Vue的设计理念上的区别。React更偏向于构建稳定大型的应用，非常的科班化。相比之下，Vue更偏向于简单迅速的解决问题，更灵活，不那么严格遵循条条框框。因此也会给人一种大型项目用React，小型项目用 Vue 的感觉。


