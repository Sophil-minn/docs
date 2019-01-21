import {
    HOST
} from 'constans.js';
let app = getApp();

var forreall = {

    request: function(params) {
      let url = HOST + `${params.url}`;
      let method = params.method;

      let header, body;
      if (method === 'POST' || method === 'PUT') {
        body = params.data;
        body.unionid = wx.getStorageSync('openid');
      } else {
        body = '';
      }
      header = {
        'Accept': "application/vnd.MLMSys.v1+json",
        'Authorization': 'Bearer '
      }

      wx.request({
        url: url,
        method: method || "GET",
        data: body,
        header,
        success: function (res) {
          try {
            params.success(res.data);
          } catch (e) {
            console.log(e)
          }
        }
      })
    }
}

module.exports = forreall;
