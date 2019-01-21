


[media-cut-tool](https://github.com/fengma1992/media-cut-tool)
[wavesurfer.js Playlist Demo](http://www.jq22.com/yanshi12107)
1、video 转 canvas（带音频）
2、[多视频播放处理](https://github.com/spademan/canvas-merge-video-in-vue)
3、[canvas 处理 图片](https://github.com/neilcarpenter/Video-filter-effects-for-canvas)
4、[视频过场效果](https://github.com/lyxuncle/iriswipe)[Canvas虹膜消除转场](https://aotu.io/notes/2016/04/13/Iris-Wipe/)
5、后端视频效果合成
6、视频转视频帧图片
[canvas+vue 实现视频碎片合并 比较粗陋](https://github.com/spademan/canvas-merge-video-in-vue)
```
1.先把所有视频碎片丢到dom里面
2.控制当前碎片指引，进行实例dom切换
3.video的currentTime只要video能播放就会改变，通过这个属性监控触发 canvas的drawimage
4.通过canvas 去drawimage去抓取当前碎片（也就是指引指向的那个video实例）
5.通过video的onend事件连接碎片
```
7、[canvas to gif](https://github.com/jnordberg/gif.js)
8、[video to gif](http://jnordberg.github.io/gif.js/tests/video.html)
9、[ffmpeg 图片 与 视频 互转]()

[canvas-nest](https://github.com/hustcc/canvas-nest.js)
![canvas-nest](https://raw.githubusercontent.com/hustcc/canvas-nest.js/master/screenshot.png)

[Dvideo](https://github.com/IFmiss/d-video) [canvas-video-player](https://github.com/Stanko/html-canvas-video-player)

[CreateJS引擎](https://www.createjs.com/) 
[PixiJS引擎](http://www.pixijs.com/)
[Fabric.js](http://fabricjs.com/)
[TOAST UI Calendar](http://ui.toast.com/tui-calendar/)
[raphael](http://dmitrybaranovskiy.github.io/raphael/)
[gojs](https://gojs.net/latest/samples/stateChart.html)
[w2ui](http://w2ui.com/)
[WebGL Shader 图形化编辑器](http://victhorlopez.github.io/editor/)
[webglstudio](https://github.com/bitores/webglstudio.js)
[css3d-engine](https://github.com/bitores/css3d-engine)


#### [html-canvas-video-player](https://github.com/Stanko/html-canvas-video-player)

#### [Video转换成Canvas](https://blog.csdn.net/u011200023/article/details/73733610)
```
/*
 * video视频转成canvas（兼容至IE8+）
 * Author: Zijor   Created On: 2017-06-25
 * 
 *  使用方法：
 *      var videoCanvas = new VideoToCanvas(videoDom);
 *
 *  对象的属性：
 *      暂无。
 *
 *  对象的方法：
 *      play       播放视频
 *      pause      暂停视频
 *      playPause  播放或暂停视频
 *      change(src) 切换视频。参数src为切换的视频地址
 */
var VideoToCanvas = (function(window, document) {
  function VideoToCanvas(videoElement) {
    if(!videoElement) {return;}

    var canvas = document.createElement('canvas');
    canvas.width = videoElement.offsetWidth;
    canvas.height = videoElement.offsetHeight;
    ctx = canvas.getContext('2d');

    var newVideo = videoElement.cloneNode(false);

    var timer = null;

    var requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
                                window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;

    var cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame;

    function drawCanvas() {
      ctx.drawImage(newVideo, 0, 0, canvas.width, canvas.height);
      timer = requestAnimationFrame(drawCanvas);
    }

    function stopDrawing() {
      cancelAnimationFrame(timer);
    }

    newVideo.addEventListener('play', function() {
      drawCanvas();
    },false);
    newVideo.addEventListener('pause', stopDrawing, false);
    newVideo.addEventListener('ended', stopDrawing, false);

    videoElement.parentNode.replaceChild(canvas, video);

    this.play = function() {
      newVideo.play();
    };

    this.pause = function() {
      newVideo.pause();
    };

    this.playPause = function() {
      if(newVideo.paused) {
        this.play();
      } else {
        this.pause();
      }
    };

    this.change = function(src) {
      if(!src) {return;}
      newVideo.src = src;
    };

    this.drawFrame = drawCanvas;
  }

  return VideoToCanvas;

})(window, document);

调用：

<video id="video" controls loop width='300' autoplay webkit-playsinline="true" src='http://www.w3school.com.cn/example/html5/mov_bbb.mp4'></video>

<script>
var video = document.getElementById('video');
new VideoToCanvas(video);
</script>
```

#### [音频](http://www.htmleaf.com/html5/yinpinheshipin/201503151524.html)


#### [弹幕](https://www.zhangxinxu.com/study/201709/canvas-barrage-video-demo.html)
```
/*!
** by zhangxinxu(.com)
** 与HTML5 video视频真实交互的弹幕效果
** http://www.zhangxinxu.com/wordpress/?p=6386
** MIT License
** 保留版权申明
*/
var CanvasBarrage = function (canvas, video, options) {
	if (!canvas || !video) {
		return;	
	}
	var defaults = {
		opacity: 100,
		fontSize: 24,
		speed: 2,
		range: [0,1],
		color: 'white',
		data: []
	};
	
	options = options || {};
	
	var params = {};
	// 参数合并
	for (var key in defaults) {
		if (options[key]) {
			params[key] = options[key];
		} else {
			params[key] = defaults[key];
		}
		
		this[key] = params[key];
	}
	var top = this;
	var data = top.data;
	
	if (!data || !data.length) {
		return;
	}

	var context = canvas.getContext('2d');
	canvas.width = canvas.clientWidth;
	canvas.height = canvas.clientHeight;

	// 存储实例
	var store = {};
	
	// 暂停与否
	var isPause = true;
	// 播放时长
	var time = video.currentTime;

	// 字号大小
	var fontSize = 28;

	// 实例方法
	var Barrage = function (obj) {
		// 一些变量参数
		this.value = obj.value;
		this.time = obj.time;
		// data中的可以覆盖全局的设置
		this.init = function () {
			// 1. 速度
			var speed = top.speed;
			if (obj.hasOwnProperty('speed')) {
				speed = obj.speed;
			}
			if (speed !== 0) {
				// 随着字数不同，速度会有微调
				speed = speed + obj.value.length / 100;
			}
			// 2. 字号大小
			var fontSize = obj.fontSize || top.fontSize;

			// 3. 文字颜色
			var color = obj.color || top.color;
			// 转换成rgb颜色
			color = (function () {
				var div = document.createElement('div');
				div.style.backgroundColor = color;
				document.body.appendChild(div);
				var c = window.getComputedStyle(div).backgroundColor;	
				document.body.removeChild(div);
				return c;
			})();
			
			// 4. range范围
			var range = obj.range || top.range;
			// 5. 透明度
			var opacity = obj.opacity || top.opacity;
			opacity = opacity / 100;
			
			// 计算出内容长度
			var span = document.createElement('span');
			span.style.position = 'absolute';
			span.style.whiteSpace = 'nowrap';
			span.style.font = 'bold ' + fontSize + 'px "microsoft yahei", sans-serif';
			span.innerText = obj.value;
			span.textContent = obj.value;
			document.body.appendChild(span);
			// 求得文字内容宽度
			this.width = span.clientWidth;
			// 移除dom元素
			document.body.removeChild(span);
			
			// 初始水平位置和垂直位置
			this.x = canvas.width;
			if (speed == 0) {
				this.x	= (this.x - this.width) / 2;
			}
			this.actualX = canvas.width;
			this.y = range[0] * canvas.height + (range[1] - range[0]) * canvas.height * Math.random();
			if (this.y < fontSize) {
				this.y = fontSize;
			} else if (this.y > canvas.height - fontSize) {
				this.y = canvas.height - fontSize;
			}
			
			this.moveX = speed;
			this.opacity = opacity;
			this.color = color;
			this.range = range;
			this.fontSize = fontSize;	
		};
		
		this.draw = function () {			
			// 根据此时x位置绘制文本
			context.shadowColor = 'rgba(0,0,0,'+ this.opacity +')';
			context.shadowBlur = 2;
			context.font = this.fontSize + 'px "microsoft yahei", sans-serif';
			if (/rgb\(/.test(this.color)) {
				context.fillStyle = 'rgba('+ this.color.split('(')[1].split(')')[0] +','+ this.opacity +')';
			} else {
				context.fillStyle = this.color;	
			}
			// 填色
			context.fillText(this.value, this.x, this.y);
		};
	};

	data.forEach(function (obj, index) {
		store[index] = new Barrage(obj);
	});

	// 绘制弹幕文本
	var draw = function () {
		for (var index in store) {
			var barrage = store[index];
			
			if (barrage && !barrage.disabled && time >= barrage.time) {
				if (!barrage.inited) {
					barrage.init();
					barrage.inited = true;
				}
				barrage.x -= barrage.moveX;
				if (barrage.moveX == 0) {
					// 不动的弹幕
					barrage.actualX -= top.speed;
				} else {
					barrage.actualX = barrage.x;
				}
				// 移出屏幕
				if (barrage.actualX < -1 * barrage.width) {
					// 下面这行给speed为0的弹幕
					barrage.x = barrage.actualX;
					// 该弹幕不运动
					barrage.disabled = true;
				}
				// 根据新位置绘制圆圈圈
				barrage.draw();	
			}
		}
	};
	
	// 画布渲染
	var render = function () {
		// 更新已经播放时间
		time = video.currentTime;
		// 清除画布
		context.clearRect(0, 0, canvas.width, canvas.height);
		
		// 绘制画布
		draw();

		// 继续渲染
		if (isPause == false) {
			requestAnimationFrame(render);
		}
	};
	
	// 视频处理
	video.addEventListener('play', function () {
		isPause = false;
		render();
	});
	video.addEventListener('pause', function () {
		isPause = true;
	});
	video.addEventListener('seeked', function () {
		// 跳转播放需要清屏
		top.reset();
	});
	
	
	// 添加数据的方法 
	this.add = function (obj) {
		store[Object.keys(store).length] = new Barrage(obj);
	};
	
	// 重置
	this.reset = function () {
		time = video.currentTime;
		// 画布清除
		context.clearRect(0, 0, canvas.width, canvas.height);
		
		for (var index in store) {
			var barrage = store[index];
			if (barrage) {
				// 状态变化
				barrage.disabled = false;
				// 根据时间判断哪些可以走起
				if (time < barrage.time) {
					// 视频时间小于播放时间
					// barrage.disabled = true;
					barrage.inited = null;
				} else {
					// 视频时间大于播放时间
					barrage.disabled = true;
				}
			}
		}
	};
};/*!
** by zhangxinxu(.com)
** 与HTML5 video视频真实交互的弹幕效果
** http://www.zhangxinxu.com/wordpress/?p=6386
** MIT License
** 保留版权申明
*/
var CanvasBarrage = function (canvas, video, options) {
	if (!canvas || !video) {
		return;	
	}
	var defaults = {
		opacity: 100,
		fontSize: 24,
		speed: 2,
		range: [0,1],
		color: 'white',
		data: []
	};
	
	options = options || {};
	
	var params = {};
	// 参数合并
	for (var key in defaults) {
		if (options[key]) {
			params[key] = options[key];
		} else {
			params[key] = defaults[key];
		}
		
		this[key] = params[key];
	}
	var top = this;
	var data = top.data;
	
	if (!data || !data.length) {
		return;
	}

	var context = canvas.getContext('2d');
	canvas.width = canvas.clientWidth;
	canvas.height = canvas.clientHeight;

	// 存储实例
	var store = {};
	
	// 暂停与否
	var isPause = true;
	// 播放时长
	var time = video.currentTime;

	// 字号大小
	var fontSize = 28;

	// 实例方法
	var Barrage = function (obj) {
		// 一些变量参数
		this.value = obj.value;
		this.time = obj.time;
		// data中的可以覆盖全局的设置
		this.init = function () {
			// 1. 速度
			var speed = top.speed;
			if (obj.hasOwnProperty('speed')) {
				speed = obj.speed;
			}
			if (speed !== 0) {
				// 随着字数不同，速度会有微调
				speed = speed + obj.value.length / 100;
			}
			// 2. 字号大小
			var fontSize = obj.fontSize || top.fontSize;

			// 3. 文字颜色
			var color = obj.color || top.color;
			// 转换成rgb颜色
			color = (function () {
				var div = document.createElement('div');
				div.style.backgroundColor = color;
				document.body.appendChild(div);
				var c = window.getComputedStyle(div).backgroundColor;	
				document.body.removeChild(div);
				return c;
			})();
			
			// 4. range范围
			var range = obj.range || top.range;
			// 5. 透明度
			var opacity = obj.opacity || top.opacity;
			opacity = opacity / 100;
			
			// 计算出内容长度
			var span = document.createElement('span');
			span.style.position = 'absolute';
			span.style.whiteSpace = 'nowrap';
			span.style.font = 'bold ' + fontSize + 'px "microsoft yahei", sans-serif';
			span.innerText = obj.value;
			span.textContent = obj.value;
			document.body.appendChild(span);
			// 求得文字内容宽度
			this.width = span.clientWidth;
			// 移除dom元素
			document.body.removeChild(span);
			
			// 初始水平位置和垂直位置
			this.x = canvas.width;
			if (speed == 0) {
				this.x	= (this.x - this.width) / 2;
			}
			this.actualX = canvas.width;
			this.y = range[0] * canvas.height + (range[1] - range[0]) * canvas.height * Math.random();
			if (this.y < fontSize) {
				this.y = fontSize;
			} else if (this.y > canvas.height - fontSize) {
				this.y = canvas.height - fontSize;
			}
			
			this.moveX = speed;
			this.opacity = opacity;
			this.color = color;
			this.range = range;
			this.fontSize = fontSize;	
		};
		
		this.draw = function () {			
			// 根据此时x位置绘制文本
			context.shadowColor = 'rgba(0,0,0,'+ this.opacity +')';
			context.shadowBlur = 2;
			context.font = this.fontSize + 'px "microsoft yahei", sans-serif';
			if (/rgb\(/.test(this.color)) {
				context.fillStyle = 'rgba('+ this.color.split('(')[1].split(')')[0] +','+ this.opacity +')';
			} else {
				context.fillStyle = this.color;	
			}
			// 填色
			context.fillText(this.value, this.x, this.y);
		};
	};

	data.forEach(function (obj, index) {
		store[index] = new Barrage(obj);
	});

	// 绘制弹幕文本
	var draw = function () {
		for (var index in store) {
			var barrage = store[index];
			
			if (barrage && !barrage.disabled && time >= barrage.time) {
				if (!barrage.inited) {
					barrage.init();
					barrage.inited = true;
				}
				barrage.x -= barrage.moveX;
				if (barrage.moveX == 0) {
					// 不动的弹幕
					barrage.actualX -= top.speed;
				} else {
					barrage.actualX = barrage.x;
				}
				// 移出屏幕
				if (barrage.actualX < -1 * barrage.width) {
					// 下面这行给speed为0的弹幕
					barrage.x = barrage.actualX;
					// 该弹幕不运动
					barrage.disabled = true;
				}
				// 根据新位置绘制圆圈圈
				barrage.draw();	
			}
		}
	};
	
	// 画布渲染
	var render = function () {
		// 更新已经播放时间
		time = video.currentTime;
		// 清除画布
		context.clearRect(0, 0, canvas.width, canvas.height);
		
		// 绘制画布
		draw();

		// 继续渲染
		if (isPause == false) {
			requestAnimationFrame(render);
		}
	};
	
	// 视频处理
	video.addEventListener('play', function () {
		isPause = false;
		render();
	});
	video.addEventListener('pause', function () {
		isPause = true;
	});
	video.addEventListener('seeked', function () {
		// 跳转播放需要清屏
		top.reset();
	});
	
	
	// 添加数据的方法 
	this.add = function (obj) {
		store[Object.keys(store).length] = new Barrage(obj);
	};
	
	// 重置
	this.reset = function () {
		time = video.currentTime;
		// 画布清除
		context.clearRect(0, 0, canvas.width, canvas.height);
		
		for (var index in store) {
			var barrage = store[index];
			if (barrage) {
				// 状态变化
				barrage.disabled = false;
				// 根据时间判断哪些可以走起
				if (time < barrage.time) {
					// 视频时间小于播放时间
					// barrage.disabled = true;
					barrage.inited = null;
				} else {
					// 视频时间大于播放时间
					barrage.disabled = true;
				}
			}
		}
	};
};
```