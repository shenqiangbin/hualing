<%@ Page Language="C#" AutoEventWireup="true" CodeFile="configFunction.aspx.cs" Inherits="admin_configFunction" %>

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
    <script src="/plugin/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>站点功能设置</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
      
        <tr>
        <td><u>首页视频文件</u><br />(文件支持flv格式)</td>
        <td>
        <input id="flash" type="text" runat="server" enableviewstate="false" class="hide" />
        <script type="text/javascript">
            $("#<%= flash.ClientID %>").QzVideoUpload({
                "code": "<%= filespec2.Code %>",
                "fileExt": "<%= filespec2.FileExt %>",
                "sizeLimit": "<%= filespec2.Filesize %>"
            });
        </script></td>
        <td> &nbsp;</td>
        </tr>
        
        <tr>
          <td width="100">页头 Script 设置</td>
          <td width="350"><textarea id="HeadScript" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">
            设置位于 &lt;head&gt; &lt;/head&gt; 之间的一段 script 代码<br />
            例如，百度商桥的接入代码可放置在此处
          </td>
        </tr>
        <tr>
          <td width="100">页脚 Script 设置</td>
          <td width="350"><textarea id="FootScript" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">
            设置位于页脚声明处的一段 script 代码<br />
            例如，站点统计、企业QQ等接入代码可放置在此处
          </td>
        </tr>
        <%--<tr>
          <td>SMTP服务器</td>
          <td><input id="SmtpServer" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">如网站有邮件发送功能，则必须设置SMTP发送服务器、用户名、密码</td>
        </tr>
        <tr>
          <td>发送邮箱用户名</td>
          <td><input id="EmailUid" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>发送邮箱密码</td>
          <td><input id="EmailPwd" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>接收留言邮箱</td>
          <td><input id="toemail" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>--%>
        <tr>
          <td>信息复制控制</td>
          <td><asp:CheckBox ID="CopyEnabled" Text="允许复制网站信息" runat="server" EnableViewState="False" /></td>
          <td class="gray">不选择，访客在浏览网站时，将无法使用“复制/粘贴”操作</td>
        </tr>
        <tr>
          <td>网页保存控制</td>
          <td><asp:CheckBox ID="SaveEnabled" Text="允许保存网页" runat="server" EnableViewState="False" /></td>
          <td class="gray">不选择，访客在浏览网站时，将无法使用“网页另存为”操作</td>
        </tr>
        <tr>
          <td>屏蔽非法IP</td>
          <td><textarea id="BanIp" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">设置要屏蔽的IP地址，多个IP请换行填写，每行一个</td>
        </tr>
        <tr>
          <td>屏蔽非法词组</td>
          <td><textarea id="BanWords" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">设置不允许访客信息中出现的非法词组，多个词组请换行填写，每行一个</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    </form>
</body>
</html>