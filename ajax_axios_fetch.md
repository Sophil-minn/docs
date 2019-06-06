
1. ajax: XMLHttpRequest 原生对象; progress
2. fetch: 原生方法, 返回 Promise 对象; 不支持且无法 中断或超时或获取状态和进度 abort | timeout | progress
3. axios: ajax 进一步封装, 返回 Promise 对象; progress | cancel | timeout

ajax, fetch 都是原生方法, 都可以进行数据的请求,
  但两者是有区别的,
  ajax 是一个原生的对象, 通过其api可知 ajax 可以获取 进度progress, 通过callback 方法获取数据,
    fetch 在使用上比ajax 稍方便一些, 而且采用 es6 中的 promise 使用返回, 同也这也继承了 Promise 的缺点
比如, fetch 一旦发起是不可以中断, 没有超时, 默认不接受和发送 cookie, credentials: 'include'

但两者都需要封装才可以更舒服的使用

axios 是 ajax 的进一步封装, 也采用了 promise 的作用返回, 但其 可以设置 timeout, 同时可以 通过 cacalToken 取消

区别:
ajax 回调方式, callback holl, 可 abort
fetch promise 方式, 不可 abort , 默认不带 cookie 

使用 不方便, 都需要 进一步封装

axios 是 ajax 进行一步封装, 使用 了promise 方式, 可abort , 算是结合了 ajax 和 fetch 优点