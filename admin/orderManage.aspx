<%@ Page Language="C#" AutoEventWireup="true" CodeFile="orderManage.aspx.cs" Inherits="admin_orderManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/qz.pagination.css" rel="stylesheet" type="text/css" />
    <link href="/plugin/datainput/dateInput.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/plugin/datainput/jquery.dateInput.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="top">
      <div class="help">
        <table>
          <tr>
            <td>
              订单号 <input id="MyTitle" type="text" class="text" runat="server" enableviewstate="false" />
              用户名 <input id="Username" type="text" class="text" runat="server" enableviewstate="false" />
              下单日期 <input id="Date1" type="text" readonly="readonly" class="text dateinput" runat="server" enableviewstate="false" /> -
              <input id="Date2" type="text" readonly="readonly" class="text dateinput" runat="server" enableviewstate="false" />
              <script type="text/javascript">
                  $("#<%= Date1.ClientID %>").date_input();
                  $("#<%= Date2.ClientID %>").date_input();
              </script>
              <select id="Status" runat="server"></select>
              <asp:ImageButton ID="SearchButton" ImageUrl="skin/blue/searchBtn.gif" runat="server" EnableViewState="false" onclick="SearchButton_Click" />
            </td>
          </tr>
        </table>
      </div>
      <h1>订单管理</h1>
      <ul class="tabs">
        <li>搜索</li>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="javascript:;" onclick="operate('pay', null, '<%= param %>');" class="btn">已支付</a>
        <a href="javascript:;" onclick="operate('del', null, '<%= param %>');" class="btn" >删除</a>
        <a href="javascript:;" onclick="window.location.href='?'" class="btn">显示全部</a>
        <div id="Paging" class="r" runat="server" enableviewstate="false"></div>
        <div id="Total" class="r2" runat="server" enableviewstate="false"></div>
      </div>
      <table class="list">
        <tr class="h">
          <td width="4%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
          <td width="17%">订单号</td>
          <td>所属会员</td>
          <td width="10%">支付方式</td>
          <td width="11%">订单价格</td>
          <td width="8%">状态</td>
          <td width="12%">下单日期</td>
          <td width="10%">操作</td>
        </tr>
        <tr id="NoDataRow" class="nodata" visible="false" runat="server" enableviewstate="false">
          <td>没有找到任何记录！</td>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false" onitemdatabound="Repeater1_ItemDataBound">
          <ItemTemplate>
            <tr>
              <td align="center"><input type="checkbox" name="g1" value="<%#Eval("Pkid")%>" /></td>
              <td><%#Eval("TrackId")%></td>
              <td id="Eval_Member" runat="server" enableviewstate="false"></td>
              <td id="Eval_PayWay" runat="server" enableviewstate="false"></td>
              <td id="Eval_Price" runat="server" enableviewstate="false" class="price" align="right"></td>
              <td id="Eval_Status" class="gray" runat="server" enableviewstate="false"></td>
              <td id="Eval_CreateTime" runat="server" enableviewstate="false"></td>
              <td>
                <a href="orderShow.aspx?pkid=<%#Eval("Pkid")%><%= param %>" class="icon icon_show" title="查看详细"></a>
                <div class="operation">
                <a href="javascript:;" onclick="operate('del',<%#Eval("Pkid")%>,'<%= param %>');" class="icon icon_del" title="删除"></a>
                </div>
              </td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
      </table>
      <div class="ctrl"></div>
    </div>
    </form>
</body>
</html>