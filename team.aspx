<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="team.aspx.cs" Inherits="team" EnableViewState="false" %>
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
 <div class="m2pos"><span class="m2name">名师<span class="cor_red">团队</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/team/13/">名师团队</a></span></div>
 <div class="m2per_ul">
 <ul>
 
 <%for (int i = 0; i < articleList.Count; i++){%>
  <li>
  <a href="/teamdetail/<%=articleList[i].Pkid %>.html" target="_blank"><img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="120" height="150"  /></a>
  <div class="m2per_txt">
  <span class="f14 cor_black"><%=articleList[i].Title %></span><br />
 <%=QianZhu.Utility.StringHelper.CutString(articleList[i].Files, 134, "...").Replace(Convert.ToChar(13).ToString(),"<br/>")%>
  <div class="m2per_more"><a class="cor_red" href="/teamdetail/<%=articleList[i].Pkid %>.html" target="_blank">讲师介绍>></a></div>
  </div>
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
