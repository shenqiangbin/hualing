<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" EnableViewState="false" %>

<%@ Import Namespace="QianZhu.Utility" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                        <div class="mpub_t1"><span class="mpub_t1name"><strong>新闻</strong><span class="cor_red">资讯</span><span class="cor_hs">/News</span></span><a href="/artlist/14/" class="mpub_tmore" rel="nofollow">查看更多</a></div>

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
                        <div class="mpub_t1"><span class="mpub_t1name"><strong>最新</strong><span class="cor_red">课程</span><span class="cor_hs">/Course</span></span><a href="/table17.html" class="mpub_tmore" rel="nofollow">查看更多</a></div>
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
                        <div class="mpub_t1"><span class="mpub_t1name"><strong>考试</strong><span class="cor_red">资讯</span></span><a href="/artlist/16/" class="mpub_tmore" rel="nofollow">查看更多</a></div>
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
                        <div class="mpub_t1"><span class="mpub_t1name"><strong>考试</strong><span class="cor_red">心得</span></span><a href="/feel/4/" class="mpub_tmore" rel="nofollow">查看更多</a></div>

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
                <div class="mpub_t1"><span class="mpub_t1name"><strong>CMA</strong><span class="cor_red">考试</span><span class="cor_hs">/CMA test</span></span></div>
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
                <div class="mrc1_t1">试听视频 Video</div>
                <div class="mrc1_mv">
                    <!-- video Button start -->
                    <div class="BBCOMVideoEmbed" style="margin: 0 auto; width: 280px; height: 209px;">
                        <script type="text/javascript" src="/js/swfobject.js"></script>
                        <div id="CuPlayer" style="margin-left:-5px;">
                            <object type="application/x-shockwave-flash" data="http://static.youku.com/v1.0.0473/v/swf/loader.swf" width="285" height="255" id="movie_player">
                                <param name="allowFullScreen" value="true">
                                <param name="allowscriptaccess" value="always">
                                <param name="flashvars" value="VideoIDS=XNzU0NzM1MTQw&amp;ShowId=0&amp;category=87&amp;Cp=0&amp;Light=on&amp;THX=off&amp;unCookie=0&amp;frame=0&amp;pvid=1413804889866WjQ&amp;uepflag=0&amp;Tid=0&amp;isAutoPlay=false&amp;Version=/v1.0.0991&amp;show_ce=0&amp;winType=interior&amp;embedid=AjE4ODY4Mzc4NQJ3d3cuc29rdS5jb20CL3NlYXJjaF92aWRlby9xX0NNQSUyMCVFNSU4RCU4RSVFOSVBMiU4Ng==&amp;vext=bc%3D%26pid%3D1413804889866WjQ%26unCookie%3D0%26frame%3D0%26type%3D0%26svt%3D0%26emb%3DAjE4ODY4Mzc4NQJ3d3cuc29rdS5jb20CL3NlYXJjaF92aWRlby9xX0NNQSUyMCVFNSU4RCU4RSVFOSVBMiU4Ng%3D%3D%26dn%3D%E7%BD%91%E9%A1%B5%26hwc%3D1%26mtype%3Doth">
                                <param name="movie" value="http://static.youku.com/v1.0.0473/v/swf/loader.swf">
                                <div class="player_html5">
                                    <div class="picture" style="height: 100%">
                                        <div style="line-height: 460px;"><span style="font-size: 18px">您还没有安装flash播放器,请点击<a href="http://www.adobe.com/go/getflash" target="_blank" rel="nofollow">这里</a>安装</span></div>
                                    </div>
                                </div>
                            </object>
                        </div>
                        <%--<script type="text/javascript">
                                    var so = new SWFObject("/swf/CuPlayerMiniV20_Gray_S.swf", "CuPlayer", "280", "209", "9", "#000000");
                                    so.addParam("allowfullscreen", "true");
                                    so.addParam("allowscriptaccess", "always");
                                    so.addParam("wmode", "opaque");
                                    so.addParam("quality", "high");
                                    so.addParam("salign", "lt");
                                    so.addVariable("CuPlayerFile", "<%=video%>");
                                    so.addVariable("CuPlayerImage", "/images/adasdasdasdsa123.png");
                                    so.addVariable("CuPlayerShowImage", "false");
                                    so.addVariable("CuPlayerWidth", "280");
                                    so.addVariable("CuPlayerHeight", "209");
                                    so.addVariable("CuPlayerAutoPlay", "false");
                                    so.addVariable("CuPlayerAutoRepeat", "true");
                                    so.addVariable("CuPlayerShowControl", "true");
                                    so.addVariable("CuPlayerAutoHideControl", "false");
                                    so.addVariable("CuPlayerAutoHideTime", "6");
                                    so.addVariable("CuPlayerVolume", "80");
                                    so.write("CuPlayer");	
                                </script>--%>
                    </div>
                    <!-- video Button END -->
                </div>
                <div class="mrc1_tx"><a href="<%=ad9.Url %>" target="_blank">
                    <img src="<%=ad9.Pic %>" alt="<%=ad9.Notes %>" width="294" height="424" /></a></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="mcban"><a href="<%=ad10.Url %>" target="_blank">
            <img src="<%=ad10.Pic %>" alt="<%=ad10.Notes %>" width="1050" height="90" /></a></div>
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
                <div class="mpub_t1"><span class="mpub_t1name"><strong>精彩</strong><span class="cor_red">视频</span></span><a class="mpub_tmore" href="/video/8/" rel="nofollow">查看更多</a></div>
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
                <div class="mpub_t1"><span class="mpub_t1name"><strong>管理会计</strong><span class="cor_red">俱乐部</span></span><a href="/club/5/" class="mpub_tmore" rel="nofollow">查看更多</a></div>
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
</asp:Content>
