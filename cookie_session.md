

```
每打开一个窗口 进行页面请求,都会产生一个 session id,
所以 为了让 打开多个 窗口 用户唯一, 需要 共享 session id, 即在服务端 重置 session id
如果要 使用 第一次生成的 session id , 这个时候需要 session 与 cookie 进行共享, 即 session id 保存在 cookie里 
```


```
 session与cookie最主要的区别就是,session是以对象的形式保存在服务器端，而cookie则是以字符串的 形式保存在客户端。
Cookie保存在客户端浏览器中，而Session保存在服务器上。Cookie机制是通过检查客户身上的“通行证”来确定客户身份的话，那么Session机制就是通过检查服务器上的“客户明细表”来确认客户身份。Session相当于程序在服务器上建立的一份客户档案，客户来访的时候只需要查询客户档案表就可以了。
```

```
①存在的位置：

cookie 存在于客户端，临时文件夹中；  session存在于服务器的内存中，一个session域对象为一个用户浏览器服务

②安全性
cookie是以明文的方式存放在客户端的，安全性低，可以通过一个加密算法进行加密后存放；  session存放于服务器的内存中，所以安全性好

③网络传输量
cookie会传递消息给服务器；  session本身存放于服务器，不会有传送流量

④生命周期(以20分钟为例)
cookie的生命周期是累计的，从创建时，就开始计时，20分钟后，cookie生命周期结束；
session的生命周期是间隔的，从创建时，开始计时如在20分钟，没有访问session，那么session生命周期被销毁。但是，如果在20分钟内（如在第19分钟时）访问过session，那么，将重新计算session的生命周期。关机会造成session生命周期的结束，但是对cookie没有影响

⑤访问范围
cookie为多个用户浏览器共享；  session为一个用户浏览器独享
```