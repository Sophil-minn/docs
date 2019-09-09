# JS 知识

### js 数据类型
```javascript
基础数据类型：Undefined、Null、Boolean、Number、String、Symbol

复杂数据类型：Object、Array、Function、Date RegExp 等

0、六种弱数据类型 = 五种基本数据类型（Number,String,Boolean,Undefined,Null） + 一种复杂数据类型（Object）

typeof xx 类型检测的结果: "number"|"string"|"boolean"|"undefined"|"object"|"function"|"symbol"

1、Array对象说它是数组，其实是一个从哈希表扩展的结构体。因此它可以提供push、splice等一些列操作。这就意味着他们的效率是很低的
2、强类型的数组，可以创建真正的数组，操作直接访问内存

强类型数组有三种基本类型：
　　Int 整数
　　Uint 无符号整数
　　Float IEEE754浮点数
根据这些基本类型可以引申出8种类数组：
　　Int8Array
　　Uint8Array
   Uint8ClampedArray
　　Int16Array
　　Uint16Array
　　Int32Array
　　Uint32Array
　　Float32Array
　　Float64Array
```
### 深克隆需要注意的问题

1. 入参类型检查
1. 当数据量较大并层次很深时，使用递归函数会导致栈溢出,而此处又无法使用尾递归,该怎么处理
1. typeof Date,Math,RegExp,Function,Null 都返回Object 该怎么处理
1. Date,RegExp,Function 应该如何克隆
1. 当对象的两个属性v,s引用同一个对象时，克隆之后也应该引用同一个对象  !!!
1. 对象的原型prototype 如何克隆
1. 属性的getOwnPropertyDescriptor如何克隆
1. for-in遍历的是原型链，需要用hasOwnProperty 判断是否是自有属性
```
如果只是拷贝 自身可枚举属性，就可以只用 Object.assign 方法；
如果是要拷贝原型上的属性，就需要 Object.assign , Object.create, Object.getPrototypeOf 方法结合使用
如果是拷贝get /set 属性，就需要 结合 Ojbect.getOwnPropertyDescriptors 方法
```

### js 数据类型检测
```javascript
1、typeof 通常用来 判断 变量 是否为 undefined
typeof 检测基本类型(number,string,boolean,undefined,symbol)+复杂类型('object','function')：
  typeof   123　　      //number
  typeof   'abc'　　    //string
  typeof    true       //boolean
  typeof    undefined  //undefined

  typeof    null        //object
  typeof    { }         //object
  typeof    [ ]         //object
  typeof    new Number  //object
  typeof    new String  //object
  typeof    new Boolean //object
  typeof    new Array   //object
  typeof    new Set()   //object
  typeof    new Map()   //object
  typeof    new Date()   //object
  typeof    new RegExp()   //object

  function a(){}
  typeof a              //function
  typeof String         //function
  typeof Number         //function
  typeof Symbol         //function

  typeof Symbol()         //symbol



2、instanceof 检测 对象的 所属类，但无法输出 所属类
    eg.  L instanceof R  即 L.__proto__.__proto__ ..... === R.prototype
    原理：检测instance左侧的变量.__proto__原型链上，是否存在instance右侧的变量.prototype原型

    function A(){}
    var a = new A();
    A instanceof Function //true
    a instanceof A        // true
    a instanceof Object   //true

3、Object.prototype.toString.call 输出 所属类，可自定义

    Object.prototype.toString.call(变量)：检测类型Object

    eg.
        function A(){}
        // 重写 toString
        A.prototype.toString = function(){
            return "[object A]"
        }

        // 检测 A 类
        Object.prototype.toString.call(A)


```

### [js 类型转化](https://www.cnblogs.com/Juphy/p/7085197.html)

1+"1" == "1" + 1 == "11" // (number, boolean)与string ,视string

不同类型进行运算时, toString();
Number -> new String(Number)


null,undefined 与另一个操作数进行运算, 类型转化规则视另一个而转为相应类型, 两个都是 null或undefined 转为 number
null+1 //1  null->Number 0, undefined -> Number NaN
null+"1" //"null1" null->String "null"
null+undefined //NaN undefined->Number NaN
null+true // 1

