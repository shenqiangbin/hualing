<%@ Page Language="C#" AutoEventWireup="true" CodeFile="starEdit.aspx.cs" Inherits="admin_starEdit" %>

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
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>论坛明星管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="starManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr id="InfoPanel" runat="server" enableviewstate="false" visible="false">
          <td width="100">会员用户名</td>
          <td id="Uname" runat="server" enableviewstate="false"></td>
          <td width="350"></td>
        </tr>
        <tr id="EditPanel" runat="server" enableviewstate="false">
          <td width="100">会员用户名<span class="fill">*</span></td>
          <td><input id="Username" type="text" style="width:300px" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="Username" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写会员用户名" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td width="350"></td>
        </tr>
        <tr>
          <td>自定义排序</td>
          <td><input id="Sort" type="text" class="text" maxlength="8" value="1" style="width:100px;" runat="server" enableviewstate="false" /><asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator1" runat="server" ControlToValidate="Sort" 
                  Display="None" EnableViewState="False" ErrorMessage="自定义排序应使用数字填写" 
                  SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">按照名次排序，1 表示第一名，将排在最前面，以此类推</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>