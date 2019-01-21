let API = require('../../utils/api.js');

Page({
    data: {
        idHide: 0,
        isEmpty: false,
        isLoadingEnd: false,
        movieData:[]
    },
    onLoad: function(option) {
        wx.showLoading({
            title: '加载中...',
        })
        
        wx.setNavigationBarTitle({
            title: '不喜欢的'
        })
    },
    onShow: function () {
      API.getTaste(this, 2);
    },

    onShowState: function (e) {
      this.data.idHide = e.currentTarget.dataset.alphabeta.id;
      let id = this.data.idHide;
      this.onShow();

      API.saveTaste(id - 1, 1)
    }
})
