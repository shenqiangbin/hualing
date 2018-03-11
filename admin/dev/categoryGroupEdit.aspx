<%@ Page Language="C#" AutoEventWireup="true" CodeFile="categoryGroupEdit.aspx.cs" Inherits="admin_dev_categoryGroupEdit" %>

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
      <h1>类别组管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="categoryGroupManage.aspx" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="120">组名<span class="fill">*</span></td>
          <td width="330"><input id="MyTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写组名" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>最大级别<span class="fill">*</span></td>
          <td><input id="MaxLevel" type="text" class="text" maxlength="9" style="width: 80px;" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator5" runat="server" ControlToValidate="MaxLevel" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写最大级别" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                  ControlToValidate="MaxLevel" Display="None" EnableViewState="False" 
                  ErrorMessage="最大级别只能使用数字填写" SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">使用数字填写此类允许的最大子类级别，填写“0”表示不限制</td>
        </tr>
        <tr>
          <td>子类通用原始URL<span class="fill">*</span></td>
          <td><input id="SubRawUrl" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator6" runat="server" ControlToValidate="SubRawUrl" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写子类通用原始URL" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
          <td class="gray">子类通用的原始的URL，变量使用 {id} 表示</td>
        </tr>
        <tr>
          <td>子类通用静态URL</td>
          <td><input id="SubUrlRoute" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">子类通用的的静态URL，对搜索引擎友好，使用变量时，要与原始URL匹配</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>