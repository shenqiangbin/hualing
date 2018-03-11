﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="optionsManage.aspx.cs" Inherits="admin_dev_optionsManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/admin/skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="/admin/skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/admin/ajax/ajax.js" type="text/javascript"></script>
    <script src="/admin/js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        function addType(obj) {
            count++;
            var demo = $(".demo tbody").html();
            demo = demo.replace(new RegExp("#", "g"), "#" + count.toString());
            obj.parent().parent().before(demo);
        }

        function formSubmit() {
            beforeSubmit();
            $("#main input[name=cmd]").val("updateall");
            form1.submit();
        }

        $(function() {
            $("#top .tags li").each(function(i, item) {
                if ($(item).attr("val") == '<%= groupId %>') $(item).addClass("current");
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="top">
      <h1>选项管理</h1>
      <ul class="tags">
        <asp:Repeater ID="Repeater2" runat="server" EnableTheming="false">
          <ItemTemplate>
            <li val="<%# Eval("Pkid") %>"><a href="?gid=<%# Eval("Pkid") %>"><%# Eval("Title") %></a></li>
          </ItemTemplate>
        </asp:Repeater>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="javascript:;" onclick="formSubmit();" class="btn">全部保存</a>
        <a href="javascript:;" onclick="operate('enab', null, '<%= param %>');" class="btn">启用/禁用</a>
        <a href="javascript:;" onclick="operate('del', null, '<%= param %>');" class="btn">删除</a>
      </div>
      <table class="list">
        <tr class="h">
          <td width="4%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
          <td>选项名称</td>
          <td width="10%">状态</td>
          <td width="15%">操作</td>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false" onitemdatabound="Repeater1_ItemDataBound">
          <ItemTemplate>
            <tr>
              <td align="center"><input type="checkbox" name="g1" value="<%#Eval("Pkid")%>" /></td>
              <td><input name="title<%#Eval("Pkid")%>" value="<%# Eval("Title") %>" maxlength="20" type="text" class="text" style="width:300px" /></td>
              <td id="Eval_Status" class="gray" runat="server" enableviewstate="false"></td>
              <td>
                <span id="Eval_MoveUp" runat="server" enableviewstate="false"></span>
                <span id="Eval_MoveDown" runat="server" enableviewstate="false"></span>
                <a href="javascript:;" onclick="operate('del',<%#Eval("Pkid")%>,'<%= param %>');" class="icon icon_del" title="删除"></a>
              </td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
        <tr>
          <td></td>
          <td colspan="3" style="padding-bottom:8px"><a href="javascript:;" onclick="addType($(this));" class="icon2 icon_add"> 新增导航组</a></td>
        </tr>
      </table>
      <div class="ctrl"></div>
      <input type="hidden" name="cmd" />
    </div>
    </form>
    
    <table class="demo">
      <tbody>
        <tr class="new">
          <td></td>
          <td><input name="title#" maxlength="20" type="text" class="text" style="width:300px" /></td>
          <td></td>
          <td>
            <a class="icon icon_empty"></a><a class="icon icon_empty"></a>
            <a href="javascript:;" onclick="$(this).parent().parent().remove();" class="icon icon_del" title="删除"></a>
          </td>
        </tr>
      </tbody>
    </table>
</body>
</html>