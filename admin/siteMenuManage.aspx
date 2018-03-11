<%@ Page Language="C#" AutoEventWireup="true" CodeFile="siteMenuManage.aspx.cs" Inherits="admin_siteMenuManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
    <script src="js/siteMenu.js?gid=<%= groupId %>" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="top">
      <h1>导航菜单管理</h1>
      <ul class="tags">
        <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false">
          <ItemTemplate>
            <li val="<%# Eval("Pkid") %>"><a href="?gid=<%# Eval("Pkid") %>"><%# Eval("Title") %></a></li>
          </ItemTemplate>
        </asp:Repeater>
      </ul>
    </div>
    
    <div id="main">
      <div class="siteMenu">
          <div class="ctrl">
            <a href="javascript:;" onclick="ajax_siteMenuHandler('enab', null);" class="btn">显示/隐藏</a>
            <a href="javascript:;" onclick="ajax_siteMenuHandler('target', null);" class="btn">设置/取消新窗</a>
            <a href="javascript:;" onclick="ajax_siteMenuHandler('del', null);" class="btn">删除</a>
          </div>
          <table class="tree">
            <tr class="h">
              <td width="8%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
              <td>导航菜单</td>
              <td width="11%">显示</td>
              <td width="11%">新窗</td>
              <td width="24%" class="last">操作</td>
            </tr>
            <tbody class="info"></tbody>
          </table>
          <div class="ctrl"></div>
      </div>
      <div class="menuLib">
        <dl>
          <dt>新增菜单</dt>
          <dd class="cur">自定义</dd>
          <dd>页面</dd>
          <dd>分类</dd>
        </dl>
        <div class="panel">
            <ul class="add">
              <li>父级ID（可在左侧点击选择）</li>
              <li><input type="text" class="text" style="width:60px" maxlength="8" /><u></u></li>
              <li><input type="checkbox" /><label>在新窗口中打开</label></li>
            </ul>
            <div class="block">
              <ul class="add">
                <li>菜单名称</li>
                <li><input type="text" class="text" maxlength="50" /></li>
                <li>URL网址</li>
                <li><input type="text" class="text" /></li>
                <li><input type="button" value="添加菜单" class="btn" /></li>
              </ul>
            </div>
            
            <div class="block">
              <table class="list">
                <tr class="h">
                  <td>页面名称</td>
                  <td width="20%">操作</td>
                </tr>
                <tbody class="info"></tbody>
              </table>
            </div>
            
            <div class="block">
              <div class="tags">
                <ul>
                  <asp:Repeater ID="Repeater2" runat="server" EnableTheming="false">
                    <ItemTemplate>
                      <li group="<%# Eval("Pkid") %>"><%# Eval("Title") %></li>
                    </ItemTemplate>
                  </asp:Repeater>
                </ul>
              </div>
              <table class="tree">
                <tr class="h">
                  <td>类别目录</td>
                  <td width="30%">操作</td>
                </tr>
                <tbody class="info cat"></tbody>
              </table>
            </div>
            
            
        </div>
      </div>
    </div>
    </form>
</body>
</html>