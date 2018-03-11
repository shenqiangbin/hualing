// JavaScript Document

var mysrc = document.scripts[document.scripts.length - 1].src;
var match = mysrc.match(/\?gid=(\d+)/);
var groupId = match[1];

$(function() {
    $("#top .tags li").each(function(i, item) {
        if ($(item).attr("val") == groupId) $(item).addClass("current");
    });

    $("ul.add li:eq(1) input").val(groupId);
    ajax_getSiteMenuTitle(groupId);

    ajax_getSiteMenuTree();
    ajax_getOnePage();
    $("div.menuLib .tags ul li:eq(0)").addClass("cur");
    ajax_getCategoryTree();
    ajax_getForumTree();
    $("div.menuLib .panel .block:eq(0)").show();

    $("div.menuLib dl dd").click(function() {
        $("div.menuLib dl dd").removeClass("cur");
        $("div.menuLib .panel .block").hide();

        $(this).addClass("cur");
        var index = $("div.menuLib dl dd").index($(this));
        $("div.menuLib .panel .block:eq(" + index + ")").show();
    });

    $("ul.add li:eq(1) input").change(function() { ajax_getSiteMenuTitle($(this).val()); });
    $("ul.add input.btn").click(function() { ajax_addSiteMenu(); });

    $("div.menuLib .tags ul li").click(function() {
        $("div.menuLib .tags ul li").removeClass("cur");
        $(this).addClass("cur");
        ajax_getCategoryTree();
    });
});

//菜单树样式与动作
function menuTreeStyle(objTr) {
    var lv = objTr.attr("lv");
    if (isNull(lv)) return;

    var spaceHtml = "";
    var nodeClass = "leaf";
    var onoff = objTr.attr("onoff");
    var rank = objTr.attr("rank");
    var line = objTr.attr("line");

    if (!isNull(onoff)) {
        onoff = onoff.toLowerCase();
        if (onoff == "true") nodeClass = "close";
        else if (onoff == "false") nodeClass = "open";
    }

    if (!isNull(rank)) {
        rank = rank.toLowerCase();
        if (rank == "first") nodeClass += "l";
        else if (rank == "last") nodeClass += "u";
        else if (rank == "alone") nodeClass += "m";
    }

    for (i = 0; i < line.length; i++) {
        if (line.substr(i, 1) == "1") spaceHtml += "<div class=\"line\"></div>";
        else spaceHtml += "<div class=\"empty\"></div>";
    }

    if (isNull(onoff))
        objTr.find("td:eq(1)").children().first().before(spaceHtml + "<div class=\"" + nodeClass + "\"></div>");
    else {
        var id = objTr.find("td:eq(1) input").val();
        objTr.find("td:eq(1)").children().first().before(spaceHtml + "<div class=\"" + nodeClass + "\" onclick=\"ajax_siteMenuHandler('onoff'," + id + ");\"></div>");
    }

    objTr.find("td:eq(1),td:eq(2),td:eq(3)").click(function() {
        $("ul.add li:eq(1) input").val($(this).parent().find("td:eq(1) input").val());
        $("ul.add li:eq(1) u").html($(this).parent().find("td:eq(1) u").html());
    });
}

//显示菜单
function ajax_getSiteMenuTree() {
    $.get("/admin/ajax/getSiteMenuTree.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        gid: groupId
    }, function(data, textStatus) {
        if (textStatus == "success") {
            $("#checkAll").attr("checked", false);
            $("div.siteMenu table.tree tbody.info").html(data);
            $("div.siteMenu table.tree tr").each(function() { menuTreeStyle($(this)); });
            tableHover();
        }
    });
}

//获取菜单名称
function ajax_getSiteMenuTitle(pkid) {
    $.get("/admin/ajax/siteMenuHandler.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        action: "gettitle",
        pkid: pkid
    }, function(data, textStatus) {
        if (textStatus == "success") {
            if (data == "!N") $("ul.add li:eq(1) u").html("<span style='color:Red'>没有找到父级菜单！</span>");
            else $("ul.add li:eq(1) u").html(data);
        }
    });
}

//新增菜单
function ajax_addSiteMenu() {
    var fid = $("ul.add li:eq(1) input").val();
    if (isNull(fid) || !regex(fid, /^\d+$/)) { alert("请输入正确的父级ID！"); $("ul.add li:eq(1) input").focus(); return; }

    var title = $("ul.add li:eq(4) input").val();
    if (isNull(title)) { alert("请输入菜单名称！"); $("ul.add li:eq(3) input").focus(); return; }

    var url = $("ul.add li:eq(6) input").val();
    var target = "_self";
    if ($("ul.add li input:checkbox").attr("checked")) target = "_blank";
    
    $("ul.add li input.btn").attr("disabled", true);
    $.get("/admin/ajax/siteMenuHandler.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        action: "add",
        fid: fid,
        title: escape(title),
        url: escape(url),
        target: target
    }, function(data, textStatus) {
        if (textStatus == "success") {
            if (data != "1") { alert("操作失败！" + data); return; }
            ajax_getSiteMenuTree();
            $("ul.add li:eq(3) input").val("");
            $("ul.add li:eq(5) input").val("");
            $("ul.add li input.btn").attr("disabled", false);
        }
    });
}

