<%@ Page Language="C#" AutoEventWireup="true" CodeFile="orderShow.aspx.cs" Inherits="admin_orderShow" %>

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
    <form id="form1" runat="server">
    <div id="top">
      <h1>订单管理 - 详细资料</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="orderManage.aspx<%= param %>" class="btn">返回</a>
      </div>
      
      <table class="doc mb20">
        <tr>
          <td class="h" colspan="6">订单号 [ <%= orders.TrackId %> ]</td>
        </tr>
        <tr>
          <td width="10%" class="cap">订单总价</td>
          <td width="25%" id="Price" runat="server" enableviewstate="false" class="price"></td>
          <td width="10%" class="cap">支付方式</td>
          <td width="30%" id="PayWay" runat="server" enableviewstate="false"></td>
          <td width="10%" class="cap">订单状态</td>
          <td id="Status" runat="server" enableviewstate="false"></td>
        </tr>
        <tr>
          <td class="cap">所属会员</td>
          <td id="MemberUname" runat="server" enableviewstate="false"></td>
          <td class="cap">备注信息</td>
          <td><%= orders.SysNotes %></td>
          <td class="cap">下单时间</td>
          <td><%= orders.CreateTime %></td>
        </tr>
        <tr>
          <td class="cap">收件人姓名</td>
          <td><%= orders.Realname %></td>
          <td class="cap">收件人手机</td>
          <td><%= orders.Tel %></td>
          <td class="cap">邮政编码</td>
          <td><%= orders.Zipcode %></td>
        </tr>
        <tr>
          <td class="cap">邮寄地址</td>
          <td colspan="5"><%= orders.Address %></td>
        </tr>
      </table>
      
      <h3>订单明细列表</h3>
      <table class="list">
        <tr class="h">
          <td width="8%">序号</td>
          <td width="20%">产品名称</td>
          <td width="15%">单价</td>
          <td width="12%">购买数量</td>
          <td>开通卡号</td>
        </tr>
        <tr id="NoDataRow" class="nodata" visible="false" runat="server" enableviewstate="false">
          <td>没有找到订单明细！</td>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false" onitemdatabound="Repeater1_ItemDataBound">
          <ItemTemplate>
            <tr>
              <td><%# Container.ItemIndex + 1 %></td>
              <td id="Eval_Title" runat="server" enableviewstate="false"></td>
              <td id="Eval_Price" runat="server" enableviewstate="false"></td>
              <td><%#Eval("Num")%></td>
              <td id="Eval_Notes" runat="server" enableviewstate="false"></td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
      </table>
      <div class="ctrl"></div>
    </div>
    </form>
</body>
</html>