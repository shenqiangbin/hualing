// JavaScript Document

//发表评论
function ajax_addComment(eventId, sumbol, fkid, content, point) {
    if (isNull(content)) { alert("请填写评价内容"); return; }
    $.get("/ajax/commentHandler.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        action: "add",
        sumbol: sumbol,
        fkid: fkid,
        content: escape(content),
        point: point
    }, function(data, textStatus) {
        if (textStatus == "success") {
            alert(data);
            ajax_getCommentList(eventId, sumbol, fkid, 1);
            $("html,body").animate({ scrollTop: $(".qzComment").offset().top }, 1000);
        }
    });
}

//支持/反对评论
function ajax_apComment(action, eventId, sumbol, fkid, pkid, page) {
    $.get("/ajax/commentHandler.ashx", {
        rnd: Math.floor(Math.random() * 9999),
        action: action,
        pkid: pkid
    }, function(data, textStatus) {
        if (textStatus == "success") {
            alert(data);
            ajax_getCommentList(eventId, sumbol, fkid, page);
        }
    });
}

//获取评论列表
function ajax_getCommentList(eventId, sumbol, fkid, page) {
    $.get("/ajax/commentList.aspx", {
        rnd: Math.floor(Math.random() * 9999),
        eventId: eventId,
        sumbol: sumbol,
        fkid: fkid,
        page: page
    }, function(data, textStatus) {
        if (textStatus == "success") {
            $("#" + eventId).html(data);
        }
    });
}


//发表留言
function ajax_addMessage(objId, groupName, fkid, realname, tel, email, content, code) {
    if (realname.length < 1) { alert("请填写您的姓名！"); return; }
    if (tel.length < 1) { alert("请填写您的电话！"); return; }
    if (email.length < 1) { alert("请填写您的邮箱！"); return; }
    if (content.length < 1) { alert("请填写留言内容！"); return; }
    if (code.length < 1) { alert("请填写图片中显示的验证码！"); return; }

    $.get("/ajax/message.ashx", {
        rnd: getRnd(),
        handle: "add",
        groupName: groupName,
        fkid: fkid,
        realname: escape(realname),
        tel: escape(tel),
        email: escape(email),
        content: escape(content),
        code: code
    }, function(data, textStatus) {
        if (textStatus == "success") {
            ajax_getMessageList(objId, groupName, fkid, 1);
            //$('html,body').animate({ scrollTop: $('#qz_message').offset().top }, 1000);
            alert(data);
        }
    });
}

//获取留言列表
function ajax_getMessageList(objId, groupName, fkid, page) {
    $.get("/ajax/message.aspx", {
        rnd: getRnd(),
        objId: objId,
        groupName: groupName,
        fkid: fkid,
        page: page
    }, function(data, textStatus) {
        if (textStatus == "success") {
            $("#" + objId).html(data);
        }
    });
}