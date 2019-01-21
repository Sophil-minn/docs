import {
  APP_ID,
  APP_SECRET
} from 'constans.js';
let forreall = require('forreall.js');

App({
    onLaunch: function() {
        try {
            var res = wx.getSystemInfoSync()
            this.globalData.windowInfo.width = res.windowWidth;
            this.globalData.windowInfo.height = res.windowHeight;
            
              var that = this;

              // var userInfo = wx.getStorageSync('userInfo');
              // if (!userInfo) {
                var objz = {};
                wx.getUserInfo({
                  success: function (res) {
                    objz = res.userInfo;
                    wx.setStorageSync('userInfo', objz);//存储userInfo  
                  }
                });
                wx.login({
                  success: function (res) {
                    console.log('code:', res);
                    forreall.request({
                      url:'/miniapps/jscode2session',
                      method:'POST',
                      data:{
                        appid: APP_ID,
                        secret: APP_SECRET,
                        js_code: res.code,
                        nickname: objz.nickName,
                        avatar: objz.avatarUrl,
                        gender: objz.gender,
                        province: objz.province,
                        city: objz.city,
                        country: objz.country
                      },
                      success: function(res){
                        wx.setStorageSync('openid', res.data);//存储userInfo
                      }
                    });
                  }
                })
              // } else {
              //   console.log(userInfo);
              // }
        } catch (e) {
            console.log(e)
            // Do something when catch error
        }
    },
    
    globalData: {
        windowInfo: {}
    },
    
})
