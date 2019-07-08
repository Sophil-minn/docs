
### btoa & atob
atob() 函数能够解码通过base-64编码的字符串数据。
btoa() 函数能够从二进制数据“字符串”创建一个base-64编码的ASCII字符串
```
中文编码一直都是程序员要关注的，window.btoa('哎哟不错')，是会抛出异常的。

那么一般的思想都是先借用encodeURIComponent进行base64编码，

然后借用decodeURIComponent进行base64解码。

后看到MDN的备注，

复制代码
function utf8_to_b64( str ) {
    return window.btoa(unescape(encodeURIComponent( str )));
}

function b64_to_utf8( str ) {
    return decodeURIComponent(escape(window.atob( str )));
}

// Usage:
utf8_to_b64('✓ à la mode'); // "4pyTIMOgIGxhIG1vZGU="
b64_to_utf8('4pyTIMOgIGxhIG1vZGU='); // "✓ à la mode"
//译者注:在js引擎内部,encodeURIComponent(str)相当于escape(unicodeToUTF8(str))
//所以可以推导出unicodeToUTF8(str)等同于unescape(encodeURIComponent(str))
```


- URL||webkitURL
- data:
- Blob || BlobBuilder:

```js
try {
    blob = new Blob([response], {type: 'application/javascript'});
} catch (e) { // Backwards-compatibility
    window.BlobBuilder = window.BlobBuilder || window.WebKitBlobBuilder || window.MozBlobBuilder;
    blob = new BlobBuilder();
    blob.append(response);
    blob = blob.getBlob();
}
```


```js
var blob = new Blob(["Hello, world!"], { type: 'text/plain' });
var blobUrl = URL.createObjectURL(blob); // create a v address.
var xhr = new XMLHttpRequest;
xhr.responseType = 'blob';
xhr.onload = function() {
   var recoveredBlob = xhr.response;
   var reader = new FileReader;
   reader.onload = function() {
     var blobAsDataUrl = reader.result;
     window.location = blobAsDataUrl;
   };
   reader.readAsDataURL(recoveredBlob);
};
xhr.open('GET', blobUrl);
xhr.send();
```

### Not allowed to navigate top frame to data URL, you can navigate iframe to data URL

```js
var pdf = "data:application/pdf;base64," + data;
window.open(pdf);
在Chrome使用window.open()打开pdf报错：

Not allowed to navigate top frame to data URL: data:application/pdf;base64,JVBERi0xLjMKMyAwIG9iago8PC9UeXBlIC9QYWdlCi9QYXJlbnQgMSAwIFIKL1....
原因分析
Chrome 60 开始禁止页面使用data:url的方式跳转导航，禁止data:url导航的使用包括：

<a href="data:xxxxx"> 点击跳转
window.open(“data:xxx”)
window.location="data:xxx"
对于使用data:url直接来加载数据的场景不会禁止，如

<img src="data:xxx" />直接加载图片
<iframe src="data:xxx" 
之所以禁止页面使用dta:url的方式跳转导航，是由于data:xxx协议存在安全问题，编码的url可能会被包含了一些攻击代码，被用来做网络钓鱼攻击。

解决方案
Chrome并没有禁止直接使用data:url的方式加载数据，如iframe，所以可以把数据放到iframe的属性src里。

var pdf = blobUrl;
var ifa = '<iframe src="' + pdf + '" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>'

e.g.
var win = window.open();
win.document.write(ifa)
or
document.body.innerHTML = ifa;


e.g.2
let ifa = '<iframe src="' + 'data:application/pdf;base64, sdfsdf' + '" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>';document.body.innerHTML = ifa;
```

### blob转base64位 和 base64位转blob
**dataURL to blob**
```js
function dataURLtoBlob(dataurl) {
    var arr = dataurl.split(','), 
        mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]), n = bstr.length, 
        u8arr = new Uint8Array(n);
    while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], { type: mime });
}

```
**blob to dataURL**
```js
function blobToDataURL(blob, callback) {
    var a = new FileReader();
    a.onload = function (e) { callback(e.target.result); }
    a.readAsDataURL(blob);
}

//test:
var blob = dataURLtoBlob('data:text/plain;base64,YWFhYWFhYQ==');
blobToDataURL(blob, function (dataurl) {
    console.log(dataurl);
});
```

### buffer 转base64
```js
var fs = require("fs");

var imageBuf = fs.readFileSync("D:\\Documents\\logo3.gif");

console.log(imageBuf.toString("base64"));
```