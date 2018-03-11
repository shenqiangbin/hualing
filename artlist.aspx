<%@ Page Title="华领cma-华领国际" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="artlist.aspx.cs" Inherits="artlist" EnableViewState="false" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<link href="/css/pagination2.css" rel="stylesheet" type="text/css" />
<title>
	华领cma-华领国际
</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
<div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
 <div class="m2pos"><span class="m2name">新闻<span class="cor_red">资讯</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="<%=category.Url %>">新闻资讯</a> > <a href="<%=category.Url %>"><%=category.Title %></a></span></div>
 <div class="m2new_u2">
 <ul>
 <%for (int i = 0; i < articleList.Count; i++){%>
  <li>
  <a href="/article/<%=articleList[i].Pkid %>.html" target="_blank"><img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="196" height="120" /></a>
  <div class="m2new_txt2">
  <div class="m2new_t"><a class="cor_black fl f14" href="/article/<%=articleList[i].Pkid %>.html" target="_blank"><%=QianZhu.Utility.StringHelper.CutString(articleList[i].Title, 59, "...")%></a><a href="/article/<%=articleList[i].Pkid %>.html" target="_blank" class="fr cor_red"> [查看详情]</a></div>
  <div class="m2new_t2">来源：<%=articleList[i].Source %> &nbsp; 发布者：<%=articleList[i].Author %> &nbsp; 发布日期：<%=QianZhu.Utility.DateHelper.ToShortDate(articleList[i].Pubdate)%></div>
  <p><%=QianZhu.Utility.StringHelper.CutString(articleList[i].Files, 238, "...")%></p>
  </div>
  </li>
  <%} %>
 </ul>
 <div class="clear"></div>
 <div class="mpage" id="Paging" runat="server" enableviewstate="false"/></div>
</div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
</asp:Content>
