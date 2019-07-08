
function _params(url) {
  var a = document.createElement('a');
  a.href = url;

  var ret = {},
    seg = a.search.replace(/^\?/, '').split('&'),
    len = seg.length, i = 0, s;
  for (; i < len; i++) {
    if (!seg[i]) { continue; }
    s = seg[i].split('=');
    ret[s[0]] = s[1];
  }
  return ret;

}


/** 
 * url: http://192.168.6.47:3000/?a=5&c=5#/?b=4&ff=656, ?a=5&c=5#/?b=4&ff=656, a=5
 * 
 * {
 *    a: "5",
 *    c: "5",
 *    b: "4",
 *    ff: "656"
 * }
 * 
*/

export default (url) => {
  let obj = {};
  url = url || window.location.href;

  let ret = url.match(/\?[^#/]+/g);

  if (ret) {
    obj = ret.reduce((total, item) => {
      return Object.assign(total, _params(item))
    }, {})
  }

  return obj;
}


