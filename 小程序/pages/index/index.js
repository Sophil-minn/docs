import {
  IMAGE_HOST
} from '../../constans.js';
let API = require('../../utils/api.js');

//获取应用实
let app = getApp();

let touch = {
  //拖拽数据
  startPoint: null,
  translateX: null,
  translateY: null,
  timeStampStart: null,
  timeStampEnd: null
};

Page({
  data: {
    allIDs:[],
    isLoadingEnd: false,
    movieData: [],
    isShowId: 0
  },
  
  onLoad: function (option) {
    wx.showLoading({
      title: '加载中...',
    })
    let isShowId;
    let movieData = this.data.movieData;
    this.setData({
      windowHeight: app.globalData.windowInfo.height,
      windowWidth: app.globalData.windowInfo.width
    })

    
  },

  getImages() {
    API.requestImages(this);
  },

  onReady() {
    this.getImages();

    this.dialog = this.selectComponent("#dialog");
  },

  showDialog(){
    this.dialog.showDialog();
  },

   //取消事件
  _cancelEvent(){
    console.log('你点击了取消');
    this.dialog.hideDialog();
  },
  //确认事件
  _confirmEvent(){
    console.log('你点击了确定');
    this.dialog.hideDialog();
  },

  touchStart: function (e) {
    touch.startPoint = e.touches[0];
    let timeStampStart = new Date().getTime();
    this.animation = wx.createAnimation({
      duration: 70,
      timingFunction: 'ease',
      delay: 0
    })
    this.touch = {
      timeStampStart
    }

  },
  //触摸移动事件
  touchMove: function (e) {
    let movieData, rotate;
    let currentPoint = e.touches[e.touches.length - 1];
    let translateX = currentPoint.clientX - touch.startPoint.clientX;
    let translateY = currentPoint.clientY - touch.startPoint.clientY;
    if (translateX < 0) {
      if (translateX > -10) {
        rotate = -1;
      } else {
        rotate = -4;
      }
    }
    if (translateX > 0) {
      if (translateX < 10) {
        rotate = 1;
      } else {
        rotate = 4;
      }
    }
    this.animation.rotate(rotate).translate(translateX, 10).step();
    let id = this.data.isShowId;
    movieData = this.data.movieData;
    movieData[id].animationData = this.animation.export();
    this.setData({
      movieData
    })

  },
  // 触摸结束事件
  touchEnd: function (e) {

    console.log(this.data.isShowId);
    if (this.data.isShowId >= this.data.movieData.length - 1) {
      this.setData({
        isLoadingEnd: true
      })
    }

    let movieData;
    let translateX = e.changedTouches[0].clientX - touch.startPoint.clientX;
    let translateY = e.changedTouches[0].clientY - touch.startPoint.clientY;
    let timeStampEnd = new Date().getTime();
    let time = timeStampEnd - this.touch.timeStampStart;
    let id = this.data.isShowId;

    console.log(id)
    
    let animation = wx.createAnimation({
      duration: 250,
      timingFunction: 'ease',
      delay: 0
    })
    if (time < 150) {
      //快速滑动
      if (translateX > 40) {
        //右划
       
        animation.rotate(0).translate(this.data.windowWidth, 0).step();
        movieData = this.data.movieData;
        movieData[id].animationData = animation.export();

        API.saveTaste(this.data.movieData[id].id,1);//保存数据
        this.markAsRead();
        this.setData({
          movieData
        })
      } else if (translateX < -40) {
        //左划
        
        animation.rotate(0).translate(-this.data.windowWidth, 0).step();
        movieData = this.data.movieData;
        movieData[id].animationData = animation.export();

        API.saveTaste(this.data.movieData[id].id, 2);//保存数据
        this.markAsRead();
        this.setData({
          movieData
        })
      } else {
        //返回原位置
        animation.rotate(0).translate(0, 0).step();
        movieData = this.data.movieData;
        movieData[this.data.isShowId].animationData = animation.export();
        this.setData({
          movieData,
        })
      }
    } else {
      if (translateX > 160) {
        //右划
       
        animation.rotate(0).translate(this.data.windowWidth, 0).step();
        movieData = this.data.movieData;
        movieData[id].animationData = animation.export();

        API.saveTaste(this.data.movieData[id].id, 1);//保存数据
        this.markAsRead();
        this.setData({
          movieData
        })
      } else if (translateX < -160) {
        //左划
        
        animation.rotate(0).translate(-this.data.windowWidth, 0).step();
        movieData = this.data.movieData;
        movieData[id].animationData = animation.export();

        API.saveTaste(this.data.movieData[id].id, 2);//保存数据
        this.markAsRead();
        this.setData({
          movieData
        })
      } else {
        //返回原位置
        animation.rotate(0).translate(0, 0).step();
        movieData = this.data.movieData;
        movieData[this.data.isShowId].animationData = animation.export();
        this.setData({
          movieData,
        })
      }
    }
  },
  onLike: function () {
    this.clickAnimation({
      direction: 'right',
    });

    if (this.data.isShowId <= this.data.movieData.length - 1){
      let current = this.data.isShowId;
     
      API.saveTaste(this.data.movieData[current].id,1)

        this.markAsRead();
    }
  },
  onUnlike: function () {
    this.clickAnimation({
      direction: 'left'
    });
    if (this.data.isShowId <= this.data.movieData.length - 1) {
        let current = this.data.isShowId;   

        API.saveTaste(this.data.movieData[current].id,2)
        
        this.markAsRead();
    }

  },
  markAsRead: function () {
    let nextId = this.data.isShowId+1;
    
    if (nextId == this.data.movieData.length - 1) {
      this.getImages();
      this.setData({
        isLoadingEnd: false
      })
    } 

      this.setData({
        isShowId: nextId,
      })
  
  },
 
  clickAnimation: function (params) {
    let x, y, duration, rotate, movieData;
    duration = 700;
    y = 100;

// 如果超过图片总数，则停止动画
    if (this.data.isShowId<this.data.movieData.length-1){
      
        if (params.direction === 'left') {
                rotate = -10;
                x = -this.data.windowWidth - 100;
        } else {

            rotate = 10;
            x = this.data.windowWidth + 100;
        }
        
        this.animation = wx.createAnimation({
            duration,
            timingFunction: 'ease',
            delay: 0
        })
        
        let id = this.data.isShowId;
        this.animation.rotate(rotate).translate(x, y).step();
        movieData = this.data.movieData;
        movieData[id].animationData = this.animation.export();
        this.setData({
            movieData
        }) 
    }else{
      this.setData({
        isLoadingEnd: true
      })
    }
  },

 
})

 
