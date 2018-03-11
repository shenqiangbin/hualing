﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminManage.aspx.cs" Inherits="admin_adminManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/qz.pagination.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="top">
      <div class="help">
        <table>
          <tr>
            <td>
              用户名 <input id="Uname" type="text" class="text" runat="server" enableviewstate="false" />
              <select id="Enabled" runat="server"></select>
              <asp:ImageButton ID="SearchButton" ImageUrl="skin/blue/searchBtn.gif" runat="server" EnableViewState="false" onclick="SearchButton_Click" />
            </td>
          </tr>
        </table>
      </div>
      <h1>管理员设置</h1>
      <ul class="tabs">
        <li>搜索</li>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="adminEdit.aspx" class="btn">新增</a>
        <a href="javascript:;" onclick="operate('enab', null, '<%= param %>');" class="btn">启用/禁用</a>
        <a href="javascript:;" onclick="operate('del', null, '<%= param %>');" class="btn">删除</a>
        <a href="javascript:;" onclick="window.location.href='?'" class="btn">显示全部</a>
        <div id="Paging" class="r" runat="server" enableviewstate="false"></div>
      </div>
      <table class="list">
        <tr class="h">
          <td width="4%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
          <td width="6%">ID</td>
          <td width="15%">用户名</td>
          <td width="12%">姓名</td>
          <td>备注</td>
          <td width="8%">状态</td>
          <td width="12%">创建日期</td>
          <td width="10%">操作</td>
        </tr>
        <tr id="NoDataRow" class="nodata" visible="false" runat="server" enableviewstate="false">
          <td>没有找到任何记录！</td>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false" onitemdatabound="Repeater1_ItemDataBound">
          <ItemTemplate>
            <tr>
              <td align="center"><input type="checkbox" name="g1" value="<%#Eval("Pkid")%>" /></td>
              <td><%#Eval("Pkid")%></td>
              <td><%#Eval("Username")%></td>
              <td><%#Eval("Realname")%></td>
              <td class="gray"><%#Eval("Notes")%></td>
              <td id="Eval_Status" runat="server" enableviewstate="false"></td>
              <td id="Eval_CreateTime" runat="server" enableviewstate="false"></td>
              <td>
                <a href="adminEdit.aspx?pkid=<%#Eval("Pkid")%><%= param %>" class="icon icon_edit" title="编辑"></a>
                <div class="operation">
                <span id="Eval_Del" runat="server" enableviewstate="false"><a href="javascript:;" onclick="operate('del',<%#Eval("Pkid")%>,'<%= param %>');" class="icon icon_del" title="删除"></a></span>
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