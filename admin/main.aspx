<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="admin_main" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>站点管理平台 - 华领国际管理北京有限公司 </title>
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/main.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/js/jquery.powerFloat.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="top">
        <ul class="menu">
          <li><a url="home.aspx" val="home">首页</a></li>
          <%= CreateSysMenu(0, null).ToString()%>
        </ul>
        <div class="board">
            <div class="logo" id="Logo" runat="server" enableviewstate="false"></div>
            <div class="mid">
                <p><span id="Nickname" runat="server" enableviewstate="false"></span>，欢迎登录站点管理平台<u>|</u><a url="setting.aspx" val="setting" onclick="aClick($(this));">设置</a><u>|</u><a href="exit.ashx">安全退出</a></p>
                <ul class="tabs">
                    <li class="current"><span class="l"></span><a url="home.aspx" val="home">首页</a><span class="fix"></span></li>
                </ul>
            </div>
            <div class="right">
                <div class="nav">
                  <%--<a href="/register/" target="_blank">会员注册</a><u>|</u>
                  <a href="/login/" target="_blank">会员登录</a><u>|</u>--%>
                 
                </div>
                <div class="search">
                    <div class="l"><input id="keys" type="text" /></div>
                    <div class="m" rel="searchType"></div>
                    <div class="r"><input type="button" /></div>
                </div>
                <ul id="searchType">
                  <li>新闻资讯</li>
                </ul>
            </div>
        </div>
        <div class="line"></div>
    </div>
    <table id="main">
        <tr valign="top">
            <td class="left" width="189">
                <div>
                    <div class="shortcut">
                        <div class="l"><a href="http://<%= Request.Url.Host %>/" target="_blank"></a></div>
                        <div class="r"><input type="button" class="refreshBtn" /></div>
                    </div>
                </div>
                <ul class="menu"></ul>
            </td>
            <td><div id="frames"><iframe name="mainframe" id="mainframe" src="home.aspx" val="home" frameborder="0" scrolling="no">
            
            </iframe></div></td>
            <td class="right" width="40">
              <div>
                <a href="javascript:;" title="返回顶部" class="totop"></a>
                <a href="javascript:;" title="刷新页面" class="refresh"></a>
                <a href="http://www.1000zhu.com/" target="_blank" title="千助官网" class="qianzhu"></a>
              </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>