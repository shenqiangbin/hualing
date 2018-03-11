<%@ Page Language="C#" AutoEventWireup="true" CodeFile="configBasic.aspx.cs" Inherits="admin_forum_configBasic" %>

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
      <h1>论坛基本设置</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">论坛标题</td>
          <td width="350"><input id="PageTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">显示在浏览器的标题栏中，也作为搜索引擎抓取的重要信息</td>
        </tr>
        <tr>
          <td>Meta Keywords</td>
          <td><input id="Keywords" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">用于优化的论坛首页关键词，多个关键词用半角逗号 " , " 分隔</td>
        </tr>
        <tr>
          <td>Meta Description</td>
          <td><textarea id="Descn" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">用于优化的论坛首页描述信息，建议控制在100字以内</td>
        </tr>
        <tr>
          <td>超级版主</td>
          <td><input id="SuperAdmin" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">填写要设为超级版主的会员用户名，超级版主拥有论坛管理的最大权限</td>
        </tr>
        <tr>
          <td>热帖最小值</td>
          <td>回复量至少达到 <input id="HotMin" type="text" class="text" style="width:60px;" maxlength="8" runat="server" enableviewstate="false" /> 帖<asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="HotMin" 
                  Display="None" EnableViewState="False" ErrorMessage="请输入热帖最小值" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                  ControlToValidate="HotMin" Display="None" EnableViewState="False" 
                  ErrorMessage="热帖最小值应使用数字输入" SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">设置成为热帖的条件，帖子达到该值时系统自动设为热帖</td>
        </tr>
      </table>
      <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
              EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
      <div class="ctrl"></div>
    </div>
    </form>
</body>
</html>