<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="article.aspx.cs" Inherits="article" EnableViewState="false" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style type="text/css">
            #floatdiv {
            	display: block;
                position: fixed;
                bottom: 0;
                background-color: #0d7bb2;
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
            .btn{
            	width: 150px;
    			margin-bottom: -6px;
    			margin-left: 20px;
            }
            .bar{
            	width: 750px;
            }
            .green-btn,.green-btn:hover{
				display: inline-block;
				width: 120px;
				height: 32px;
				line-height: 32px;
				font-size: 16px;
				color: #FFFFFF;
				border-radius: 200px;
				text-decoration:none;
				background-color: #00a2ff;
				text-align: center;
				margin: 12px 22px;
			}
			.linka{
				width: 190px;
				display: inline-block;
				height: 20px;
				margin: 16px 0;
				line-height: 20px;
				font-size:16px;
				text-decoration:none;
				color: #555555;
				border-left: 4px solid #ff8a00;
				padding-left: 10px;
			}
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
<div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
 <div class="m2pos"><span class="m2name">新闻<span class="cor_red">资讯</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="<%=category.Url %>">新闻资讯</a> > <a href="<%=category.Url %>"><%=category.Title %></a></span></div>
 <h2 class="m2new_h2"><%=model.Title %></h2>
 <div class="m2new_info">发布时间：<%=QianZhu.Utility.DateHelper.ToShortDate(model.Pubdate) %> &nbsp;&nbsp; 来源：<%= model.Source %>&nbsp;&nbsp; 发布者：<%= model.Author %>  <a href="http://lwt.zoosnet.net/LR/Chatpre.aspx?id=LWT91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0"><img class="btn" src="../btn.png"/></a></div>
 <div class="bar" style="border: 1px solid #aaaaaa;box-sizing: border-box;padding: 18px 5px;">
			<img src="../5img.png" style="width: 290px; height: 180px;"/>
			<div style="padding-left:20px; width: 420px; height: 180px; display: inline-block;">
				<a class="linka" href="http://www.hualingedu.com/wtdetail/897.html">2018CMA考试日期</a>
				<a class="linka" href="http://www.hualingedu.com/aboutcma2.html">CMA在中国被认可吗</a>
				<a class="linka" href="http://www.hualingedu.com/article/1515.html">2018CMA考试报名时间</a>
				<a class="linka" href="http://www.hualingedu.com/wtdetail/1127.html">CMA证书含金量</a>
				<a class="linka" href="http://www.hualingedu.com/wtdetail/1161.html">2018CMA考试地点</a>
				<a class="linka" href="http://www.hualingedu.com/wtdetail/1509.html">CMA适合哪些人考？</a>
				<a class="linka" href="http://www.hualingedu.com/wtdetail/1208.html">2018CMA考试费</a>
				<a class="linka" href="http://www.hualingedu.com/wtdetail/1177.html">CMA通过率</a>
			</div>
		</div>
 <div class="m2new_editor">
   <%= model.Content %>
 <div class="clear"></div>
 </div>
 <div class="bar" style="background-image: url('../bg-more.jpg');height: 233px;background-size: cover;text-align: center;">
			<span style="color: #FFF;line-height: 54px;font-size: 24px;">对此我们还有更多问题</span>
			<div style="text-align: center;">
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA的影响力</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA课程体系</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA人才缺口</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA薪资待遇</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA企业招聘</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA考试语言</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA考试地点</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA持续教育</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA考试题型</a>
				<a class="green-btn" href="http://lwt.zoosnet.net/lr/chatpre.aspx?id=lwt91490211&lng=cn&p=%e4%ba%94%e6%8a%98%e4%bc%98%e6%83%a0&r=&rf1=http%3A//www.hualingedu&rf2=.com/&cid=1514472454230605574286&sid=1516683502359542111407">CMA通过率</a>
			</div>
		</div>
 <div class="m2new_res">
 <!-- Baidu Button BEGIN -->
<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
<a class="bds_qzone"></a>
<a class="bds_tsina"></a>
<a class="bds_tqq"></a>
<a class="bds_renren"></a>
<a class="bds_t163"></a>
<span class="bds_more">更多</span>
<a class="shareCount"></a>
</div>
<script type="text/javascript" id="bdshare_js" data="type=tools&uid=6478904" ></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
</script>
<!-- Baidu Button END -->
 </div>
<div class="mpage2">
<span class="fl" id="Prev" runat="server" enableviewstate="false"></span>
 <span class="fr" id="Next" runat="server" enableviewstate="false"></span>
</div>

<img class="bar" src="../erwei.png"/>
  <a href="http://www.hualingedu.com/xyzt1/ "><img class="bar" src="../guanggao.png"/></a>
</div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
<a href="http://cn.mikecrm.com/17K2vxt" id="floatdiv">
        	<img src="../floatimg.png"/>
        </a>
</asp:Content>
