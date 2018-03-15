<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" EnableViewState="false" %>

<%@ Import Namespace="QianZhu.Utility" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript" src="/js/jquery.SuperSlide.js"></script>
    <script type="text/javascript" src="/js/index_huitu.js"></script>
    <style type="text/css">
            #floatdiv {
            	display: block;
                position: fixed;
                bottom: 0;
                background-color: #eb3632;
                width: 100%;
                min-width: 1170px;
                height: 52px;
                z-index: 100;
            }
            #floatdiv>img{
            	position: absolute;
            	bottom: 0;
                width: 1170px;
                left: 50%;
                margin-left: -585px;
            }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="banBg">
        <div class="banBox">
            <div id="slideBox" class="slideBox slideBox1">
                <div class="banBtnL prev"></div>
                <div class="banBtnR next"></div>
                <div class="hd">
                    <ul>
                        <%for (int i = 0; i < adFixedList.Count; i++)
                          {%><li></li>
                        <%} %>
                    </ul>
                </div>
                <div class="bd">
                    <ul>
                        <%for (int i = 0; i < adFixedList.Count; i++)
                          {%>
                        <li><a target="_blank" href="<%=adFixedList[i].Url %>">
                            <img src="<%=adFixedList[i].Pic %>" alt="<%=adFixedList[i].Title %>" /></a></li>
                        <%} %>
                    </ul>
                </div>
            </div>
            <script language="javascript">
                jQuery(".slideBox1").slide({ mainCell: ".bd ul", effect: "leftLoop", autoPlay: true });
            </script>
        </div>
    </div>
    <div class="main">
        <div class="mcon1">
            <div class="mL">
                <div class="mc1_bx1">
                    <div class="mc1_bx1L">
                        <div class="mpub_t1"><span class="mpub_t1name"><strong style="color:#445368;">行业资讯</strong><span class="cor_red"></span><span class="cor_hs">&nbsp;|&nbsp;News</span></span><a href="/artlist/14/" class="mpub_tmore" rel="nofollow">查看更多</a></div>

                        <%if (articleList.Count > 0)
                          {%>
                        <div class="mc1_bxlTop">
                            <a class="fl" href="<%=ad8.Url %>" target="_blank">
                                <img src="<%=ad8.Pic %>" alt="<%=ad8.Notes %>" width="108" height="75" /></a>
                            <div class="mc1_bx1p1">
                                <a href="/article/<%=articleList[0].Pkid %>.html" target="_blank" class="cor_red"><%=QianZhu.Utility.StringHelper.CutString(articleList[0].Title, 29, "...")%></a><br />
                                <%=QianZhu.Utility.StringHelper.CutString(articleList[0].Files, 66, "")%>
                            </div>
                        </div>
                        <%} %>
                        <div class="mc1_u1">
                            <ul>
                                <% for (int i = 1; i < articleList.Count; i++)
                                   {%>
                                <li><span class="fl"><a href="/article/<%=articleList[i].Pkid %>.html" target="_blank" title="<%=articleList[i].Title %>"><%=QianZhu.Utility.StringHelper.CutString(articleList[i].Title, 36, "")%></a></span><span class="fr">[<%=QianZhu.Utility.DateHelper.ToShortDate(articleList[i].Pubdate)%>]</span></li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                    <div class="mc1_bx1R">
                        <div class="mpub_t1"><span class="mpub_t1name"><strong style="color:#445368;">最新课程</strong><span class="cor_red"></span><span class="cor_hs">&nbsp;|&nbsp;Course</span></span><a href="/table17.html" class="mpub_tmore" rel="nofollow">查看更多</a></div>
                        <div class="mc1_tab">
                            <table width="100%">
                                <tr class="mc1_th">
                                    <td width="21%" align="center">授课方式</td>
                                    <td width="18%" align="center">期号</td>
                                    <td width="26%" align="center" valign="middle">开课时间</td>
                                    <td width="13%" align="center" valign="middle">城市</td>
                                    <td width="22%" align="center" valign="middle">开班情况</td>
                                </tr>
                                <%for (int i = 0; i < CourseList.Count; i++)
                                  {%>
                                <tr>
                                    <td align="center"><%=CourseList[i].Way %></td>
                                    <td align="center"><%=CourseList[i].Issue %></td>
                                    <td align="center" valign="middle"><%=QianZhu.Utility.DateHelper.ToShortDate(CourseList[i].Opentime) %></td>
                                    <td align="center" valign="middle"><%=CourseList[i].City %></td>
                                    <td align="center" valign="middle"><a class="mc1_a1" href="<%=CourseList[i].Tel %>" target="_blank">
                                        <%if (CourseList[i].Pv == 0)
                                          {%>
                                        <img src="images/mc1_btn3.jpg" width="51" height="18" />
                                        <% }
                                          else if (CourseList[i].Pv == 1)
                                          { %><img src="images/mc1_btn2.jpg" width="51" height="18" />
                                        <%}
                                          else
                                          { %><img src="images/mc1_btn1.jpg" width="51" height="18" />
                                        <%} %>
                                    </a></td>
                                </tr>
                                <%} %>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="mc1_bx2">
                    <div id="slideBox2" class="slideBox slideBox2">
                        <div class="hd">
                            <ul>
                                <%for (int i = 0; i < adFixedList1.Count; i++)
                                  {%><li></li>
                                <%} %>
                            </ul>
                        </div>
                        <div class="bd">
                            <ul>
                                <%for (int i = 0; i < adFixedList1.Count; i++)
                                  {%>
                                <li><a target="_blank" href="<%=adFixedList1[i].Url %>">
                                    <img src="<%=adFixedList1[i].Pic %>" alt="<%=adFixedList1[i].Title %>" /></a><div class="mc2_imgNmae"><%=adFixedList1[i].Title%></div>
                                </li>
                                <%} %>
                            </ul>
                        </div>
                    </div>
                    <script language="javascript">
                        jQuery(".slideBox2").slide({ mainCell: ".bd ul", effect: "fold", autoPlay: true });
                    </script>
                </div>
                <div class="mc1_bx1 mc1_bx3">
                    <div class="mc1_bx1L">
                        <div class="mpub_t1"><span class="mpub_t1name"><strong style="color:#445368;">聚焦CMA</strong><span class="cor_red"><span class="cor_hs">&nbsp;|&nbsp;Focus</span></span></span><a href="/artlist/16/" class="mpub_tmore" rel="nofollow">查看更多</a></div>
                        <%if (articleList1.Count > 0)
                          {%>
                        <div class="mc1_bxlTop">
                            <a class="fl" href="<%=ad4.Url %>" target="_blank">
                                <img src="<%=ad4.Pic %>" alt="<%=ad4.Notes %>" width="108" height="75" /></a>
                            <div class="mc1_bx1p1">
                                <%if (articleList1[0].IsHead)
                                  {%>
                                <a class="cor_reda">[优惠]</a>
                                <%}
                                  else
                                  { %><a class="cor_black">[通知]</a><%} %>
                                <a href="/article/<%=articleList1[0].Pkid %>.html" target="_blank" class="cor_red"><%=QianZhu.Utility.StringHelper.CutString(articleList1[0].Title, 26, "")%></a><br />
                                <%=QianZhu.Utility.StringHelper.CutString(articleList1[0].Files, 62, "")%>
                            </div>
                        </div>
                        <%} %>
                        <div class="mc1_u1">
                            <ul>
                                <% for (int i = 1; i < articleList1.Count; i++)
                                   {%>
                                <li><span class="fl">
                                    <%if (articleList1[i].IsHead)
                                      {%>
                                    <a class="mc3_a2">优惠</a>
                                    <%}
                                      else
                                      { %><a class="mc3_a1">通知</a><%} %>
                                    <a class="fl" href="/article/<%=articleList1[i].Pkid %>.html" target="_blank" title="<%=articleList1[i].Title %>"><%=QianZhu.Utility.StringHelper.CutString(articleList1[i].Title, 33, "")%></a></span><span class="fr">[<%=QianZhu.Utility.DateHelper.ToShortDate(articleList1[i].Pubdate)%>]</span></li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                    <div class="mc1_bx1R mc1_bx1Ra">
                        <div class="mpub_t1"><span class="mpub_t1name"><strong style="color:#445368;">精英推荐CMA</strong><span class="cor_red"><span class="cor_hs">&nbsp;|&nbsp;Elite</span></span></span><a href="/feel/4/" class="mpub_tmore" rel="nofollow">查看更多</a></div>

                        <%if (articleList2.Count > 0)
                          {%>
                        <div class="mc1_bxlTop">
                            <a class="fl" href="<%=ad5.Url %>" target="_blank">
                                <img src="<%=ad5.Pic %>" alt="<%=ad5.Notes %>" width="108" height="75" /></a>
                            <div class="mc1_bx1p1">
                                <a href="/feeldetail/<%=articleList2[0].Pkid %>.html" target="_blank" class="cor_red"><%=QianZhu.Utility.StringHelper.CutString(articleList2[0].Title, 31, "")%></a><br />
                                <%=QianZhu.Utility.StringHelper.CutString(articleList2[0].Files, 62, "")%>
                            </div>
                        </div>
                        <%} %>
                        <div class="mc1_u1">
                            <ul>
                                <% for (int i = 1; i < articleList2.Count; i++)
                                   {%>
                                <li><span class="fl"><a href="/feeldetail/<%=articleList2[i].Pkid %>.html" target="_blank" title="<%=articleList2[i].Title %>"><%=QianZhu.Utility.StringHelper.CutString(articleList2[i].Title, 43, "")%></a></span><span class="fr">[<%=QianZhu.Utility.DateHelper.ToShortDate(articleList2[i].Pubdate)%>]</span></li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="mc1_bx4">
                    <a class="fl" href="<%=ad6.Url %>" target="_blank">
                        <img src="<%=ad6.Pic %>" alt="<%=ad6.Notes %>" width="343" height="155" /></a>
                    <a class="fr" href="<%=ad7.Url %>" target="_blank">
                        <img src="<%=ad7.Pic %>" alt="<%=ad7.Notes %>" width="343" height="155" /></a>
                </div>
            </div>
            <div class="mR">
                <div class="mpub_t1"><span class="mpub_t1name" style="color:#445368;"><strong>CMA考试</strong><span class="cor_red"></span><span class="cor_hs">&nbsp;|&nbsp;CMA test</span></span></div>
                <div class="mrc1_u1">
                    <ul>
                        <li><a href="<%=ad12.Url%>" target="_blank">
                            <img src="/images/mc1r_1.jpg" alt="<%=ad12.Title%>" width="93" height="91" /></a></li>
                        <li><a href="/book.html">
                            <img src="/images/mc1r_2.jpg" width="93" height="91" /></a></li>
                        <li><a href="/book.html">
                            <img src="/images/mc1r_3.jpg" width="93" height="91" /></a></li>
                    </ul>
                </div>
                <div class="mrc1_u2">
                    <ul>
                        <%for (int i = 0; i < adFixedList6.Count; i++)
                          {%>
                        <li><a class="mrc1_a1" href="<%=adFixedList6[i].Url %>"><%=adFixedList6[i].Title %></a></li>
                        <%} %>
                    </ul>
                </div>
                <%--<div class="mrc1_t1">CMA高清网课试听</div>--%>
                <div class="mrc1_mv" style="padding:0px;">
                    <a href="http://www.bzcj.com/front/playkpoint/163?kpointId=989" target="_blank">
                       <img src="images/indexpage-videotry.jpg" width="100%" />
                    </a>                                      
                </div>
               <div class="mpub_t1" style="margin-top:86px;"><span class="mpub_t1name"><strong style="color:#445368;">学员分享</strong><span class="cor_red"><span class="cor_hs">&nbsp;|&nbsp;Share</span></span></span></div>
                <div class="mrc1_tx" style="margin-top: -4px;padding-top:0px;"><a href="http://www.hualingedu.com/feeldetail/1214.html" target="_blank">
                     <img src="images/index-liyao.jpg"  width="100%" />
                </div>
                <div class="mrc1_tx" style="padding-top: 3px;"><a href="http://www.hualingedu.com/feeldetail/1189.html" target="_blank">
                    <img src="images/index-wanglin.jpg" width="100%" />
                </div>
                <div class="mrc1_tx" style="padding-top: 3px;"><a href="http://www.hualingedu.com/feeldetail/1604.html" target="_blank">
                    <img src="images/index-gavin.jpg" width="100%" />
                </div>
                <%--<div class="mrc1_tx"><a href="<%=ad9.Url %>" target="_blank">
                    <img src="<%=ad9.Pic %>" alt="<%=ad9.Notes %>" width="294" height="424" /></a></div>--%>
            </div>
            <div class="clear"></div>
        </div>
<%--        <div class="mcban"><a href="<%=ad10.Url %>" target="_blank">
            <img src="<%=ad10.Pic %>" alt="<%=ad10.Notes %>" width="1050" height="90" /></a></div>--%>
        <div class="mcban">
            <a href="http://cn.mikecrm.com/7YYhriE" target="_blank">
                <img src="images/index-contact.jpg" width="1050" />
            </a>
        </div>
        <div class="mcon1 clearfix">
            <div class="mL">
                <div class="mlc2_bx1">
                    <a href="<%=ad11.Url %>" target="_blank">
                        <img src="<%=ad11.Pic %>" alt="<%=ad11.Notes %>" width="720" height="290" /></a>
                    <div class="mlc2_txt"><%=ad11.Notes %></div>
                </div>
                <div class="mlc2_bx2">
                    <div id="slideBox3" class="slideBox slideBox3">
                        <div class="hd">
                            <ul><%for (int i = 0; i < adFixedList3.Count; i++)
                                  {%><li><%=i+1 %></li>
                                <%} %></ul>
                        </div>
                        <div class="bd">
                            <ul>
                                <%for (int i = 0; i < adFixedList3.Count; i++)
                                  {%>
                                <li><a target="_blank" href="<%=adFixedList3[i].Url %>">
                                    <img src="<%=adFixedList3[i].Pic %>" alt="<%=adFixedList3[i].Title %>" /></a></li>
                                <%} %>
                            </ul>
                        </div>
                    </div>
                    <script language="javascript">
                        jQuery(".slideBox3").slide({ mainCell: ".bd ul", effect: "leftLoop", autoPlay: true });
                    </script>
                </div>
            </div>
            <div class="mR">
                <div class="mpub_t1"><span class="mpub_t1name" style="color:#445368;"><strong>精彩视频</strong><span class="cor_red"><span class="cor_hs">&nbsp;|&nbsp;Video</span></span></span><a class="mpub_tmore" href="/video/8/" rel="nofollow">查看更多</a></div>
                <div class="mrc1_u3">
                    <ul>
                        <% for (int i = 0; i < articleList3.Count; i++)
                           {
                               if (i > 1) continue;%>
                        <li>
                            <div class="mrc1_imgMv"><a target="_blank" href="/videodetail/<%=articleList3[i].Pkid %>.html">
                                <img src="<%=articleList3[i].Pic %>" alt="<%=articleList3[i].Title %>" width="138" height="90" /><img class="mrc1_ico" src="images/mvIco.png" width="32" height="32" /></a></div>
                            <a target="_blank" href="/videodetail/<%=articleList3[i].Pkid %>.html"><%=QianZhu.Utility.StringHelper.CutString(articleList3[i].Title, 17, "")%></a>
                        </li>
                        <%}%>
                    </ul>
                </div>
                <div class="mrc1_u4">
                    <ul>
                        <%if (articleList3.Count > 2)
                          {%>
                        <% for (int i = 2; i < articleList3.Count; i++)
                           {%>
                        <li><a target="_blank" href="/videodetail/<%=articleList3[i].Pkid %>.html"><%=QianZhu.Utility.StringHelper.CutString(articleList3[i].Title, 42, "...")%></a></li>
                        <%}
  }%>
                    </ul>
                </div>
                <div class="mpub_t1"><span class="mpub_t1name"><strong style="color:#445368;">IMA新闻</strong><span class="cor_red"><span class="cor_hs">&nbsp;|&nbsp;News</span></span></span><a href="/artlist/15/" class="mpub_tmore" rel="nofollow">查看更多</a></div>
                <div class="mrc1_u5">
                    <ul>
                        <% for (int i = 0; i < articleList4.Count; i++)
                           {%>
                        <li><a target="_blank" href="/clubdetail/<%=articleList4[i].Pkid %>.html" class="fl"><%=QianZhu.Utility.StringHelper.CutString(articleList4[i].Title, 31, "")%></a><span class="fr"><%=QianZhu.Utility.DateHelper.ToShortDate(articleList4[i].Pubdate)%></span></li>
                        <%}%>
                    </ul>
                </div>
            </div>
        </div>
        <!-- 标签切换 Start -->
        <div class="hoverTag mchg1">
            <div class="chgBtnList">
                <ul>
                    <li class="chgBtn chgCutBtn">合作伙伴</li>
                    <li class="chgBtn">友情链接</li>
                </ul>
            </div>
            <div class="chgConList">
                <div class="chgCon">
                    <a class="mpub_tmore mpub_tmore2" href="/partner/" rel="nofollow">查看更多</a>
                    <img class="mc3_btn1 prev" src="/images/mbtn3.jpg" width="21" height="62" />
                    <div class="mc3ImgBox">
                        <ul>
                            <%for (int i = 0; i < adFixedList4.Count; i++)
                              {%>
                            <li>
                                <img src="<%=adFixedList4[i].Pic %>" alt="<%=adFixedList4[i].Title %>" width="161" height="58" /></li>
                            <%} %>
                        </ul>
                    </div>
                    <img class="mc3_btn2 next" src="/images/mbtn3a.jpg" width="21" height="62" />
                </div>
                <div class="chgCon">
                    <a class="mpub_tmore2" href="#"></a>
                    <div class="mnn_con1">
                        <%for (int i = 0; i < adFixedList5.Count; i++)
                          {%>
                        <a href="<%=adFixedList5[i].Url %>" target="_blank"><%=adFixedList5[i].Title %></a><%if (i < adFixedList5.Count - 1)
                                                                                                             {%> |  <%} %>
                        <%} %>
                    </div>
                </div>
            </div>
        </div>
        <script language="javascript">
            jQuery(".mchg1 .chgCon").slide({ titCell: "", mainCell: ".mc3ImgBox ul", autoPage: true, effect: "leftLoop", autoPlay: true, vis: 5 });
            $(".mchg1 .chgCon").hide(); $(".mchg1 .chgCon").eq(0).show();
        </script>
        <!-- 标签切换 End -->

        <div class="clear"></div>
    </div>
    <a href="http://lwt.zoosnet.net/LR/Chatpre.aspx?id=LWT91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0" id="floatdiv"style='background-color: #0d7bb2;'>
        	<img src="floatimg.png"/>
        </a>
</asp:Content>
