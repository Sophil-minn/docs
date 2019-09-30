1. 基本类型
```ts
// 基本类型: number, string, boolean, null, undefined
let s: string;
let x: null = null;
let y: undefined = undefined;
```

2. 数组类型
```ts
// 复杂类型: xxx[], Tuple, 枚举
// 或
// 复杂类型: Array<number> , Array<string>, Array<boolean>
// 数组
let s: number[];
// 元组
let x: [string, number] = ['hello', 10]
// 枚举 1. 先自定义数据类型 2.
enum Color {Red, Green, Blue}
let color: Color = Color.Red;
```
3. 任意值: 用户各种各样基本类型
```ts
// any
let xx: any;
let v : any[] = [1, true, "free"]
```
4. 空值: 用在无返回的函数中
```ts
// void
let xx:void = undefined;
```

5. Never: 用在那些抛出异常或
```ts
// 返回never的函数必须存在无法达到的终点
function error(message: string): never {
    throw new Error(message);
}

// 推断的返回值类型为never
function fail() {
    return error("Something failed");
}

// 返回never的函数必须存在无法达到的终点
function infiniteLoop(): never {
    while (true) {
    }
}
```

6. 类型转化
```ts
let someValue: any = "this is a string";

let strLength: number = (<string>someValue).length;
let xxxLength: number = (someValue as string).length;
```

7. interface 结构体一
```ts
// ?: 可选属性
interface SquareConfig {
    color?: string;
    width?: number;
}

let xx: SquareConfig;
```

8. class 结构体二: 可继承结构体
```ts
class Point {
    x: number;
    y: number;
}


```

9. 多个类型
```ts
let sn: string | null = "xx";
```

10. [高级类型](https://typescript.bootcss.com/advanced-types.html)


### js 转 Typescript 步骤

1、原来的语法结构基本不变
2、添加大量的变量类型，前期无要求，可以全部使用 any
3、参数中可要可不要的，设置为 可选参数 ?:
4、js 转 type 自动转为 严格模式，所以要遵守严格模式的要求，比如 变量先定义才可以使用，再比如，变量不能重复定义 等
5. 重点: 各种数据结构定义

```typescript
//ref: https://www.cnblogs.com/zhengweijie/p/7152056.html

// 数据类型
// 基础类型 null|undefined|number|string|boolean|any|array
// 对象类型 Number|String|Boolean|Any|Array
// 其它对象： Date | Error | RegExp
// 数组：相同数据对象合并类型 Array<number>|Array<string>|Array<boolean>|Array<any>等
// 元组：不同数据对象合并类型 [string,number,...]
// 类型替代： type | as   如 type S = string;
// 其它自定义类型： e.g. ()=> string


// 字段限定 结构体 
//= 预留字段可选填
interface Address {
  readonly g: string,  // readonly 定义只读属性
  sheng: string,
  city: string,
  xian?: string // 可选填参数
}

// 字段不限 结构体
interface Info {
  [propName: string]: any; // 表示可以任意添加属性个数  ，添加的属性类型为 any
}

// ["a","1"]
// 等同于 string[] 或 Array<string>
interface StringArray {
  [index: number]: string; // index 为下标
}

// [1, 1, 2, 3, 5]
// 等同于 number[] 或 Array<number>
interface NumberArray {
  [index: number]: number; // index 为下标
}

let a: StringArray = ["a"];
let b: NumberArray = [1];
console.log(a, b)



abstract class Person {
  public name: string = 'Your Name';
  public age: number = 0;
  private money: number; // 内部变量，因无外部调用的可能，所以必须在内部有使用，否则为多余变量报错
  protected home: string;


  constructor(__name: string = 'my name', __age: number = -1, public address: Address = {
    g: '中国',
    sheng: '',
    city: ''
  }, public info: Info = {
    a: 'test'
  }) {
    this.name = __name;
    this.age = __age;
  }

  say() {
    console.log('I have money about', this.money);
  }

  abstract hasHome(); // 未实现的方法必须声明为 abstract
}

export class Teacher extends Person {
  constructor(__name: string = 'my name', __age: number = -1, address: Address = {
    g: '中国',
    sheng: '',
    city: ''
  }, info: Info = {
    j: '中文'
  }, public job: string = '老师') {
    super(__name, __age, address, info);
  }

  hasHome() {

  }
}

function f() {
  console.log("f(): evaluated");
  return function (target, propertyKey: string, descriptor: PropertyDescriptor) {
    console.log("f(): called");
  }
}

function g() {
  console.log("g(): evaluated");
  return function (target, propertyKey: string, descriptor: PropertyDescriptor) {
    console.log("g(): called");
  }
}

export class Ano {
  @f()
  @g()
  method() { }
}
```

#### 多数据类型 声明元组（Tuple）

1. 元组
let preson: [number, string]
如 person = [18, 'xiaoming'] // 按顺序赋值

2. 多种类型
let xx: string | number;
xx = 12;