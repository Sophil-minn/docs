// 标题设置
export default (title) => {
  console.log(title)
  document.title = title;
  var mobile = navigator.userAgent.toLowerCase();
  if (/iphone|ipad|ipod/.test(mobile)) {
    var iframe = document.createElement('iframe');
    iframe.style.visibility = 'hidden';
    iframe.style.height = 0;
    iframe.style.display = 'none';
    iframe.setAttribute('src', 'favicon.ico');
    var iframeCallback = function () {
      setTimeout(function () {
        iframe.removeEventListener('load', iframeCallback);
        document.body.removeChild(iframe);
      }, 0);
    };
    iframe.addEventListener('load', iframeCallback);
    document.body.appendChild(iframe);
  }
}