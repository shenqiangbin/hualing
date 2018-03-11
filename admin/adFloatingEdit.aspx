<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adFloatingEdit.aspx.cs" Inherits="admin_adFloatingEdit" %>

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
    <script type="text/javascript">
        function locationChange(obj) {
            var val = obj.val();
            var parent = obj.parent();
            parent.find("span").hide();
            obj.css("margin-bottom", "8px");

            if (val == "1") parent.find("span:eq(0), span:eq(2)").show();
            else if (val == "2") parent.find("span:eq(0), span:eq(3)").show();
            else if (val == "3") parent.find("span:eq(1), span:eq(2)").show();
            else if (val == "4") parent.find("span:eq(1), span:eq(3)").show();
            else obj.css("margin-bottom", "0");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>悬浮广告管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="adFloatingManage.aspx<%= param %>" class="btn">返回</a>
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
        <tr>
          <td>悬浮位置<span class="fill">*</span></td>
          <td>
            <select id="Location" runat="server" onchange="locationChange($(this))"></select><br />
            <span class="hide">距页面顶端 <input id="MarginTop" type="text" class="text" maxlength="3" style="width:60px;" runat="server" enableviewstate="false" /> 像素,&nbsp;</span>
            <span class="hide">距页面底端 <input id="MarginBottom" type="text" class="text" maxlength="3" style="width:60px;" runat="server" enableviewstate="false" /> 像素,&nbsp;</span>
            <span class="hide">距页面左侧 <input id="MarginLeft" type="text" class="text" maxlength="3" style="width:60px;" runat="server" enableviewstate="false" /> 像素</span>
            <span class="hide">距页面右侧 <input id="MarginRight" type="text" class="text" maxlength="3" style="width:60px;" runat="server" enableviewstate="false" /> 像素</span>
            <script type="text/javascript">locationChange($("#<%= Location.ClientID %>"));</script>
            <asp:RequiredFieldValidator 
                ID="RequiredFieldValidator2" runat="server" ControlToValidate="Location" 
                Display="None" EnableViewState="False" ErrorMessage="请选择悬浮位置" 
                SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator 
                ID="RegularExpressionValidator1" runat="server" ControlToValidate="MarginTop" 
                Display="None" EnableViewState="False" ErrorMessage="顶端边距应使用数字填写" 
                SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator 
                ID="RegularExpressionValidator3" runat="server" ControlToValidate="MarginBottom" 
                Display="None" EnableViewState="False" ErrorMessage="底端边距应使用数字填写" 
                SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator 
                ID="RegularExpressionValidator2" runat="server" ControlToValidate="MarginLeft" 
                Display="None" EnableViewState="False" ErrorMessage="左侧边距应使用数字填写" 
                SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator 
                ID="RegularExpressionValidator4" runat="server" ControlToValidate="MarginRight" 
                Display="None" EnableViewState="False" ErrorMessage="右侧边距应使用数字填写" 
                SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">选择并设置广告在页面中悬浮的位置</td>
        </tr>
        <tr>
          <td>广告图<span class="fill">*</span></td>
          <td>
	        <input id="Pic" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= Pic.ClientID %>").QzImageUpload({
	                "code": "<%= filespec.Code %>",
	                "fileExt": "<%= filespec.FileExt %>",
	                "sizeLimit": "<%= filespec.Filesize %>",
	                "imgWidth": 150,
	                "imgHeight": 280
	            });
            </script>
            <asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator3" runat="server" ControlToValidate="Pic" 
                  Display="None" EnableViewState="False" ErrorMessage="请上传广告图片" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
	      </td>
	      <td class="gray">图片格式 <%= filespec.FileFormat.Replace("|", " | ") %>，图片大小 <%= filespec.Filesize %> KB 以内</td>
        </tr>
        <tr>
          <td>URL链接</td>
          <td><input id="URL" type="text" class="text" value="http://" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">URL链接应以 “ http:// ” 开头</td>
        </tr>
        <%--<tr>
          <td>文字说明</td>
          <td><input id="Notes" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>--%>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>