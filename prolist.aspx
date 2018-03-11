<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="prolist.aspx.cs" Inherits="prolist" %>
<%@ MasterType VirtualPath="~/main.master" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<link href="/css/pagination2.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">    
<div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
 <div class="m2pos"><span class="m2name">课程<span class="cor_red">班型</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/prolist/2/">课程班型 > <a href="/prolist/2/">CMA课程</a></span></div>
 <div class="m2editor1 m2editor2">
 <!-- 标签切换 Start hoverTag-->
<div class="clickTag m2chg1">
  <div class="chgBtnList" style=" height:28px;">
   <ul>
   <%for (int i = 0; i < productList.Count; i++){%>
  <li class="chgBtn<%if(i==0){%> chgCutBtn<%} %>"><%=productList[i].Title %></li>
  <% } %>
  </ul>
  </div>
  <div class="chgConList m2tab1">
  <%for (int i = 0; i < productList.Count; i++){%>
    <div class="chgCon<%if(i>0){%> hidden<%} %>">
    <%=productList[i].Content %>
    </div>
    <% } %>
  </div>
</div>
<!-- 标签切换 End -->
 <div class="clear"></div>
 </div>
</div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
</asp:Content>