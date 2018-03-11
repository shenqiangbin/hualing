<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cardEdit.aspx.cs" Inherits="admin_cardEdit" %>

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
      <h1>惠卡管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="cardManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tbody id="Unactivated" runat="server">
        <tr>
          <td width="100">卡号<span class="fill">*</span></td>
          <td><input id="CardNo" type="text" style="width:300px" maxlength="50" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="CardNo" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写卡号" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td width="400" class="gray">卡号必须保持唯一</td>
        </tr>
        <tr>
          <td>出售状态</td>
          <td><asp:CheckBox ID="Sold" runat="server" Text="该卡已出售" /></td>
          <td class="gray">设置为已出售的卡将不会被自动分配给在线购买的用户</td>
        </tr>
        </tbody>
        <tbody id="Activated" runat="server" visible="false">
        <tr>
          <td width="100">卡号</td>
          <td><%= memberCard.CardNo %></td>
          <td width="400"></td>
        </tr>
        <tr>
          <td>激活状态</td>
          <td class="green">该卡已激活</td>
          <td></td>
        </tr>
        <tr>
          <td>激活时间</td>
          <td><%= memberCard.ActiveTime %></td>
          <td></td>
        </tr>
        <tr>
          <td>所属地区</td>
          <td><input id="AreaId" type="text" runat="server" enableviewstate="false" />
              <script type="text/javascript">
                  $("#<%= AreaId.ClientID %>").QzSelect({
                      dataSource: "ajax/getAreaData.ashx",
                      chooseEnd: true
                  });
              </script>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>真实姓名</td>
          <td><input id="Realname" type="text" class="text" style="width:300px;" maxlength="20" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>身份证号</td>
          <td><input id="IdentityCard" type="text" class="text" style="width:300px;" maxlength="18" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>车牌号码</td>
          <td><input id="PlateNumber" type="text" class="text" style="width:300px;" maxlength="30" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>车辆品牌</td>
          <td><input id="VehicleBrand" type="text" class="text" style="width:300px;" maxlength="50" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>荷载人数</td>
          <td><input id="LoadPeople" type="text" class="text" style="width:300px;" maxlength="50" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>手机号</td>
          <td><input id="Mobi" type="text" class="text" style="width:300px;" maxlength="11" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>电子邮箱</td>
          <td><input id="Email" type="text" class="text" style="width:300px;" maxlength="100" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>地址</td>
          <td><input id="Address" type="text" class="text" style="width:300px;" maxlength="100" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        </tbody>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>