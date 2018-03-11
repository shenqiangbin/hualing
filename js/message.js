// JavaScript Document

var friendLayer;

$(function() {
    $(".friendlist ul li u a").autoIMG();
    setContacts();

    var uid = getQueryString("uid");
    if (regex(uid, /^\d+$/)) {
        $(".hoverTag .chgBtn").removeClass("chgCutBtn");
        $(".hoverTag .chgBtn:eq(1)").addClass("chgCutBtn");
        $(".chgConList .chgCon").hide();
        $(".chgConList .chgCon:eq(1)").show();
    }

    $(".friendlist ul li").each(function(i, item) {
        $(item).click(function() {
            if ($(this).attr("class") == "cur") $(this).removeClass("cur");
            else $(this).addClass("cur");
            setContacts();
        });
    });

    $(".selectfriend a").click(function() {
        layer.close(friendLayer);
    });

    $(".m4r_selFr .m4r_html").click(function() {
        friendLayer = $.layer({
            type: 1,
            area: ['400px', '300px'],
            title: false,
            page: { dom: '.friendpanel' }
        });
    });
});

function setContacts() {
    var vals = "";
    $(".m4r_html ul.l").html("");
    $(".friendlist ul li.cur").each(function(i, item) {
        $(".m4r_html ul.l").append("<li>" + $(item).find("u label").html() + "</li>");
        vals += "," + $(item).attr("uid");
    });
    $(".m4r_html ul.l").append("&nbsp;");
    if (!isNull(vals)) vals = vals.substring(1);
    $(".m4r_html input.hide").val(vals);
}

function beforeSubmit() {
    var friends = $(".m4r_html input.hide").val();
    var content = $("textarea.m4r_area").val();
    if (isNull(friends)) { alert("请选择收件人"); return false; }
    if (isNull(content)) { alert("请填写发送内容"); return false; }
    if (content.length > 300) { alert("私信内容请控制在300字以内"); return false; }
    return true;
}