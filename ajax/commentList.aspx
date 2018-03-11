<%@ Page Language="C#" AutoEventWireup="true" CodeFile="commentList.aspx.cs" Inherits="ajax_commentList" %>

<table class="qzComment" align="center">
  <tr>
    <td class="t1">惠友评论</td>
    <td class="t2">已有<strong> <%= total %> </strong>人参与</td>
  </tr>
  <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false" onitemdatabound="Repeater1_ItemDataBound">
    <ItemTemplate>
      <tr>
        <td colspan="2" class="list">
          <div id="Eval_User" runat="server" enableviewstate="false" class="l"></div>
          <div class="r">
            <a style="cursor:pointer;" onclick="ajax_apComment('agree', '<%= Request.QueryString["eventId"] %>', '<%= Request.QueryString["sumbol"] %>', '<%= Request.QueryString["fkid"] %>', <%# Eval("Pkid") %>, '<%= Request.QueryString["page"] %>');">支持(<%# Eval("Agree")%>)</a> |
            <a style="cursor:pointer;" onclick="ajax_apComment('oppose', '<%= Request.QueryString["eventId"] %>', '<%= Request.QueryString["sumbol"] %>', '<%= Request.QueryString["fkid"] %>', <%# Eval("Pkid") %>, '<%= Request.QueryString["page"] %>');">反对(<%# Eval("Oppose")%>)</a>
          </div>
          <div class="clear"></div>
          <p id="Eval_Content" runat="server" enableviewstate="false"></p>
        </td>
      </tr>
    </ItemTemplate>
  </asp:Repeater>
  <tr>
    <td colspan="2" align="center">
      <div id="Paging" runat="server" enableviewstate="false" class="page"></div>
    </td>
  </tr>
  <tr>
    <td colspan="2" class="talk">
      <div class="t">我要评论</div>
      <div>给出您的评价：
        <input type="radio" name="com_point" value="1" /> 好评&nbsp;
        <input type="radio" name="com_point" value="2" checked="checked" /> 中评&nbsp;
        <input type="radio" name="com_point" value="3" /> 差评
      </div>
      <textarea id="com_content"></textarea>
      <input type="button" value="发表评论" class="submit" onclick="ajax_addComment('<%= Request.QueryString["eventId"] %>', '<%= Request.QueryString["sumbol"] %>', '<%= Request.QueryString["fkid"] %>', $('#com_content').val(), $('input[name=com_point]:checked').val())" />
    </td>
  </tr>
</table>