//从页面中新增菜单
function ajax_addSiteMenuFromOnePage(pageId) {
    var fid = $("ul.add li:eq(1) input").val();
    if (isNull(fid) || !regex(fid, /^\d+$/)) { alert("请输入正确的父级ID！"); $("ul.add li:eq(1) input").focus(); return; }

    var target = "_self";
    if ($("ul.add li input:checkbox").attr("checked")) target = "_blank";

    $.get("/admin/ajax/siteMenuHandler.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        action: "addpage",
        pageId: pageId,
        fid: fid,
        target: target
    }, function(data, textStatus) {
        if (textStatus == "success") {
            if (data != "1") { alert("操作失败！"); return; }
            ajax_getSiteMenuTree();
        }
    });
}

//从树中新增菜单
function ajax_addSiteMenuFromTree(action, pattern, pkid) {
    var fid = $("ul.add li:eq(1) input").val();
    if (isNull(fid) || !regex(fid, /^\d+$/)) { alert("请输入正确的父级ID！"); $("ul.add li:eq(1) input").focus(); return; }

    var target = "_self";
    if ($("ul.add li input:checkbox").attr("checked")) target = "_blank";

    $.get("/admin/ajax/siteMenuHandler.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        action: action,
        pattern: pattern,
        pkid: pkid,
        fid: fid,
        target: target
    }, function(data, textStatus) {
        if (textStatus == "success") {
            if (data != "1") { alert("操作失败！"); return; }
            ajax_getSiteMenuTree();
        }
    });
}

//操作菜单
function ajax_siteMenuHandler(action, pkid) {
    if (isNull(pkid)) pkid = getCheckboxValues("g1");
    if (isNull(pkid)) { alert("请选择要操作的菜单"); return; }

    if (action == "del") {
        var flag = confirm("删除后无法恢复，确认删除所选菜单吗？");
        if (flag == "0") return;
    }

    $.get("/admin/ajax/siteMenuHandler.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        action: action,
        pkid: pkid
    }, function(data, textStatus) {
        if (textStatus == "success") {
            ajax_getSiteMenuTree();
        }
    });
}

//显示页面
function ajax_getOnePage() {
    $.get("/admin/ajax/getOnePage.ashx", {
        rnd: Math.floor(Math.random() * 9999)
    }, function(data, textStatus) {
        if (textStatus == "success") {
            $("div.menuLib table.list tbody.info").html(data);
            tableHover();
            $("div.menuLib table.list tr:last td").css("border", "none");
        }
    });
}

//设置树样式
function setTreeStyle(objTr, action) {
    var lv = objTr.attr("lv");
    if (isNull(lv)) return;

    var spaceHtml = "";
    var nodeClass = "leaf";
    var onoff = objTr.attr("onoff");
    var rank = objTr.attr("rank");
    var line = objTr.attr("line");

    if (!isNull(onoff)) {
        onoff = onoff.toLowerCase();
        if (onoff == "true") nodeClass = "close";
        else if (onoff == "false") nodeClass = "open";
    }

    if (!isNull(rank)) {
        rank = rank.toLowerCase();
        if (rank == "first") nodeClass += "l";
        else if (rank == "last") nodeClass += "u";
        else if (rank == "alone") nodeClass += "m";
    }

    for (i = 0; i < line.length; i++) {
        if (line.substr(i, 1) == "1") spaceHtml += "<div class=\"line\"></div>";
        else spaceHtml += "<div class=\"empty\"></div>";
    }

    if (isNull(onoff))
        objTr.find("td:eq(0)").children().first().before(spaceHtml + "<div class=\"" + nodeClass + "\"></div>");
    else {
        var id = objTr.find("td:eq(1) input").val();
        objTr.find("td:eq(0)").children().first().before(spaceHtml + "<div class=\"" + nodeClass + "\" onclick=\"ajax_open_close('" + action + "','" + id + "');\"></div>");
    }
}

//显示分类
function ajax_getCategoryTree() {
    $.get("/admin/ajax/getCategoryTree.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        gid: $("div.menuLib .tags ul li.cur").attr("group")
    }, function(data, textStatus) {
        if (textStatus == "success") {
            $("div.menuLib table.tree tbody.cat").html(data);
            $("div.menuLib table.tree tbody.cat tr").each(function() { setTreeStyle($(this), "onoff_cat"); });
            tableHover();
        }
    });
}

//显示论坛
function ajax_getForumTree() {
    $.get("/admin/ajax/getForumTree.ashx", {
        rnd: Math.floor(Math.random() * 9999)
    }, function(data, textStatus) {
        if (textStatus == "success") {
            $("div.menuLib table.tree tbody.bbs").html(data);
            $("div.menuLib table.tree tbody.bbs tr").each(function() { setTreeStyle($(this), "onoff_bbs"); });
            tableHover();
        }
    });
}

//操作分类
function ajax_open_close(action, pkid) {
    $.get("/admin/ajax/siteMenuHandler.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        action: action,
        pkid: pkid
    }, function(data, textStatus) {
        if (textStatus == "success") {
            ajax_getCategoryTree();
            ajax_getForumTree();
        }
    });
}