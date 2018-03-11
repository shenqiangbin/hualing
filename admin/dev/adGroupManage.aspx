<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adGroupManage.aspx.cs" Inherits="admin_dev_adGroupManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/admin/skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="/admin/skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="/admin/skin/blue/qz.pagination.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/admin/ajax/ajax.js" type="text/javascript"></script>
    <script src="/admin/js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("#top .tags li").each(function(i, item) {
                if (window.location.pathname.indexOf($(item).find("a").attr("href")) > 0)
                    $(item).addClass("current");
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="top">
      <div class="help">
        <table>
          <tr>
            <td>
              组名 <input id="MyTitle" type="text" class="text" runat="server" enableviewstate="false" />
              <select id="Display" runat="server"></select>
              <select id="Inbuilt" runat="server"></select>
              <asp:ImageButton ID="SearchButton" ImageUrl="/admin/skin/blue/searchBtn.gif" runat="server" EnableViewState="false" onclick="SearchButton_Click" />
            </td>
          </tr>
        </table>
      </div>
      <h1>广告组管理</h1>
      <ul class="tags">
        <li><a href="adGroupManage.aspx">广告组</a></li>
        <li><a href="adFixedManage.aspx">内置广告</a></li>
      </ul>
      <ul class="tabs">
        <li>搜索</li>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="adGroupEdit.aspx" class="btn">新增</a>
        <a href="javascript:;" onclick="operate('del', null, '<%= param %>');" class="btn">删除</a>
        <a href="javascript:;" onclick="window.location.href='?'" class="btn">显示全部</a>
      </div>
      <table class="list">
        <tr class="h">
          <td width="4%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
          <td width="6%">ID</td>
          <td>组名</td>
          <td width="15%">展示方式</td>
          <td width="15%">系统内置</td>
          <td width="15%">创建日期</td>
          <td width="12%">操作</td>
        </tr>
        <tr id="NoDataRow" class="nodata" visible="false" runat="server" enableviewstate="false">
          <td>没有找到任何记录！</td>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false" onitemdatabound="Repeater1_ItemDataBound">
          <ItemTemplate>
            <tr>
              <td align="center"><input type="checkbox" name="g1" value="<%#Eval("Pkid")%>" /></td>
              <td><%#Eval("Pkid")%></td>
              <td><%#Eval("Title")%></td>
              <td id="Eval_Display" runat="server" enableviewstate="false"></td>
              <td id="Eval_Status" class="gray" runat="server" enableviewstate="false"></td>
              <td id="Eval_CreateTime" runat="server" enableviewstate="false"></td>
              <td>
                <a href="adGroupEdit.aspx?pkid=<%#Eval("Pkid")%><%= param %>" class="icon icon_edit" title="编辑"></a>
                <div class="operation">
                <a href="javascript:;" onclick="operate('del',<%#Eval("Pkid")%>,'<%= param %>');" class="icon icon_del" title="删除"></a>
                </div>
              </td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
      </table>
      <div class="ctrl"></div>
    </div>
    </form>
</body>
</html>