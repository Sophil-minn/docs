# HTTP

![HTTP 请求协议](https://upload-images.jianshu.io/upload_images/2964446-fdfb1a8fce8de946.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
GET /books/?sex=man&name=Professional HTTP/1.1
Host: www.wrox.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1) Firefox/1.0.1
Connection: Keep-Alive
Content-Type: application/x-www-form-urlencoded
Content-Length: 89
Expires: Sat, 24 Mar 2018 03:29:15 GMT
Content-Encoding: gzip
Cache-Control: no-cache|private|max-age
X-Requested-With: XMLHttpRequest

-------
:authority: img.bosszhipin.com
:method: GET
:path: /4c9a9e76fe588693dd4977aeca454d4b8c7dd922ad47494fc02c388e12c00eac_s.jpg
:scheme: https
accept: image/webp,image/apng,image/*,*/*;q=0.8
accept-encoding: gzip, deflate, br
accept-language: zh-CN,zh;q=0.9
cache-control: no-cache
pragma: no-cache
referer: https://www.zhipin.com/geek/new/index/recommend
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.52 Safari/537.36
-------------------
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: zh-CN,zh;q=0.9
Cache-Control: no-cache
Connection: keep-alive
Host: saa.com
Pragma: no-cache
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.52 Safari/537.36
--------------------
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate, br
Accept-Language: zh-CN,zh;q=0.9
Cache-Control: no-cache
Connection: keep-alive
Cookie: CFID=7426092; CFTOKEN=34255360; JSESSIONID=84304e654d5041305cd3364b21f5e772c6d6; CFID=7426092; CFTOKEN=34255360; USERID=x; TURN_OFF_FACTORY=0; ESN=1; GREEN=1; MRADDS=1; SPRUCE=1; USE_CACHE=1; EPA_MODE=0; EPA_MOTHER_Q=0; ADVANCED_SEARCH=0; SUPER_WIDTH=0; BOXFRAME=1; FASTLIST=1; FASTMARKET=1; LAYOUT2=1; LAYOUT3=1; MYSAA3=1; SHOW_SAVED=1; GM_POSTCARD=0
Host: www.saa.com
Pragma: no-cache
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.52 Safari/537.36
----------------
```

### HTTP 请求方法

```
请求方法 GET POST PUT DELETE 等

从命名看，
GET: 是取数据，主要是请求数据
POST: 是发送数据，主要是提交数据

当然，
GET, POST都是 客户端 与 服务器数据交互的 方法，

1、只是向服务器传输数据时字符限制不同
	post基本没有数据字符数限制，
	get有字符限制， URL最大长度是 2048个字符

2、传输位置不同
	GET 是在请求的 URL 中发送，可见性强
	POST 是在请求的 消息主体 中发送， 不可见

3、缓存处理方式不同
	GET： 能被缓存，参数保留在浏览器历史中
	POST：不能缓存

4、安全性
	GET：没有POST安全
	POST: 也只是 比 GET 安全
	
其它
	GET 获取资源
	POST 新增资源
	PUT 更新资源
	DELETE 删除资源
```

### HTTP 状态码

```
状态代码有三位数字组成，第一个数字定义了响应的类别，共分五种类别:

