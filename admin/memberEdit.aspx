<%@ Page Language="C#" AutoEventWireup="true" CodeFile="memberEdit.aspx.cs" Inherits="admin_memberEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="/plugin/uploadify/uploadify.css"rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/js/qz.select.js" type="text/javascript"></script>
    <script src="/plugin/autoimg/jquery.autoImg.js" type="text/javascript"></script>
    <script src="/plugin/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            if (!isNull(getQueryString("pkid"))) { $("input:password").val("········"); }
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>报名管理 - 编辑</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="memberManage.aspx<%= param %>" class="btn">返回</a>
       
      </div>
      <table class="frm">
      <tr>
          <td width="100">意向课程</td>
          <td><%= member.Username %></td>
          <td width="350"></td>
        </tr>
       
       <%-- <tr>
          <td>登录密码</td>
          <td>
            <input id="Pwd" type="password" style="width:300px" maxlength="20" class="text" runat="server" enableviewstate="false" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
            ControlToValidate="Pwd" Display="None" ErrorMessage="密码至少输入6位字符" 
            SetFocusOnError="True" ValidationExpression="^[\w\W]{6,}$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">如不修改密码，则无须填写</td>
        </tr>
        <tr>
          <td>确认密码</td>
          <td>
            <input id="Pwd2" type="password" style="width:300px" maxlength="20" class="text" runat="server" enableviewstate="false" />
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
            ControlToCompare="Pwd" ControlToValidate="Pwd2" Display="None" 
            EnableViewState="False" ErrorMessage="两次输入的密码不一致，请重新输入"></asp:CompareValidator>
          </td>
          <td class="gray">修改密码时，再次输入新密码，以确认正确</td>
        </tr>--%>
        <%--<tr>
          <td>会员头像</td>
          <td>
	        <input id="Pic" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= Pic.ClientID %>").QzImageUpload({
	                "code": "<%= filespec.Code %>",
	                "fileExt": "<%= filespec.FileExt %>",
	                "sizeLimit": "<%= filespec.Filesize %>"
	            });
            </script>
	      </td>
	      <td class="gray">图片格式 <%= filespec.FileFormat.Replace("|", " | ")%>，图片大小 <%= filespec.Filesize%> KB 以内</td>
        </tr>--%>
        <tr>
          <td>姓名<span class="fill"></span></td>
          <td><%=member.Realname%></td>
          <td></td>
        </tr>
        <%--<tr>
          <td>昵称</td>
          <td><input id="Nickname" type="text" style="width:300px" maxlength="10" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>--%>
        <tr>
          <td>性别</td>
          <td>
               <%=member.Sex%> 
          </td>
          <td></td>
        </tr>
        <tr>
          <td>年龄</td>
          <td>
         <%=member.Pic%>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>单位</td>
          <td>
        <%=member.Nickname%>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>职务</td>
          <td>
        <%=member.Tel%>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>手机号</td>
          <td><%=member.Mobi%>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>邮箱</td>
          <td><%=member.Email%>
          </td>
          <td></td>
        </tr>
       <%-- <tr>
          <td>出生日期</td>
          <td>
            <input id="Birthday" type="text" readonly="readonly" class="text date" runat="server" enableviewstate="false" />
            <script type="text/javascript">
                $("#<%= Birthday.ClientID %>").date_input();
            </script>
          </td>
          <td></td>
        </tr>--%>
        <tr>
          <td>所在地<span class="fill">*</span></td>
          <td>
          <input id="AreaId" type="text" runat="server" enableviewstate="false" />
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
          <td>备注</td>
          <td><%=member.Address%></td>
          <td></td>
        </tr>
       <%--  <tr>
          <td>邮政编码</td>
          <td><input id="Zipcode" type="text" style="width:300px" maxlength="6" class="text" runat="server" enableviewstate="false" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="Zipcode" 
                Display="None" EnableViewState="False" ErrorMessage="邮政编码格式输入错误" 
                SetFocusOnError="True" ValidationExpression="^\d{6}$"></asp:RegularExpressionValidator>
          </td>
          <td></td>
        </tr>--%>
      </table>
      <div class="ctrl"></div>
    </div>
    
    </form>
</body>
</html>