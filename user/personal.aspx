<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="personal.aspx.cs" Inherits="user_personal" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register src="~/inc/user.ascx" tagname="user" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">    
<uc1:banner ID="banner1" runat="server" />
<div class="main2">
<uc1:user ID="user1" runat="server" />
<div class="m2R">
<div class="m2box1a">
 <div class="m2box2a">
 <div class="m2box3a">
 <div class="mct1 mct1_v2">
 <span class="mct1_v2s1">
 <span class="mct1_v2s2">个人资料</span>
 </span>
 <span class="fr">您当前的位置：<a href="/">首页</a> > <a href="/user/">会员中心</a> > <a class="cor_blue" href="#">个人资料</a></span>
 </div>
 <div class="m2rbox">
   <div class="mregL2">
    <form id="Form1" runat="server">
     <ul>
    
   <li><span class="mreg_s1">用户名：</span><span class="fl cor_red"><%=member.Username %></span></li>
   <li><span class="mreg_s1">邮箱：</span><span class="fl cor_red"><%=member.Email %></span></li>
  <li><span class="mreg_s1">真实姓名：</span><input type="text" class="m2free_int m2free_int2"  id="Realname" runat="server" enableviewstate="false"/><span class="fl cor_red">*</span></li>
  <li><span class="mreg_s1">性别：</span><input class="m2free_chk" type="radio" name="sex" <%if(sex==1){ %>checked="checked"<%} %> value="1" />先生 &nbsp;&nbsp;&nbsp; <input type="radio" class="m2free_chk" name="sex" value="2" <%if(sex==2){ %>checked="checked"<%} %> />女士</li>
  <li><span class="mreg_s1">手机号：</span><span><%=member.Mobi %></span><span class="pl20 cor_red"><%--修改--%></span><span class="pl20">已验证</span></li>
  <li><span class="mreg_s1">QQ号码：</span><input type="text" class="m2free_int m2free_int2"  id="QQ" runat="server" enableviewstate="false"/></li>
  <%--<li><span class="mreg_s1">验证码：</span><input class="m2free_int m2free_int2 m2free_int3" name="" type="text" />
    <a class="fl" href="#"><img src="images/coder2.jpg" width="83" height="32" /></a> &nbsp; <a class="cor_hs" href="#">看不清换一个</a></li>--%>
  <li><span class="mreg_s1">&nbsp;</span>
   <asp:Button ID="SubminButton" runat="server" CssClass="m2freeBtn m2freeBtnv2" onclick="SubminButton_Click" />
  </li>
  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Realname" 
                                        Display="None" EnableViewState="False" ErrorMessage="请输入您的真实姓名" 
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                         <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
   
 </ul>
 </form>
 <div class="clear"></div>
</div>
<div class="mregR2"><div class="m2mbr_img2"><%--<img src="images/mp2.jpg" width="120" height="138" />
<p><a href="#">修改头像</a></p>--%>
</div></div>
   <div class="clear"></div>
 </div>
 <br /><br />
 </div>
 </div>
</div>
</div>
<div class="clear"></div>
</div>
</asp:Content>