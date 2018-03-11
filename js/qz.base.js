/*
 * General function
 *
 * Copyright (c) 2013 qianzhu
 * http://www.1000zhu.com/
 *
 */

//判断是否为空
function isNull(str) {
    if (str == null || str == "" || str.length < 1)
        return true;
    else
        return false;
}

//操作方法
//参数：cmd - 命令名称
//　　　ids - 信息ID集合，可为空
//　　　param - URL参数，可为空
//　　　groupName - 可选项，当ids为空时自动获取复选框值的组名称，默认名"g1"
function operate(cmd, ids, param, groupName) {
    if (isNull(ids)) {
        var gn = "g1";
        if (arguments.length == 4) gn = groupName;
        ids = getCheckboxValues(gn);
    }
    if (isNull(ids)) { alert("请选择要操作的信息"); return; }

    if (cmd == "del") {
        var flag = confirm("删除后无法恢复，确认删除所选记录吗？");
        if (flag == "0") return;
    }

    if (isNull(param)) param = "";
    window.location.href = "?cmd=" + cmd + "&ids=" + ids + param;
}

//获取复选框选中状态
function checked(event) {
    if (event.attr("checked") == true || event.attr("checked") == "checked")
        return true;
    else
        return false;
}

//获取复选框选中值
function getCheckboxValues(groupName) {
    var vals = "";
    $("[name=" + groupName + "]:checkbox").each(function() {
        if ($(this).attr("checked")) vals += $(this).val() + ",";
    });
    if (vals.length > 0) vals = vals.substring(0, vals.length - 1);
    return vals;
}

//设置复选框全选/全取消
function setAllCheckbox(event, groupName) {
    $("[name=" + groupName + "]:checkbox").each(function() {
        var checked = false;
        if (event.attr("checked") == true || event.attr("checked") == "checked") checked = true;
        $(this).attr("checked", checked);
    });
}

//设置复选框被选中状态
function setCheckbox(vals, groupName) {
    if (vals.length <= 0) return;
    $("[name=" + groupName + "]:checkbox").each(function() {
        var pos = vals.indexOf("," + $(this).val() + ",");
        if (pos >= 0) $(this).attr("checked", true);
    });
}

//正则验证
//数字：/^\d+$/
function regex(str, expression) {
    if (expression.test(str))
        return true;
    else
        return false;
}

//获取页面文件名
function getPageName() {
    var strUrl = window.location.pathname.split("/");
    return strUrl[strUrl.length - 1];
}

//获取不带参数的URL
function getUrl() {
    var url = document.location.href.toLowerCase();
    var pos = url.indexOf("?");
    if (pos > 0) url = url.substring(1, pos);
    return url;
}

//获取URL参数值
function getQueryString(key) {
    var returnValue = "";
    var URLString = new String(document.location);
    var serachLocation = -1;
    var queryStringLength = key.length;

    do {
        serachLocation = URLString.indexOf(key + "\=");
        if (serachLocation != -1) {
            if ((URLString.charAt(serachLocation - 1) == '?') || (URLString.charAt(serachLocation - 1) == '&')) {
                URLString = URLString.substr(serachLocation);
                break;
            }
            URLString = URLString.substr(serachLocation + queryStringLength + 1);
        }
    }

    while (serachLocation != -1)
    if (serachLocation != -1) {
        var seperatorLocation = URLString.indexOf("&");
        if (seperatorLocation == -1)
            returnValue = URLString.substr(queryStringLength + 1);
        else
            returnValue = URLString.substring(queryStringLength + 1, seperatorLocation);
    }

    return returnValue;
}

//加入收藏
function addFavorite() {
    var url = window.location;
    var title = document.title;
    var ua = navigator.userAgent.toLowerCase();
    if (ua.indexOf("360se") > -1) {
        alert("由于360浏览器功能限制，请按 Ctrl+D 手动收藏！");
    }
    else if (ua.indexOf("msie 8") > -1) {
        window.external.AddToFavoritesBar(url, title); //IE8
    }
    else if (document.all) {
        try {
            window.external.addFavorite(url, title);
        } catch (e) {
            alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
        }
    }
    else if (window.sidebar) {
        window.sidebar.addPanel(title, url, "");
    }
    else {
        alert('您的浏览器不支持,请按 Ctrl+D 手动收藏!');
    }
}