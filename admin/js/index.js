// JavaScript Document

$(function() {
    if (isNull($.cookie("remember"))) {
        $(".login input:eq(0)").focus();
    }
    else {
        $(".login ul input:eq(0)").val($.cookie("remember"));
        $(".login input:eq(1)").focus();
        $(".login .l input:eq(0)").attr("checked", true);
    }

    $("#codeImg").click(function(e) {
        $(this).attr("src", $(this).attr("src") + "&rnd=" + Math.floor(Math.random() * 9999));
    });
});

function beforeSubmit() {
    var chk = $(".login .l input:eq(0)").attr("checked");
    if (chk == "checked") $.cookie("remember", $(".login ul input:eq(0)").val(), { expires: 10 });
    else $.cookie("remember", null);
}