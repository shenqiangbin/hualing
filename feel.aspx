<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="feel.aspx.cs" Inherits="feel" EnableViewState="false" %>
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
 <div class="m2pos"><span class="m2name">学员<span class="cor_red">专区</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="<%=category.Url %>">学员专区</a> > <a href="<%=category.Url %>"><%=category.Title%></a></span></div>
 <div class="m2new_u2">
 <ul>
 <%for (int i = 0; i < articleList.Count; i++)
   {%>
  <li style=" height:201px;">
  <a href="/feeldetail/<%=articleList[i].Pkid %>.html" target="_blank"><img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="140" height="169" /></a>
  <div class="m2new_txt2asa">
  <div class="m2new_t"><a class="cor_black fl f14" href="/feeldetail/<%=articleList[i].Pkid %>.html" target="_blank"><%=QianZhu.Utility.StringHelper.CutString(articleList[i].Title, 68, "...")%></a><a href="/feeldetail/<%=articleList[i].Pkid %>.html" target="_blank" class="fr cor_red"> [查看详情]</a></div>
  <br/>
  <p><%=QianZhu.Utility.StringHelper.CutString(articleList[i].Files, 333, "...")%></p>
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
