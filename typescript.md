js 转 Typescript 步骤

1、原来的语法结构基本不变
2、添加大量的变量类型，前期无要求，可以全部使用 any
3、参数中可要可不要的，设置为 可选参数 ?:
4、js 转 type 自动转为 严格模式，所以要遵守严格模式的要求，比如 变量先定义才可以使用，再比如，变量不能重复定义 等

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