1xx: 信息性状态码 100, 101
2xx: 成功状态码 200：OK
3xx: 重定向状态码
301: 永久重定向, Location响应首部的值仍为当前URL，因此为隐藏重定向;
302: 临时重定向，显式重定向, Location响应首部的值为新的URL
304：Not Modified 未修改，比如本地缓存的资源文件和服务器上比较时，发现并没有修改，服务器返回一个304状态码， 告诉浏览器，你不用请求该资源，直接使用本地的资源即可。
4xx: 客户端错误状态码
404: Not Found 请求的URL资源并不存在
5xx: 服务器端错误状态码
500: Internal Server Error 服务器内部错误
502: Bad Gateway 前面代理服务器联系不到后端的服务器时出现
504：Gateway Timeout 这个是代理能联系到后端的服务器，但是后端的服务器在规定的时间内没有给代理服务器响应
```


### HTTP 请求头

```
Accept-Language: zh-cn,zh;q=0.5
Accept-Language表示浏览器所支持的语言类型，分别是中文和简体中文，优先支持简体中文。
Accept-Charset: GB2312,utf-8;q=0.7,*;q=0.7
Accept-Charset告诉 Web 服务器，浏览器可以接受哪些字符编码，分别是 GB2312、utf-8 和任意字符，优先顺序是 GB2312、utf-8、*。
Accept:text/html,application/xhtml+xml,application/xml;q=0.9,/;q=0.8
Accept表示浏览器支持的 MIME 类型，分别是 text/html、application/xhtml+xml、application/xml 和 /，优先顺序是它们从左到右的排列顺序。
Accept-Encoding: gzip, deflate
Accept-Encoding表示浏览器有能力解码的编码类型，压缩编码是 gzip 和 deflate。
User-Agent:Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
User-Agent（用户代理），简称 UA，它是一个特殊字符串头，使得服务器能够识别客户端使用的操作系统及版本、CPU 类型、浏览器及版本、浏览器渲染引擎、浏览器语言、浏览器插件等
Host: 域名
Host表示请求的服务器网址；
Connection: Keep-Alive
Connection表示客户端与服务连接类型，Keep-Alive表示持久连接；
```

### HTTP 响应头 

```
Server:Apache/1.3.6 使用的服务器名称
Content-Type:text/html;charset=GBK 用来指明接受者的实体正文的媒体类型
Content-Encoding:gzip 与请求报头Accept-Encooding对应，告诉浏览器服务端采用的是什么压缩编码
Content-Language:zh-cn 貌似了资源所用的自然语言，与Accept-Language对应
Content-Length:10527 指明实体正文的长度
Keep-Alive:timeout=5,max=120 保持连接的时间
```


### HTTP 三次握手

![img](https://images2015.cnblogs.com/blog/1159846/201706/1159846-20170605223656153-365910138.png)

```
握手核心：三次握手，通信双方的序列号 - 两厢情愿，互相留暗号
第一次握手：Client发送 SYN + seq(Client)，待Server确认(告诉Server,Client序列号）
第二次握手：Server确认后回传 SYN/ACK + seq(Server)，Client确认（告诉Client,Server序列号）
第三次握手：Client再回传 ACK，Server 确认后，握手结束, 发送数据（告诉 Server要接收数据）
eg：
“喂，你听得到吗？”
“我听得到呀，你听得到我吗？”
“我能听到你，今天balabala……”

```
### HTTP 四次挥手

![img](http://hi.csdn.net/attachment/201108/7/0_1312718564tZXD.gif)
```
挥手核心：四次挥手，通信双方关闭socket监听
第一次挥手：主动关闭方发送 FIN
第二次挥手：被动关闭方收到 FIN, 发送 ACK
第三次挥手：被动关闭方发送 FIN
第四次挥手：主动关闭方收到 FIN, 发送 ACK
eg:
"喟，你关闭了么，你先关闭我再关闭” FIN M
“我关闭了，你等会” ack M+1
“我关闭了，你也关闭吧” FIN N
“我知道了，2msl时后，你不回复我就关闭了” ACK=1 ack=K+1
```

### TCP / UDP

```
TCP: 可靠连接，需要三次握手，连接后发送数据
特点：

UDP: 不可靠连接，不连接直接发送， 谁想接收可以直接接收（广播式，散发式）
特点：一次只能传输少量数据
```

#### 浅析HTTP/2的多路复用
	HTTP/2有三大特性：头部压缩、Server Push、多路复用。前两个特性意思比较明确，也好理解，唯有多路复用不太好理解，尤其是和HTTP1.1进行对比的时候，这个问题我想了很长时间，也对比了很长时间，现在把思考的结果分享出来，希望对大家有帮忙。

先来说说Keep-Alive
在没有Keep-Alive前，我们与服务器请求数据的流程是这样：
每次请求都会建立一次HTTP连接，也就是我们常说的3次握手4次挥手，这个过程在一次请求过程中占用了相当长的时间，而且逻辑上是非必需的，因为不间断的请求数据，第一次建立连接是正常的，以后就占用这个通道，下载其他文件，这样效率多高啊！你猜对了，这就是Keep-Alive。

我们知道HTTP协议采用“请求-应答”模式，当使用普通模式，即非KeepAlive模式时，每个请求/应答客户和服务器都要新建一个连接，完成 之后立即断开连接（HTTP协议为无连接的协议）；当使用Keep-Alive模式（又称持久连接、连接重用）时，Keep-Alive功能使客户端到服 务器端的连接持续有效，当出现对服务器的后继请求时，Keep-Alive功能避免了建立或者重新建立连接。
http 1.0中默认是关闭的，需要在http头加入"Connection: Keep-Alive"，才能启用Keep-Alive；http 1.1中默认启用Keep-Alive，如果加入"Connection: close "，才关闭。目前大部分浏览器都是用http1.1协议，也就是说默认都会发起Keep-Alive的连接请求了，所以是否能完成一个完整的Keep- Alive连接就看服务器设置情况。

Keep-Alive解决的问题
Keep-Alive解决的核心问题：一定时间内，同一域名多次请求数据，只建立一次HTTP请求，其他请求可复用每一次建立的连接通道，以达到提高请求效率的问题。这里面所说的一定时间是可以配置的，不管你用的是Apache还是nginx。

HTTP1.1还是存在效率问题
如上面所说，在HTTP1.1中是默认开启了Keep-Alive，他解决了多次连接的问题，但是依然有两个效率上的问题：

第一个：串行的文件传输。当请求a文件时，b文件只能等待，等待a连接到服务器、服务器处理文件、服务器返回文件，这三个步骤。我们假设这三步用时都是1秒，那么a文件用时为3秒，b文件传输完成用时为6秒，依此类推。（注：此项计算有一个前提条件，就是浏览器和服务器是单通道传输）
第二个：连接数过多。我们假设Apache设置了最大并发数为300，因为浏览器限制，浏览器发起的最大请求数为6，也就是服务器能承载的最高并发为50，当第51个人访问时，就需要等待前面某个请求处理完成。
HTTP/2的多路复用
HTTP/2的多路复用就是为了解决上述的两个性能问题，我们来看一下，他是如何解决的。

解决第一个：在HTTP1.1的协议中，我们传输的request和response都是基本于文本的，这样就会引发一个问题：所有的数据必须按顺序传输，比如需要传输：hello world，只能从h到d一个一个的传输，不能并行传输，因为接收端并不知道这些字符的顺序，所以并行传输在HTTP1.1是不能实现的。
![clipboard.png](https://segmentfault.com/img/bVUSGx?w=745&h=201)

HTTP/2引入二进制数据帧和流的概念，其中帧对数据进行顺序标识，如下图所示，这样浏览器收到数据之后，就可以按照序列对数据进行合并，而不会出现合并后数据错乱的情况。同样是因为有了序列，服务器就可以并行的传输数据，这就是流所做的事情。

![clipboard.png](https://segmentfault.com/img/bVUSLx?w=562&h=375)

解决第二个问题：HTTP/2对同一域名下所有请求都是基于流，也就是说同一域名不管访问多少文件，也只建立一路连接。同样Apache的最大连接数为300，因为有了这个新特性，最大的并发就可以提升到300，比原来提升了6倍！
以前我们做的性能优化不适用于HTTP/2了
JS文件的合并。我们现在优化的一个主要方向就是尽量的减少HTTP的请求数， 对我们工程中的代码，研发时分模块开发，上线时我们会把所有的代码进行压缩合并，合并成一个文件，这样不管多少模块，都请求一个文件，减少了HTTP的请求数。但是这样做有一个非常严重的问题：文件的缓存。当我们有100个模块时，有一个模块改了东西，按照之前的方式，整个文件浏览器都需要重新下载，不能被缓存。现在我们有了HTTP/2了，模块就可以单独的压缩上线，而不影响其他没有修改的模块。
多域名提高浏览器的下载速度。之前我们有一个优化就是把css文件和js文件放到2个域名下面，这样浏览器就可以对这两个类型的文件进行同时下载，避免了浏览器6个通道的限制，这样做的缺点也是明显的，1.DNS的解析时间会变长。2.增加了服务器的压力。有了HTTP/2之后，根据上面讲的原理，我们就不用这么搞了，成本会更低。