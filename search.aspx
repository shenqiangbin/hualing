<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" EnableViewState="false" %>
<%@ Import Namespace = "QianZhu.Utility" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="right" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<link href="/css/pagination2.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
 <div class="m2pos"><span class="m2name">搜索<span class="cor_red">结果</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a>搜索结果</a></span></div>
 <div class="m2new_u3">
 <ul>
  <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false">
<ItemTemplate>
<li><a class="fl" href="<%# Eval("Url") %>" target="_blank"><%# QianZhu.Utility.StringHelper.CutString(Eval("Title").ToString(),85,"...") %></a><span class="fr"><%# QianZhu.Utility.DateHelper.ToShortDate(Eval("createtime").ToString())%></span></li>
</ItemTemplate>
</asp:Repeater>
 </ul>
 <div class="clear"></div>
 </div>
<div class="mpage" id="Paging" runat="server" enableviewstate="false"/></div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
</asp:Content>