<%@ Page Language="C#" AutoEventWireup="true" CodeFile="categoryGroupManage.aspx.cs" Inherits="admin_dev_categoryGroupManage" %>

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
</head>
<body>
    <form id="form1" runat="server">
    <div id="top">
      <div class="help">
        <table>
          <tr>
            <td>
              组名 <input id="MyTitle" type="text" class="text" runat="server" enableviewstate="false" />
              <select id="Enabled" runat="server"></select>
              <asp:ImageButton ID="SearchButton" ImageUrl="/admin/skin/blue/searchBtn.gif" runat="server" EnableViewState="false" onclick="SearchButton_Click" />
            </td>
          </tr>
        </table>
      </div>
      <h1>类别组管理</h1>
      <ul class="tabs">
        <li>搜索</li>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="categoryGroupEdit.aspx" class="btn">新增</a>
        <a href="javascript:;" onclick="operate('enab', null, '<%= param %>');" class="btn">上线/下线</a>
        <a href="javascript:;" onclick="operate('del', null, '<%= param %>');" class="btn">删除</a>
        <a href="javascript:;" onclick="window.location.href='?'" class="btn">显示全部</a>
      </div>
      <table class="list">
        <tr class="h">
          <td width="4%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
          <td width="5%">ID</td>
          <td>组名</td>
          <td width="20%">子类通用原始URL</td>
          <td width="16%">子类通用静态URL</td>
          <td width="10%">最大级别</td>
          <td width="8%">状态</td>
          <td width="12%">创建日期</td>
          <td width="14%">操作</td>
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
              <td><%#Eval("SubRawUrl")%></td>
              <td><%#Eval("SubUrlRoute")%></td>
              <td><%#Eval("MaxLevel")%> 级</td>
              <td id="Eval_Status" class="gray" runat="server" enableviewstate="false"></td>
              <td id="Eval_CreateTime" runat="server" enableviewstate="false"></td>
              <td>
                <span id="Eval_MoveUp" runat="server" enableviewstate="false"></span>
                <span id="Eval_MoveDown" runat="server" enableviewstate="false"></span>
                <a href="categoryGroupEdit.aspx?pkid=<%#Eval("Pkid")%><%= param %>" class="icon icon_edit" title="编辑"></a>
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