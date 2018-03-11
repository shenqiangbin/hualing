<%@ Page Title="" Language="C#" MasterPageFile="~/main2.master" AutoEventWireup="true" CodeFile="train.aspx.cs" Inherits="train" %>
<%@ MasterType VirtualPath="~/main2.master" %>
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
 <div class="m2pos"><span class="m2name">内训<span class="cor_red">课程</span></span><span class="m2posR">当前位置：<a href="/index1.html">首页</a> > <a href="/train/18/">内训课程</a> > <a href="<%=model.Url %>"><%=model.Title%></a></span></div>
 <div class="m2editor1 m2editor2">
 <!-- 标签切换 Start hoverTag-->
<div class="clickTag m2chg1">
  <div class="chgBtnList">
   <ul>
    <%for (int i = 0; i < categoryList.Count; i++)
    {%>
  <li class="chgBtn<%if(categoryList[i].Pkid.ToString()==cid){%> chgCutBtn<%} %>"><a style=" color:#fff;" href="/train/<%=categoryList[i].Pkid%>/"><%=categoryList[i].Title%></a></li>
  <% } %>
  </ul>
   <div class="clear"></div>
  </div>
  <div class="chgConList m2kcList">
  <%for (int i = 0; i < categoryList.Count; i++)
    {%>
  <%productList = getprlist(categoryList[i].Pkid); %>
    <div class="chgCon<%if(categoryList[i].Pkid.ToString()!=cid){%> hidden<%} %>">
     <ul>
     <%for (int j = 0; j < productList.Count; j++){%>
    <li><a  target="_blank" href="/product/<%=productList[j].Pkid %>.html"><%=productList[j].Title %></a></li>
   <% } %>
    </ul>
    <div class="nxkc1 nxkceq">
   <div class="nxkc1_title">适合对象</div>
 </div>
 <div class="nxkc1_txt">
   <%=categoryList[i].Content%>
 </div>
 <%--<div class="nxkc1">
   <div class="nxkc1_title">课程信息</div>
 </div>
 <%=categoryList[i].Content2%>  --%>  
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
<script>
$(function(){
  $(".m2menu ul dl").removeClass("hidden");
})
</script>
</asp:Content>