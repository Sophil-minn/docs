Object.defineProperty(obj, prop, descriptor)：当属性的 configurable 为 true 时，可以对已有的属性的描述符进行变更。
Object.preventExtensions(obj)：阻止 obj 被添加新的属性。
Object.seal(obj)：阻止 obj 被添加新的属性或者删除已有的属性。
Object.freeze(obj)：阻止 obj 被添加新的属性、删除已有的属性或者更新已有的属性。


		Object.defineProperty(to, prop, Object.getOwnPropertyDescriptor(from, prop));


 Reflect.ownKeys（obj）= Object.getOwnPropertyNames（target）+ 
 Object.getOwnPropertySymbols（target)

  //不打印myMethod，因为它被定义为不可枚举
 console.log（Object.keys（testObject））; 
 
 //打印myMethod，不管它是否可枚举。 
 console.log（Reflect.ownKeys（testObject））; 