function 与其它转运算,视 function而定转为 String后进行运算
(function(){}) + 1 
(function(){}) + "1"
(function(){}) + true
(function(){}) + {}

{} + 1 // 1
{} + "1" //1
{} + true // 1

即 function > {} > string > number > boolean > (null|undefined)

-- string - number - string -number - number - ...

优化级低的 总是 随着 优化级高的 类型的变化而调整变化 方向
```
Boolean:
1、所有对象转换为Bool类型都为true
2、只有以下几个数值转换为Bool为false: undefined/null/0/NAN/""

String：
1、原始数据类型转换为字符串，相当于直接把原数据用引号包起来
2、对象转字符串，相当于 .toString(), 若 toString 一样，.valueOf
3、[].toString()  // ""

Number:
1、
2、如果是对象，则调用对象的valueOf()方法，然后依据前面的规则转换返回的值。如果转换的结果是NaN，则调用对象的toString()方法，再次依照前面的规则转换返回的字符串值
3、Number(null); // 0
4、Number('undefined'); // NAN
5、Number(true); // 1
   Number(false); //0
6、字符串转数值，能解析的返回数值，不能解析的返回NAN
  Number('123'); //123
  Number('123shj'); //NAN
  parseInt('123shj'); // 123
  Number('\t\v\r12.34\n'); // 12.34
  parseInt('\t\v\r12.34\n'); // 12

隐式转化：
1、数字和字符串、布尔类型、数组进行比较时，字符串（或布尔类型、或数组）先转换为数字（Number），再进行比较；数组转数字请参看后文。
2、字符串和布尔类型比较，看完下面的代码我疯了。如果一定要给一个解释，那么一定是进行比较的两个数据同时经过Number()的洗礼后再进行比较。数组和布尔类型的比较也如此。
3、undefined 除了和null进行非全等比较返回true,其它均返回false。null 除了和 undefined进行非全等比较返回true,其它均返回false。
4、数组（或对象）和字符串进行比较时，数组（或对象）会转换成字符串再进行比较。


valueOf():
对象	   返回值
Date	  存储的时间是从 1970 年 1 月 1 日午夜开始计的毫秒数 UTC。
Array	  数组的元素被转换为字符串，这些字符串由逗号分隔，连接在一起。其操作与 Array.toString 和 Array.join 方法相同。
Boolean	  Boolean 值。
Function  函数本身。
Number	  数字值。
Object	  对象本身。
String	  字符串值。

toString:
对象	   返回值
Array	  将 Array 的元素转换为字符串。结果字符串由逗号分隔，且连接起来。
Boolean	  如果 Boolean 值是 true，则返回 “true”。否则，返回 “false”。
Date	  返回日期的文字表示法。
Error	  返回一个包含相关错误信息的字符串。
Function  返回如下格式的字符串，其中 functionname 是被调用 toString 方法函数的名称：function functionname( ) { [native code] }
Number	  返回数字的文字表示。
String	  返回 String 对象的值。
默认	   返回 “[object objectname]”，其中 objectname 是对象类型的名称。
```

### js  强类型数组TypedArray
```
ArrayBuffer的功能和C语言中的malloc相似
      var buf=new ArrayBuffer(4);
      var a=new Uint16Array(buf);
      console.log(a);

TypedArray.prototype.copyWithin(target, start[, end = this.length]) 
TypedArray.prototype.entries() 
TypedArray.prototype.every(callbackfn, thisArg?) 
TypedArray.prototype.fill(value, start=0, end=this.length) 
TypedArray.prototype.filter(callbackfn, thisArg?) 
TypedArray.prototype.find(predicate, thisArg?) 
TypedArray.prototype.findIndex(predicate, thisArg?) 
TypedArray.prototype.forEach(callbackfn, thisArg?) 
TypedArray.prototype.indexOf(searchElement, fromIndex=0) 
TypedArray.prototype.join(separator) 
TypedArray.prototype.keys() 
TypedArray.prototype.lastIndexOf(searchElement, fromIndex?) 
TypedArray.prototype.map(callbackfn, thisArg?) 
TypedArray.prototype.reduce(callbackfn, initialValue?) 
TypedArray.prototype.reduceRight(callbackfn, initialValue?) 
TypedArray.prototype.reverse() 
TypedArray.prototype.slice(start=0, end=this.length) 
TypedArray.prototype.some(callbackfn, thisArg?) 
TypedArray.prototype.sort(comparefn) 
TypedArray.prototype.toLocaleString(reserved1?, reserved2?) 
TypedArray.prototype.toString() 
TypedArray.prototype.values() 
```

