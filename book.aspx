<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="book.aspx.cs" Inherits="book" %>
<%@ Register Src="~/inc/banner.ascx" TagName="banner" TagPrefix="uc1" %>
<%@ Register Src="~/inc/Right.ascx" TagName="Right" TagPrefix="uc1" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <script src="/js/qz.select.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <div class="banBg banBg2">
<uc1:banner ID="banner1" runat="server" />
</div>
<div class="main">
<div class="m2L">
 <div class="m2pos"><span class="m2name">CMA<span class="cor_red">培训</span></span><span class="m2posR">当前位置：<a href="/">首页</a> > <a href="#">CMA培训</a></span></div>
 <div class="m2reg_t1">在线报名</div>
 <div class="m2reg_ul">
 <form id="Form1" runat="server">
 <ul>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 意向课程：</span><input class="m2reg_int1" name="" type="text" id="yix" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 姓名：</span><input class="m2reg_int1" name="" type="text" id="names" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1">性别：</span><input name="sex" type="radio" class="m2reg_rad" value="男" checked="checked" /> 男 &nbsp;&nbsp; <input name="sex" type="radio" class="m2reg_rad" value="女" /> 女</li>
  <li><span class="m2reg_s1">年龄：</span><input class="m2reg_int1" name="" type="text" id="bristh" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1">单位：</span><input class="m2reg_int1" name="" type="text" id="unit" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1">职务：</span><input class="m2reg_int1" name="" type="text" id="zw" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1"><span class="cor_red">*</span> 手机：</span><input class="m2reg_int1" name="" type="text" id="tel" runat="server" enableviewstate="false" okeyup ="if(isNaN(value))execCommand('undo')" /></li>
  <li><span class="m2reg_s1">邮箱：</span><input class="m2reg_int1" name="" type="text" id="Email" runat="server" enableviewstate="false"/></li>
  <li><span class="m2reg_s1">地区：</span>
  <input class="m2reg_int1" id="AreaId" type="text" runat="server" enableviewstate="false" />
                  <script type="text/javascript">
                      $("#<%= AreaId.ClientID %>").QzSelect({
                          dataSource: "/ajax/getAreaData.ashx",
                          chooseEnd: true,
                          titles: "选择省,选择市"
                      });
                  </script>
  </li>
  <li><span class="m2reg_s1">备注：</span><textarea class="m2reg_area" name="" cols="11" rows="5" id="bz" runat="server" enableviewstate="false"></textarea><div class="clear"></div></li>
  <li><span class="m2reg_s1">验证码：</span><input class="m2reg_int1 m2reg_int2" name="" type="text" id="code" runat="server" enableviewstate="false"/>
    <a class="m2reg_coder" href="javascript:void(-1);" onclick="changeimg();return false;"><img src="/Validate.aspx" id="validimg"  width="62" height="25" /></a> &nbsp; <a class="m2reg_a1" href="javascript:void(-1);" onclick="changeimg();return false;">看不清换一个</a></li>
  <li class="m2reg_btnBox"><span class="m2reg_s1">&nbsp;</span>
  <asp:Button ID="SubminButton" runat="server" CssClass="m2reg_submit" onclick="SubminButton_Click" />
  </li>
   <asp:RequiredFieldValidator  ID="RequiredFieldValidator1" runat="server" ErrorMessage="请输入意向课程" Display="None" EnableViewState="False" ControlToValidate="yix"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator  ID="RequiredFieldValidator6" runat="server" ErrorMessage="请输入姓名" Display="None" EnableViewState="False" ControlToValidate="names"></asp:RequiredFieldValidator>
 
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tel" 
            Display="None" EnableViewState="False" ErrorMessage="请输入手机" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>    
             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
            ControlToValidate="tel" Display="None" EnableViewState="False" 
            ErrorMessage="手机格式输入不正确" SetFocusOnError="True" 
            ValidationExpression="1[3|5|7|8|][0-9]{9}"></asp:RegularExpressionValidator>    
        <asp:RequiredFieldValidator  ID="RequiredFieldValidator8" runat="server" ControlToValidate="code" 
            Display="None" EnableViewState="False" ErrorMessage="请输入验证码" 
            SetFocusOnError="True"></asp:RequiredFieldValidator>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"   
            EnableViewState="False" ShowMessageBox="true" ShowSummary="False" />

 </ul>  </form>
 <div class="clear"></div>
 </div>
 <div class="m2reg_bx1">
 <span class="f14 cor_red">注意事项：</span><br />
1. 请仔细如实填写在线报名信息，以便我们及时与您取得联系；<br />
2. 每期班级名额有限，所以请尽早确认并提交您的报名信息；<br />
3. 在您提交信息后，华领CMA课程顾问将在一个工作日内与您取得联系，请您耐心等待。
<p class="m2reg_alr">注意：提交之前请检查以上报名信息是否正确，填写完毕后请按"提交信息"按钮。</p>
 </div>
 <div class="m2reg_bx2">
 <span class="cor_red">你也可以通过以下方式联系我们：</span><br />
电话：400-109-9900<br />
邮箱：marketing-1@hualingedu.com<br />
地址：北京市海淀区北四环西路9号银谷大厦816/818
 </div>
</div>
<uc1:Right ID="Right1" runat="server" />
<div class="clear"></div>
</div>
<script type="text/javascript">
function changeimg() {
var img = $("#validimg").get(0);
img.src = "/Validate.aspx?tmp=" + parseInt(Math.random() * 9000 + 1000);
}
</script>
</asp:Content>