<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="topic.aspx.cs" Inherits="topic" %>
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
  <div class="m2pos"><span class="m2name">关于<span class="cor_red">华领</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/aboutus10.html">关于华领</a>> <a href="<%=category.Url %>"><%=category.Title%></a></span></div>
 <div class="m2imgPage">
 <ul>
 
 <%for (int i = 0; i < articleList.Count; i++){%>
  <li>
  <a ><img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="220" height="135" /><br /><center><%=articleList[i].Title%></center></a>
   <div class="m2imgLay">
    <img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="471" height="289" />
    <p><%=articleList[i].Files%></p>
    <div class="m2imgIco"></div>
  </div>
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
