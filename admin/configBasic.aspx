<%@ Page Language="C#" AutoEventWireup="true" CodeFile="configBasic.aspx.cs" Inherits="admin_configBasic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="/plugin/uploadify/uploadify.css"rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.config.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.all.js" type="text/javascript"></script>
    <script src="/plugin/autoimg/jquery.autoImg.js" type="text/javascript"></script>
    <script src="/plugin/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>站点基本设置</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">网站标题</td>
          <td width="350"><input id="PageTitle" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">显示在浏览器的标题栏中，也作为搜索引擎抓取的重要信息</td>
        </tr>
        <tr>
          <td>Meta Keywords</td>
          <td><input id="Keywords" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">用于优化的首页关键词，多个关键词用半角逗号 " , " 分隔</td>
        </tr>
        <tr>
          <td>Meta Description</td>
          <td><textarea id="Descn" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">用于优化的描首页述信息，建议控制在100字以内</td>
        </tr>
        <tr>
          <td>CMA网站Logo</td>
          <td>
	        <input id="ForeLogo" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= ForeLogo.ClientID %>").QzImageUpload({
	                "code": "<%= foreLogoSpec.Code %>",
	                "fileExt": "<%= foreLogoSpec.FileExt %>",
	                "sizeLimit": "<%= foreLogoSpec.Filesize %>",
	                "imgHeight": 100
	            });
            </script>
          </td>
          <td class="gray">
            网站前台的Logo，展示给浏览者，以体现网站形象的标志<br />
            图片格式 <%= foreLogoSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= foreLogoSpec.Filesize %> KB 以内
          </td>
        </tr>
        <tr>
          <td>内训Logo</td>
          <td>
	        <input id="ForeLogo2" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= ForeLogo2.ClientID %>").QzImageUpload({
	                "code": "<%= foreLogoSpec2.Code %>",
	                "fileExt": "<%= foreLogoSpec2.FileExt %>",
	                "sizeLimit": "<%= foreLogoSpec2.Filesize %>",
	                "imgHeight": 100
	            });
            </script>
          </td>
          <td class="gray">
            网站前台的Logo，展示给浏览者，以体现网站形象的标志<br />
            图片格式 <%= foreLogoSpec2.FileFormat.Replace("|", " | ") %>，图片大小 <%= foreLogoSpec2.Filesize %> KB 以内
          </td>
        </tr>
        <tr>
          <td>后台Logo</td>
          <td>
	        <input id="BackLogo" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= BackLogo.ClientID %>").QzImageUpload({
	                "code": "<%= backLogoSpec.Code %>",
	                "fileExt": "<%= backLogoSpec.FileExt %>",
	                "sizeLimit": "<%= backLogoSpec.Filesize %>",
	                "imgWidth": 240,
	                "imgHeight": 60
	            });
            </script>
          </td>
          <td class="gray">
            网站后台的Logo，只有管理员能看到，在本页的左上角<br />
            图片格式 <%= backLogoSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= backLogoSpec.Filesize %> KB 以内
          </td>
        </tr>
        <tr>
          <td>网站备案号</td>
          <td><input id="Icp" type="text" style="width:300px;" maxlength="100" class="text" runat="server" enableviewstate="false" /></td>
          <td class="gray">若您的网站已通过备案，可在此输入备案号</td>
        </tr>
        <tr>
          <td valign="top">CMA页脚信息</td>
          <td colspan="2"><textarea id="Foot" runat="server" enableviewstate="false"></textarea>
            <script type="text/javascript">
                UE.getEditor("<%= Foot.ClientID %>", { initialFrameHeight: 120,
                    toolbars: [
                    ['undo', 'redo', '|', 'bold', 'italic', 'underline', 'strikethrough', '|', 'forecolor', 'selectall',
                    'removeformat', 'cleardoc', '|', 'fontfamily', 'fontsize', '|', 'link', 'unlink', '|', 'spechars']]
                });
            </script>
          </td>
        </tr>
         <tr>
          <td valign="top">内训页脚信息</td>
          <td colspan="2"><textarea id="Foot2" runat="server" enableviewstate="false"></textarea>
            <script type="text/javascript">
                UE.getEditor("<%= Foot2.ClientID %>", { initialFrameHeight: 120,
                    toolbars: [
                    ['undo', 'redo', '|', 'bold', 'italic', 'underline', 'strikethrough', '|', 'forecolor', 'selectall',
                    'removeformat', 'cleardoc', '|', 'fontfamily', 'fontsize', '|', 'link', 'unlink', '|', 'spechars']]
                });
            </script>
          </td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    </form>
</body>
</html>