### 原型链
```
一直不知道如何描述这个概念, 原型链,字面意思包含两个方面内容, 一是原型, 一是链, 它描述的是一种继承的链式结构,或者说是属性及方法的查找方向, 
它查找自己属性或方法时, 如果本次找不到就会去上一级原型上找, 找不到会再向上一级找
```

### js reduce
```
第一个参数:接受一个函数，函数有四个参数
1、上一次的值;
2、当前值;
3、当前值的索引;
4、数组;

[0, 1, 2, 3, 4].reduce(function(previousValue, currentValue, index, array){
 return previousValue + currentValue;
});

第二个参数:我们可以把这个参数作为第一次调用callback时的第一个参数
```

### Set, WeakSet, Map, WeakMap
```
Set 没有重复的值
WeakSet 没有重复的值,但是它只能用于存储对象,没有引用的对象将被垃圾回收
Map 有序键值对集合
WeakMap 有序键值对集合,只不过 WeakMap 的 key 只能是非空对象
```


### js 自由变量 与 作用域
```
自由变量: 非 A 作用域 定义的变量 x，在 A 中 调用 x，相对于 A 作用域，x 是自由变量
静态作用域：定义时 所在 作用域
查找变量：
1、本地作用域
2、被调用函数 定义的 作用域 
3、继续向 父作用域 ，直到 全局作用域

变量查找顺序： 本地作用域  ->  定义作用域  ->  ... -> 全局作用域

eg_01 外部定义.
var x = 10;
function fn() {
    console.log(x)
}

function show(f) {
    var x  = 20;
    f();            //10, 而非 20
}

show(fn)

eg_02 内部定义.
var a = 10;

function fn() {
    var b = 20;

    function bar() {
        console.log(a + b)   //定义时 a = 10, b = 20
    }

    return bar
}

var x = fn(),
    b = 200;

x();
```


### js 闭包
```
官方解释：一个拥有许多变量和绑定了这些变量的环境的表达式（通常是一个函数），因而这些变量也是该表达式的一部分。
用途：
1、匿名自执行函数
2、结果缓存
3、封装
4、实现类和继承

一句话说闭包:
函数的作用域, 不取决于运行时的环境, 而取决于函数声明时的环境.
```
### js 栈与堆
```
栈内存和堆内存与垃圾回收机制有关, 为了使程序运行时占用的内存最小。

栈(stack)会自动分配内存空间，会自动释放
堆(heap)动态分配的内存，大小不定也不会自动释放

基本类型：存放在栈内存中，简单的数据段，占据固定大小的空间(Undefined,String,Boolean,Null,Number)
引用类型：存放在堆内存中,包含引用类型的变量实际上保存的指针(对象，数组，函数)，指那些可能由多个值构成的对象

栈:
  优势是，存取速度比堆要快，仅次于直接位于CPU中的寄存器。
  缺点是，存在栈中的数据大小与生存期必须是确定的，缺乏灵活性。
```

### JS 高级函数

