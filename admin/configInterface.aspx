<%@ Page Language="C#" AutoEventWireup="true" CodeFile="configInterface.aspx.cs" Inherits="admin_configInterface" %>

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
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>第三方接口设置</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="120"><h2>支付宝接口设置</h2></td>
          <td width="350"></td>
          <td></td>
        </tr>
        <tr>
          <td>支付宝账号</td>
          <td><input id="AlipayUid" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">签约支付宝账号或卖家支付宝帐户</td>
        </tr>
        <tr>
          <td>合作身份者ID</td>
          <td><input id="AlipayPartner" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>安全检验码</td>
          <td><input id="AlipayKey" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>支付宝订单标题</td>
          <td><input id="AlipayOrderTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">支付宝页面显示的订单标题，如不填默认为网站标题</td>
        </tr>
        <tr>
          <td><h2>Excel 操作权限</h2></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td>Windows 账号</td>
          <td><input id="ExcelUsername" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">一般直接使用超级管理员账号，如使用其他账号需保证对 Excel 有操作权</td>
        </tr>
        <tr>
          <td>Windows 登录密码</td>
          <td><input id="ExcelPassword" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    </form>
</body>
</html>