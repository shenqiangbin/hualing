<%@ Page Language="C#" AutoEventWireup="true" CodeFile="courseEdit.aspx.cs" Inherits="admin_articleEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="/plugin/uploadify/uploadify.css"rel="stylesheet" type="text/css" />
    <link href="/plugin/datainput/dateInput.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/js/qz.select.js" type="text/javascript"></script>
    <script src="/plugin/datainput/jquery.dateInput.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.config.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.all.js" type="text/javascript"></script>
    <script src="/plugin/autoimg/jquery.autoImg.js" type="text/javascript"></script>
    <script src="/plugin/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>课程管理 - <%=myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="courseManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">方式<span class="fill">*</span></td>
          <td><input id="MyTitle" type="text" style="width:400px" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写方式" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td width="350"></td>
        </tr>
        
        <tr>
          <td>期号</td>
          <td><input id="issue" type="text" style="width:150px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        
        <tr>
          <td>开课时间</td>
          <td>
            <input id="Pubdate" type="text" readonly="readonly" class="text date" runat="server" enableviewstate="false" />
            <script type="text/javascript">
                $("#<%= Pubdate.ClientID %>").date_input();
            </script>
          </td>
          <td class="gray">不填写则默认为当前日期</td>
        </tr>
        
         <tr>
          <td>城市</td>
          <td><input id="city" type="text" style="width:150px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
       
          <tr>
          <td>开班情况</td>
          <td><input id="pv" type="text" okeyup ="if(isNaN(value))execCommand('undo')"   value="2"  style="width:150px;" maxlength="50" class="text" runat="server" enableviewstate="false" />0-已满 1-紧张  2-咨询</td>
          <td></td>
        </tr>
       <tr>
          <td>咨询QQ或ec  链接</td>
          <td><input id="qq" type="text" style="width:320px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>设置置顶</td>
          <td><asp:CheckBox ID="IsTop" runat="server" Text="将本条信息设为置顶" /></td>
          <td></td>
        </tr>
        <tr>
          <td>自定义排序</td>
          <td><input id="Sort" type="text" class="text" maxlength="8" value="1" style="width:100px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">最小序号为 “ 1 ”，序号越大则显示位置越靠前</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>