- js 惰性函数
```
惰性载入表示函数执行的分支只会在函数第一次掉用的时候执行，在第一次调用过程中，该函数会被覆盖为另一个按照合适方式执行的函数，这样任何对原函数的调用就不用再经过执行的分支了

eg.

var addEvent = function(type, element, fun){
    if(window.addEventListener) {
        addEvent = function(type, element, fun){
            element.addEventListener(type, fun, false);
        }
    } else if(window.attachEvent){
        addEvent = function(type, element, fun){
            element.attachEvent('on' + type, fun);
        }
    } else {
        addEvent = function (type, element, fun) {
            element['on' + type] = fun;
        }
    }

    return addEvent(type, element, fun);
    
}

总结：函数在内部重新定义，覆盖
1、何时使用 惰性函数
    a) 应用频繁，如果只用一次，是体现不出它的优点出来的，用的次数越多，越能体现这种模式的优势所在；
    b) 固定不变，一次判定，在固定的应用环境中不会发生改变；

```

- js 函数柯里化
```
定义1：柯里化通常也称分步求值，其含义是给函数分步传递参数，每次传递参数后部分应用参数，并返回一个更具体的函数接受剩下的参数，这中间可嵌套多层这样的接受部分参数函数，直至返回最后结果。

定义2：柯里化是这样一个过程，把接受多参 变成接受 单一参数

fn(a,b,c,d)=>fn(a)(b)(c)(d)；

fn(a,b,c,d)=>fn(a，b)(c)(d)；

fn(a,b,c,d)=>fn(a)(b，c，d)；

......

再或者这样：

fn(a,b,c,d)=>fn(a)(b)(c)(d)()；

fn(a,b,c,d)=>fn(a)；fn(b)；fn(c)；fn(d)；fn()；

但不是这样：

fn(a,b,c,d)=>fn(a)；

fn(a,b,c,d)=>fn(a，b)；

......

eg.
var currying = function (fn) {
    var _args = [];
    return function () {
        1、无参数时 调用 fn 计算, 延迟计算
        if (arguments.length === 0) {
            return fn.apply(this, _args);
        }
        2、存储参数 (_args += arguments)
        Array.prototype.push.apply(_args, [].slice.call(arguments));
        return arguments.callee;
    }
};

var multi=function () {
    var total = 0;
    for (var i = 0, c; c = arguments[i++];) {
        total += c;
    }
    return total;
};

var sum = currying(multi);  

sum(100,200)(300);
sum(400);
console.log(sum());     // 1000  （空白调用时才真正计算）
```

#### js 回调函数

- 同步回调
- 异步回调 - 实现异步编程

```
1、为什么需要异步
答：同步有局限性，
单线程 = js执行（CPU 无法有效利用） + 渲染（界面的卡死）
既：js是单线程。单线程碰到阻塞就楞b了(阻塞在那边)，所以要用异步。

```

### js 异步编程
```
ES6 以前:
    回调函数
    事件监听（事件发布/订阅）
    封装 Promise 对象

ES6:
    Generator 函数
    原生 Promise 对象

ES7:
    async 和 await


1、JS 异步机制 = 浏览器事件循环 + 任务队列
2、浏览器只有一个事件循化，和多个 任务队列(任务分类，方便控制各类任务的优先级)
3、异步实现函数：setTimeout, setInterval, setImmediate，process.nextTick, Promises，Object.observe, MutationObserver

eg.
function f1(callbak){
　　　　setTimeout(function () {
　　　　　　// f1的任务代码
　　　　　　callback()
　　　　}, 1000);
}
```

### JS 继承

    原型属性和方法（挂在prototype中）、实例属性和方法（写在 构造函数 中）
    
    1、可以多继承
    2、父类属性、方法动态共享
    3、实例即是子类实例也是父类实例
    4、可向父类实例传参
    5、不要浪费内存、提交效率


#### 构造继承

- 继承父类的实例属性和方法

```
function Cat(name){
  Animal.call(this);
  this.name = name || 'Tom';
}
```

    1. 可以实现多继承（call多个父类对象）
    2. 创建子类实例时，可以向父类传递参数
    
    1. 只能继承父类的实例属性和方法，不能继承原型属性/方法
    2. 实例并不是父类的实例，只是子类的实例  cat instanceof Animal // false



#### 原型链继承

- 继承父类的原型属性和方法

