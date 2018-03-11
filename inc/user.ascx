<%@ Control Language="C#" AutoEventWireup="true" CodeFile="user.ascx.cs" Inherits="inc_user" %>
<%@ Import Namespace = "QianZhu.Utility" %>
<div class="m2L">
<div class="m2box1">
 <div class="m2box2">
 <div class="m2box3">
 <div class="mc3_t1"><img width="23" height="23" src="/images/tico_5.jpg"><span class="mc3_tname">会员中心</span></div>
 <div class="m2mbrBox">
 <div class="m2mbr_top">
 <%--<div class="m2mbr_img"><img src="/images/mp1.jpg" width="80" height="115" /></div>--%>
 <div class="m2mbr_p1">
 <span class="m2mbr_s1"><%=member.Username %></span><br />
<span class="cor_hs">已认证</span> <img src="/images/mpico.jpg" width="16" height="14" /><br />
<%=member.Email %>
 </div>
 </div>
 <div class="m2mbr_t1">账户管理</div>
 <div class="m2mbr_ul">
 <ul>
  <li><img src="/images/mpico1.jpg" width="18" height="16" /> <a href="/user/personal.html">个人资料</a></li>
  <li><img src="/images/mpico2.jpg" width="18" height="16" /> <a href="/user/password.html">修改密码</a></li>
  <li><img src="/images/mpico3.jpg" width="18" height="16" /> <a href="/user/exit.ashx">安全退出</a></li>
 </ul>
 </div>
 <div class="m2mbr_u2">
  <ul>
   <li><a href="/user/">
   <img class="fl" src="/images/mpico4.jpg" width="42" height="42" />
   <div class="m2mbr_itm">我的首页<br /><span>会员中心首页</span></div>
   </a></li>
  <%if (member.DistrictId != 0)
    {%>
   <li><a href="javascript:void(-1)" class="mreg_click">
   <img class="fl" src="/images/mpico5.jpg" width="42" height="42" />
   <div class="m2mbr_itm">我的奖品<br /><span>查看已中奖品</span></div>
   </a></li>
   <%}
    else
    { %>
    <li><a href="/results.html" >
   <img class="fl" src="/images/mpico5.jpg" width="42" height="42" />
   <div class="m2mbr_itm">我要抽奖<br /><span>您有一次抽奖机会</span></div>
   </a></li>
   <%} %>
   <li><a href="/show.html">
   <img class="fl" src="/images/mpico6.jpg" width="42" height="42" />
   <div class="m2mbr_itm">免费量房/预约设计师<br /><span>在线预约免费量房及设计</span></div>
   </a></li>
  </ul>
 </div>
 <br /><br /><br />
 <div class="clear"></div>
 </div>
 </div>
 </div>
</div>
</div>

<!--中奖弹出层 开始-->
<div class="mlayBox"></div>
<div class="mlayConImg">
<img src="<%=ad6.Pic %>" width="890" height="418" />
<div class="mlay_close"></div>
</div>
<!--END-->
