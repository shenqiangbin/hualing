<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="join.aspx.cs" Inherits="join" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="/plugin/datainput/dateInput.css" rel="stylesheet" type="text/css" />
    <script src="/plugin/datainput/jquery.dateInput.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       
<div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
  <div class="m2pos"><span class="m2name">关于<span class="cor_red">华领</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/aboutus10.html">关于华领</a>> <a href="/join.html">加入我们</a></span></div>
 <div class="m2reg_t1">招聘职位</div>
 <div class="m2reg_ul m2reg_ulv1">
 <form id="Form1" runat="server">
 <ul>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 申请人姓名：</span><input class="m2reg_int1" name="" type="text" id="names" runat="server" enableviewstate="false" /></li>
  <li><span class="m2reg_s1">性别：</span><input name="sex" type="radio" class="m2reg_rad" value="1" checked="checked" /> 男 &nbsp;&nbsp; <input name="sex" type="radio" class="m2reg_rad" value="2" /> 女</li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 出生日期：</span><input class="m2reg_int1" name="" type="text" id="bristh" runat="server" enableviewstate="false"/>
  <script type="text/javascript">
                $("#<%= bristh.ClientID %>").date_input();
            </script></li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 籍贯：</span><input class="m2reg_int1" name="" type="text" id="addr" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1">薪资要求：</span><input class="m2reg_int1" name="" type="text" id="salacy" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 电话：</span><input class="m2reg_int1" name="" type="text" id="tel" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> E-mail：</span><input class="m2reg_int1" name="" type="text" id="Email" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1">通讯地址：</span><input class="m2reg_int1" name="" type="text" id="address" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1">教育经历：</span><textarea class="m2reg_area" name="" cols="10" rows="5" id="edu" runat="server" enableviewstate="false"></textarea><div class="clear"></div></li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 工作经历：</span><textarea class="m2reg_area" name="" cols="10" rows="5" id="works" runat="server" enableviewstate="false"></textarea><div class="clear"></div></li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 自我评价：</span><textarea class="m2reg_area" name="" cols="10" rows="5" id="evaluation" runat="server" enableviewstate="false"></textarea><div class="clear"></div></li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 验证码：</span><input class="m2reg_int1 m2reg_int2" name="" type="text" id="code" runat="server" enableviewstate="false"/>
    <a class="m2reg_coder" href="javascript:void(-1);" onclick="changeimg();return false;"><img src="/Validate.aspx" id="validimg"  width="62" height="25" /></a> &nbsp; <a class="m2reg_a1" href="javascript:void(-1);" onclick="changeimg();return false;">看不清换一个</a></li>
  <li class="m2reg_btnBox"><span class="m2reg_s1">&nbsp;</span>
  <asp:Button ID="SubminButton" runat="server" CssClass="m2reg_submit" onclick="SubminButton_Click" />
  </li>
 </ul>
 
  <asp:RequiredFieldValidator  ID="RequiredFieldValidator1" runat="server" ErrorMessage="请输入姓名" Display="None" EnableViewState="False" ControlToValidate="names"></asp:RequiredFieldValidator>
        
        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="Email" 
            Display="None" EnableViewState="False" ErrorMessage="请输入邮箱" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
            ControlToValidate="Email" Display="None" EnableViewState="False" 
            ErrorMessage="邮箱格式输入不正确" SetFocusOnError="True" 
            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tel" 
            Display="None" EnableViewState="False" ErrorMessage="请输入电话" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>
       <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
            ControlToValidate="tel" Display="None" EnableViewState="False" 
            ErrorMessage="电话格式输入不正确" SetFocusOnError="True" 
            ValidationExpression="1[3|5|7|8|][0-9]{9}"></asp:RegularExpressionValidator>    
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="addr" 
            Display="None" EnableViewState="False" ErrorMessage="请输入籍贯" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>
      
      <asp:RequiredFieldValidator  ID="RequiredFieldValidator4" runat="server" ControlToValidate="works" 
            Display="None" EnableViewState="False" ErrorMessage="请输入工作经历" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator  ID="RequiredFieldValidator5" runat="server" ControlToValidate="evaluation" 
            Display="None" EnableViewState="False" ErrorMessage="请输入自我评价" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator  ID="RequiredFieldValidator8" runat="server" ControlToValidate="code" 
            Display="None" EnableViewState="False" ErrorMessage="请输入验证码" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"   
            EnableViewState="False" ShowMessageBox="true" ShowSummary="False" />
  </form>
 <div class="clear"></div>
 </div>
</div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
<script type="text/javascript">
function changeimg() {
var img = $("#validimg").get(0);
img.src = "/Validate.aspx?tmp=" + parseInt(Math.random() * 9000 + 1000);
}
</script>
</asp:Content>