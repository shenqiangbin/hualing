<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="club.aspx.cs" Inherits="club" EnableViewState="false" %>
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
 <div class="m2pos"><span class="m2name">学员<span class="cor_red">专区</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/feel/4/">学员专区</a> > <a href="<%=category.Url%>"><%=category.Title %></a></span></div>
 <div class="m2new_ul">
 <ul>
  <%for (int i = 0; i < articleList.Count; i++){%>
  <li>
  <a href="/clubdetail/<%=articleList[i].Pkid %>.html" target="_blank"><img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>"  width="320" height="216"  /><br /> <%=QianZhu.Utility.StringHelper.CutString(articleList[i].Title, 41, "...")%></a></li>
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
