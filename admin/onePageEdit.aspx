<%@ Page Language="C#" AutoEventWireup="true" CodeFile="onePageEdit.aspx.cs" Inherits="admin_onePageEdit" %>

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
    <script type="text/javascript">
        var editor;
        function initContent() {
            editor.ready(function() {
                editor.setContent($('.demo').html());
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>页面管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="onePageManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">页面名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
              ID="RequiredFieldValidator2" runat="server" ControlToValidate="MyTitle" 
              Display="None" EnableViewState="False" ErrorMessage="请填写页面名称" 
              SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>Page Title</td>
          <td><input id="PageTitle" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">用于优化的页面标题，不填写默认为页面名称</td>
        </tr>
        <tr>
          <td>Meta Keywords</td>
          <td><input id="Keywords" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">用于优化的关键词，多个关键词用半角逗号 " , " 分隔</td>
        </tr>
        <tr>
          <td>Meta Description</td>
          <td><textarea id="Descn" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">用于优化的描述信息，建议控制在100字以内</td>
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
        <tr id="ContentTr" runat="server">
          <td valign="top">
            页面内容<span class="fill">*</span><br />
            <span class="hide init">[ <a href="javascript:;" onclick="initContent()">初始化格式</a> ]</span>
          </td>
          <td colspan="2">
            <textarea id="MyContent" runat="server" enableviewstate="false"></textarea>
            <div class="demo"><%= onePage.InitContent %></div>
            <script type="text/javascript">
                if (!isNull($('.demo').html())) $(".init").show();
                editor = UE.getEditor("<%= MyContent.ClientID %>", {});
            </script>
              <asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator3" runat="server" ControlToValidate="MyContent" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写页面内容" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
        </tr>
        <tr>
          <td>父页面ID</td>
          <td><input id="FatherId" type="text" class="text" maxlength="8" value="0" style="width: 80px;" runat="server" enableviewstate="false" />
              </td>
          <td class="gray">可以对多个页面进行分组，填 " 0 " 表示没有父页面</td>
        </tr>
        <tr>
          <td>自定义排序</td>
          <td><input id="Sort" type="text" class="text" maxlength="8" value="1" style="width:80px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">最小序号为 “ 1 ”，序号越大则显示位置越靠前</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>