```
function Tmp(){}
Tmp.prototype = Animal.prototype;
// 只把 Animal 中 prototype 中属性方法 挂载到 Cat 中 prototype
Cat.prototype = new Tmp();
```

    1. 父类新增原型方法/原型属性，子类都能访问到
    2. 简单，易于实现
    
    1. 无法实现多继承
    2. 为子类新增原型属性和方法，必须要在`new Animal()`这样的语句之后执行
    3. 创建子类实例时，无法向父类构造函数传参




##### 寄生组合继承

- STEP1 给实例属性和方法
- STEP2 给原型链属性和方法
- STEP3 修复原型链的构建函数指向

```
function Cat(name){
  Animal.call(this);
  this.name = name || 'Tom';
}
(function(){
  // 创建一个没有实例方法的类
  var Super = function(){};
  Super.prototype = Animal.prototype;
  //将实例作为子类的原型
  Cat.prototype = new Super();
  // 需要修复下构造函数
  Cat.prototype.constructor = Cat;
})();

升级版：
Function.prototype.mulcall = function(source){
	if(source instanceof Array) {
  		for(var i, len=source.length; i<len; i++){
          source[i].call(this);
      }
	} else if(source instanceof Object){
  		
	}
}
```

#### 实例继承-只继承父类实例

```
function Cat(name){
  var instance = new Animal();
  instance.name = name || 'Tom';
  return instance;
}
```

1. 实例是父类的实例，不是子类的实例 cat instanceof Cat  // false
2. 不支持多继承


### 正则

- 字符串.replace(正则,新的字符串/回调函数): 替换成的结果
- 字符串.match(正则): null or [ 匹配内容 ]
- 正则.exec(字符串): null or [ 匹配内容 ]
- 正则.test(字符串): true or false
```
test 测试有没有匹配
exec/match 给出匹配的内容 
replace等给出正则后的结果 
```

- 匹配
```
最长匹配（贪婪匹配）：
最短匹配（非贪婪匹配）：

```
- 匹配中的捕获组
```
$n：匹配第n个捕获组的内容，n取0-9
$nn：匹配第nn个捕获组内容，nn取01-99
$`：匹配子字符串之后的字符串
$'：匹配子字符串之前的字符串
$&：匹配整个模式得字符串
$$：表示$符号本身
```

- ss
```
g: 全局
^&: 字符串全匹配
([ab])\1 相当于 (aa|bb)
```

- 转义字符
```
\s : 空格
\S : 非空格
\d : 数字
\D : 非数字
\w : 字符 ( 字母 ，数字，下划线_ )
\W : 非字符
.（点）——任意字符
. : 真正的点
\b : 独立的部分 （ 起始，结束，空格 ）
\B : 非独立的部分
```
![%E5%AD%97%E7%AC%A6%E5%92%8C%E4%BD%8D%E7%BD%AE.png](https://files.jb51.net/file_images/article/201704/201704061304452.png)

- 案例
```
只能输入数字和英文的
​	
<input 
onkeyup="value=value.replace(/[\W]/g,'') " 
onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
ID="Text1" 
NAME="Text1">

String.prototype.replace([RegExp|String], [String|Function])
```

```
String.prototype.trim = function(){
    /**
     * @param rs：匹配结果
     * @param $1:第1个()提取结果
     * @param $2:第2个()提取结果
     * @param offset:匹配开始位置
     * @param source：原始字符串
     */
    this.replace(/(^\s+)|(\s+$)/g,function(rs,$1,$2,offset,source){
        //arguments中的每个元素对应一个参数
        console.log(arguments);
    });
};
" abcd ".trim();
 
输出结果：
 
[" ", " ", undefined, 0, " abcd "] //第1次匹配结果
[" ", undefined, " ", 5, " abcd "] //第2次匹配结果
```

### JS "==" 与 "==="
```
==  要先进行类型转换，再比较
=== 不做类型转换

一言以蔽之：==先转换类型再比较，===先判断类型，如果不是同一类型直接为false。

