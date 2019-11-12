### 操作 业务UI 相关

1. 定位到某个位置
1. 操作(显隐等)某个组件或UI


### 常规操作
1. 前进
1. 后退
1. 关闭
1. 重载
1. 跳转: (跳转指定页)

### 操作 系统设备 相关
1. 打开相册
1. 选择图片
1. 打电话
1. 发短信
1. 打开自定义分享 
1. 打开系统分享
1. 打开浏览器

### 操作 相关协议
1. 打开 别的 app
1. 定准到某一页

### 壳webview 与 JS 交互 (广播式交互)
- 广播式交互: 一方发出请求信息,不会等待响应
- 函数互调
- 

1. 设置 appBar
- 1. 设置 左边按钮
  1. 设置 右边按钮
  1. 显示隐藏
1. 分享
1. 借助壳打开 三方app 协议
1. 文件上传
1. 各种 Dialog
1. 各种 Toast



### 壳本身
1. 功能更新
1. 功能可自定义启用关闭

### 唤醒 - Uni Links

1. 浏览器 -> 唤醒APP
  用户A在手机上通过浏览器打开了某APP的M站或者官网，则引导用户打开该APP或者下载该APP。

2. 微信、QQ等 -> 唤醒APP
  用户通过某APP分享了一条链接至微信或QQ，用户B点开该链接后，引导用户B打开该APP或者下载该APP。

3. 短信、邮件、二维码等-> 唤醒APP
  用户A打开了某APP的推广短信，邮件或者扫描二维码等，引导用户打开该APP或者下载该APP。

4. 其他APP -> 唤醒APP
  用户A通过第三方APP分享了一条链接至用户B，用户B点开该链接后，引导用户B打开指定APP或者下载指定APP。



1. adb shell 验证
```
adb shell am start -a android.intent.action.MAIN -d "scheme://host"
adb shell am start -a android.intent.action.VIEW -d "example://gizmos" com.myapp

adb shell communicates with the only available device (or emulator), so if you've got multiple devices you have to specify which one you want to run the shell in via:

The only USB connected device - adb -d shell '...'
The only emulated device - adb -e shell '...'
You could use adb devices to list currently available devices (similarly flutter devices does the same job).
```

1. 常见APP的 URL scheme
```
QQ： mqq:// 
微信： weixin:// 
京东： openapp.jdmoble:// 
淘宝： taobao:// 
美团： imeituan:// 
点评： dianping:// 
1号店： wccbyihaodian:// 
支付宝： alipay:// 
微博： sinaweibo:// 
腾讯微博： TencentWeibo:// 
weico微博： weico:// 
知乎： zhihu:// 
豆瓣fm： doubanradio:// 
网易公开课： ntesopen:// 
Chrome： googlechrome:// 
QQ浏览器： mqqbrowser:// 
uc浏览器： ucbrowser:// 
搜狗浏览器： SogouMSE:// 
百度地图： baidumap:// bdmap:// 
优酷： youku:// 
人人： renren:// 
我查查： wcc:// 
有道词典： yddictproapp:// 
微盘： sinavdisk:// 
名片全能王： camcard://
```