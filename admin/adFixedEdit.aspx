﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adFixedEdit.aspx.cs" Inherits="admin_adFixedEdit" %>

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
      <h1><%= group.Title %>管理 - <%= myhead%></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="adFixedManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">名称<span class="fill">*</span></td>
          <td><input id="MyTitle" type="text" style="width:300px" maxlength="50" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写名称" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td width="350"></td>
        </tr>
        <tbody id="PicPanel" runat="server">
        <tr>
          <td>广告图</td>
          <td>
	        <input id="Pic" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= Pic.ClientID %>").QzImageUpload({
	                "code": "<%= imageSpec.Code %>",
	                "fileExt": "<%= imageSpec.FileExt %>",
	                "sizeLimit": "<%= imageSpec.Filesize %>",
	                "imgWidth": 300
	            });
            </script>
	      </td>
	      <td class="gray">
	        图片尺寸：<%= adFixed.Width == 0 ? (group.Width == 0 ? "不限" : group.Width.ToString()) : adFixed.Width.ToString() %> ( 宽 ) ×
	        <%= adFixed.Height == 0 ? (group.Height == 0 ? "不限" : group.Height.ToString()) : adFixed.Height.ToString() %> ( 高 ) px<br />
	        图片格式 <%= imageSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= imageSpec.Filesize %> KB 以内
	      </td>
        </tr>
        <%--<tr>
          <td>缩略图</td>
          <td>
	        <input id="Thumb" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= Thumb.ClientID %>").QzImageUpload({
	                "code": "<%= thumSpec.Code %>",
	                "fileExt": "<%= thumSpec.FileExt %>",
	                "sizeLimit": "<%= thumSpec.Filesize %>"
	            });
            </script>
	      </td>
	      <td class="gray">图片格式 <%= thumSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= thumSpec.Filesize %> KB 以内</td>
        </tr>--%>
        </tbody>
        <tr>
          <td>URL链接</td>
          <td><input id="URL" type="text" class="text" value="http://" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">URL链接应以 “ http:// ” 开头</td>
        </tr>
        <tr>
          <td>文字说明</td>
          <td>
          <textarea id="Notes" runat="server" enableviewstate="false"></textarea>
          </td>
          <td></td>
        </tr>
        <tbody id="SortPanel" runat="server">
        <tr>
          <td>自定义排序</td>
          <td><input id="Sort" type="text" class="text" maxlength="8" value="1" style="width:100px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">最小序号为 “ 1 ”，序号越大则显示位置越靠前</td>
        </tr>
        </tbody>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>