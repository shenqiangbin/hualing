<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="path.aspx.cs" Inherits="path" EnableViewState="false" %>
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
 <div class="m2pos"><span class="m2name">学员<span class="cor_red">专区</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/feel/4/">学员专区</a> > <a href="<%=category.Url %>"><%=category.Title %></a></span></div>
 <div class="m2new_u3">
 <ul>
 <%for (int i = 0; i < articleList.Count; i++){%>
<li><a class="fl" href="/clubdetail/<%=articleList[i].Pkid %>.html" target="_blank"><%=QianZhu.Utility.StringHelper.CutString(articleList[i].Title, 72, "...")%></a><span class="fr"><%=QianZhu.Utility.DateHelper.ToShortDate(articleList[i].Pubdate)%></span></li>
  <%} %>
 </ul>
 <div class="clear"></div>
 </div>
<div class="mpage" id="Paging" runat="server" enableviewstate="false"/></div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
</asp:Content>
