// jQuery.autoIMG.js v0.3
// Tang Bin - http://planeArt.cn/ - MIT Licensed
(function($) {

    // 设置加载状态的替换图像
    var tempPath = '/plugin/autoimg/loading.gif';
    // 设置加载错误的替换图像
    var errorPath = '/plugin/autoimg/error.png';
    // 检测是否支持css2.1 max-width属性
    var isMaxWidth = 'maxWidth' in document.documentElement.style;
    // 检测是否IE7浏览器
    var isIE7 = ! -[1, ] && !('prototype' in Image) && isMaxWidth;

    new Image().src = tempPath;

    $.fn.autoIMG = function(options) {
        var defaults = {
            widthAuto: true,
            heightAuto: true,
            widthVar: 0,    //px
            heigthVar: 0,   //px
            middle: true
        };
        var o = $.extend(defaults, options);

        var $this = this;
        var maxWidth = $this.width() + o.widthVar;
        var maxHeight = $this.height() + o.heigthVar;
        if (maxWidth == 0 && $this.css("width")) maxWidth = $this.css("width").replace(new RegExp("px", "g"), "");
        if (maxHeight == 0 && $this.css("height")) maxHeight = $this.css("height").replace(new RegExp("px", "g"), "");

        return $this.find('img').each(function(i, img) {

            // 如果支持max-width属性则使用此，否则使用下面预加载方式
            /*if (isMaxWidth) {
            if (o.widthAuto) img.style.maxWidth = maxWidth + 'px';
            if (o.heightAuto) {
            img.style.maxHeight = maxHeight + 'px';
            if (o.middle) {
            $(function() {
            img.style.marginTop = (maxHeight - img.height) / 2 + 'px';
            img.style.display = "inline";
            });
            }
            }
            return;
            }*/

            var path = img.getAttribute('data-src') || img.src,
				next = img.nextSibling,
				parent = img.parentNode,
				temp = new Image();

            // 删除img图像，并替换成loading图片
            img.style.display = 'none';
            img.removeAttribute('src');
            parent.removeChild(img);

            temp.src = tempPath;

            imgReady(tempPath, function(width, height) {

                $(temp).css("display", "inline");
                temp.style.marginTop = (maxHeight - height) / 2 + 'px';
                next ? next.insertBefore(temp) : parent.appendChild(temp);

                // 图片尺寸就绪执行
                imgReady(path, function(width, height) {

                    if (o.widthAuto && o.heightAuto) {
                        if (width / height >= maxWidth / maxHeight) {
                            if (width > maxWidth) {
                                height = (height * maxWidth) / width;
                                width = maxWidth;
                            }
                        } else {
                            if (height > maxHeight) {
                                width = (width * maxHeight) / height;
                                height = maxHeight;
                            }
                        }
                    }
                    else if (o.widthAuto && width > maxWidth) {
                        height = maxWidth / width * height,
					width = maxWidth;
                    }
                    else if (o.heightAuto && height > maxHeight) {
                        width = maxHeight / height * width;
                        height = maxHeight;
                    }

                    // 删除loading图像
                    temp.parentNode.removeChild(temp);

                    // 恢复显示调整后的原图像
                    img.style.width = width + 'px';
                    img.style.height = height + 'px';
                    img.setAttribute('src', path);

                    $(img).css("display", "inline");
                    next ? next.insertBefore(img) : parent.appendChild(img);

                    // 调整图像垂直居中
                    if (o.middle && o.heightAuto) {
                        img.style.marginTop = (maxHeight - height) / 2 + 'px';
                    }

                }, function() {
                    // 加载错误
                    temp.src = errorPath;
                    temp.style.width = '32px';
                    temp.style.height = '32px';
                    temp.title = 'Image load error!';
                });
            });
        });
    };

    // IE7缩放图片会失真，采用私有属性通过三次插值解决
    isIE7 && (function(c, d, s) { s = d.createElement('style'); d.getElementsByTagName('head')[0].appendChild(s); s.styleSheet && (s.styleSheet.cssText += c) || s.appendChild(d.createTextNode(c)) })('img {-ms-interpolation-mode:bicubic}', document);

    // 图片头数据加载就绪事件
    // http://www.planeart.cn/?p=1121
    // @param	{String}	图片路径
    // @param	{Function}	获取尺寸的回调函数 (参数1接收width；参数2接收height)
    // @param	{Function}	加载错误的回调函数 (可选)
    (function() {
        var list = [], intervalId = null,

		tick = function() {
		    var i = 0;
		    for (; i < list.length; i++) {
		        list[i].end ? list.splice(i--, 1) : list[i]();
		    };
		    !list.length && stop();
		},

		stop = function() {
		    clearInterval(intervalId);
		    intervalId = null;
		};

        this.imgReady = function(url, callback, error) {
            var check, end, width, height, offsetWidth, offsetHeight, div,
				accuracy = 1024,
				doc = document,
				container = doc.body || doc.getElementsByTagName('head')[0],
				img = new Image();

            img.src = url;
            if (!callback) return img;

            // 如果图片被缓存，则直接返回缓存数据
            if (img.complete) return callback(img.width, img.height);

            // 向页面插入隐秘图像，用来监听图片是否占位
            div = doc.createElement('div');
            div.style.cssText = 'visibility:hidden;position:absolute;left:0;top:0;width:1px;height:1px;overflow:hidden';
            div.appendChild(img)
            container.appendChild(div);
            width = img.offsetWidth;
            height = img.offsetHeight;

            // 完全加载完毕的事件
            img.onload = function() {
                end();
                callback(img.width, img.height);
            };

            // 加载错误后的事件
            img.onerror = function() {
                end();
                error && error();
            };

            // 检测图片是否已经占位
            check = function() {
                offsetWidth = img.offsetWidth;
                offsetHeight = img.offsetHeight;
                if (offsetWidth !== width || offsetHeight !== height || offsetWidth * offsetHeight > accuracy) {
                    end();
                    callback(offsetWidth, offsetHeight);
                };
            };
            check.url = url;

            // 操作结束后进行清理
            // 删除元素与事件，避免IE内存泄漏
            end = function() {
                check.end = true;
                img.onload = img.onerror = null;
                div.innerHTML = '';
                div.parentNode.removeChild(div);
            };

            // 将检测图片是否占位的函数加入定时器列队定期执行
            // 同一图片只加入一个检测器
            // 无论何时只允许出现一个定时器，减少浏览器性能损耗
            !check.end && check();
            for (var i = 0; i < list.length; i++) {
                if (list[i].url === url) return;
            };
            if (!check.end) {
                list.push(check);
                if (!intervalId) intervalId = setInterval(tick, 150);
            };
        };
    })();

})(jQuery);