先说 ===，这个比较简单。下面的规则用来判断两个值是否===相等： 
1、如果类型不同，就[不相等] 
2、如果两个都是数值，并且是同一个值，那么[相等]；(！例外)的是，如果其中至少一个是NaN，那么[不相等]。（判断一个值是否是NaN，只能用isNaN()来判断） 
3、如果两个都是字符串，每个位置的字符都一样，那么[相等]；否则[不相等]。 
4、如果两个值都是true，或者都是false，那么[相等]。 
5、如果两个值都引用同一个对象或函数，那么[相等]；否则[不相等]。 
6、如果两个值都是null，或者都是undefined，那么[相等]。 
再说 ==，根据以下规则： 
1)原始类型的值

原始类型的数据会转换成数值类型再进行比较。字符串和布尔值都会转换成数值。

(2)对象与原始类型值比较

对象（这里指广义的对象，包括数值和函数）与原始类型的值比较时，对象转化成原始类型的值，再进行比较。

(3)undefined和null

undefined和null与其他类型的值比较时，结果都为false，它们互相比较时结果为true。

(4)相等运算符的缺点

相等运算符隐藏的类型转换，会带来一些违反直觉的结果。
```

### js 类型比对
```
1、对于Array,Object等高级类型，进行“指针地址”比较, ==和===是没有区别的
2、基础类型与高级类型，将高级转化为基础类型，进行“值”比较，==和===是有区别的

[]==null           //false
[]==undefined      //false
0==null             //false
0==undefined        //false
""==undefined       //false
false==null         // false
false==!null        // false

null==undefined     //true

[]==[]              // false
{}=={}              // false

[]==0               //true
[]==""              //true

0==[]==""==false //true

null==true // false
!null==true // true

0=={} // false
{}==0 // SyntaxError
```

### js 字符串与二进制
```
//["49", "20", "6c", "6f", "76", "65", "20", "79", "6f", "75"];
let str="I love you"
str.split("").map((char)=>{
  // 获取 字符二进制码
  let code = char.charCodeAt(0)
  // 十六进制
  let uint16String = code.toString(16)
  return uint16String
})

let binaryStr = "49206c6f766520796f75"; 
// 每两个字符分组
let binaryArr = binaryStr.match(/.{2}/g);
let intArr = binaryArr.map((item)=>{
  let int10 = parseInt(item, 16)
  return int10
})

String.fromCharCode(...intArr)
或者
let win1251decoder = new TextDecoder('windows-1251');
bytes = new Uint8Array(intArr);
console.log(win1251decoder.decode(bytes));

//
xhr.responseType = 'arraybuffer';
xhr.onreadystatechange = function () {
  if (req.readyState === 4 ) {
    var arrayResponse = xhr.response;
    var dataView = new DataView(arrayResponse);
    var decoder = new TextDecoder(encoding);
    var decodedString = decoder.decode(dataView);
    console.info(decodedString);

    var ints = new Uint32Array(dataView.byteLength / 4);
  }
}
```

### js 中 void
```
0、undefined 容易被篡改， void 不会被篡改
1、返回 undefined, 因为 
2、防止 不必要 的行为
  填充 a.href="javascript:void(0)"
  填充 img.src="javascript:void(0)"
```

### js 中 onclick
```
1、a onclick 先于 href 执行, 且 onclick 控制着 href 的执行
2、a onlick 返回值
    return true: 返回正常的处理结果
    return false: 返回错误的处理结果;终止处理;阻止提交表单;阻止执行默认的行为
    return: 把控制权返回给页面

3、<a herf="" onclick="func();return false">
```

### JS 中 apply 、 call 、bind
- apply 、 call 、bind 三者都是用来改变函数的this对象的指向的
- apply 、 call 、bind 三者第一个参数都是this要指向的对象，也就是想指定的上下文
- apply 、 call 、bind 三者都可以利用后续参数传参
- bind 是返回对应函数，便于稍后调用
- apply 、call 则是立即调用 

```
call（） 就是用来让括号里的对象 来集成括号外的函数的属性

