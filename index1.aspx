<%@ Page Title="" Language="C#" MasterPageFile="~/main2.master" AutoEventWireup="true" CodeFile="index1.aspx.cs" Inherits="index1" EnableViewState="false" %>
<%@ Import Namespace = "QianZhu.Utility" %>
<%@ MasterType VirtualPath="~/main2.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style>
	.mqy3_ul a{
		overflow: hidden;
    	display: inline-block;
    	height: 24px;
	}
</style>
<script language="javascript" type="text/javascript" src="/js/jquery.SuperSlide.js"></script>
<script type="text/javascript" src="/js/index_huitu.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div class="banBg">
<div class="banBox">
<div id="slideBox" class="slideBox slideBox1">
<div class="banBtnL prev"></div>
<div class="banBtnR next"></div>
        <div class="hd">
            <ul><%for (int i = 0; i < adFixedList.Count; i++){%><li></li><%} %></ul>
        </div>
        <div class="bd">
            <ul>
             <% adFixedList[0].Url = "http://www.hualingedu.com/inner/";for (int i = 0; i < adFixedList.Count; i++)
               {%>
<li><a target="_blank" href="<%=adFixedList[i].Url %>"><img src="<%=adFixedList[i].Pic %>" alt="<%=adFixedList[i].Title %>"  /></a></li>
<%} %>
            </ul>
        </div>
    </div>
<script language="javascript">
jQuery(".slideBox1").slide({mainCell:".bd ul",effect:"leftLoop",autoPlay:true});
</script>
</div>
</div>
<div class="main">
<div class="mqycon1">
<div class="mpub_t1"><span class="mpub_t1name"><strong>内训</strong><span class="cor_red">案例</span><span class="cor_hs">/ Successful case</span></span><a href="/example/" class="mpub_tmore">查看更多</a></div>
<div class="mqyc1_bx1">
  <img class="mqy_btnL prev" src="images/mqy_btn1.jpg" width="25" height="41" />
  <div class="mqyc1_u1">
  <ul>
  <%for (int i = 0; i < adFixedList1.Count; i++){%>
  <li>
   <%if (adFixedList1[i].Url.Trim() != "http://")
{%><a href="<%=adFixedList1[i].Url%>" target="_blank"><img src="<%=adFixedList1[i].Pic %>" alt="<%=adFixedList1[i].Title %>" width="148" height="95" /></a>
<%}else{ %>  <a target="_blank" ><img src="<%=adFixedList1[i].Pic %>" alt="<%=adFixedList1[i].Title %>" width="148" height="95" /></a><%} %>
   <a class="cor_black"><%=QianZhu.Utility.StringHelper.CutString(adFixedList1[i].Title, 21, "")%></a><br />
   <%=QianZhu.Utility.StringHelper.CutString(adFixedList1[i].Notes, 44, "")%>
   </li>
<%} %>
  </ul>
  </div> <img class="mqy_btnR next" src="images/mqy_btn2.jpg" width="25" height="41" />
</div>
<script language="javascript">
jQuery(".mqyc1_bx1").slide({titCell:"",mainCell:".mqyc1_u1 ul",autoPage:true,effect:"leftLoop",autoPlay:true,vis:5});
</script>
</div>
<div class="mqycon2 clearfix">
<div class="mqy2L">
<div class="mpub_t1"><span class="mpub_t1name"><strong>CMA内训课程</strong></span><a href="/cmacourse13.html" class="mpub_tmore">查看更多</a></div>
<div class="mqy2_1">
<%=pageSection.Content%>
<div class="mqy2_part">Part1</div>
</div>
<div class="mqy2_1">
<%=pageSection1.Content%>
<div class="mqy2_part">Part2</div>
</div>
<div class="mqy2_t1">财务及管理类内训</div>
<div class="mqy2_u1">
 <ul>
 <%for (int i = 0; i < categoryList.Count; i++)
    {%>
  <li><a class="mqy2_a1" target="_blank" href="/train/<%=categoryList[i].Pkid%>/"><%=categoryList[i].Title%></a></li>
  <% } %>
 </ul>
