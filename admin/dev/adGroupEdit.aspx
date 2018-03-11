<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adGroupEdit.aspx.cs" Inherits="admin_dev_adGroupEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/admin/skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="/admin/skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="/plugin/uploadify/uploadify.css"rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/plugin/autoimg/jquery.autoImg.js" type="text/javascript"></script>
    <script src="/plugin/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="/admin/ajax/ajax.js" type="text/javascript"></script>
    <script src="/admin/js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        function sizeTrDisplay() {
            var display = $("input[type=radio]:checked").val();
            var inbuilt = checked($("input[type=checkbox]"));
            if (display == "0" && !inbuilt) $("#sizeTr").show();
            else $("#sizeTr").hide();
        }

        $(function() {
            sizeTrDisplay();
            $("input[type=radio]").click(function(e) { sizeTrDisplay(); });
            $("input[type=checkbox]").click(function(e) { sizeTrDisplay(); });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>广告组管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="adGroupManage.aspx" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">组名<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写组名" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>展示方式</td>
          <td>
            <asp:RadioButtonList ID="Display" runat="server" 
                RepeatDirection="Horizontal" RepeatLayout="Flow">
            </asp:RadioButtonList>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>系统内置</td>
          <td><asp:CheckBox ID="Inbuilt" runat="server" Text="设置为系统内置的广告，不允许增删" /></td>
          <td></td>
        </tr>
        <tr id="sizeTr" class="hide">
          <td>标准尺寸图</td>
          <td>
	        <input id="Pic" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= Pic.ClientID %>").QzImageUpload({
	                "code": "<%= filespec.Code %>",
	                "fileExt": "<%= filespec.FileExt %>",
	                "sizeLimit": "<%= filespec.Filesize %>",
	                "imgWidth": 300
	            });
            </script>
	      </td>
	      <td class="gray">
	        标准图片尺寸：<%= adGroup.Width %> ( 宽 ) × <%= adGroup.Height %> ( 高 ) px<br />
	        图片格式 <%= filespec.FileFormat.Replace("|", " | ") %>，图片大小 <%= filespec.Filesize %> KB 以内
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