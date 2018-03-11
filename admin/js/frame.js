// JavaScript Document

var pageName = getPageName();

$(function() {
    ajax_getCommonBtn();
    setHelpPanel();
    tableHover();
    $("#checkAll").click(function(e) { setAllCheckbox($(this), "g1"); });
    $("#main .ctrl").html($("#main .ctrl:eq(0)").html());
});

function beforeSubmit() {
    $('.ctrl .btn').attr('disabled', true);
}

function setHelpPanel() {
    $("#top ul.tabs li").click(function() {
        var obj = $("#top .help");
        var classname = $(this).attr("class");
        $("#top ul.tabs li").removeClass("current");
        var index = $("#top ul.tabs li").index($(this));

        if (classname == "current") {
            if (obj.css("display") == "none") {
                showHelpContent($(this));
                obj.slideDown("fast");
                $.cookie(pageName, index);
            }
            else {
                obj.slideUp("fast");
                $.cookie(pageName, null);
            }
        }
        else {
            showHelpContent($(this));
            obj.slideDown("fast");
            $.cookie(pageName, index);
        }
    });

    if ($.cookie(pageName)) $("#top ul.tabs li:eq(" + $.cookie(pageName) + ")").trigger("click");
}

function showHelpContent(curLi) {
    $("#top .help table tr").css("display", "none");
    var index = $("#top ul.tabs li").index(curLi);
    $("#top .help table tr:eq(" + index + ")").css("display", "block");
    curLi.addClass("current");
}

function setInnerTabs(editor) {
    editor.ready(function() {
        $("ul.innerTabs li a").click(function(e) {
            saveContent(editor);
            $("ul.innerTabs li a").removeClass("cur");
            $(this).addClass("cur");
            index = $("ul.innerTabs li a").index($(this));
            editor.setContent($(".contentTd textarea.hide:eq(" + index + ")").val());
        });

        $("ul.innerTabs li a:eq(0)").addClass("cur");
        editor.setContent($(".contentTd textarea.hide:eq(0)").val());
    });
}

function saveContent(editor) {
    var index = $("ul.innerTabs li a").index($("ul.innerTabs li a.cur"));
    $(".contentTd textarea.hide:eq(" + index + ")").val(editor.getContent());
}

function tableHover() {
    $("#main table tr.h").each(function(i, item) {
        $(item).find("td:last").addClass("last");
    });
    
    var nodataTr = $("#main table tr.nodata");
    nodataTr.find("td").attr("colspan", nodataTr.parent().find("tr.h td").length);
    
    $("#main table:not('.doc') tr:not('.h')").mouseover(function() {
        $(this).find("td").css("background", "#f0f1ff");
        $(this).find(".operation").show();
    });

    $("#main table:not('.doc') tr:not('.h')").mouseout(function() {
        $(this).find("td").css("background", "transparent");
        $(this).find(".operation").hide();
    });
}

function treeStyle(objTr) {
    var lv = objTr.attr("lv");
    if (isNull(lv)) return;

    var spaceHtml = "";
    var nodeClass = "leaf";
    var onoff = objTr.attr("onoff");
    var rank = objTr.attr("rank");

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

    for (i = 1; i <= parseInt(lv) - 1; i++) {
        spaceHtml += "<div class=\"line\"></div>";
    }

    if (isNull(onoff))
        objTr.find("td:eq(1)").children().first().before(spaceHtml + "<div class=\"" + nodeClass + "\"></div>");
    else {
        var id = objTr.find("td:eq(0) input").val();
        objTr.find("td:eq(1)").children().first().before(spaceHtml + "<div class=\"" + nodeClass + "\" onclick=\"operate('onoff'," + id + ",'&gid=" + getQueryString("gid") + "');\"></div>");
    }
}

var count = 0;

function addArea(obj, fatherId) {
    count++;
    var objTr = obj.parent().parent();
    var strHtml = "<tr lv='" + objTr.attr("lv") + "' class='new'>";
    strHtml += "<td><input name='newAreaFid" + count.toString() + "' type='hidden' value='" + fatherId + "' /></td>";
    strHtml += "<td colspan='2'><input name='newAreaName" + count.toString() + "' type='text' class='text' style='width:120px' /></td>";
    strHtml += "<td>";
    for (i = 0; i < 4; i++) strHtml += "<a class='icon icon_empty'></a>";
    strHtml += "<a href='javascript:;' onclick='$(this).parent().parent().remove();' class='icon icon_del' title='删除'></a></td>";
    strHtml += "</tr>";

    $(objTr).before(strHtml);
    treeStyle(objTr.prev());
}

function setRulePanel(accessRule) {
    $("#checkAll").click(function() {
        setAllCheckbox($(this), "g1");
        setAllCheckbox($(this), "g2");
    });

    $(".rules dl").each(function(i, item) {
        $(item).find("dt input").click(function() {
            $(item).find("dd input").attr("checked", checked($(this)));
            if (!checked($(this))) $("#checkAll").attr("checked", false);
        });
        $(item).find("dd input").click(function() {
            if (!checked($(this))) {
                $(item).find("dt input").attr("checked", false);
                $("#checkAll").attr("checked", false);
            }
        });

        if (accessRule.length > 0 || accessRule != "all") {
            var checkAll = true;
            $(item).find("dd input").each(function(i, chk) {
                var pos = accessRule.indexOf("," + $(chk).val() + ",");
                if (pos >= 0) $(chk).attr("checked", true);
                else checkAll = false;
            });
            if ($(item).find("dd").length > 0 && checkAll) {
                $(item).find("dt input").attr("checked", true);
            }
        }
    });

    if (accessRule == "all") {
        $("#checkAll").attr("checked", true);
        setAllCheckbox($("#checkAll"), "g1");
        setAllCheckbox($("#checkAll"), "g2");
    }
}