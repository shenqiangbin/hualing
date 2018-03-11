<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Right.ascx.cs" Inherits="inc_Right"
    EnableViewState="false" %>
<%@ Import Namespace="QianZhu.Utility" %>
<div class="m2R">
    <div class="m2menu">
        <ul>
            <%for (int i = 0; i < SiteMenuList.Count; i++)
              {%>
            <li><a href="<%=SiteMenuList[i].Url %>" target="<%=SiteMenuList[i].Target %>" class="m2menu_a1<%if(menu==SiteMenuList[i].RelationId){%> m2menu_cuta1<% } %>">
                <%=SiteMenuList[i].Title%></a>
                <%if (SiteMenuList[i].HasChild)
                  {%>
                <%SiteMenuList1 = getMenu(SiteMenuList[i].Pkid, SiteMenuList[i].GroupId);%>
                <dl class="hidden">
                    <%for (int j = 0; j < SiteMenuList1.Count; j++)
                      {%>
                    <dd>
                        <a class="m2menu_a3 <%if(menu2==SiteMenuList1[j].RelationId){%> m2menu_cuta3<% } %>"
                            target="<%=SiteMenuList1[j].Target %>" href="<%=SiteMenuList1[j].Url %>">
                            <%=SiteMenuList1[j].Title%></a></dd>
                    <%} %>
                </dl>
                <%}%>
            </li>
            <%} %>
        </ul>
        <div class="clear">
        </div>
    </div>
    <div class="m2r_u1 clearfix">
        <ul>
            <li><a href="/subject2/" target="_blank">
                <img src="/images/m2r_btn1.jpg" width="220" height="45" /></a></li>
            <li><a  href="<%=ad.Url%>" target="_blank">
                <img src="/images/m2r_btn2.jpg" width="220" height="45" /></a></li>
            <li><a href="/book.html" target="_blank">
                <img src="/images/m2r_btn3.jpg" width="220" height="45" /></a></li>
        </ul>
    </div>
    <div class="mpub_t1">
        <span class="mpub_t1name"><strong>最新</strong><span class="cor_red">课程</span></span><a
            class="fr" href="/table13.html">更多>></a></div>
    <div class="block">
     <%if (ad8.Url.Trim() != "http://")
{%><a href="<%=ad8.Url %>" target="_blank"><img src="<%=ad8.Pic %>" alt="<%=ad8.Title %>"  width="220" height="55" /></a>
<%}else{ %><img src="<%=ad8.Pic %>" alt="<%=ad8.Title %>"  width="220" height="55" /><%} %>
   </div>
    <div class="m2r_u2 clearfix">
        <ul>
 <li><a href="<%=ad1.Url %>" target="_blank"><%=ad1.Notes %></a></li>
  <li><a href="<%=ad2.Url %>" target="_blank"><%=ad2.Notes %></a></li>
  <li><a href="<%=ad10.Url %>" target="_blank"><%=ad10.Notes %></a></li>
  <li><a href="<%=ad11.Url %>" target="_blank"><%=ad11.Notes %></a></li>
  <li><a href="<%=ad12.Url %>" target="_blank"><%=ad12.Notes %></a></li>
    </ul>
    </div>
    <div class="mpub_t1 m2r_t1">
        <span class="mpub_t1name"><strong>考试</strong><span class="cor_red">资讯</span></span><a
            class="fr" href="/artlist/16/">更多>></a></div>
    <div class="mc1_u1 m2r_u3 clearfix">
        <ul>
        <% for (int i = 0; i < articleList2.Count; i++){%>
 <li><span class="fl"> <%if (articleList2[i].IsHead){%>
 <a  class="mc3_a2">优惠</a>
   <%}else{ %><a  class="mc3_a1">通知</a><%} %><a class="fl" href="/article/<%=articleList2[i].Pkid %>.html" target="_blank"><%=QianZhu.Utility.StringHelper.CutString(articleList2[i].Title, 25, "")%></a></span></li>
    <%}%>
        </ul>
    </div>
    <div class="block">
         <%if (ad9.Url.Trim() != "http://")
{%><a href="<%=ad9.Url %>" target="_blank"><img src="<%=ad9.Pic %>" alt="<%=ad9.Title %>"   width="220" height="175" /></a>
<%}else{ %><img src="<%=ad9.Pic %>" alt="<%=ad9.Title %>"   width="220" height="175" /><%} %></div>
    <div class="m2r_u4">
        <ul>
            <li class="fl">
            <img src="<%=ad7.Pic %>" alt="<%=ad7.Title %>"  width="100" height="100" /><br />
                <%=ad7.Title %></li>
            <li class="fr">
            <img src="<%=ad6.Pic %>" alt="<%=ad6.Title %>"  width="100" height="100" /><br />
                <%=ad6.Notes %></li>
        </ul>
    </div>
</div>
