let API = require('../../utils/api.js');
Page({
    data: {
        isEmpty: false,
        isLoadingEnd: false,
        idHide: 0,
        movieData: []
    },
    onLoad: function(option) {
        wx.showLoading({
            title: '加载中...',
        })
        
        wx.setNavigationBarTitle({
            title: '喜欢的'
        })
    },
    onShow: function(){
      API.getTaste(this, 1);
    },

    onShowState: function (e) {
      this.data.idHide = e.currentTarget.dataset.id;
      let id = this.data.idHide;
      this.setData({
        id
      })
      this.onShow();

      API.saveTaste(id, 2, this.onShow())
    }
})
