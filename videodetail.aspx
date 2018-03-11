﻿<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="videodetail.aspx.cs" Inherits="videodetail" EnableViewState="false" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
<div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
 <div class="m2pos"><span class="m2name">关于<span class="cor_red">华领</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="/aboutus10.html">关于华领</a> > <a href="<%=category.Url %>"><%=category.Title %></a></span></div>
 <h2 class="m2new_h2"><%=model.Title %></h2>
 <div class="m2new_info"> </div>
 <div class="m2new_editor">
   <%= model.Content %>
 <div class="clear"></div>
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
</div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
</asp:Content>