function test(a,b,c,d) 
   { 
      var arg = Array.prototype.slice.call(arguments,1); 
      alert(arg); 
   } 
   test("a","b","c","d"); //b,c,d

多次用到 Array.prototype.slice.call(arguments, 1)，不就是等于 arguments.slice(1) 吗？像前者那样写具体的好处是什么？这个很多js新手最疑惑的地方。那为什么呢？

因为arguments并不是真正的数组对象，只是与数组类似的Arguments对象而已，所以它并没有slice这个方法

真正原理--将类数组对象转化为数组，要求就是有一个length的属性
Array.prototype.slice.call(arguments)能将具有length属性的对象转成数组，除了IE下的节点集合（因为ie下的dom对象是以com对象的形式实现的，js对象与com对象不能进行转换） 
如：

var a={length:2,0:'first',1:'second'};//类数组,有length属性，长度为2，第0个是first，第1个是second
console.log(Array.prototype.slice.call(a,0));// ["first", "second"],调用数组的slice(0);

var a={length:2,0:'first',1:'second'};
console.log(Array.prototype.slice.call(a,1));//["second"]，调用数组的slice(1);

var a={0:'first',1:'second'};//去掉length属性，返回一个空数组
console.log(Array.prototype.slice.call(a,0));//[]

function test(){
  console.log(Array.prototype.slice.call(arguments,0));//["a", "b", "c"]，slice(0)
  console.log(Array.prototype.slice.call(arguments,1));//["b", "c"],slice(1)
}
test("a","b","c");
补充： 
将函数的实际参数转换成数组的方法

方法一：var args = Array.prototype.slice.call(arguments);

方法二：var args = [].slice.call(arguments, 0);

方法三：

var args = []; 
for (var i = 1; i < arguments.length; i++) { 
    args.push(arguments[i]);
}
最后，附个转成数组的通用函数

var toArray = function(s){
    try{
        return Array.prototype.slice.call(s);
    } catch(e){
        var arr = [];
        for(var i = 0,len = s.length; i < len; i++){
            //arr.push(s[i]);
               arr[i] = s[i];  //据说这样比push快
        }
         return arr;
    }
}
```

### JS new Function()定义函数
```
var funcName = new Function("arg1","arg2","arg3","return arg1");

// 生成 function
function(arg1, arg2, arg3) {
    return arg1
}
```

### JS 中 MVC 和 MVVM
![](https://images2018.cnblogs.com/blog/1048550/201807/1048550-20180701101631549-484806327.png)
```
MVC:
model：应用程序中处理数据逻辑的一部分，通常用来模型对象对数据库的存存取等操作. state 数据
view：视图部分，通常指jsp、html等用来对用户展示的一部分. render
controller：控制层通常用来处理业务逻辑，负责从试图读取数据，并向模型发送数据. react 
```
![](https://images2018.cnblogs.com/blog/1048550/201807/1048550-20180701105302049-745020808.png)
```
MVVM(vue):
View: 可以通过事件绑定Model，template 视图
Model: 可以通过数据绑定View，data 数据
ViewMode: 可以实现数据和视图的完全分离,是Model和View的连接桥. Vue 实例

mvvm的设计原理是基于mvc的，所以说mvvm不算是一种创新，充其量是一种改造，这其中的ViewModel便是一个小小的创新
```


### JS 垃圾回收机制
```
1、JS中最常见的垃圾回收方式: 标记清除
工作原理：是当变量进入环境时，将这个变量标记为“进入环境”。当变量离开环境时，则将其标记为“离开环境”。标记“离开环境”的就回收内存。

2、引用计数 方式
工作原理：跟踪记录每个值被引用的次数。

```

### JS 内存泄漏
```
1. 没有清理的DOM元素引用(DOM)
原因：虽然别的地方删除了，但是对象中还存在对dom的引用
解决：手动删除。

2. 子元素存在引用引起的内存泄漏(DOM)
原因：div中的ul li  得到这个div，会间接引用某个得到的li，那么此时因为div间接引用li，即使li被清空，也还是在内存中，并且只要li不被删除，他的父元素都不会被删除。
解决：手动删除清空。

