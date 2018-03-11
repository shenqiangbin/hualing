<%@ Control Language="C#" AutoEventWireup="true" CodeFile="banner.ascx.cs" Inherits="inc_banner" %>
<%@ Import Namespace = "QianZhu.Utility" %>
<div class="banBox">
 <%if (ad6.Url.Trim() != "http://")
{%><a href="<%=ad6.Url %>" target="_blank"><img src="<%=ad6.Pic %>" alt="<%=ad6.Title %>"  width="1440" height="230" /></a>
<%}else{ %><img src="<%=ad6.Pic %>" alt="<%=ad6.Title %>"  width="1440" height="230" /><%} %>
</div>
