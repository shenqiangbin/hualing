<%@ Page Language="C#" AutoEventWireup="true" CodeFile="filespecEdit.aspx.cs" Inherits="admin_dev_filespecEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/admin/skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="/admin/skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="/plugin/uploadify/uploadify.css"rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/plugin/autoimg/jquery.autoImg.js" type="text/javascript"></script>
    <script src="/plugin/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="/admin/ajax/ajax.js" type="text/javascript"></script>
    <script src="/admin/js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("[name=NameType]:radio").each(function() {
                $(this).click(function(e) {
                    if ($(this).val() == "1") $("#NameFormat").show();
                    else {
                        $("#NameFormat").val("");
                        $("#NameFormat").hide();
                    }
                });
            });

            $(".filespec").next().click(function(e) {
                var reg = new RegExp("#", "g");
                $(".filespec").append($(".demo").html().replace(reg, "#" + count.toString()));
                count++;
            });

            if (isNull(getQueryString("pkid"))) $(".filespec").next().trigger("click");
            else if (isNull($("#NameFormat").val())) $("[name=NameType]:radio:eq(0)").trigger("click");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <div class="help">
        <table>
          <tr>
            <td>
              关于“上传路径”和“文件名格式”填写方法的说明：<br />
              1. 大括号 { } 内的字符代表变量，有特殊含义，大括号之外的字符为常规字符，常规字符只能使用字母、数字、下划线组合。<br />
              2. 大括号内字符变量含义：y - 年，M - 月，d - 日，h - 时，m - 分，s - 秒，r - 随机数，所有字符变量区分大小写。<br />
              3. 随机数字符变量 r 后面必须跟随数字来表示位数，例如 r6 表示6位随机数。<br />
              4. 文件名格式如使用“原名”，上传文件时可能会出现同名文件被覆盖的情况。
            </td>
          </tr>
        </table>
      </div>
      <h1>文件规格管理 - <%= myhead %></h1>
      <ul class="tabs">
        <li>帮助</li>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="filespecManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="110">规格名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写文件规格名称" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
          <td class="gray">为该文件规格起名，可以是中文名</td>
        </tr>
        <tr>
          <td>代码<span class="fill">*</span></td>
          <td><input id="MyCode" type="text" style="width:300px;" maxlength="20" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator2" runat="server" ControlToValidate="MyCode" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写文件代码" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                  ControlToValidate="MyCode" Display="None" EnableViewState="False" 
                  ErrorMessage="文件代码只能使用字母、数字、下划线组合" SetFocusOnError="True" 
                  ValidationExpression="^\w+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">文件规格的唯一标识，只能使用字母、数字、下划线组合表示</td>
        </tr>
        <tr>
          <td>文件格式<span class="fill">*</span></td>
          <td><input id="FileFormat" type="text" style="width:300px;" maxlength="50" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator3" runat="server" ControlToValidate="FileFormat" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写文件格式" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                  ControlToValidate="FileFormat" Display="None" EnableViewState="False" 
                  ErrorMessage="文件格式填写有误，正确写法如：jpg|gif|png" SetFocusOnError="True" 
                  ValidationExpression="^([a-zA-Z]+\|)*[a-zA-Z]+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">填写文件后缀名，多个用“|”分隔，例如：jpg|gif|png</td>
        </tr>
        <tr>
          <td>文件大小</td>
          <td>不能超过 <input id="Filesize" type="text" style="width:60px;" maxlength="8" class="text" runat="server" enableviewstate="false" /> KB<asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator3" runat="server" ControlToValidate="Filesize" 
                  Display="None" EnableViewState="False" ErrorMessage="文件大小应使用数字填写" 
                  SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">使用数字填写，不填或填“0”表示无限制</td>
        </tr>
        <tr>
          <td>上传路径<span class="fill">*</span></td>
          <td><input id="SavePath" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator4" runat="server" ControlToValidate="SavePath" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写上传路径" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator4" runat="server" ControlToValidate="SavePath" 
                  Display="None" EnableViewState="False" ErrorMessage="上传路径格式错误" 
                  SetFocusOnError="True" ValidationExpression="^\/((\w+|{[yMdhms]+})\/)+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">格式：/upload/images/{yyyyMM}/{dd}/</td>
        </tr>
        <tr>
          <td>文件名格式</td>
          <td>
              <asp:RadioButtonList ID="NameType" runat="server" 
                  RepeatDirection="Horizontal" RepeatLayout="Flow">
                  <asp:ListItem Value="0">原名</asp:ListItem>
                  <asp:ListItem Selected="True" Value="1">自定义</asp:ListItem>
              </asp:RadioButtonList>
              <input id="NameFormat" type="text" style="width:120px;" maxlength="30" class="text" runat="server" enableviewstate="false" />
              <asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator5" runat="server" ControlToValidate="NameFormat" 
                  Display="None" EnableViewState="False" ErrorMessage="文件名格式错误" 
                  SetFocusOnError="True" ValidationExpression="^(\w*({([yMdhms]+|r\d+)})*\w*)*$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">格式：logo、{yyyyMMddhhmmss}、{hhmmss}{r4}，不填写表示用原名</td>
        </tr>
        <tr>
          <td>图片水印功能开关</td>
          <td><asp:RadioButtonList id="WmSwitch" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                <asp:ListItem Value="0">关闭</asp:ListItem>
                <asp:ListItem Value="1">文字水印</asp:ListItem>
                <asp:ListItem Value="2">图片水印</asp:ListItem>
              </asp:RadioButtonList></td>
          <td class="gray">水印仅对图片文件有效</td>
        </tr>
        <tr>
          <td>水印位置</td>
          <td><select id="WmAlign" runat="server"></select></td>
          <td class="gray">选择在在图片上加盖水印的位置</td>
        </tr>
        <tr>
          <td>水印透明度</td>
          <td><input id="WmTransparent" type="text" style="width:50px;" maxlength="3" class="text" runat="server" enableviewstate="false" /> %
              <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" 
                ControlToValidate="WmTransparent" Display="None" EnableViewState="False" 
                ErrorMessage="水印透明度应使用数字填写" SetFocusOnError="True" 
                ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">透明度值为 0% - 100%，100为不透明，0为完全透明</td>
        </tr>
        <tr>
          <td>水印文字</td>
          <td><input id="WmText" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">填写用于水印的文字内容，例如：本图由 1000zhu.com 提供</td>
        </tr>
        <tr>
          <td>文字样式</td>
          <td>大小：<input id="WmTextSize" type="text" style="width:50px;" maxlength="2" class="text" runat="server" enableviewstate="false" /> 像素　
              <select id="WmTextColor" class="mid" runat="server"></select>　
              <select id="WmTextFont" class="mid" runat="server"></select>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" 
                  ControlToValidate="WmTextSize" Display="None" EnableViewState="False" 
                  ErrorMessage="文字大小应使用数字填写" SetFocusOnError="True" 
                  ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">设置用于水印的文字样式</td>
        </tr>
        <tr id="logoTr">
          <td>水印图片</td>
          <td>
	        <input id="WmImage" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= WmImage.ClientID %>").QzImageUpload({
	                "code": "<%= watermarkSpec.Code %>",
	                "fileExt": "<%= watermarkSpec.FileExt %>",
	                "sizeLimit": "<%= watermarkSpec.Filesize %>"
	            });
            </script>
          </td>
          <td class="gray">图片格式 <%= watermarkSpec.FileFormat.Replace("|", " | ")%>，图片大小 <%= watermarkSpec.Filesize%> KB 以内</td>
        </tr>
        <tr>
          <td>缩略图生成设置</td>
          <td>
            <ul class="filespec">
              <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false">
                <ItemTemplate>
                <li>
                  宽 <input name="thumwidth<%# Container.ItemIndex %>" type="text" value="<%# GetDataItem().ToString().Split(new char[] { ',' })[0] %>" style="width:50px;" maxlength="8" class="text" /> px ×
                  高 <input name="thumheight<%# Container.ItemIndex %>" type="text" value="<%# GetDataItem().ToString().Split(new char[] { ',' })[1] %>" style="width:50px;" maxlength="8" class="text" /> px&nbsp;
                  <input name="thumwm<%# Container.ItemIndex %>" value="1" type="checkbox" <%# GetDataItem().ToString().Split(new char[] { ',' })[2] == "1" ? "checked=\"checked\"" : "" %> /> 允许水印
                  <input type="button" onclick="$(this).parent().remove();" onfocus="blur()" title="删除" class="del" />
                </li>
                </ItemTemplate>
              </asp:Repeater>
            </ul>
            <a href="javascript:;" class="icon2 icon_add"> 新增尺寸</a>
          </td>
          <td class="gray">仅针对图片文件有效，控制其各种缩略图尺寸，上传时系统自动生成</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
    
    <div class="demo">
      <li>
        宽 <input name="thumwidth#" type="text" style="width:50px;" maxlength="8" class="text" /> px ×
        高 <input name="thumheight#" type="text" style="width:50px;" maxlength="8" class="text" /> px&nbsp;
        <input name="thumwm#" value="1" type="checkbox" /> 允许水印
        <input type="button" onclick="$(this).parent().remove();" onfocus="blur()" title="删除" class="del" />
      </li>
    </div>
</body>
</html>