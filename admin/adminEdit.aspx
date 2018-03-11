<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminEdit.aspx.cs" Inherits="admin_adminEdit" %>

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
    <script type="text/javascript">
        $(function() {
            if (!isNull(getQueryString("pkid"))) { $("input:password").val("········"); }
            setRulePanel('<%= admin.AccessRule %>');
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>管理员设置 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="adminManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">姓名<span class="fill">*</span></td>
          <td><input id="Realname" type="text" style="width:300px" maxlength="20" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator5" runat="server" ControlToValidate="Realname" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写姓名" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
                  </td>
          <td></td>
        </tr>
        <tr>
          <td>登录用户名<span class="fill">*</span></td>
          <td><input id="Username" type="text" style="width:300px;" maxlength="20" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator2" runat="server" ControlToValidate="Username" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写登录用户名" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
            ControlToValidate="Username" Display="None" ErrorMessage="用户名应使用5-20位的字母、数字、下划线" 
            SetFocusOnError="True" ValidationExpression="^\w{5,20}$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">使用5-20位的字母、数字、下划线组合填写，且应保持唯一</td>
        </tr>
        <tr>
          <td>登录密码<span class="fill">*</span></td>
          <td><input id="Pwd" type="password" style="width:300px;" maxlength="20" class="text" onfocus="this.createTextRange().select()" onpaste="return false" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator3" runat="server" ControlToValidate="Pwd" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写登录密码" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
            ControlToValidate="Pwd" Display="None" ErrorMessage="密码至少输入6位字符" 
            SetFocusOnError="True" ValidationExpression="^[\w\W]{6,}$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">登录密码至少设置6位以上（含6位）的字符</td>
        </tr>
        <tr>
          <td>确认密码<span class="fill">*</span></td>
          <td><input id="Pwd2" type="password" style="width:300px;" maxlength="20" class="text" onfocus="this.createTextRange().select()" onpaste="return false" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator4" runat="server" ControlToValidate="Pwd" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写确认密码" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:CompareValidator ID="CompareValidator1" runat="server" 
            ControlToCompare="Pwd" ControlToValidate="Pwd2" Display="None" 
            EnableViewState="False" ErrorMessage="两次输入的密码不一致，请重新输入"></asp:CompareValidator>
          </td>
          <td class="gray">再次填写登录密码以确认无误</td>
        </tr>
        <tr id="RuleTr1" runat="server">
          <td valign="top">
            设置权限<br />
            <input type="checkbox" id="checkAll" name="checkAll" value="all" /> 完全控制
          </td>
          <td colspan="2">
            <div class="rules">
              <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false" onitemdatabound="Repeater1_ItemDataBound">
                <ItemTemplate>
                  <dl>
                    <dt><strong><%# Eval("Title") %></strong>&nbsp;&nbsp;|&nbsp;&nbsp;<input type="checkbox" name="g1" /><label>全选</label></dt>
                    <asp:Repeater ID="Repeater1_2" runat="server" EnableTheming="false">
                      <ItemTemplate>
                        <dd><input type="checkbox" name="g2" value="<%# DataBinder.Eval(((RepeaterItem)Container.Parent.Parent).DataItem, "Title")%>_<%# Eval("Title") %>" /><label><%# Eval("Title") %></label></dd>
                      </ItemTemplate>
                    </asp:Repeater>
                  </dl>
                </ItemTemplate>
              </asp:Repeater>
            </div>
          </td>
        </tr>
        <tr id="RuleTr2" runat="server" visible="false">
          <td>设置权限</td>
          <td>完全控制</td>
          <td class="gray">系统默认超级管理员拥有完全控制权限</td>
        </tr>
        <tr>
          <td>简要说明</td>
          <td><textarea id="Notes" runat="server" enableviewstate="false"></textarea></td>
          <td></td>
        </tr>
        <tr>
          <td>设置启用</td>
          <td><asp:CheckBox ID="Enabled" runat="server" Checked="true" Text="设置管理员状态为启用" /></td>
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