<%@ Page Language="C#" AutoEventWireup="true" CodeFile="menuEdit.aspx.cs" Inherits="admin_menuEdit" %>

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
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>论坛版块管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="menuManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">版块名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="10" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写版块名称" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>版块描述</td>
          <td><textarea id="Descn" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">本版块的概要描述，建议控制在100字以内</td>
        </tr>
        <tr>
          <td>设置版主</td>
          <td><textarea id="Moderators" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">填写要设为版主的会员用户名，每行一个，不存在的会员系统将自动忽略<br />版主拥有对本版块的帖子的管理权限</td>
        </tr>
        <tr>
          <td>版块形象图</td>
          <td>
	        <input id="Pic" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
                $("#<%= Pic.ClientID %>").QzImageUpload({
                    "code": "<%= filespec.Code %>",
                    "fileExt": "<%= filespec.FileExt %>",
                    "sizeLimit": "<%= filespec.Filesize %>"
                });
            </script>
	      </td>
	      <td class="gray">建议图片尺寸：100 ( 宽 ) × 100 ( 高 ) px<br />图片格式 <%= filespec.FileFormat.Replace("|", " | ")%>，图片大小 <%= filespec.Filesize%> KB 以内</td>
        </tr>
        <tr>
          <td>Page Title</td>
          <td><input id="PageTitle" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">用于优化的页面标题，不填写默认为页面名称</td>
        </tr>
        <tr>
          <td>Meta Keywords</td>
          <td><input id="Keywords" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">本版块相关关键词，用于网站优化，多个关键词用半角逗号 &quot; , &quot; 分隔</td>
        </tr>
        <tr>
          <td>URL别名</td>
          <td><input id="UrlAlias" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /><asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator2" runat="server" 
                  ControlToValidate="UrlAlias" Display="None" EnableViewState="False" 
                  ErrorMessage="URL别名输入非法" SetFocusOnError="True" 
                  ValidationExpression="^[\w-]+(/[\w-]+)*(\.[\w]+)*$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">美化URL，亲和搜索引擎。网站服务器需支持URL重写，方可生效<br />
              格式：news、news/it、news.html、news/it.html</td>
        </tr>
        <tr>
          <td>父版块ID<span class="fill">*</span></td>
          <td><input id="FatherId" type="text" class="text" maxlength="9" style="width: 80px;" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator5" runat="server" ControlToValidate="FatherId" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写父版块ID" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                  ControlToValidate="FatherId" Display="None" EnableViewState="False" 
                  ErrorMessage="父版块ID只能使用数字填写" SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">没有父版块填写 &quot; 0 &quot;</td>
        </tr>
        <tr>
          <td>显示位置</td>
          <td>
            <select id="sort" name="sort"><option value="">&lt;--移动至--&gt;</option></select>
            <script type="text/javascript">
                $("#<%= FatherId.ClientID %>").QzGetSortList({
                    symbol: "forummenu",
                    objectId: "sort",
                    pkid: getQueryString('pkid')
                });
            </script>
          </td>
          <td class="gray">设置本版块在同一父版块的所有子版块中的排序位置</td>
        </tr>
        <tr>
          <td>设置推荐</td>
          <td><asp:CheckBox ID="IsReco" runat="server" Text="将本版块设为推荐" /></td>
          <td class="gray">论坛版块推荐仅对二级版块有效<br />设置为推荐的论坛版块，将显示在网站首页和内页的相关区域中</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>