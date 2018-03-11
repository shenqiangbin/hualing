<%@ Page Language="C#" AutoEventWireup="true" CodeFile="articleEdit.aspx.cs" Inherits="admin_articleEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <link href="/plugin/uploadify/uploadify.css"rel="stylesheet" type="text/css" />
    <link href="/plugin/datainput/dateInput.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/js/qz.select.js" type="text/javascript"></script>
    <script src="/plugin/datainput/jquery.dateInput.js" type="text/javascript"></script>
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
      <h1>文章管理 - <%=myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="articleManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">标题<span class="fill">*</span></td>
          <td><input id="MyTitle" type="text" style="width:400px" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写标题" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td width="350"></td>
        </tr>
        <%if (cid == "3")
          {%>
        <tr>
          <td>类别<span class="fill">*</span></td>
          <td><input id="CategoryId" type="text" runat="server" enableviewstate="false" />
              <script type="text/javascript">
              var cid="<%=cid %>";
                  $("#<%= CategoryId.ClientID %>").QzSelect({
                    dataSource: "ajax/getCategoryData.ashx",
                    fatherId: cid,
                    chooseEnd: true
                  });
              </script>
          </td>
          <td></td>
        </tr>
        <%} %>
        <%if (cid == "3" || cid == "6" || cid == "7")
          {%>
        <tr>
          <td>来源</td>
          <td><input id="Source" type="text" style="width:150px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>作者</td>
          <td><input id="author" type="text" style="width:150px;" maxlength="50" class="text" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <%} %>
       <%if (cid !="1")
         {%>
        <tr>
          <td>Meta Keywords</td>
          <td><input id="Keywords" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">用于优化的关键词，多个关键词用半角逗号 " , " 分隔</td>
        </tr>
        <tr>
          <td>Meta Description</td>
          <td><textarea id="Descn" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">用于优化的描述信息，建议控制在100字以内</td>
        </tr>
       <% } %>
       <%if (cid != "5" && cid != "6" && cid != "7")
         {%>
          <tr>
          <td> 概述</td>
          <td><textarea id="files" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray"></td>
        </tr>
       
       <%} %>
        
            <%--<tr>
            <td><u>上传视频文件</u><br />(文件支持flv格式)</td>
            <td>
            <input id="flash" type="text" runat="server" enableviewstate="false" class="hide" />
            <script type="text/javascript">
                $("#<%= flash.ClientID %>").QzVideoUpload({
                    "code": "<%= filespec2.Code %>",
                    "fileExt": "<%= filespec2.FileExt %>",
                    "sizeLimit": "<%= filespec2.Filesize %>"
                });
            </script></td>
            </tr>--%>
          <%if (cid != "1" && cid != "6" && cid != "7")
            {%>
          <tr>
          <td>标题图片</td>
          <td>
	        <input id="Pic" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
                $("#<%= Pic.ClientID %>").QzImageUpload({
                    "code": "<%= filespec.Code %>",
                    "fileExt": "<%= filespec.FileExt %>",
                    "sizeLimit": "<%= filespec.Filesize %>"
                });
            </script>
	      </td>
	      <td class="gray">图片格式 <%= filespec.FileFormat.Replace("|", " | ")%>，图片大小 <%= filespec.Filesize%> KB 以内,新闻(196*120) 俱乐部(320*216) 名师(120*150) 心得(140*169) 专题(460*280)</td>
        </tr>
       <%} %>
       
        <tr>
          <td>发布日期</td>
          <td>
            <input id="Pubdate" type="text" readonly="readonly" class="text date" runat="server" enableviewstate="false" />
            <script type="text/javascript">
                $("#<%= Pubdate.ClientID %>").date_input();
            </script>
          </td>
          <td class="gray">不填写则默认为当前日期</td>
        </tr>
        
     
        <tr>
          <td valign="top">正文内容<span class="fill">*</span></td>
          <td colspan="2"><textarea id="MyContent" runat="server" enableviewstate="false"></textarea>
              <script type="text/javascript">
                  UE.getEditor("<%= MyContent.ClientID %>", {});
              </script>
            </td>
        </tr>
        
        
        
        <tr>
          <td>设置置顶</td>
          <td><asp:CheckBox ID="IsTop" runat="server" Text="将本条信息设为置顶" /></td>
          <td></td>
        </tr>
        <tr>
          <td>自定义排序</td>
          <td><input id="Sort" type="text" class="text" maxlength="8" value="1" style="width:100px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">最小序号为 “ 1 ”，序号越大则显示位置越靠前</td>
        </tr>
          <%if (cid == "3"){%>
        <tr>
          <td>设置优惠</td>
          <td><asp:CheckBox ID="isHead" runat="server" Text="将本条信息设为优惠，默认是通知" /></td>
          <td></td>
        </tr>
        <%} %>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>