<%@ Page Language="C#" AutoEventWireup="true" CodeFile="msgTempEdit.aspx.cs" Inherits="admin_msgTempEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.config.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.all.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>消息模板管理 - 编辑</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="msgTempManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">消息类型</td>
          <td id="Mode" runat="server" enableviewstate="false"></td>
        </tr>
        <tr>
          <td>消息模板名称</td>
          <td><%= msgTemp.Title %></td>
        </tr>
        <tr>
          <td>说明</td>
          <td class="gray"><%= msgTemp.Notes%></td>
        </tr>
        <tr id="SubjectTr" runat="server">
          <td>消息模板标题<span class="fill">*</span></td>
          <td><input id="Subject" type="text" style="width:97%" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="Subject" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写消息模板标题" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
        </tr>
        <tr>
          <td valign="top">消息模板内容<span class="fill">*</span></td>
          <td>
            <textarea id="MyContent" runat="server" enableviewstate="false"></textarea>
            <asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator3" runat="server" ControlToValidate="MyContent" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写消息模板内容" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
            <label id="ScriptLabel" runat="server" enableviewstate="false">
            <script type="text/javascript">
                UE.getEditor("<%= MyContent.ClientID %>", { initialFrameHeight: 300,
                    toolbars: [
                    ['undo', 'redo', '|', 'bold', 'italic', 'underline', 'strikethrough', '|', 'forecolor', 'selectall',
                    'removeformat', 'cleardoc', '|', 'fontfamily', 'fontsize', '|', 'link', 'unlink']]
                });
            </script>
            </label>
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