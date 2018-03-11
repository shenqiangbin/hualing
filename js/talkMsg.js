if (isMobile()) {
    ShowTalkMobile()
} else {
    ShowTalk({
        eqImgUrl: 'http://www.hualingedu.com/images/msglayer/lkf-eqcode.png'
    });
    ShowMsg();
}
function ShowTalkMobile() {
    var html = '<link href="http://www.hualingedu.com/css/kfstyle.css?v=2" rel="stylesheet" /><div id="lmobile" class="lmobile">\
        <a href="javascript:void(0)" class="lmobile-close-btn" onclick="CloseMsgMobile();">关闭</a>\
        <img src="http://www.hualingedu.com/images/msglayer/mobile-msg-bg.png" class="img-responsive" />\
        <div class="btns-bottom">\
            <div class="btn-box">\
                <a href="tel:4001099900">\
                    <img src="http://www.hualingedu.com/images/msglayer/mobile-phone.png" class="img-responsive" />\
                </a>\
            </div>\
            <div class="btn-box">\
                <a href="javascript:void(0)"  onclick="openZoosUrl(\'chatwin\',\'&e=客服人员在线,欢迎点击咨询\');return false;">\
                <img src="http://www.hualingedu.com/images/msglayer/mobile-talke.png" class="img-responsive" />\</a>\</div>\</div>\</div>';
    document.writeln(html);
}

function ShowTalk(config) {
    var html = "<link href='http://www.hualingedu.com/css/kfstyle.css?v=2' rel='stylesheet' />\
    <div class='lkf-box'>\
        <div class='lkf-content'>\
            <a href='http://lwt.zoosnet.net/LR/Chatpre.aspx?id=LWT91490211&lng=cn&oname=华领国际cma' target='_blank' class='btn-kf cma1'></a>\
            <a href='http://lwt.zoosnet.net/LR/Chatpre.aspx?id=LWT91490211&lng=cn&oname=华领cma碧蓉' target='_blank' class='btn-kf cma2'></a>\
            <a href='http://lwt.zoosnet.net/LR/Chatpre.aspx?id=LWT91490211&lng=cn' target='_blank' class='btn-kf qyzx'></a>\
            <a href='http://lwt.zoosnet.net/LR/Chatpre.aspx?id=LWT91490211&lng=cn&oname=华领管理会计大师课' target='_blank' class='btn-kf cpe'></a>\
            <a href='http://lwt.zoosnet.net/LR/Chatpre.aspx?id=LWT91490211&lng=cn&oname=华领教务' target='_blank' class='btn-kf jwfw'></a>\
            <img src='" + config.eqImgUrl + "' class='kf-eqcode' />\
        </div>\
        <a class='showbtn-kf isShow' href='javascript:void(0)' onclick='ShowHide(this)'></a>\
    </div>";
    document.writeln(html);
}

function ShowMsg() {
    var html = "<div class='tel-layer-box' id='telLayerBox'>\
        <input type='text' class='tel-text' placeholder='请输入您的电话号码' maxlength='11' id='btnRTxt'>\
        <a href='javascript:void(0);' class='tel-btn' id='btnRTel'>免费回电</a> \
        <a href='javascript:void(0);' onclick='CloseMsg()' class='tlb-close-btn'></a>\
        <a href='http://lwt.zoosnet.net/LR/Chatpre.aspx?id=LWT91490211' target='_blank' class='tlb-btn'></a>\
    </div>";
    document.writeln(html);
    document.writeln('<script type="text/javascript"  data-lxb-uid="3767661" data-lxb-gid="194843" src="http://lxbjs.baidu.com/api/asset/api.js?t=' + new Date().getTime() + '" charset="utf-8"></scr' + 'ipt>');
    document.writeln('<script>');
    document.writeln('document.getElementById("btnRTel").onclick=function(){');
    document.writeln('lxb.call(document.getElementById("btnRTxt"));};');
    document.writeln('<\/script>');
}

/*----------方法----------*/
function ShowHide(target) {
    if ($(target).hasClass('isShow')) {
        $(target).parent().stop().animate({ left: "-137px" });
        $(target).removeClass('isShow');
    } else {
        $(target).parent().stop().animate({ left: "0px" });
        $(target).addClass('isShow');
    }
}

function CloseMsg() {
    $('#telLayerBox').fadeOut();
    setTimeout(function () {
        $('#telLayerBox').fadeIn();
    }, 30000)
}

function CloseMsgMobile() {
    $('#lmobile').fadeOut();
    setTimeout(function () {
        $('#lmobile').fadeIn();
    }, 30000)
}

function isMobile() {
    var ua = navigator.userAgent;
    var ipad = ua.match(/(iPad).*OS\s([\d_]+)/),
        isIphone = !ipad && ua.match(/(iPhone\sOS)\s([\d_]+)/),
        isAndroid = ua.match(/(Android)\s+([\d.]+)/),
        isMobile = isIphone || isAndroid;
    return isMobile;
}

