import {
  IMAGE_HOST,
  MAX_Z
} from '../constans.js';
let forreall = require('../forreall.js');

var API = {
  requestImages: function (that){
    forreall.request({
      url: '/miniapps/imageNew',
      method: 'POST',
      data: {
        'count': 5
      },
      success: function (res) {
        let arr = res.data;
        let data = that.data;
        for (let i = 0; i < arr.length; i++) {
          if (data.allIDs.indexOf(arr[i].id) == -1) {

            data.allIDs.push(arr[i].id);
            data.movieData.push({
              "id": arr[i].id,
              "isRender": true,
              "animationData": null,
              "zIndex": MAX_Z - data.allIDs.length,
              "picUrl": IMAGE_HOST + arr[i].img_name
            });

          }

        }

        // ADD
        wx.hideLoading();
        that.setData({
          movieData: data.movieData,
          allIDs: data.allIDs
        });
      }
    });
  },

  saveTaste: function(imgId, taste, onShow){ // requestLike
    forreall.request({
      url:'/miniapps/tasteStore',
      method: 'POST',
      data:{
        'img_id': imgId,
        'taste': taste
      },
      success: function(res){
        onShow;
      }
    });
  },

  getTaste: function(that, taste){
    forreall.request({
      url: '/miniapps/imageTaste',
      method: "POST",
      data: {
        'taste': taste
      },
      success: function (res) {
        wx.hideLoading()
        let arr = res.data;
        let data = that.data;
        data.listArr = arr.length;
        for (let i = 0; i < arr.length; i++) {
          data.movieData[i] = {
            "id": arr[i].id,
            "isRender": true,
            "score": i,
            "picUrl": IMAGE_HOST + arr[i].img_name
          }
        }
        that.setData({
          movieData: data.movieData,
          listArr: data.listArr
        });
      }
    });
  }

}

module.exports = API;