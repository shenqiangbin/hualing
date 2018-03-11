<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cardImport.aspx.cs" Inherits="admin_cardImport" %>

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
    <script src="/plugin/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>惠卡管理 - 批量导入</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="cardManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">导入</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="120">上传Excel数据表<span class="fill">*</span></td>
          <td width="300">
	        <input id="FilePath" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= FilePath.ClientID %>").QzFileUpload({
	                "code": "<%= filespec.Code %>",
	                "fileExt": "<%= filespec.FileExt %>",
	                "sizeLimit": "<%= filespec.Filesize %>"
	            });
            </script>
	          <asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator3" runat="server" ControlToValidate="FilePath" 
                  Display="None" EnableViewState="False" ErrorMessage="请选择Excel文件" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
	      </td>
	      <td class="gray">文件格式 <%= filespec.FileFormat.Replace("|", " | ")%>，文件大小 <%= filespec.Filesize%> KB 以内</td>
        </tr>
        <tr>
          <td>标准格式文件</td>
          <td><a href="/upload/excel/惠卡导入标准格式.xls" target="_blank">点击这里下载</a></td>
          <td></td>
        </tr>
        <tr>
          <td valign="top">操作说明</td>
          <td colspan="2">
            1. Excel表格式：<br />
　　            要求Excel表中的字段顺序与数量与所建的数据表中的应完全一致。<br />
　　            <span class="red">[ 惠卡 ] 数据表的字段及顺序应为：卡号，出售状态。</span><br />
　　            Excel表中的第一行为表头，放置字段名称，从第二行起为正式数据。在数据导入时，系统不会录入第一行的内容。<br />
            2. 字段格式：<br />
　　            卡号，必须保持唯一，如出现相同卡号，将被自动忽略并不录入系统。<br />
　　            出售状态，用 0 ( 未出售 )、1 ( 已出售 ) 表示。
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