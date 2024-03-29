# [Web 安全](https://kb.cnblogs.com/page/564656/)

攻：
- 取客户端 cookie，提交给 黑客 自己（取用户信息）
- sql jia登陆:? 占位符

防：
- 所用 输入


#### CSRF 攻击

　　CSRF(Cross-site request forgery), 跨站请求伪造，也被称为：one click attack/session riding， 缩写为：CSRF/XSRF

　　CSRF 可以简单理解为：攻击者盗用了你的身份，以你的名义发送恶意请求，容易造成个人隐私泄露以及财产安全。

![img](https://images2015.cnblogs.com/news/24634/201703/24634-20170310173400857-57627094.jpg)　　如上图所示：要完成一次 CSRF 攻击，受害者必须完成：

1. 登录受信任网站，并在本地生成 cookie
2. 在不登出 A 的情况下，访问危险网站 B

　　举个简单的例子：

　　某银行网站 A，它以 GET 请求来完成银行转账的操作，如：

```
http://www.mybank.com/transfer.php?toBankId=11&money=1000
```

　　而某危险网站 B，它页面中含有一段 HTML 代码如下：

```
<img src=http://www.mybank.com/transfer.php?toBankId=11&money=1000>
```

　　某一天，你登录了银行网站 A，然后又访问了危险网站 B，这时候你突然发现你的银行账号少了 1000 块，原因是银行网站 A 违反了 HTTP 规范，使用 GET 请求更新资源。

　　B 中的 <img> 以 GET 方式请求第三方资源(指银行网站，这原本是一个合法的请求，但被不法分子利用了)，由于你此前登录银行网站 A 且还未退出，这时候你的浏览器会带上你的银行网站 A 的 Cookie 发出 GET 请求，结果银行服务器收到请求后，认为这是一条合法的更新资源的操作，所以立刻进行转账操作，这样就完成了一次简单的跨站请求伪造。

　　银行发现这个问题后，决定把获取请求数据的方法改为 POST 请求，只获取 POST 请求的数据，后台处理页面 transfer.php 代码如下：

```
<?php
    session_start();
    if (isset($_POST['toBankId'] &&isset($_POST['money']))
    {
        transfer($_POST['toBankId'],　$_POST['money']);
    }
```

　　这样网站 B 就无法通过简单的 POST 请求来完成转账请求了。然而，危险网站 B 与时俱进，将其页面代码修改了下：

```
<body onload="steal()">
    <iframe name="steal" display="none">
　　     <form method="POST" name="transfer"　action="http://www.myBank.com/transfer.php">
　　        <input type="hidden" name="toBankId" value="11">
　　        <input type="hidden" name="money" value="1000">
　　     </form>
    </iframe>
</body>
```

　　因为这里危险网站 B 暗地里发送了 POST 请求到银行，通过一个隐藏的自动提交的表单来提交请求，同样地完成了转账操作。

　　可以看出，CSRF 攻击时源于 WEB 的隐式身份验证机制！WEB 的身份验证机制虽然可以保证一个请求是来自某个用户的浏览器，但无法保证该请求是经过用户批准发送的。

## 那么如何进行 CSRF 防御呢？

　　CSRF 防御可以从服务端和客户端两方面着手，防御效果是从服务端着手效果比较好，现在一般 CSRF 防御液都在服务端进行的。

- 关键操作只接受 POST 请求
- 验证码：

　　CSRF 攻击的过程，往往是在用户不知情的情况下发生的，在用户不知情的情况下构造网络请求，所以如果使用验证码，那么每次操作都需要用户进行互动，从而简单有效地防御了 CSRF 的攻击。

　　但是如果你自啊一个网站作出任何举动都要输入验证码的话会严重影响用户体验，所以验证码一般只出现在特殊操作里面，或者在注册时候使用。

- 检测 Referer：

　　常见的互联网页面与页面之间是存在联系的，比如你在 [腾讯首页](https://link.zhihu.com/?target=http%3A//www.qq.com) 应该找不到通往 [http://www.facebook.com](https://link.zhihu.com/?target=http%3A//www.facebook.com) 的链接的，比如你在某论坛留言，那么不管你留言之后重定向到哪里，之前的网址一定保留在新页面中 Referer 属性中。

　　通过检查 Referer 的值，我们就可以判断这个请求是合法的还是非法的，但是问题出在服务器不是任何时候都接受到 Referer 的值，所以 Referer Check 一般用于监控 CSRF 攻击的发生，而不用来抵御攻击。

- Token：目前主流的做法是使用 Token 防御 CSRF 攻击

　　CSRF 攻击要成功的条件在于攻击者能够准确地预测所有的参数从而构造出合法的请求，所以根据不可预测性原则，我们可以对参数进行加密从而防止 CSRF 攻击，可以保存其原有参数不变，另外添加一个参数 Token，其值是随机的，这样攻击者因为不知道 Token 而无法构造出合法的请求进行攻击，所以我们在构造请求时候只需要保证：

1. Token 要足够随机，使攻击者无法准确预测
2. Token 是一次性的，即每次请求成功后要更新 Token，增加预测难度
3. Token 要主要保密性，敏感操作使用 POST，防止 Token 出现在 URL 中

　　最后值得注意的是，过滤用户输入的内容不能阻挡 CSRF 攻击，我们需要做的事过滤请求的来源，因为有些请求是合法，有些是非法的，所以 CSRF 防御主要是过滤那些非法伪造的请求来源。

## XSS 攻击：

　　XSS 又称为 CSS，全程为 Cross-site script，跨站脚本攻击，为了和 CSS 层叠样式表区分所以取名为 XSS，是 Web 程序中常见的漏洞。

　　其原理是攻击者向有 XSS 漏洞的网站中输入恶意的 HTML 代码，当其它用户浏览该网站时候，该段 HTML 代码会自动执行，从而达到攻击的目的，如盗取用户的 Cookie，破坏页面结构，重定向到其它网站等。

　　例如：某论坛的评论功能没有对 XSS 进行过滤，那么我们可以对其进行评论，评论如下：

```
<script>
while(true) {
    alert('你关不掉我');
}
</script>
```

　　在发布评论中含有 JS 的内容文本，这时候如果服务器没有过滤或转义掉这些脚本，作为内容发布到页面上，其他用户访问这个页面的时候就会运行这段脚本。

　　这只是一个简单的小例子，恶意着可以将上述代码修改为恶意的代码，就可以盗取你的 Cookie 或者其它信息了。

　　XSS 类型：

　　一般可以分为： 持久型 XSS 和非持久性 XSS

1. 持久型 XSS 就是对客户端攻击的脚本植入到服务器上，从而导致每个正常访问到的用户都会遭到这段 XSS 脚本的攻击。(如上述的留言评论功能)
2. 非持久型 XSS 是对一个页面的 URL 中的某个参数做文章，把精心构造好的恶意脚本包装在 URL 参数重，再将这个 URL 发布到网上，骗取用户访问，从而进行攻击

　　非持久性 XSS 的安全威胁比较小，因为只要服务器调整业务代码进行过滤，黑客精心构造的这段 URL 就会瞬间失效了，而相比之下，持久型 XSS 的攻击影响力很大，有时候服务端需要删好几张表，查询很多库才能将恶意代码的数据进行删除。

## 如何防御 XSS 攻击？

　　理论上，网站上所有可输入的地方没有对输入内容进行处理的话，都会存在 XSS 漏洞，漏洞的危险取决于攻击代码的威力，攻击代码也不局限于 script，防御 XSS 攻击最简单直接的方法就是过滤用户的输入。

- 如果不需要用户输入 HTML，可以直接对用户的输入进行 HTML 转义：

```
<script>
window.location.href="http://www.xss.com";
</script>
```

　　经过转义后就成了：

```
&lt;script&gt;window.location.href=&quot;http://www.baidu.com&quot;&lt;/script&gt;
```

　　它现在会像普通文本一样显示出来，变得无毒无害，不能执行了。

- 当用户需要输入 HTML 代码时：

　　当我们需要用户输入 HTML 的时候，需要对用户输入的内容做更加小心细致的处理。

　　仅仅粗暴地去掉 script 标签是没有用的，任何一个合法 HTML 标签都可以添加 onclick 一类的事件属性来执行 JavaScript。

　　更好的方法可能是，将用户的输入使用 HTML 解析库进行解析，获取其中的数据。然后根据用户原有的标签属性，重新构建 HTML 元素树。构建的过程中，所有的标签、属性都只从白名单中拿取。

## SQL 注入：

　　所谓 SQL 注入，就是通过把 SQL 命令插入到 Web 表单提交或页面请求的查询字符串，最终达到棋牌呢服务器执行恶意的 SQL 命令。

　　具体来说，它是利用现有应用程序，将(恶意) 的 SQL 命令注入到后台数据库引擎执行的能力，它可以通过在 Web 表单中输入 (恶意) SQL 语句得到一个存在安全漏洞的网站上的数据库，而不是按照设计者意图去执行 SQL 语句。

## SQL 防护：

1. 永远不要信任用户的输入: 对用户的输入进行校验，可以通过正则表达式，或限制长度；对单引号和双"-"进行转换等。
2. 永远不要使用动态拼装 SQL，可以使用参数化的 SQL 或者直接使用存储过程进行数据查询存取。
3. 永远不要使用管理员权限的数据库连接，为每个应用使用单独的权限有限的数据库连接。
4. 不要把机密信息直接存放，加密或者 hash 掉密码和敏感的信息。

## DDOS 攻击：

　　分布式拒绝服务(DDoS:Distributed Denial of Service)攻击指借助于客户/服务器技术，将多个计算机联合起来作为攻击平台，对一个或多个目标发动DDoS攻击，从而成倍地提高拒绝服务攻击的威力。

　　可以打个比方：

　　一群恶霸试图让对面那家有着竞争关系的商铺无法正常营业，他们会采取什么手段呢？（只为举例，切勿模仿）

　　恶霸们扮作普通客户一直拥挤在对手的商铺，赖着不走，真正的购物者却无法进入；或者总是和营业员有一搭没一搭的东扯西扯，让工作人员不能正常服务客户；也可以为商铺的经营者提供虚假信息，商铺的上上下下忙成一团之后却发现都是一场空，最终跑了真正的大客户，损失惨重。

　　此外恶霸们完成这些坏事有时凭单干难以完成，需要叫上很多人一起。嗯，网络安全领域中 DoS 和 DDoS 攻击就遵循着这些思路。

　　DDOS 攻击利用目标系统网络服务功能缺陷或者直接消耗其系统资源，使得该目标系统无法提供正常的服务。

　　DDoS 攻击通过大量合法的请求占用大量网络资源，以达到瘫痪网络的目的。 具体有几种形式：

1. 通过使网络过载来干扰甚至阻断正常的网络通讯；
2. 通过向服务器提交大量请求，使服务器超负荷；
3. 阻断某一用户访问服务器；
4. 阻断某服务与特定系统或个人的通讯。

## SYN 攻击：

　　属于 DDOS 攻击中的一种具体表现形式。

　　在三次握手过程中，服务器发送 SYN-ACK 之后，收到客户端的 ACK 之前的 TCP 连接称为半连接(half-open connect)。此时服务器处于 SYN_RCVD 状态。当收到 ACK 后，服务器才能转入 ESTABLISHED 状态.

　　SYN 攻击指的是，攻击客户端在短时间内伪造大量不存在的 IP 地址，向服务器不断地发送 SYN 包，服务器回复确认包，并等待客户的确认。

　　由于源地址是不存在的，服务器需要不断的重发直至超时，这些伪造的 SYN 包将长时间占用未连接队列，正常的 SYN 请求被丢弃，导致目标系统运行缓慢，严重者会引起网络堵塞甚至系统瘫痪。

　　检测 SYN 攻击：检测 SYN 攻击非常的方便，当你在服务器上看到大量的半连接状态时，特别是源 IP 地址是随机的，基本上可以断定这是一次 SYN 攻击。

　　SYN 攻击防护：

1. 缩短超时（SYN Timeout）时间
2. 增加最大半连接数
3. 过滤网关防护