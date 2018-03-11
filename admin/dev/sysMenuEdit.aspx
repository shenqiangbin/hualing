<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysMenuEdit.aspx.cs" Inherits="admin_dev_sysMenuEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/admin/skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="/admin/skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/admin/ajax/ajax.js" type="text/javascript"></script>
    <script src="/admin/js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <div class="help">
        <table>
          <tr>
            <td>
              1. 填写“新增页面URL”后，将会在系统顶端的主导航及右侧导航中出现“新增”快捷按钮。<br />
              2. 菜单最大级别为 2 级，选择更改“父级菜单”后，相应的子菜单级别也将随之改变，但 2 级以下子菜单将被隐藏。
            </td>
          </tr>
        </table>
      </div>
      <h1>系统菜单管理 - <%= myhead %></h1>
      <ul class="tabs">
        <li>帮助</li>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="sysMenuManage.aspx" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">ID编号</td>
          <td id="Pkid" runat="server" enableviewstate="false">系统自动分配ID</td>
          <td></td>
        </tr>
        <tr>
          <td width="100">菜单名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="10" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写菜单名称" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>本页URL</td>
          <td><input id="LinkUrl" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">填写管理列表页面的URL</td>
        </tr>
        <tr>
          <td>新增页面URL</td>
          <td><input id="AddPageUrl" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">填写新增功能页面的URL</td>
        </tr>
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
                    symbol: "sysmenu",
                    objectId: "sort",
                    pkid: getQueryString('pkid')
                });
            </script>
          </td>
          <td class="gray">设置本菜单在同一父类的所有子菜单中的排序位置</td>
        </tr>
        <tr>
          <td>展开菜单</td>
          <td><asp:CheckBox ID="IsOpen" runat="server" Text="设置菜单为展开状态（即显示其子菜单）" /></td>
          <td></td>
        </tr>
        <tr>
          <td>显示菜单</td>
          <td><asp:CheckBox ID="Enabled" runat="server" Text="设置菜单为显示状态" /></td>
          <td></td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>