3. 被遗忘的定时器或者回调(JS)
原因：定时器中有dom的引用，即使dom删除了，但是定时器还在，所以内存中还是有这个dom。
解决：手动删除定时器和dom。

4. 意外的全局变量引起的内存泄漏(JS)
原因：全局变量，不会被回收。
解决：使用严格模式避免。

5. 闭包引起的内存泄漏(JS)
原因：闭包可以维持函数内局部变量，使其得不到释放。
解决：将事件处理函数定义在外部，解除闭包,或者在定义事件处理函数的外部函数中，删除对dom的引用。

```

### 模块化开发

> 2009年，nodejs 项目应用于服务端，模块化编程就随之应运而生了。

- 模块化的进程
```
1、无序（洪荒时代）：自由写代码(无函数)
2、函数时代： 将代码关进笼子中（有函数）
3、面向对象时间：（函数属性再集中封装）
4、匿名自执行函数：（function(){})()
5、伪模块开发（CMD/AMD）
6、模块开发（还未诞生的ES6标准 CommonJS)
```

- 模块化规范
```
常用规范：CMD/AMD, 其它规范：Closure/ES6/CommonJS
AMD(异步模块定义):
主要框架：requirejs
判定：define.amd
模块定义：define([id, ["a","b"]],function(a, b){})
其它：开始时 amd 摆脱了 cmd 束缚，requirejs2.0 又兼容了 cmd

CMD:
主要框架：seajs
判定：define.cmd
模块定义：define([id，[依赖，] ], function(require, exports, module){})


CommonJS:
主要环境：node,不适用于浏览器环境

```

- 模块解决了哪些问题
```
1、很多的全局变量，或全局函数
2、多文件引入时，严格按依赖顺序放置
3、大型项目中，js文件引入太多，依赖顺序维护等维护太难

总结： 全局量，依赖顺序

把全局变量或函数 多数局部化  - 多模块
1、防作用域被污染 
2、防止代码暴露可被修改

开闭原则，单一职责：不修改原文件不修改，，只能新增文件（只增不改）

模块之间依赖管理：即不能直接交互，只能在模块入口注入模块
```

### JQuery 扩展

- $.extend() 

`全局方法，调用方式： $.方法`

- $.fn.extend()  扩展的函数，

`实例方法，调用方式  $("").方法`


### Ajax（异步 javascript and xml） 异步通信技术（核心ajax 对象）

- API

```
open（method, url, async）
setRequestHeader
send([string])
onreadystatechange
```

- 与服务端交互过程

```
readystate==4时返回数据
```

### Promise方法
```
原理：
1、Promise 代表着一个承诺。作为承诺，总需要有一个结果，无论成功与否。
2、then: then方法接收两个参数：onResolve和onReject，分别代表当前 promise 对象在成功或失败时，接下来需要做的操作。为了方便链式调用，then方法的实现中，都会返回一个新的 promise 对象（如果此处也返回自身的话，则串行操作就变成并行操作了，显然不符合我们的目标）

reject: 设置promise状态为已失败，并执行catch失败回调

resolve: 设置promise 状态为成功， 并执行then 成功回调

catch:  指定reject 回调

race(并发): 处理当一组 promise 中任意一个完成时的情况
all(并发): 处理当一组 promise 中全部都完成时的情况
```

#### history & hash
```
1.history 模式
主要有以下几个东西
(1)window.history.pushState(obj, title [, url])
(2)window.history.replaceState(obj, title [, url])(3)一个popstate事件，在前进和后退调用时触发

问题：
1、不怕前进，不怕后退，就怕刷新，f5
2、要后台配置支持:如果 URL 匹配不到任何静态资源，则应该返回同一个 index.html 页面，这个页面就是你 app 依赖的页面。

2.hash 模式（默认）
主要就是一个事件
(1) window.onhashchange



3、 abstract（不在浏览器环境则使用）
```