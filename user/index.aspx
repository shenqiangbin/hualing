<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="user_index" %>
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
 <span class="mct1_v2s2">会员中心</span>
 </span>
 <span class="fr">您当前的位置：<a href="/">首页</a> > <a href="#" class="cor_blue">会员中心</a> <%--> <a class="cor_blue" href="#">公司新闻</a>--%></span>
 </div>
 <div class="m2rbox m2rboxv3">
 <div class="m2mbr_t2">欢迎，<%= uname %>回来！</div>
 <div class="m2mbr_txt">
 尊敬的会员您好，恭喜您成为我们的VIP用户！
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
