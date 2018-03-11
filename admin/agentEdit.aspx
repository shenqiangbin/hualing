<%@ Page Language="C#" AutoEventWireup="true" CodeFile="agentEdit.aspx.cs" Inherits="admin_agentEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/js/qz.select.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>代理商管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="agentManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tbody id="InfoPanel" runat="server" enableviewstate="false" visible="false">
        <tr>
          <td width="100">会员用户名</td>
          <td><%= member.Username %></td>
          <td width="350"></td>
        </tr>
        <tr>
          <td>代理日期</td>
          <td><%= member.AgentCreateTime %></td>
          <td></td>
        </tr>
        </tbody>
        <tr id="UnamePanel" runat="server" enableviewstate="false">
          <td width="100">会员用户名<span class="fill">*</span></td>
          <td><input id="Username" type="text" style="width:300px" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="Username" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写会员用户名" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td width="350"></td>
        </tr>
        <tr>
          <td>代理地区<span class="fill">*</span></td>
          <td><input id="AreaId" type="text" runat="server" enableviewstate="false" />
              <script type="text/javascript">
                  $("#<%= AreaId.ClientID %>").QzSelect({
                      dataSource: "ajax/getAreaData.ashx",
                      chooseEnd: true
                  });
              </script>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="AreaId" 
                  Display="None" EnableViewState="False" ErrorMessage="请选择代理地区" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
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