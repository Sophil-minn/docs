# [WEB请求过程](http://www.cnblogs.com/wade-luffy/p/5905786.html)
> http解析,浏览器缓存机制,域名解析,cdn分发
**目录**

- [HTTP请求头](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label0)
- [HTTP响应头 ](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label1)
- [HTTP状态码](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label2)
- [浏览器缓存机制](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label3)
- [DNS解析过程](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label4)
- [跟踪域名解析过程的命令](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label5)
- [清除缓存的域名](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label6)
- [CDN架构](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label7)
- [负载均衡](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label8)
- [CDN动态加速](https://www.cnblogs.com/wade-luffy/p/5905786.html#_label9)


### 概述
```
发起一个http请求的过程就是建立一个socket通信的过程。

我们可以模仿浏览器发起http请求，譬如用httpclient工具包，curl命令等方式。

curl "http://www.baidu.com" 　　返回页面数据

curl -I "http://www.baidu.com"　　-I查看http响应头的信息

curl -I "http://www.baidu.com" -H "Cookie=......; Accept-Charset=...."　　-H添加请求头的信息 
```
### HTTP解析

http header控制着互联网上成千上万的用户的数据的传输。最关键的是，它控制着用户浏览器的渲染行为和服务器的执行逻辑。

firefox可用firebug查看，httpfox工具，fidder工具，chrome&ie自带调试工具等都可以查看。

[回到顶部](https://www.cnblogs.com/wade-luffy/p/5905786.html#_labelTop)

### HTTP请求头

**Accept-Language**: zh-cn,zh;q=0.5
Accept-Language表示浏览器所支持的语言类型，分别是中文和简体中文，优先支持简体中文。

**Accept-Charset**: GB2312,utf-8;q=0.7,*;q=0.7
Accept-Charset告诉 Web 服务器，浏览器可以接受哪些字符编码，分别是 GB2312、utf-8 和任意字符，优先顺序是 GB2312、utf-8、*。

**Accept**:text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept表示浏览器支持的 MIME 类型，分别是 text/html、application/xhtml+xml、application/xml 和 */*，优先顺序是它们从左到右的排列顺序。

**Accept-Encoding**: gzip, deflate
Accept-Encoding表示浏览器有能力解码的编码类型，压缩编码是 gzip 和 deflate。

**User-Agent**:Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
User-Agent（用户代理），简称 UA，它是一个特殊字符串头，使得服务器能够识别客户端使用的操作系统及版本、CPU 类型、浏览器及版本、浏览器渲染引擎、浏览器语言、浏览器插件等

**Host**: 域名
Host表示请求的服务器网址；

**Connection**: Keep-Alive
Connection表示客户端与服务连接类型，Keep-Alive表示持久连接；

[回到顶部](https://www.cnblogs.com/wade-luffy/p/5905786.html#_labelTop)

## HTTP响应头 

**Server**:Apache/1.3.6
使用的服务器名称
**Content-Type**:text/html;charset=GBK
用来指明接受者的实体正文的媒体类型
**Content-Encoding**:gzip
与请求报头Accept-Encooding对应，告诉浏览器服务端采用的是什么压缩编码
**Content-Language**:zh-cn
貌似了资源所用的自然语言，与Accept-Language对应
**Content-Length**:10527
指明实体正文的长度
**Keep-Alive**:timeout=5,max=120
保持连接的时间

[回到顶部](https://www.cnblogs.com/wade-luffy/p/5905786.html#_labelTop)

## HTTP状态码
```
200　　客户端请求成功
302　　临时跳转，跳转的地址通过location指定
400　　客户端请求语法错误，不能被服务器识别
403　　服务器收到请求，但是拒绝服务
404　　请求的资源不存在
500　　服务器发生不可预期的错误
```

## 浏览器缓存机制
> 浏览一个网页时发现有异常的情况下，通常考虑的是是不是浏览器做了缓存，一般的做法可以通过ctrl+F5组合键重新请求这个页面，重新请求的页面肯定是最新的页面。

 ![img](https://images2015.cnblogs.com/blog/990532/201609/990532-20160925134119972-1041555981.png)

**Cache-Control**
```
must-revalidation/proxy-revalidation　　如果缓存失败，请求必须发送到服务器进行重新验证，请求头中设置
no-cache　　所有内容都不会被缓存，请求头或者响应头中设置
public　　所有内容都将被缓存，响应头中设置
private　　内容只缓存到私有缓存中，响应头中设置
no-store　　所有内容都不会被缓存到缓存或internet临时文件中，响应头中设置
max-age=10　　缓存内容在10秒后失效，只在http1.1中可用和last-modified一起使用时优先级较高，响应头中设置　　
```
**Pragma**
```
no-cache　　请求头中设置，no-cache这个名字有一点误导。设置了no-cache之后，并不是说浏览器就不再缓存数据，只是浏览器在使用缓存数据时，需要先确认一下数据是否还跟服务器保持一致。如果设置了no-cache，而ETag的实现没有反应出资源的变化，那就会导致浏览器的缓存数据一直得不到更新的情况。  

<META HTTP-EQUIV="Pragma" CONTENT="no-cache">　　html页面中写入**（**部分浏览器可以支持，所有缓存代理服务器都不支持，代理不解析HTML内容本身。）
```
**Expires**

**![img](https://images2015.cnblogs.com/blog/990532/201609/990532-20160925135641865-2044702012.png)**
```
Date头域表示消息发送的时间，时间的描述格式由rfc822定义
Web服务器告诉浏览器在2012-11-28 03:30:01这个时间点之前，可以使用缓存文件。发送请求的时间是2012-11-28 03:25:01，即缓存5分钟。
Expires 是HTTP 1.0的东西，现在默认浏览器均默认使用HTTP 1.1，所以它的作用基本忽略。
```
**Cache-Control策略导向图**

**![img](https://images2015.cnblogs.com/blog/990532/201706/990532-20170626142223727-462207264.png)**

**Last-Modified/If-Modified-Since**
```
Last-Modified/If-Modified-Since要配合Cache-Control使用。
Last-Modified：标示这个响应资源的最后修改时间。web服务器在响应请求时，告诉浏览器资源的最后修改时间。
If-Modified-Since：当资源过期时（使用Cache-Control标识的max-age），发现资源具有Last-Modified声明，则再次向web服务器请求时带上头 If-Modified-Since，表示请求时间。web服务器收到请求后发现有头If-Modified-Since 则与被请求资源的最后修改时间进行比对。若最后修改时间较新，说明资源又被改动过，则响应整片资源内容（写在响应消息包体内），HTTP 200；若最后修改时间较旧，说明资源无新修改，则响应HTTP 304 (无需包体，节省浏览)，告知浏览器继续使用所保存的cache。
```
**Etag/If-None-Match（优先级比last-modified高，缓存过期后先判断有没有etag声明再判断有没有last-modified声明）**
```
Etag/If-None-Match也要配合Cache-Control使用。
Etag：web服务器响应请求时，告诉浏览器当前资源在服务器的唯一标识（生成规则由服务器觉得）。Apache中，ETag的值，默认是对文件的索引节（INode），大小（Size）和最后修改时间（MTime）进行Hash后得到的。
If-None-Match：当资源过期时（使用Cache-Control标识的max-age），发现资源具有Etage声明，则再次向web服务器请求时带上头If-None-Match （Etag的值）。web服务器收到请求后发现有头If-None-Match 则与被请求资源的相应校验串进行比对，决定返回200或304。
```
**PS**
```
使用Last-Modified已经足以让浏览器知道本地的缓存副本是否足够新，为什么还需要Etag（实体标识）呢？HTTP1.1中Etag的出现主要是为了解决几个Last-Modified比较难解决的问题：

1. Last-Modified标注的最后修改只能精确到秒级，如果某些文件在1秒钟以内，被修改多次的话，它将不能准确标注文件的修改时间
2. 如果某些文件会被定期生成，当有时内容并没有任何变化，但Last-Modified却改变了，导致文件没法使用缓存
3. 有可能存在服务器没有准确获取文件修改时间，或者与代理服务器时间不一致等情形

Etag是服务器自动生成或者由开发者生成的对应资源在服务器端的唯一标识符，能够更加准确的控制缓存。Last-Modified与ETag是可以一起使用的，服务器会优先验证ETag，一致的情况下，才会继续比对Last-Modified，最后才决定是否返回304。
```
## DNS域名解析

术语解释:

**根域**，就是所谓的“.”，其实我们的网址www.baidu.com在配置当中应该是www.baidu.com.（最后有一点），一般我们在浏览器里输入时会省略后面的点，而这也已经成为了习惯。根域服务器我们知道有13台，但是这是错误的观点。根域服务器只是具有13个IP地址，但机器数量却不是13台，因为这些IP地址借助了任播的技术，所以我们可以在全球设立这些IP的镜像站点，你访问到的这个IP并不是唯一的那台主机。

**域名后缀**，国际顶级域名，有两种划分方式，一种互联网刚兴起时的按照行业性质划分的com.，net.等，一种是按国家划分的如cn.，jp.，等。每个域都会有域名服务器，也叫权威域名服务器。

**顶级域或者叫做一级域**，baidu.com就是一个顶级域名，而www.baidu.com却不是顶级域名，他是在baidu.com 这个域里的一叫做www的主机。

**二级域，三级域**，只要我买了一个顶级域，并且我搭建了自己BIND服务器（或者其他软件搭建的）注册到互联网中，那么我就可以随意在前面多加几个域了（当然长度是有限制的）。比如a.www.baidu.com，在这个网址中，www.baidu.com变成了一个二级域而不是一台主机，主机名是a。

**域名服务器**，能提供域名解析的服务器，上面的记录类型可以是A(address)记录，NS记录（name server），MX（mail），CNAME等。

**A记录**，A代表的是address，用户可以在此设置子域名并指向到自己的目标主机地址上，从而实现通过域名找到服务器。指向的目标主机地址类型只能使用IP地址，如将taobao.com域名下的item.taobao.com指定到115.238.33.11，order.taobao.com指定到112.134.22.34。A记录可以将多个域名解析到一个IP地址，但不能将一个域名解析到多个IP地址。

**MX记录**，表示的是Mail Exchange（邮件交换记录），用于将以该域名为结尾的电子邮件指向对应的邮件服务器以进行处理。如：用户所用的邮件是以域名mydomain.com为结尾的，则需要在管理界面中添加该域名的MX记录来处理所有以@mydomain.com结尾的邮件。 

说明：MX记录可以使用主机名或IP地址；·MX记录可以通过设置优先级实现主辅服务器设置，“优先级”中的数字越小表示级别越高。也可以使用相同优先级（即随机）达到负载均衡的目的；·如果在“主机名”中填入子域名则此MX记录只对该子域名生效。

**CNAME记录**，全称是Canonical Name（别名解析）。可以为一个域名设置一个或者多个别名。

说明：CNAME的目标主机地址只能使用主机名，不能使用IP地址；·主机名前不能有任何其他前缀，如：http://等是不被允许的；A记录优先于CNAME记录。即如果一个主机地址同时存在A记录和CNAME记录，则CNAME记录不生效。  

**NS记录**，解析服务器记录，为某个域名指定DNS解析服务器，也就是这个域名由指定的IP地址的DNS域名服务器去解析。例如用户希望由12.34.56.78这台服务器解析news.mydomain.com，则需要设置news.mydomain.com的NS记录。

说明：“优先级”中的数字越小表示级别越高；·“IP地址/主机名”中既可以填写IP地址，也可以填写像ns.mydomain.com这样的主机地址，但必须保证该主机地址有效。如将news.mydomain.com的NS记录指向到ns.mydomain.com，在设置NS记录的同时还需要设置ns.mydomain.com的指向，否则NS记录将无法正常解析；NS记录优先于A记录。即，如果一个主机地址同时存在NS记录和A记录，则A记录不生效。这里的NS记录只对子域名生效。 

**TXT记录**，为某个主机名或域名设置说明，如可以为taobao.com设置TXT记录为“天下第一”这样的说明。

## DNS解析过程

当用户在浏览器中输入域名并按下回车键后
```
第一步：浏览器会检查缓存中有没有这个域名对应的解析过的IP地址，如果有，这个解析过程就结束了，直接拿到IP进行访问。这个浏览器缓存域名是有限制的，除了缓存大小有限制，缓存的时间也有限制，通常情况下由TTL属性来设置。

第二步：如果用户浏览器缓存中没有，浏览器会查找操作系统中是否有这个域名对应的DNS解析结果。windows中c:/windows/system32/drivers/etc/hosts文件设置，linux中/etc/hosts文件中设置。当解析到这个配置文件中的某个域名时，操作系统会在缓存中缓存这个解析结果。（修改文件后不立即生效的原因）

第三步：在网络配置中都会有“DNS服务器地址”这一项，当前面两步都不能解析时，操作系统会把这个域名发送给设置的DNS服务器（简称LDNS）-local缩写，一般是本地区的域名服务器也可以是自己设置的域名服务器地址，如果命中，那解析就此结束并返回IP并标记为**非权威服务器的应答**。如是学校的互联网，那么你的DNS服务器肯定在你的学校，如果你是一个小区接入互联网，那这个DNS就是提供给你接入互联网的应用供应商，即电信或联通。windows中能用ipconfig查看DNS服务器地址，linux中cat /etc/resolv.conf查看DNS Server。

第四步：如果LDNS没有命中，LDNS就会向Root Server域名服务器请求解析。LDNS会从**配置文件**里面读取13个根域名服务器的地址（这些地址是不变的，直接在BIND的配置文件中），然后像其中一台发起请求。

第五步:根服务器拿到这个请求后，知道他是com.这个顶级域名下的，所以就会返回com.域中的NS记录，一般来说是13台主机名和IP（主域名服务器地址即gTLD-国际顶级域名服务器地址），返回给本地域名服务器即LDNS，

第六步：LDNS再向上一步返回的其中一台gTLD服务器发送请求。com.域的服务器（gTLD）发现你这请求是baidu.com这个域的，一查发现了这个域的NS（一般就是你注册的域名服务器），那就返回给你，你再去查。

第七步：LDNS接受gTLD返回的域服务器地址（即域名服务提供商的域服务器）并向其中一台再次发起请求，在baidu.com的域下面查了下有www的这台主机，就把这个IP返回给你了。

第八步：LDNS接受返回的IP和TLL值

第九步：LDNS缓存这个域名和IP的对应关系，缓存时间有TLL控制

第十步：LDNS把解析的结果返回给用户，用户根据TLL值缓存在本地系统缓存中，域名解析结束。

ps：

一般经历从根域名（.）到gTLD Server(.com.)到Name Server(taobao.com.)

DNS的服务器有多个备份，可以从任何一台查询到解析结果。
```

## 跟踪域名解析过程的命令

nslookup　　查询域名的解析结果　　linux&windows

dig host +trace　　查询DNS的解析过程　　linux 


## 清除缓存的域名

 ipconfig /flushdns　　刷新缓存　　windows

 /etc/init.d/nscd restart　　重启　　linux

JVM也会缓存DNS的解析结果，这个缓存是在InetAddress类中完成的，而且这个缓存时间比较特殊，它有两种策略：一种是正确解析结果缓存，另一种是失败的解析结果缓存。这两个缓存时间由两个配置项控制，配置项在%JAVA_HOME%\lib\security\java.security文件中。两个配置项分别是networkaddress.cache.ttl和networkaddress.cache.negative.tll，默认值分别是-1（永不失效）和10（缓存10秒）。

-Dsun.net.inetaddr.tll=***可以来修改默认值，InetAddress类也可以动态修改。

# CDN(Content Delivery Network)

CDN也就是内容分布网络（Content Delivery Network），它是构筑在现有 Internet 上的一种先进的流量分配网络。其目的是通过在现有的 Internet 中增加一层新的网络架构，将网站的内容发布到最接近用户的网络"边缘"，使用户可以就近取得所需的内容，提高用户访问网站的响应速度。有别于镜像，它比镜像更智能，可以做这样一个比喻：CDN = 镜像（Mirror）+ 缓存（Cache）+ 整体负载均衡（GSLB）。因而，CDN 可以明显提高 Internet中信息流动的效率。

目前CDN都以缓存网站中的静态数据为主，如CSS、JS、图片和静态页面等数据。用户在从主站服务器请求到动态内容后再从CDN上下载这些静态数据，从而加速网页数据内容的下载速度，如淘宝有90%以上的数据都是由CDN来提供的。 


## CDN架构

 ![img](https://images2015.cnblogs.com/blog/990532/201609/990532-20160926122456828-1341887244.png)

一个用户访问某个静态文件（如CSS文件），这个静态文件的域名假如是cdn.taobao.com，那么首先要向Local DNS服务器发起请求，一般经过迭代解析后回到这个域名的注册服务器去解析，一般每个公司都会有一个DNS解析服务器。这时这个DNS解析服务器通常会把它重新CNAME解析到另外一个域名，重新从.（根域名）发起对这个域名的解析，而这个域名最终会被指向CDN全局中的DNS负载均衡服务器，再由这个GTM来最终分配是哪个地方的访问用户，返回给离这个访问用户最近的CDN节点。

拿到DNS解析结果，用户就直接去这个CDN节点访问这个静态文件了，如果这个节点中所请求的文件不存在，就会再回到源站去获取这个文件，然后再返回给用户。


## 负载均衡

负载均衡（Load Balance）就是对工作任务进行平衡、分摊到多个操作单元上执行，如图片服务器、应用服务器等，共同完成工作任务。它可以提高服务器响应速度及利用效率，避免软件或者硬件模块出现单点失效，解决网络拥塞问题，实现地理位置无关性，为用户提供较一致的访问质量。

通常有三种负载均衡架构，分别是链路负载均衡、集群负载均衡和操作系统负载均衡。

链路负载均衡也就是前面提到的通过DNS解析成不同的IP，然后用户根据这个IP来访问不同的目标服务器。负载均衡是由DNS的解析来完成的，用户最终访问哪个Web Server是由DNS Server来控制的，在这里就是由Global DNS Server来动态解析域名服务。这种DNS解析的优点是用户会直接访问目标服务器，而不需要经过其他的代理服务器，通常访问速度会更快。但是也有缺点，由于DNS在用户本地和Local DNS Server都有缓存，一旦某台Web Server挂掉，那么很难及时更新用户的域名解析结构。如果用户的域名没有及时更新，那么用户将无法访问这个域名，带来的后果非常严重。

![img](https://images2015.cnblogs.com/blog/990532/201609/990532-20160926122600860-370855683.png)

 

集群负载均衡是另外一种常见的负载均衡方式，它一般分为硬件负载均衡和软件负载均衡。

硬件负载均衡一般使用一台专门硬件设备来转发请求，硬件负载均衡的关键就是这台价格非常昂贵的设备，如F5，通常为了安全需要一主一备。它的优点很显然就是性能非常好，缺点就是非常贵，一般公司是用不起的，还有就是当访问量陡然增大超出服务极限时，不能进行动态扩容。

![img](https://images2015.cnblogs.com/blog/990532/201609/990532-20160926122652641-78942974.png)

 

软件负载均衡是使用最普遍的一种负载方式，它的特点是使用成本非常低，直接使用廉价的PC就可以搭建。缺点就是一般一次访问请求要经过多次代理服务器，会增加网络延时。两台是LVS，使用四层负载均衡，也就是在网络层利用IP地址进行地址转发。下面三台使用HAProxy进行七层负载，也就是可以根据访问用户的HTTP请求头来进行负载均衡，如可以根据不同的URL来将请求转发到特定机器或者根据用户的Cookie信息来指定访问的机器。

![img](https://images2015.cnblogs.com/blog/990532/201609/990532-20160926122717063-856578111.png)

 

操作系统负载均衡，就是利用操作系统级别的软中断或者硬件中断来达到负载均衡，如可以设置多队列网卡等来实现。


## CDN动态加速

CDN动态加速技术原理是在CDN的DNS解析中通过动态的链路探测来寻找回源最好的一条路径，然后通过DNS的调度将所以请求调度到选定的这条路径上回源，从而加速用户访问的效率。

由于CDN节点是遍布全国的，所有用户接入一个CDN节点后可以选择一条从离用户最近的CDN节点到原站链路最好的路径让用户走。一个简单的原则就是从源站上下载一个指定大小的文件，看哪个链路耗时最短，这样可以构成一个链路列表然后绑定到DNS解析上，更新到CDN的LDNS。