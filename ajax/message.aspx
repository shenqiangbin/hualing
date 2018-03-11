<%@ Page Language="C#" AutoEventWireup="true" CodeFile="message.aspx.cs" Inherits="ajax_message" %>

<a id="qz_message"></a>
<table class="qzMessage" align="center">
  <tr>
    <td>
     <%-- <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false" onitemdatabound="Repeater1_ItemDataBound">
        <ItemTemplate>
          <table class="list" align="center">
            <tr>
              <td class="ask">
                <div class="t1">留言咨询</div>
                <div class="t2">留言时间：<%# Eval("CreateTime") %></div>
                <div class="words" id="Eval_Content" runat="server" enableviewstate="false"></div>
              </td>
            </tr>
            <tr id="Eval_ReplyTr" runat="server" enableviewstate="false" visible="false">
              <td class="respond">
                <div class="t1">专家回复</div>
                <div class="t2"><%# Eval("ReplyTime")%></div>
                <div class="words" id="Eval_Reply" runat="server" enableviewstate="false"></div>
              </td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:Repeater>--%>
    </td>
  </tr>
  <tr>
    <td id="Paging" runat="server" enableviewstate="false" class="paging"></td>
  </tr>
  <tr>
    <td>
      <table class="talk">
        <tr>
          <td class="t1">我要留言</td>
        </tr>
        <tr>
          <td>
            姓名 <input type="text" id="msg_realname" style="width:100px;" maxlength="10" />&nbsp;
            电话 <input type="text" id="msg_tel" style="width:120px;" maxlength="20" />&nbsp;
            邮箱 <input type="text" id="msg_email" style="width:200px;" maxlength="50" /><br />
            <textarea id="msg_content"></textarea>
            <div style="float:left;">
              验证码 <input id="msg_code" type="text" style="width: 50px;" maxlength="4" />
			  
			  <a href="javascript:;" onclick="changeCode('msg_codeImg');" style="float:right;padding:0 10px 0 10px;">验证码看不清楚，点击换一张</a>&nbsp;<a href="javascript:;" onclick="changeCode('msg_codeImg');"><img src="ajax/checkCode.ashx?w=60&h=22&f=13" id="msg_codeImg" width="60" height="22" style="border:1px solid #ccc; vertical-align:middle;float:right;" alt="验证码图片，点我换新图" /></a>
            </div>
            <input type="button" value="提交留言" class="submit" onclick="ajax_addMessage('<%= Request.QueryString["objId"] %>', '<%= Request.QueryString["groupName"] %>', '<%= Request.QueryString["fkid"] %>', $('#msg_realname').val(), $('#msg_tel').val(), $('#msg_email').val(), $('#msg_content').val(), $('#msg_code').val());" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>