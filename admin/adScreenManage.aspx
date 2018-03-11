<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adScreenManage.aspx.cs" Inherits="admin_adScreenManage" %>

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
      <h1>幕布广告管理</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">开关控制</td>
          <td><asp:CheckBox ID="Enabled" runat="server" Text="启用幕布广告" /></td>
          <td width="350"></td>
        </tr>
        <tr>
          <td>广告大图</td>
          <td>
	        <input id="ScreenFile" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= ScreenFile.ClientID %>").QzImageUpload({
	                "code": "<%= imageSpec.Code %>",
	                "fileExt": "<%= imageSpec.FileExt %>",
	                "sizeLimit": "<%= imageSpec.Filesize %>",
	                "imgWidth": 350,
	                "imgHeight": 150
	            });
            </script>
	      </td>
	      <td class="gray">图片格式 <%= imageSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= imageSpec.Filesize %> KB 以内</td>
        </tr>
        <tr>
          <td>缩略图<span class="fill">*</span></td>
          <td>
	        <input id="ScreenThumFile" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= ScreenThumFile.ClientID %>").QzImageUpload({
	                "code": "<%= thumSpec.Code %>",
	                "fileExt": "<%= thumSpec.FileExt %>",
	                "sizeLimit": "<%= thumSpec.Filesize %>",
	                "imgWidth": 350,
	                "imgHeight": 150
	            });
            </script>
	      </td>
	      <td class="gray">图片格式 <%= thumSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= thumSpec.Filesize %> KB 以内</td>
        </tr>
        <tr>
          <td>URL链接</td>
          <td><input id="ScreenUrl" type="text" class="text" value="http://" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">URL链接应以 “ http:// ” 开头</td>
        </tr>
        <tr>
          <td>自动收缩时间</td>
          <td>广告大图打开 <input id="ScreenOffTime" type="text" class="text" maxlength="5" value="0" style="width:60px;" runat="server" enableviewstate="false" /> 秒后自动收缩为缩略图<asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator1" runat="server" 
                  ControlToValidate="ScreenOffTime" Display="None" EnableViewState="False" 
                  ErrorMessage="自动收缩时间应使用数字填写" SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">填写 “0” 表示不自动收缩</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>