</div>
</div>
<div class="mqy2R">
<div class="mpub_t1"><span class="mpub_t1name"><strong>热门内训课程</strong></span><a href="/train/18/" class="mpub_tmore">查看更多</a></div>
<div class="mqy2_b1">
<a class="fl" href="<%=ad4.Url %>" target="_blank"><img src="<%=ad4.Pic %>" alt="<%=ad4.Notes %>" width="246" height="85" /></a><a class="fr" href="<%=ad7.Url %>" target="_blank"><img src="<%=ad7.Pic %>" alt="<%=ad7.Notes %>" width="246" height="85" /></a>
</div>
<div class="mqy2_u2">
<ul>
<% for (int i = 0; i < productList1.Count; i++)
     {%>
        <li><a href="/product/<%=productList1[i].Pkid %>.html" target="_blank" class="fl"><%=QianZhu.Utility.StringHelper.CutString(productList1[i].Title, 43, "")%></a><span class="fr"><%=QianZhu.Utility.DateHelper.ToShortDate(productList1[i].Pubdate)%></span></li>
   <%}%>
</ul>
<div class="clear"></div>
</div>
</div>
</div>
<div class="mcban"> <a href="<%=ad5.Url %>" target="_blank"><img src="<%=ad5.Pic %>" alt="<%=ad5.Notes %>" width="1050" height="90" /></a></div>
<div class="mqycon3">
<div class="mqy3L">
<div class="mpub_t1"><span class="mpub_t1name"><strong class="cor_red">华领内训优势</strong></span><a href="/adv18.html" class="mpub_tmore">查看更多</a></div>
<div class="mqy3_bom">
<a  class="mqy3_img" href="<%=ad6.Url %>" target="_blank"><img src="<%=ad6.Pic %>" alt="<%=ad6.Notes %>" width="216" height="160" /><div class="mqy3_name"><%=ad6.Notes %></div></a>
<div class="mqy3_ul">
<ul>
    <li><a href="<%=ad8.Url %>" target="_blank"><span class="cor_black"><%=ad8.Title %>：</span><%=ad8.Notes %></a></li>
    <li><a href="<%=ad9.Url %>" target="_blank"><span class="cor_black"><%=ad9.Title %>：</span><%=ad9.Notes %></a></li>
    <li><a href="<%=ad10.Url %>" target="_blank"><span class="cor_black"><%=ad10.Title %>：</span><%=ad10.Notes %></a></li>
    <li><a href="<%=ad11.Url %>" target="_blank"><span class="cor_black"><%=ad11.Title %>：</span><%=ad11.Notes %></a></li>
    <li><a href="<%=ad12.Url %>" target="_blank"><span class="cor_black"><%=ad12.Title %>：</span><%=ad12.Notes %></a></li>
    <li><a href="<%=ad13.Url %>" target="_blank"><span class="cor_black"><%=ad13.Title %>：</span><%=ad13.Notes %></a></li>
</ul>
</div>
</div>
</div>
<div class="mqy3R">
<div class="mpub_t1"><span class="mpub_t1name"><strong class="cor_red">讲师团队</strong></span><a href="/expert/12/" class="mpub_tmore">查看更多</a></div>
<div class="mqyc3_imgUl">
  <img class="mqyc3_btn1 prev" src="images/mqy_btn3.jpg" width="16" height="27" />
  <div class="mqyc3_pul">
  <ul>
  
 <%for (int i = 0; i < articleList.Count; i++){%>
     <li>
   <a class="fl" href="/expertdetail/<%=articleList[i].Pkid %>.html" target="_blank"><img src="<%=articleList[i].Pic %>" title="<%=articleList[i].Title %>" width="115" height="126" /></a>
   <div class="mqyc3Txt">
   <div class="mqyc3_rp">
    <span class="cor_black">讲师：<%=articleList[i].Title %></span><br />
    <%=articleList[i].Files.Replace(Convert.ToChar(13).ToString(),"<br/>")%><br />
   </div>
   <a href="/expertdetail/<%=articleList[i].Pkid %>.html" target="_blank"><img src="images/mqy_btn5.jpg" width="93" height="21" /></a>
   </div>
   </li>
  <%} %>
  </ul>
  </div>
  <img class="mqyc3_btn2 next" src="images/mqy_btn4.jpg" width="16" height="27" />
</div>
<script language="javascript">
jQuery(".mqyc3_imgUl").slide({titCell:"",mainCell:".mqyc3_pul ul",autoPage:true,effect:"leftLoop",autoPlay:true,vis:1});
</script>
</div>
<div class="clear"></div>
</div>
<div class="clear"></div>
</div>
</asp:Content>