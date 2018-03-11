<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="admin_index" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>网站管理后台-华领</title>
    <link href="skin/blue/index.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="js/index.js" type="text/javascript"></script>
</head>
<body>
  <form id="form1" runat="server" onsubmit="beforeSubmit()">
    <div class="main">
      <asp:Panel ID="Panel1" runat="server" DefaultButton="SubmitButton">
      <div class="login">
        <ul>
          <li><input id="Username" type="text" maxlength="20" tabindex="1" runat="server" enableviewstate="false" /></li>
          <li><input id="Pwd" type="password" maxlength="20" tabindex="2" runat="server" enableviewstate="false" /></li>
          <li>
            <input id="Code" type="text" maxlength="4" tabindex="3" style="width:60px;" runat="server" enableviewstate="false" />
            <img src="ajax/checkCode.ashx?w=60&h=18&f=13" id="codeImg" width="60" height="18" title="点我换一组" />
          </li>
        </ul>
        <div class="l">
          <asp:CheckBox ID="RemembPwd" Text="记住帐号" runat="server" EnableViewState="false" /><br />
          <asp:CheckBox ID="AutoLogin" Text="自动登录" runat="server" EnableViewState="false" />
        </div>
        <asp:LinkButton ID="SubmitButton" TabIndex="4" CssClass="submit" onclick="SubmitButton_Click" runat="server" EnableViewState="false"></asp:LinkButton>
        <div class="info">技术支持&nbsp;&nbsp;千助科技&nbsp;&nbsp;1000zhu.com</div>
      </div>
      </asp:Panel>
    </div>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
        Display="None" ErrorMessage="请输入您的帐号" ControlToValidate="Username" 
        EnableViewState="False" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
        Display="None" ErrorMessage="请输入您的密码" ControlToValidate="Pwd" 
        EnableViewState="False" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
        Display="None" ErrorMessage="请输入图片中的验证码" ControlToValidate="Code" 
        EnableViewState="False" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
  </form>
</body>
</html>