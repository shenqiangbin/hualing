// JavaScript Document


//获取常用菜单按钮
function ajax_getCommonBtn() {
    $.get("/admin/ajax/getCommonBtn.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        id: $(window.parent.document).find("#top ul.tabs li.current a").attr("val")
    }, function(data, textStatus) {
        if (textStatus == "success") {
            if (data != "0") {
                $("#top a.btn").remove();
                $("#top h1").after(data);
            }
        }
    });
}

//常用菜单操作
function ajax_opCommonMenu(op, pkid) {
    $.get("/admin/ajax/opCommonMenu.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        op: op,
        pkid: pkid
    }, function(data, textStatus) {
        if (textStatus == "success") {
            ajax_getCommonBtn();
            window.parent.ajax_getCommonMenuList();
        }
    });
}

//获取常用菜单列表
function ajax_getCommonMenuList() {
    $.get("/admin/ajax/getCommonMenuList.ashx", {
        rnd: Math.floor(Math.random() * 9999)
    }, function(data, textStatus) {
        if (textStatus == "success") {
            $("#main ul.menu").html(data);

            $("#main ul.menu li").click(function() { aClick($(this)); });
            $("#main ul.menu li a").click(function() { aClick($(this)); });

            $("#main ul.menu li a").mouseover(function() {
                $(this).parent().unbind("click", "");
            });

            $("#main ul.menu li a").mouseout(function() {
                $(this).parent().click(function() { aClick($(this)); });
            });
        }
    });
}

//获取排序列表
$.fn.QzGetSortList = function(options) {
    var defaults = {
        symbol: "",
        objectId: "",
        group: 0,
        pkid: 0
    };
    var o = $.extend(defaults, options);
    var $this = $(this);

    var event = $("#" + o.objectId);
    if (event == null) return;
    
    $this.change(function(e) {
        event.attr("disabled", true);
        $.ajax({
            url: "/admin/ajax/getSortList.ashx",
            type: "get",
            data: "symbol=" + o.symbol + "&fid=" + $this.val() + "&gid=" + o.group + "&pkid=" + o.pkid + "&rnd=" + Math.floor(Math.random() * 9999),
            dataType: "json",
            success: function(data) {
                
                var optionTitle = event.find("option:eq(0)");
                if (optionTitle != null && isNull(optionTitle.val())) optionTitle == null;
                event.empty();
                if (optionTitle != null) event.append(optionTitle);

                if (isNull(data)) return;

                event.append("<option value='0'>&nbsp;最顶部</option>");
                for (var n = 0; n < data.length; n++)
                    event.append("<option value='" + data[n].id + "'>【" + data[n].title + "】下面</option>");

                event.attr("disabled", false);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown);
            }
        });
    });

    if (!isNull($this.val())) $this.trigger("change");
}