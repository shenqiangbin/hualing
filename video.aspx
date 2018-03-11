<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="video.aspx.cs" Inherits="video" EnableViewState="false" %>
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
 <div class="m2pos"><span class="m2name">关于<span class="cor_red">华领</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/aboutus10.html">关于华领</a> > <a href="<%=category.Url %>"><%=category.Title %></a></span></div>
 <div class="m2new_u2">
 <ul>
 <%for (int i = 0; i < articleList.Count; i++){%>
  <li>
  <a href="/videodetail/<%=articleList[i].Pkid %>.html" target="_blank"><img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="196" height="120" /></a>
  <div class="m2new_txt2">
  <div class="m2new_t"><a class="cor_black fl f14" href="/videodetail/<%=articleList[i].Pkid %>.html" target="_blank"><%=QianZhu.Utility.StringHelper.CutString(articleList[i].Title, 59, "...")%></a><a href="/videodetail/<%=articleList[i].Pkid %>.html" target="_blank" class="fr cor_red"> [查看详情]</a></div>
  <br/>
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
