// JavaScript Document

var editorId, editor, auth = false;

var mysrc = document.scripts[document.scripts.length - 1].src;
var expression = /\?auth=(\w+)/
if (expression.test(mysrc)) {
    var match = mysrc.match(expression);
    if (match[1] == "True") auth = true;
}

$(function() {
    $(".msb2_perBox .pic").autoIMG();
    $(".msb2R .msb2_c").autoIMG({ heightAuto: false, widthVar: -2 });
    $(".msb2_m").html($(".mbbsPage").html());

    if ($(".msb2_d a.top3").attr("val") == "3") $(".msb2_d a.top3").html("取消总置顶");
    if ($(".msb2_d a.top1").attr("val") == "1") $(".msb2_d a.top1").html("取消版置顶");
    if ($(".msb2_d a.best").attr("val") == "True") $(".msb2_d a.best").html("取消精华");
    if ($(".msb2_d a.reco").attr("val") == "True") $(".msb2_d a.reco").html("取消推荐");

    $(".msb2_d a.reply").click(function() {
        $("html,body").animate({ scrollTop: $(".anchor_reply").offset().top }, 1000);
    });

    editorId = $(".msb2_editor textarea").attr("id");
    editor = UE.getEditor(editorId, {
        imageFieldName: "bbs_image",
        initialFrameWidth: "796",
        initialFrameHeight: "180",
        toolbars: [['bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', 'insertimage', '|', 'link', 'unlink']]
    });

    if (auth) {
        $(".msb2_editor .msb2_abs").hide();
        $(".msb2R .msb2m_bom").show();
    }
    else {
        editor.ready(function() {
            editor.setDisabled("fullscreen");
        });
    }

    //加关注
    $(".addfriend").each(function() {

        var status = $(this).attr("status").toLowerCase();
        if (status == "true") $(this).html("取消关注");
        else if (status == "false") $(this).html("加关注");
        else return;

        $(this).click(function() {
            var $this = $(this);
            $this.attr("disabled", true);
            var uid = $this.attr("uid");

            $.get("/ajax/friendHandler.ashx", {
                rnd: Math.floor(Math.random() * 9999),
                uid: uid
            }, function(data, textStatus) {
                if (textStatus == "success") {
                    $this.attr("disabled", false);
                    if (isNull(data)) { layer.alert("没有获取到返回信息", 8); return; }

                    if (data == "true") { layer.alert("恭喜您，关注成功！", 10); }
                    else if (data == "false") { layer.alert("已取消关注", 10); }
                    else if (data == "101") layer.alert("抱歉，没有找到该用户", 8);

                    $(".addfriend[uid='" + uid + "']").each(function() {
                        if (data == "true") $(this).html("取消关注");
                        else if (data == "false") $(this).html("加关注");
                    });
                }
            });
        });
    });
});

//操作方法
//参数：cmd - 命令名称，id - 帖子ID，param - URL参数，可为空
function operatePost(cmd, id, param) {
    if (isNull(id)) { alert("请选择要操作的信息"); return; }

    if (cmd == "del_t" || cmd == "del_r") {
        var flag = confirm("删除后无法恢复，确认删除该帖子吗？");
        if (flag == "0") return;
    }

    window.location.href = "/bbs/thread.aspx?cmd=" + cmd + "&id=" + id + param;
}