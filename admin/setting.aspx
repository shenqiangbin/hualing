<%@ Page Language="C#" AutoEventWireup="true" CodeFile="setting.aspx.cs" Inherits="admin_setting" %>

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
    <script type="text/javascript">
        $(function() {
            $("input:password").val("········");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>我的设置</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">登录用户名</td>
          <td><%= admin.Username%></td>
          <td width="350"></td>
        </tr>
        <tr>
          <td>我的姓名</td>
          <td><%= admin.Realname%></td>
          <td></td>
        </tr>
        <tr>
          <td>设置昵称</td>
          <td><input id="Nickname" type="text" style="width:300px" maxlength="20" class="text" runat="server" enableviewstate="false" /></td>
          <td>设置后系统会优先显示您的昵称</td>
        </tr>
        <tr>
          <td>登录密码</td>
          <td>
            <input id="Pwd" type="password" style="width:300px" maxlength="20" class="text" runat="server" enableviewstate="false" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
            ControlToValidate="Pwd" Display="None" ErrorMessage="密码至少输入6位字符" 
            SetFocusOnError="True" ValidationExpression="^[\w\W]{6,}$"></asp:RegularExpressionValidator>
          </td>
          <td>如不修改密码，则无须填写</td>
        </tr>
        <tr>
          <td>确认密码</td>
          <td>
            <input id="Pwd2" type="password" style="width:300px" maxlength="20" class="text" runat="server" enableviewstate="false" />
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
            ControlToCompare="Pwd" ControlToValidate="Pwd2" Display="None" 
            EnableViewState="False" ErrorMessage="两次输入的密码不一致，请重新输入"></asp:CompareValidator>
          </td>
          <td>修改密码时，再次输入新密码，以确认正确</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>