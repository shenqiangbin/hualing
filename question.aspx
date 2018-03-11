<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="question.aspx.cs" Inherits="question" EnableViewState="false" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
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
 <div class="m2pos"><span class="m2name">关于<span class="cor_red">CMA</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/cmajj.html">关于CMA</a> > <a href="<%=category.Url %>"><%=category.Title%></a></span></div>
 <div class="m2qustion_u2s">
 <ul>
 <%for (int i = 0; i < articleList.Count; i++){%>
  <li>

  <div class="m2qustion_ts"><a class="cor_black fl f14"  href="/wtdetail/<%=articleList[i].Pkid%>.html" target="_blank" style=" font-weight:bold"><%=articleList[i].Title%></a></div>
  <p><%=articleList[i].Files.Replace(Convert.ToChar(13).ToString(), "<br/>").Replace("  ", "&nbsp;&nbsp;")%></p>
 <br />
  </li>
  <%} %>
 </ul>
 <div class="clear"></div>
 </div>
 <div class="mpage" id="Paging" runat="server" enableviewstate="false"/></div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
</asp:Content>
