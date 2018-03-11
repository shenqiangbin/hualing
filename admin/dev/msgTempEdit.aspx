<%@ Page Language="C#" AutoEventWireup="true" CodeFile="msgTempEdit.aspx.cs" Inherits="admin_dev_msgTempEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/admin/skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="/admin/skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.config.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.all.js" type="text/javascript"></script>
    <script src="/admin/ajax/ajax.js" type="text/javascript"></script>
    <script src="/admin/js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>消息模板管理 ( 开发者 ) - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="msgTempManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">消息模板名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
              ID="RequiredFieldValidator2" runat="server" ControlToValidate="MyTitle" 
              Display="None" EnableViewState="False" ErrorMessage="请填写消息模板名称" 
              SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>模板形式<span class="fill">*</span></td>
          <td>
            <asp:RadioButtonList ID="Mode" runat="server" 
                RepeatDirection="Horizontal" RepeatLayout="Flow">
            </asp:RadioButtonList><asp:RequiredFieldValidator 
              ID="RequiredFieldValidator1" runat="server" ControlToValidate="Mode" 
              Display="None" EnableViewState="False" ErrorMessage="请选择模板形式" 
              SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>模板说明</td>
          <td><textarea id="Notes" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">主要说明模板中可能用到的代码符号</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>