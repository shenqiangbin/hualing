<%@ Page Language="C#" AutoEventWireup="true" CodeFile="onePageEdit.aspx.cs" Inherits="admin_dev_onePageEdit" %>

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
    <script type="text/javascript">
        function contentTrDisplay() {
            if ($("input[name=Mode]:checked").val() == "0") {
                $("#contentTr").show();
                var obj = $("#rawurlTr").hide().find("input");
                if (isNull(obj.val())) obj.val("url");
            }
            else {
                $("#contentTr").hide();
                $("#rawurlTr").show().find("input");
            }
        }

        $(function() {
            contentTrDisplay();
            $("input[name=Mode]").click(function(e) { contentTrDisplay(); });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>页面与版面 - 系统页面管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="onePageManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">系统页面名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
              ID="RequiredFieldValidator2" runat="server" ControlToValidate="MyTitle" 
              Display="None" EnableViewState="False" ErrorMessage="请填写系统页面名称" 
              SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>页面形式</td>
          <td>
            <asp:RadioButtonList ID="Mode" runat="server" 
                RepeatDirection="Horizontal" RepeatLayout="Flow">
            </asp:RadioButtonList>
          </td>
          <td class="gray">其他形式的页面例如：频道页、注册页、登录页、专题页等</td>
        </tr>
        <tr id="rawurlTr" class="hide">
          <td>原始URL<span class="fill">*</span></td>
          <td><input id="RawUrl" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator6" runat="server" ControlToValidate="RawUrl" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写原始URL" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
          <td></td>
        </tr>
        <tr>
          <td>URL别名</td>
          <td><input id="UrlAlias" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /><asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator2" runat="server" 
                  ControlToValidate="UrlAlias" Display="None" EnableViewState="False" 
                  ErrorMessage="URL别名输入非法" SetFocusOnError="True" 
                  ValidationExpression="^[\w-]+(/[\w-]+)*(\.[\w]+)*$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">美化URL，亲和搜索引擎。网站服务器需支持URL重写，方可生效<br />格式：news、news/it、news.html、news/it.html</td>
        </tr>
        <tr id="contentTr" class="hide">
          <td valign="top">标准内容格式</td>
          <td colspan="2"><textarea id="InitContent" runat="server" enableviewstate="false"></textarea>
              <script type="text/javascript">
                  UE.getEditor("<%= InitContent.ClientID %>", {});
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