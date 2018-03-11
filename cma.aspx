<%@ Page Title="" Language="C#" MasterPageFile="~/main2.master" AutoEventWireup="true" CodeFile="cma.aspx.cs" Inherits="cma" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main2.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">   
<div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
<div class="m2pos"><span class="m2name"><%=model.Title.Substring(0,2)%><span class="cor_red"><%=model.Title.Substring(2,2)%></span></span><span class="m2posR">当前位置：<a href="/index1.html">首页</a> > <a href="<%=model.Url %>"><%=model.Title%></a></span></div>
 <div class="m2editor1 m2editor2">
  <%= model.Content %>
 <div class="clear"></div>
 </div>
</div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
</asp:Content>
