<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adPopupManage.aspx.cs" Inherits="admin_adPopupManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="/plugin/uploadify/uploadify.css"rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/plugin/autoimg/jquery.autoImg.js" type="text/javascript"></script>
    <script src="/plugin/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>弹出广告管理</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">开关控制</td>
          <td><asp:CheckBox ID="Enabled" runat="server" Text="启用弹出广告" /></td>
          <td width="350"></td>
        </tr>
        <tr>
          <td>广告图</td>
          <td>
	        <input id="PopupFile" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= PopupFile.ClientID %>").QzImageUpload({
	                "code": "<%= filespec.Code %>",
	                "fileExt": "<%= filespec.FileExt %>",
	                "sizeLimit": "<%= filespec.Filesize %>",
	                "imgWidth": 350,
	                "imgHeight": 150
	            });
            </script>
	      </td>
	      <td class="gray">图片格式 <%= filespec.FileFormat.Replace("|", " | ")%>，图片大小 <%= filespec.Filesize%> KB 以内</td>
        </tr>
        <tr>
          <td>URL链接</td>
          <td><input id="PopupUrl" type="text" class="text" value="http://" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">URL链接应以 “ http:// ” 开头</td>
        </tr>
        <tr>
          <td>全屏遮罩</td>
          <td><asp:CheckBox ID="PopupShade" runat="server" Text="显示广告时自动全屏遮罩" /></td>
          <td class="gray">本效果将使访客在关闭广告前，无法进行其他页面操作</td>
        </tr>
        <tr>
          <td>自动关闭时间</td>
          <td>广告打开 <input id="PopupOffTime" type="text" class="text" maxlength="5" value="0" style="width:60px;" runat="server" enableviewstate="false" /> 秒后自动关闭<asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator1" runat="server" 
                  ControlToValidate="PopupOffTime" Display="None" EnableViewState="False" 
                  ErrorMessage="自动关闭时间应使用数字填写" SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">填写 “0” 表示不自动关闭</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>