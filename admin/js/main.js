// JavaScript Document

$(function() {
    ajax_getCommonMenuList();

    $("#top ul.menu>li>a").each(function() {
        if ($(this).attr("rel")) $(this).powerFloat();
    });

    $("#top ul.menu li a").click(function() { aClick($(this)) });
    $("#top ul.tabs li a").click(function() { activeNavTab($(this).parent(), null) });

    if ($.cookie("searchtype")) $(".search .m").html($.cookie("searchtype"));
    else $(".search .m").html($("#searchType li:eq(0)").html());
    $(".search .m").powerFloat();

    $("#searchType li").click(function() {
        $(".search .m").html($(this).html());
        $.cookie("searchtype", $(this).html());
        $.powerFloat.hide();
    });

    $(".search .r input").click(function() {
        var keys = $.trim($("#keys").val());
        var searchtype = $(".search .m").html();
        if (searchtype == "新闻") addNavTab("1", "新闻", "articleManage.aspx?cid=3&title=" + escape(keys));
    });

    $(".search .l input").keydown(function() {
        if (event.keyCode == 13) {
            $(".search .r input").trigger("click");
            return false;
        }
    });

    if ($.browser.msie && parseInt($.browser.version) == 6) {
        var obj = $("#main .right div");
        obj.css('position', 'absolute');
        obj[0].style.setExpression('top', 'eval((document.documentElement).scrollTop + 400) + "px"');
    }

    $(".right a.totop").click(function() {
        $("html,body").animate({ scrollTop: $("body").offset().top }, 200);
    });

    $("input.refreshBtn, .right a.refresh").click(function() { refreshIframe() });
    window.setInterval("reinitIframe()", 200);
});

function activeNavTab(obj, url) {
    $("#top .board ul.tabs li").removeClass("current");
    obj.addClass("current");
    var val = $.trim(obj.find("a").attr("val"));

    $("#main ul.menu li").removeClass("current").each(function(i, item) {
        if ($.trim($(item).attr("val")) == val) $(item).addClass("current");
    });

    $("#frames iframe").css("display", "none").each(function(i, item) {
        if ($.trim($(item).attr("val")) == val) {
            if (url) $(item).attr("src", url);
            $(item).css("display", "");
        }
    });
}

function aClick(obj) {
    if (obj.attr("url").length <= 0) return;
    var title = obj.attr("key");
    if (!title) title = obj.html();
    addNavTab(obj.attr("val"), title, obj.attr("url"));

    $.powerFloat.hide();

    var curNavVal = $("#top .board ul.tabs li.current a").attr("val");
    $("#main ul.menu li").removeClass("current").each(function(i, item) {
        if ($.trim($(item).attr("val")) == curNavVal) $(item).addClass("current");
    });
}

function addNavTab(val, title, url) {
    var exsit = false;
    $("#top .board ul.tabs li").each(function(i, item) {
        if ($.trim($(item).find("a").attr("val")) == $.trim(val)) {
            activeNavTab($(item), url);
            exsit = true;
        }
    });

    if (!exsit) {
        $("#top .board ul.tabs li").removeClass("current");
        var tabHtml = "<li class=\"current\"><span class=\"l\"></span><a url=\"" + url + "\" val=\"" + val + "\" onclick=\"activeNavTab($(this).parent(), null);\">" + title + "</a><span class=\"r\" onclick=\"delNavTab($(this).parent());\"></span></li>";
        $("#top .board ul.tabs").append(tabHtml);

        $("#frames iframe").css("display", "none");
        var frameHtml = "<iframe id=\"frame_" + val + "\" src=\"" + url + "\" val=\"" + val + "\" frameborder=\"0\" scrolling=\"no\"></iframe>";
        $("#frames").append(frameHtml);

        $("#main ul.menu li a").removeClass("current").each(function(i, item) {
            if ($.trim($(item).attr("url")) == url) $(item).addClass("current");
        });
    }
}

function delNavTab(obj) {
    var prevObj = obj.prev();

    obj.remove();
    if (obj.attr("class") == "current") activeNavTab(prevObj, null);

    $("#frames iframe").each(function(i, item) {
        if ($.trim($(item).attr("val")) == $.trim(obj.find("a").attr("val"))) $(item).remove();
        if (obj.attr("class") == "current" && $.trim($(item).attr("src")) == $.trim(prevObj.find("a").attr("url"))) $(item).css("display", "");
    });
}

function setHeight(frame) {
    if (frame.contentWindow.document.body == null) return;
    if (frame.contentWindow.document.body.scrollHeight != null && frame.contentWindow.document.body.scrollHeight != 0)
        height = frame.contentWindow.document.body.scrollHeight;
    else if (frame.contentWindow.document.documentElement.scrollHeight != 0)
        height = frame.contentWindow.document.documentElement.scrollHeight;
    frame.height = height;
}

function reinitIframe() {
    $("#frames iframe").each(function(i, item) {
        setHeight(document.getElementById($(item).attr("id")));
    });
}

function refreshIframe() {
    var val = $("#top .board ul.tabs li.current a").attr("val");
    $("#frames iframe").each(function(i, item) {
        if ($.trim($(item).attr("val")) == $.trim(val)) {
            window.frames[i].location.reload();
        }
    });
}