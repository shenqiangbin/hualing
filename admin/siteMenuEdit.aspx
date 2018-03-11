<%@ Page Language="C#" AutoEventWireup="true" CodeFile="siteMenuEdit.aspx.cs" Inherits="admin_siteMenuEdit" %>
<%@ Import Namespace="QianZhu.Utility" %>

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
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>导航菜单管理 - 编辑</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="siteMenuManage.aspx" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">ID编号</td>
          <td id="Pkid"><%= siteMenu.Pkid.ToString() %></td>
          <td></td>
        </tr>
        <tr>
          <td>所属导航菜单</td>
          <td id="GroupName" runat="server" enableviewstate="false"></td>
          <td></td>
        </tr>
        <tr>
          <td>导航名称<span class="fill">*</span></td>
          <td><input id="MyTitle" type="text" style="width:300px;" maxlength="10" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写页面名称" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr id="urlTr">
          <td>URL网址</td>
          <td><input id="Url" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">URL网址一般以“http://”开头，若不填写则该菜单不可点击</td>
        </tr>
        <tr>
          <td>打开方式</td>
          <td><asp:CheckBox ID="Target" runat="server" Text="在新窗口中打开" /></td>
          <td></td>
        </tr>
        <tr>
          <td>父级ID<span class="fill">*</span></td>
          <td><input id="FatherId" type="text" class="text" maxlength="9" style="width: 80px;" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator5" runat="server" ControlToValidate="FatherId" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写父级ID" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                  ControlToValidate="FatherId" Display="None" EnableViewState="False" 
                  ErrorMessage="父级ID只能使用数字填写" SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">顶级菜单填写“0”</td>
        </tr>
        <tr>
          <td>显示位置</td>
          <td>
            <select id="sort" name="sort"><option value=""><--移动至--></option></select>
            <script type="text/javascript">
                $("#<%= FatherId.ClientID %>").QzGetSortList({
                    symbol: "sitemenu",
                    objectId: "sort",
                    group: getQueryString('gid'),
                    pkid: getQueryString('pkid')
                });
            </script>
          </td>
          <td class="gray">设置本类在同一父类的所有子类中的排序位置</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>