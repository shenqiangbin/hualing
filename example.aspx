<%@ Page Title="" Language="C#" MasterPageFile="~/main2.master" AutoEventWireup="true" CodeFile="example.aspx.cs" Inherits="example" EnableViewState="false" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main2.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<link href="/css/pagination2.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
<div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
  <div class="m2pos"><span class="m2name">内训<span class="cor_red">案例</span></span><span class="m2posR">当前位置：<a href="/index1.html">首页</a> > <a href="#">内训案例</a></span></div>
 <div class="m2partner_u2">
 <ul>
 <%for (int i = 0; i < articleList.Count; i++){%>
  <li>
   <%if (articleList[i].Url.Trim() != "http://")
{%><a href="<%=articleList[i].Url%>" target="_blank"> <img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="187" height="120" /></a>
<%}else{ %> <img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="187" height="120" /><%} %>
  <div class="m2new_txt2">
  <div class="m2new_twed"><a class="cor_black fl f14" ><%=articleList[i].Title%></a> </div>
  <p><%=articleList[i].Notes.Replace(Convert.ToChar(13).ToString(), "<br/>").Replace("  ", "&nbsp;&nbsp;")%></p>
  </div>
   <div class="clear"></div>
  </li>
  <%} %>
 </ul>
 <div class="clear"></div>
 </div>
<div class="mpage" id="Paging" runat="server" enableviewstate="false"></div>
</div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
</asp:Content>
