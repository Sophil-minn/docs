# [使用性能API快速分析web前端性能](https://segmentfault.com/a/1190000004010453)

页面的性能问题一直是产品开发过程中的重要一环，很多公司也一直在使用各种方式监控产品的页面性能。从控制台工具、Fiddler抓包工具，到使用`DOMContentLoaded`和`document.onreadystatechange`这种侵入式javascript代码方式来检测DOM事件发生和结束的时间，再到使用第三方工具如`WebPagetest`、`Pingdom`等通过在不同的浏览器环境和地域进行测试来寻求优化建议等等，这些方式不仅麻烦，而且测量的指标比较单一。如果有一些可以帮我们直接获取页面性能信息的API出现，并且成为标准被被浏览器厂商支持，那性能监控会不会又是另一幅蓝图？

好在W3C Web性能工作小组与各浏览器厂商都已认识到性能对于web开发的重要性，为了解决当前性能测试的困难，W3C推出了一套性能API标准，各种浏览器对这套标准的支持如今也逐渐成熟起来。这套API的目的是简化开发者对网站性能进行精确分析与控制的过程，方便开发者采取手段提高web性能。

整套标准包含了10余种API，各自针对性能检测的某个方面。在下图中可以看到它们当前在规范流程中的进展：

![API进展](http://horve.github.io/images/performance/1.png)

## 下面是API及描述其功能的列表：

| API                      | 名称         | 功能                                                         |
| ------------------------ | ------------ | ------------------------------------------------------------ |
| Navigation Timing        | 导航计时     | 能够帮助网站开发者检测真实用户数据（RUM），例如带宽、延迟或主页的整体页面加载时间。 |
| Resource Timing          | 资源计时     | 对单个资源的计时，可以对细粒度的用户体验进行检测。           |
| High Resolution Timing   | 高精度计时   | 该API规范所定义的JavaScript接口能够提供精确到微秒级的当前时间，并且不会受到系统时钟偏差或调整的影响。 |
| Page Visibility          | 页面可见性   | 通过这一规范，网站开发者能够以编程方式确定页面的当前可见状态，从而使网站能够更有效地利用电源与CPU。当页面获得或失去焦点时，文档对象的visibilitychange事件便会被触发。 |
| Performance Timeline     | 性能时间线   | 以一个统一的接口获取由Navigation Timing、Resourcing Timing和User Timing所收集的性能数据。 |
| Battery Status           | 电池状态     | 能够检测当前设备的电池状态，例如是否正在充电、电量等级。可以根据当前电量决定是否显示某些内容，对于移动设备来说非常实用。 |
| User Timing              | 用户计时     | 可以对某段代码、函数进行自定义计时，以了解这段代码的具体运行时间。 |
| Beacon                   | 灯塔         | 可以将分析结果或诊断代码发送给服务器，它采用了异步执行的方式，因此不会影响页面中其它代码的运行。 |
| Animation Timing         | 动画计时     | 通过requestAnimationFrame函数让浏览器精通地控制动画的帧数，能够有效地配合显示器的刷新率，提供更平滑的动画效果，减少对CPU和电池的消耗。 |
| Resource Hits            | 资源提示     | 通过html属性指定资源的预加载，例如在浏览相册时能够预先加载下一张图片，加快翻页的显示速度。 |
| Frame Timing             | 帧计时       | 通过一个接口获取与帧相关的性能数据，例如每秒帧数和TTF。      |
| Navigation Error Logging | 错误日志记录 | 通过一个接口存储及获取与某个文档相关的错误记录。             |

## 浏览器支持

下表列举了当前主流浏览器对性能API的支持，其中标注星号的内容并非来自于Web性能工作小组。

| 规范                                   | IE   | Firefox        | Chrome       | Safari | Opera | iOS Safari     | Android |
| -------------------------------------- | ---- | -------------- | ------------ | ------ | ----- | -------------- | ------- |
| Navigation Timing                      | 9    | 31             | 全部         | 8      | 26    | 8 (不包括 8.1) | 4.1     |
| High Resolution Timing                 | 10   | 31             | 全部         | 8      | 26    | 8 (不包括 8.1) | 4.4     |
| Page Visibility                        | 10   | 31             | 全部         | 7      | 26    | 7.1            | 4.4     |
| Resource Timing                        | 10   | 34             | 全部         | -      | 26    | -              | 4.4     |
| Battery Status*                        | -    | 31（部分支持） | 38           | -      | 26    | -              | -       |
| User Timing                            | 10   | -              | 全部         | -      | 26    | -              | 4.4     |
| Beacon                                 | -    | 31             | 39           | -      | 26    | -              | -       |
| Animation Timing                       | 10   | 31             | 全部         | 6.1    | 26    | 7.1            | 4.4     |
| Resource Hints                         | -    | -              | 仅限Canary版 | -      | -     | -              | -       |
| Frame Timing                           | -    | -              | -            | -      | -     | -              | -       |
| Navigation Error Logging               | -    | -              | -            | -      | -     | -              | -       |
| WebP*                                  | -    | -              | 全部         | -      | 26    | -              | 4.1     |
| Picture element and srcset attribute * | -    | -              | 38           | -      | 26    | -              | -       |

其中有两个可以帮助我们检测真实用户环境下的页面加载Timing和页面资源加载Timing: `Navigation Timing`和`Resource Timing`。这两个API非常有用，可以帮助我们获取页面的Domready时间、onload时间、白屏时间等，以及单个页面资源在从发送请求到获取到rsponse各阶段的性能参数。

使用这两个API时需要在页面完全加载完成之后才能使用，最简单的办法是在window.onload事件中读取各种数据，因为很多值必须在页面完全加载之后才能得出。

## Navigation Timing

`Navigation Timing API`能够帮助网站开发者检测真实用户数据（RUM），例如带宽、延迟或主页的整体页面加载时间。用法如下：

```
var timinhObj = performance.timing;
```

`performance.timing`返回的是一个`PerformanceTiming`对象，如下图：

![PerformanceTiming](http://horve.github.io/images/performance/performancetiming01.png)

如果要获得 page load time(页面加载时间)，可以用`PerformanceTiming`对象中`loadEventStart`的值减去`navigationStart`的值：

```
plt = page.loadEventStart - page.navigationStart;
```

需要注意的是，`PerformanceTiming`对象中各属性值的单位均为毫秒数。

`PerformanceTiming`对象包含了各种与浏览器性能有关的时间数据，提供浏览器处理网页各个阶段的耗时，它包含的页面性能属性如下表：

| 属性                       | 含义                                                         |
| -------------------------- | ------------------------------------------------------------ |
| navigationStart            | 准备加载新页面的起始时间                                     |
| redirectStart              | 如果发生了HTTP重定向，并且从导航开始，中间的每次重定向，都和当前文档同域的话，就返回开始重定向的timing.fetchStart的值。其他情况，则返回0 |
| redirectEnd                | 如果发生了HTTP重定向，并且从导航开始，中间的每次重定向，都和当前文档同域的话，就返回最后一次重定向，接收到最后一个字节数据后的那个时间.其他情况则返回0 |
| fetchStart                 | 如果一个新的资源获取被发起，则 fetchStart必须返回用户代理开始检查其相关缓存的那个时间，其他情况则返回开始获取该资源的时间 |
| domainLookupStart          | 返回用户代理对当前文档所属域进行DNS查询开始的时间。如果此请求没有DNS查询过程，如长连接，资源cache,甚至是本地资源等。 那么就返回 fetchStart的值 |
| domainLookupEnd            | 返回用户代理对结束对当前文档所属域进行DNS查询的时间。如果此请求没有DNS查询过程，如长连接，资源cache，甚至是本地资源等。那么就返回 fetchStart的值 |
| connectStart               | 返回用户代理向服务器服务器请求文档，开始建立连接的那个时间，如果此连接是一个长连接，又或者直接从缓存中获取资源（即没有与服务器建立连接）。则返回domainLookupEnd的值 |
| (secureConnectionStart)    | 可选特性。用户代理如果没有对应的东东，就要把这个设置为undefined。如果有这个东东，并且是HTTPS协议，那么就要返回开始SSL握手的那个时间。 如果不是HTTPS， 那么就返回0 |
| connectEnd                 | 返回用户代理向服务器服务器请求文档，建立连接成功后的那个时间，如果此连接是一个长连接，又或者直接从缓存中获取资源（即没有与服务器建立连接）。则返回domainLookupEnd的值 |
| requestStart               | 返回从服务器、缓存、本地资源等，开始请求文档的时间           |
| responseStart              | 返回用户代理从服务器、缓存、本地资源中，接收到第一个字节数据的时间 |
| responseEnd                | 返回用户代理接收到最后一个字符的时间，和当前连接被关闭的时间中，更早的那个。同样，文档可能来自服务器、缓存、或本地资源 |
| domLoading                 | 返回用户代理把其文档的 "current document readiness" 设置为 "loading"的时候 |
| domInteractive             | 返回用户代理把其文档的 "current document readiness" 设置为 "interactive"的时候. |
| domContentLoadedEventStart | 返回文档发生 DOMContentLoaded事件的时间                      |
| domContentLoadedEventEnd   | 文档的DOMContentLoaded 事件的结束时间                        |
| domComplete                | 返回用户代理把其文档的 "current document readiness" 设置为 "complete"的时候 |
| loadEventStart             | 文档触发load事件的时间。如果load事件没有触发，那么该接口就返回0 |
| loadEventEnd               | 文档触发load事件结束后的时间。如果load事件没有触发，那么该接口就返回0 |

一般来说，我们需要获取到的页面性能参数包括：**DNS查询耗时、TCP链接耗时、request请求耗时、解析dom树耗时、白屏时间、domready时间、onload时间**等，而这些参数是通过上面的`performance.timing`各个属性的差值组成的，计算方法如下：

```
DNS查询耗时 ：domainLookupEnd - domainLookupStart
TCP链接耗时 ：connectEnd - connectStart
request请求耗时 ：responseEnd - responseStart
解析dom树耗时 ： domComplete - domInteractive
白屏时间 ：responseStart - navigationStart
domready时间 ：domContentLoadedEventEnd - navigationStart
onload时间 ：loadEventEnd - navigationStart
```

`Navigation Timing`的目的是用于分析页面整体性能指标。如果要获取个别资源（例如JS、图片）的性能指标，就需要使用`Resource Timing API`。

## Resource Timing

浏览器获取网页时，会对网页中每一个静态资源（脚本文件、样式表、图片文件等等）发出一个HTTP请求。`Resource Timing`可以获取到单个静态资源从开始发出请求到获取响应之间各个阶段的Timing。用法如下:

```
var resourcesObj = performance.getEntries();
```

`Resource Timing`返回的是一个对象数组，数组的每一个项都是一个对象，这个对象中包含了当前静态资源的加载Timing，如下图：

![PerformanceTiming](http://horve.github.io/images/performance/performancetiming02.png)

我们可以根据数组的长度获取到页面中静态资源的数量，然后通过数组的每一项分析单个静态资源的请求状态。

`performance`中还有一些性能API尚未成为W3C标准（如第一张图中的工作进度），有的处于编辑草案阶段，有的处于工作草案阶段，当这些API逐渐成为推荐标准以后，一定会对我们进行前端性能监控带来很大的便利，我们也可以通过这些API很方便地直接从页面中获取到我们希望得到的性能信息。

## 相关资源

[performance API](http://javascript.ruanyifeng.com/bom/performance.html)

[window.performance 详解](https://github.com/fredshare/blog/issues/5)

[使用简洁的 Navigation Timing API 测试网页加载速度（不完全译文）](http://www.cnblogs.com/mrsunny/archive/2012/09/04/2670727.html)

### [从 Chrome 源码看浏览器如何加载资源](https://segmentfault.com/r/1250000011782411?shareId=1210000011782412)

# [使用性能API快速分析web前端性能](https://segmentfault.com/a/1190000004010453)



## [如何在浏览器中查看当前页面请求各个指标数据](https://blog.csdn.net/q_12341234/article/details/42461255)

# [HTML5 performance API 草案.](http://www.cnblogs.com/_franky/archive/2011/11/07/2238980.html)

### [Performance API](http://javascript.ruanyifeng.com/bom/performance.html)



eg1

```
var namespace = {};
 
 
void function (window, document,  ns, undefined){
 
     
    ns = window[ns];
     
    if(!window.performance || ns.Performance){
    //performance api , (Date : 2011-11),  ie9+(包括兼容模式), chrome11+, Firefox7+ . (Safari,Opera. 没有实现) 
        return;
    }
     
     
    var mixin = function (oTarget ,oSource) {
            var s;
            for (s in oSource){
                if(oSource.hasOwnProperty(s)){
                    oTarget[s] = oSource[s];
                }
            }
            return oTarget;
        },
        performance = window.performance,
        timing = performance.timing,
        navigation = performance.navigation,
        create = function (properties) {
            var obj;
             
            if(Object.create){
                return Object.create(null, properties);
            }
             
             
            obj = {};
            for (var s  in properties){
                /*
                 
                    ie9+ 兼容模式. performance 可用，但ES5 相关特性不可用.
                    但是getter 的设计,本来是为了解决.获取时间不正确的状况处理的.
                    比如 responseTime 的设计.  为了解决这个问题.引入了update接口.
                 
                */
                if(properties.hasOwnProperty(s)){
                    if(typeof properties[s].get == 'function'){
                        //如果属性是一个函数,那么就应该是需要延迟获取的属性.则调用相关get方法获取当前值.
                        obj[s] = properties[s].get();
                    }else{
                        obj[s] = properties[s].value;
                    }
                }
            }
            return obj; 
        },
        properties = {
            isDirectClientCache : {//是否直接走的客户端缓存.
                value : function () {
                    if(navigation.type === 1){//刷新的访问,自然不可能直接走cache.
                        return false;
                    }
                    if(timing.requestStart === 0){//Firefox7,当直接走缓存时request,connect相关时间节点都为0
                        return true;
                    }
                    if(timing.connectStart === timing.connectEnd){//Freifox8+,Chrome11+,IE9+
                    //应注意的是,有时候304时, 如果资源问本地文件，chrome会因为connect连接建立过快，而导致 此处为true. 但基本线上应不会出现此类问题.
                    //另一个解决思路是对比responseStart和responseEnd.但这个受干扰影响更多.更不靠谱.
                        return true;
                    }
                     
                    return false;
                }()
            },
            navigationType : {
                value : navigation.type 
                /*  
                    0  nomal get or link .  
                    1  reload.   
                    2 back forward.
                    3 reserved . (oters method.)
                    但应注意的是,Firefox8+,开始又恢复了Firefox3.5-的老问题，即返回（后退）的方式访问页面，onload不会被触发.
                    所以如果搜集信息上报,是在onload回调中,就要警惕,Firefox8+浏览器，会导致上报脚本，没有被执行的问题.
                    Opera,Safari 也存在同样的问题,将来这两款浏览器支持performance时也应注意.
                    另外一个问题就是,domContentLoaded事件存在onload同样的问题.只有IE和Chrome,没有这个问题.
                    最靠谱的做法是注册到onpageshow上(如果浏览器支持的话). 否则.除非我们牺牲精准度.来直接执行脚本...
                     
                     
                    辅onpageshow 事件支持情况:
                     
                        onpageshow的支持列表:
                        Firefox 1.5 +
                        Safari5+
                        Chrome4+
 
                        Opera12,IE10 PP2,至今仍未支持 .
                     
                */
            },
            redirectCount : {//只能统计到同源的重定向次数.
                value : navigation.redirectCount
            },
            redirectTime : {//重定向消耗的时间.
                value : timing.redirectEnd - timing.redirectStart
            },
            /* fetchTime,我们 拿到，没什么价值，也没有优化的可能性存在.
            fetchTime : {
                value : Math.max(timing.domainLookupStart - timing.fetchStart, 0)
                //Firefox的domainLookupStart，如果因没有发生dns look up ,则该值不是fetchStart,而是navigationStart的值.并没有遵守标准.
            },
            */
            domainLookupTime : {
                value : timing.domainLookupEnd - timing.domainLookupStart
            },
            connectTime : {//注意,这个不是连接保持的时间,而是与服务器端建立连接所花费的时间.
                value : timing.connectEnd - timing.connectStart
            },
            requestTime : {//因为木有准确的获取RequestEnd的有效办法.所以这个值实际上是我们接收到服务器响应数据的那个时间 减去发出HTTP请求，所花费的时间.
                //注意,Firefox 7,在走cache时.requestStart,会为0.Firefox8以修复.当无法正确获取时,我们应该返回 -1.
                value : timing.responseStart - (timing.requestStart || timing.responseStart + 1)
            }
        },
        deferrProperites = {
                //延时的属性
            responseTime : {
                /*
                 
                    .responseEnd
                    返回用户代理接收到最后一个字符的时间，和当前连接被关闭的时间中，更早的那个. 同样,文档可能来自服务器、缓存、或本地资源.
                    补充: 此值的读取应该是在我们可以确保真的是Response结束以后. 比如window.onload.  因为考虑到chunked输出的情况. 那么我们脚本执行，并获取该值时，响应还没有结束. 这就会导致获取时间不准确.
                    bugs : 
                         1. IE10 PP2, 以及Chrome17- ，走本地缓存时.在文档中间的脚本执行时去读取此值, 将为0. IE9本来没有问题,结果IE10 PP2,反倒有了问题.
                         2. Chrome16-,(Chrome17,已修复此问题.)在地址栏输入相同地址,走本地缓存时. responseEnd的时间，居然早于responseStart的时间. （不得不承认，这简直就是奇葩啊!）
                         3. Chrome17-,从页面a,到地址b,再重定向到地址c, 此时如果地址c是走缓存.则. ResponseEnd的时间，会早于ResponseStart的时间.(好吧,我们把希望寄予Chrome18好了.)
 
                    实现差异:(由于草案中，并未提及,当文档被分段输出后.在中间文档数据，接受过程中,responseEnd应如何处理,导致浏览器实现存在差异.)
                         IE9 - IE10 PP2 , Firefox8-Firefox10,在不走存在Response阶段（非走cache的情况下.）.会根据每次接收到的数据块的时间,去更新.responseEnd的时间.
                         Chrome17-,Firefox7,则在分段数据的接受过程中，不会更新.responseEnd的时间,其值,始终为0.
 
                         
                    基于不确定性,所以该值被获取的时如果过早，就返回 -1, 否则返回正确的值.
                    DomContentLoaded., 即语义上的DOM Parse 也早已结束了.而且其他资源也都加在完毕了.   而更早的 domInteractive .IE系列存在bug:
                    IE9 - IE10 PP2(IE10,走cache情况除外). 在分段输出文档的情况下，该值并不是全部文档解析完成后的时间,而是第一个数据块被解析完成的时间. 
 
                        实现差异:(由于草案中，并未提及,文档解析并未结束时,其默认值的应该是多少.导致浏览器实现有差异.)
                        按我个人理解，并未解析结束，应该为0. 但是IE似乎对这个东西理解不太一样. 其他浏览器会是0. 
                        但是. IE9-IE10 PP2,则会比较有趣.即使是分段输出,我取到的值.也和onload以后去到的,domInteractive的值是一致的.  
                        导致这一神奇现象的原因是,正式IE系的bug所导. 该时间是错误的引用了,DOM解析完成第一个数据块的时间.而不是整个文档的. 
                        但是纠结起来就要挖掘更深层次的原因了. 因为草案只说该值体现的是,用户代理把"current document readiness" 设置为 "interactive"的时间.
                        如果IE系处理分段输出的html文档，向来都是这样做的。那么该值与其他浏览器的差异。也是可以理解的. 
                     
                    基于，以上综合原因，所以决定借助domContentLoadedEventStart 检测来确定responseTime是否可信. 如不可信，则返回-1.
                 
                */
                get : function () {//此值IE9仅共参考.并不值信任.IE10则可信任.
                    var val = timing.responseEnd - timing.responseStart;
                    if(timing.domContentLoadedEventStart){
                        if(val < 0 ) {//修正chrome16- 走cache时的bug.
                            val = 0;
                        }
                    }else {
                        val = -1;
                    }
                    return val;
                }
                 
            },
            domParsingTime : {//IE系不可信任.职能期待IE系将来的实现了.
                get : function () {
                    /*
                        注意IE9 - IE10 PP2,bug.  IE下，这个计算出来的值，仅共参考.完全不靠谱.
                        iE9 - IE10 PP2 , 当文档是chunked方式输出的时候.总是要等最后一个chunked被浏览器接收后,
                        domLoading才会有有效值.  也就是说,IE中目前的状况是.domLoading.无论如何，都要晚于responseEnd.
                        其他浏览器则无此问题.  但是这个问题导致我们计算IE下DOM Parsing等后续的一系列时间不准确. 
                        即 domInteractive - domLoading 甚至会经常得到0.   
                         
                         
                         
                     
                    */
                     
                   
                    return timing.domContentLoadedEventStart ? timing.domInteractive - timing.domLoading : -1;
                }
            },
            resourcesLoadedTime : {//IE系列不可信任,原因当然是分段输出问题.domLoading不准确,导致后续计算都不准确的问题.所以仅供参考.
                /*
                   此时间指的是.页面所有onload计算范围内的资源加载结束后到文档开始进行dom parse的时间段. 
                 
                */
                get : function () {
                    return timing.loadEventStart ? timing.loadEventStart - timing.domLoading : -1;
                }
            },
            firstPaintTime : {//从导航到页面首次渲染所消耗的时间.(该属性并非标准的属性.而是微软私有的.目前IE9+支持)
                get : function () {//如果都不支持该属性，或，读取该属性时，页面还没有渲染,则返回 -1;
                    //这段代码是一个愿望，希望将来,firstPaint 将进入草案，并被浏览器实现.哪怕他们依赖前缀.
                    var t = timing.firstPaint ||  
                            timing.msFirstPaint || 
                            timing.mozFirstPaint || 
                            timing.webkitFirstPaint || 
                            timing.oFirstPaint;
                             
                    return t ? t - timing.fetchStart : -1; 
                             
                     
                }
            },
            domContentLoadedTime : {//从导航 到 页面domReady所消耗的时间. 
                get : function () {
                     return timing.domContentLoadedEventStart ? timing.domContentLoadedEventStart - timing.fetchStart : -1;
                }
            },
            windowLoadedTime :{//获取当前文档fetchStart 到 window.onload,所花费的总时间.
                get : function () {
                    return timing.loadEventStart ? timing.loadEventStart - timing.fetchStart : -1;
                }
            }
        },
        pfm = create(mixin(properties, deferrProperites));
         
         
    ns.Performance = pfm;
 
     
     
    if(Object.defineProperty){//单体对象的方法，没有必要挂在到prototype上. so ..
        Object.defineProperty(pfm, 'update', {value : function () {return this;}});
    }else{ //for IE9+,兼容模式. 需要每次依赖update方法，每次都去手动更新那些不靠谱的东西.
        pfm.update = function () {
            for (var s in deferrProperites){
                if(deferrProperites.hasOwnProperty(s)){
                    pfm[s] = deferrProperites[s].get();
                }
            }
        }
    }
 
     
     
     
}(window, document, 'namespace');
 
 
window.onload = function () {
    setTimeout(function () {
        var pfm = namespace.Performance;
        pfm.update();
        alert([
            'isDirectClientCache : ' + pfm.isDirectClientCache,
            'navigationType : ' + pfm.navigationType,
            'redirectCount : ' + pfm.redirectCount,
            'redirectTime : ' + pfm.redirectTime,
            'domainLookupTime : ' + pfm.domainLookupTime,
            'connectTime : ' + pfm.connectTime,
            'requestTime : ' + pfm.requestTime,
            'responseTime : ' + pfm.responseTime,
            'domParsingTime : ' + pfm.domParsingTime,
            'resourcesLoadedTime : ' + pfm.resourcesLoadedTime,
            'firstPaintTime : ' + pfm.firstPaintTime,
            'domContentLoadedTime : ' + pfm.domContentLoadedTime,
            'windowLoadedTime : ' + pfm.windowLoadedTime
        ].join('\n'));
     
    }, 300);
}
```







eg2.

```
;
(function() {
 
    handleAddListener('load', getTiming)
 
    function handleAddListener(type, fn) {
        if(window.addEventListener) {
            window.addEventListener(type, fn)
        } else {
            window.attachEvent('on' + type, fn)
        }
    }
 
    function getTiming() {
        try {
            var time = performance.timing;
            var timingObj = {};
 
            var loadTime = (time.loadEventEnd - time.loadEventStart) / 1000;
 
            if(loadTime < 0) {
                setTimeout(function() {
                    getTiming();
                }, 200);
                return;
            }
 
            timingObj['重定向时间'] = (time.redirectEnd - time.redirectStart) / 1000;
            timingObj['DNS解析时间'] = (time.domainLookupEnd - time.domainLookupStart) / 1000;
            timingObj['TCP完成握手时间'] = (time.connectEnd - time.connectStart) / 1000;
            timingObj['HTTP请求响应完成时间'] = (time.responseEnd - time.requestStart) / 1000;
            timingObj['DOM开始加载前所花费时间'] = (time.responseEnd - time.navigationStart) / 1000;
            timingObj['DOM加载完成时间'] = (time.domComplete - time.domLoading) / 1000;
            timingObj['DOM结构解析完成时间'] = (time.domInteractive - time.domLoading) / 1000;
            timingObj['脚本加载时间'] = (time.domContentLoadedEventEnd - time.domContentLoadedEventStart) / 1000;
            timingObj['onload事件时间'] = (time.loadEventEnd - time.loadEventStart) / 1000;
            timingObj['页面完全加载时间'] = (timingObj['重定向时间'] + timingObj['DNS解析时间'] + timingObj['TCP完成握手时间'] + timingObj['HTTP请求响应完成时间'] + timingObj['DOM结构解析完成时间'] + timingObj['DOM加载完成时间']);
 
            for(item in timingObj) {
                console.log(item + ":" + timingObj[item] + '毫秒(ms)');
            }
 
            console.log(performance.timing);
 
        } catch(e) {
            console.log(timingObj)
            console.log(performance.timing);
        }
    }
})();
```

