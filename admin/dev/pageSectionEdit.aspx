<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pageSectionEdit.aspx.cs" Inherits="admin_dev_pageSectionEdit" %>

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
      <h1>页面与版面 - 局部版面管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="pageSectionManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">局部版面名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
              ID="RequiredFieldValidator2" runat="server" ControlToValidate="MyTitle" 
              Display="None" EnableViewState="False" ErrorMessage="请填写局部版面名称" 
              SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td valign="top">标准内容格式</td>
          <td colspan="2"><textarea id="InitContent" runat="server" enableviewstate="false"></textarea>
              <script type="text/javascript">
                  editor = UE.getEditor("<%= InitContent.ClientID %>", { initialFrameHeight: 300,
                      toolbars: [
                      ['source', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', 'strikethrough', '|', 'forecolor', 'selectall',
                      'removeformat', 'cleardoc', '|', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright',
                      'justifyjustify', '|', 'link', 'unlink', '|', 'insertimage', 'insertvideo', '|', 'spechars']]
                  });
              </script>
          </td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>