<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="password.aspx.cs" Inherits="user_password" %>
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
 <span class="mct1_v2s2">修改密码</span>
 </span>
 <span class="fr">您当前的位置：<a href="/">首页</a> > <a href="#">会员中心</a> > <a class="cor_blue" href="#">修改密码</a></span>
 </div>
 <div class="m2rbox">
   <div class="mregL2">
  <form id="Form1" runat="server">
     <ul>
            <li><span class="mreg_s1">原密码：</span> <input class="m2free_int m2free_int2" id="OldPwd" type="password" runat="server" enableviewstate="false" maxlength="20"/><span class="fl cor_red">*</span></li>
            <li><span class="mreg_s1">新密码：</span><input class="m2free_int m2free_int2" id="NewPwd" type="password" runat="server" enableviewstate="false" maxlength="20"/><span class="fl cor_red">*</span></li>
            <li><span class="mreg_s1">确认新密码：</span> <input class="m2free_int m2free_int2" id="NewPwd2" type="password" runat="server" enableviewstate="false" maxlength="20"/><span class="fl cor_red">*</span></li>
            <li><span class="mreg_s1">&nbsp;</span>
             <asp:Button ID="SubmitButton" runat="server" CssClass="m2freeBtn m2freeBtnv2" onclick="SubmitButton_Click" />
            </li>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="OldPwd" Display="None" EnableViewState="False" 
                                ErrorMessage="请输入原密码" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="NewPwd" Display="None" EnableViewState="False" 
                                ErrorMessage="请输入新密码" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                ControlToValidate="NewPwd" Display="None" ErrorMessage="密码长度应为6-20位" 
                                SetFocusOnError="True" ValidationExpression="^[\w\W]{6,}$"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="NewPwd2" Display="None" EnableViewState="False" 
                                ErrorMessage="请确认新密码" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                ControlToCompare="NewPwd" ControlToValidate="NewPwd2" Display="None" 
                                EnableViewState="False" ErrorMessage="两次输入的新密码不一致" SetFocusOnError="True"></asp:CompareValidator>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
                                
 </ul>
 </form>
 <div class="clear"></div>
</div>
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
