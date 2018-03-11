<%@ Page Language="C#" AutoEventWireup="true" CodeFile="categoryEdit.aspx.cs" Inherits="admin_categoryEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
        <script src="/plugin/ueditor/ueditor.config.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.all.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1><%= group.Title %>管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="categoryManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">类别名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="10" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写类别名称" 
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
          <td class="gray">本类相关关键词，用于网站优化，多个关键词用半角逗号 " , " 分隔</td>
        </tr>
        <tr>
          <td>Meta Description</td>
          <td><textarea id="Descn" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">本类的概要描述，用于网站优化，建议控制在100字以内</td>
        </tr>
        <%--<tr>
          <td>URL别名</td>
          <td><input id="UrlAlias" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /><asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator2" runat="server" 
                  ControlToValidate="UrlAlias" Display="None" EnableViewState="False" 
                  ErrorMessage="URL别名输入非法" SetFocusOnError="True" 
                  ValidationExpression="^[\w-]+(/[\w-]+)*(\.[\w]+)*$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">美化URL，亲和搜索引擎。网站服务器需支持URL重写，方可生效<br />格式：news、news/it、news.html、news/it.html</td>
        </tr>--%>
        <tr>
          <td>父级ID<span class="fill">*</span></td>
          <td><input id="FatherId" type="text" class="text" maxlength="9" style="width: 80px;" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator5" runat="server" ControlToValidate="FatherId" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写父类ID" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                  ControlToValidate="FatherId" Display="None" EnableViewState="False" 
                  ErrorMessage="父类ID只能使用数字填写" SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">没有父级填写 " 0 "</td>
        </tr>
        <tr>
          <td>显示位置</td>
          <td>
            <select id="sort" name="sort"><option value=""><--移动至--></option></select>
            <script type="text/javascript">
                $("#<%= FatherId.ClientID %>").QzGetSortList({
                    symbol: "category",
                    objectId: "sort",
                    group: getQueryString('gid'),
                    pkid: getQueryString('pkid')
                });
            </script>
          </td>
          <td class="gray">设置本类在同一父类的所有子类中的排序位置</td>
        </tr>
         <%if (group.Pkid == 10)
           {%>
        <tr>
          <td valign="top">适合对象<span class="fill">*</span></td>
          <td colspan="2"><textarea id="MyContent" runat="server" enableviewstate="false"></textarea>
              <script type="text/javascript">
                  UE.getEditor("<%= MyContent.ClientID %>", {});
              </script>
            </td>
        </tr>
        <%-- <tr>
          <td valign="top">课程内容<span class="fill">*</span></td>
          <td colspan="2"><textarea id="MyContent2" runat="server" enableviewstate="false"></textarea>
              <script type="text/javascript">
                  UE.getEditor("<%= MyContent2.ClientID %>", {});
              </script>
            </td>
        </tr>--%>
        <%} %>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>