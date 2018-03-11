<%@ Page Language="C#" AutoEventWireup="true" CodeFile="projectEdit.aspx.cs" Inherits="admin_projectEdit" %>

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
    <script type="text/javascript">
        var editor;
        function formSubmit() {
            saveContent(editor);
            beforeSubmit();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="formSubmit();">
    <div id="top">
      <h1><%= groupName %>管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="projectManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100"><%= groupName %>名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写<%= groupName %>名称" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>所属类别<span class="fill">*</span></td>
          <td><input id="CategoryId" type="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator2" runat="server" ControlToValidate="CategoryId" 
                  Display="None" EnableViewState="False" ErrorMessage="请选择所属类别" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <script type="text/javascript">
                  $("#<%= CategoryId.ClientID %>").QzSelect({
                    dataSource: "ajax/getCategoryData.ashx",
                    fatherId: <%= Request["gid"] %>,
                    chooseEnd: true
                  });
              </script>
          </td>
          <td></td>
        </tr>
        <tr>
          <td>所属地区</td>
          <td><input id="AreaId" type="text" runat="server" enableviewstate="false" />
              <script type="text/javascript">
                  $("#<%= AreaId.ClientID %>").QzSelect({
                      dataSource: "ajax/getAreaData.ashx",
                      chooseEnd: true
                  });
              </script>
          </td>
          <td class="gray">不选择地区，则本条信息将显示在所有地区中</td>
        </tr>
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
        <tr>
          <td><%= groupName %>缩略图</td>
          <td>
	        <input id="Pic" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= Pic.ClientID %>").QzImageUpload({
	                "code": "<%= thumSpec.Code %>",
	                "fileExt": "<%= thumSpec.FileExt %>",
	                "sizeLimit": "<%= thumSpec.Filesize %>"
	            });
            </script>
	      </td>
	      <td class="gray">
	        <%= Request["gid"] == "13" ? "建议图片尺寸：136 ( 宽 ) × 108 ( 高 ) px" : "建议图片尺寸：220 ( 宽 ) × 150 ( 高 ) px" %><br />
	        图片格式 <%= thumSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= thumSpec.Filesize %> KB 以内
	      </td>
        </tr>
        <tr>
          <td><%= groupName %>大图</td>
          <td>
	        <input id="Pictures" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= Pictures.ClientID %>").QzImageUpload({
	                "code": "<%= imageSpec.Code %>",
	                "fileExt": "<%= imageSpec.FileExt %>",
	                "sizeLimit": "<%= imageSpec.Filesize %>"
	            });
            </script>
	      </td>
	      <td class="gray">建议图片尺寸：340 ( 宽 ) × 230 ( 高 ) px<br />图片格式 <%= imageSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= imageSpec.Filesize %> KB 以内</td>
        </tr>
        <tr>
          <td><%= groupName %>头条图</td>
          <td>
	        <input id="TopPic" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= TopPic.ClientID %>").QzImageUpload({
	                "code": "<%= imageSpec.Code %>",
	                "fileExt": "<%= imageSpec.FileExt %>",
	                "sizeLimit": "<%= imageSpec.Filesize %>"
	            });
            </script>
	      </td>
	      <td class="gray">用于首页版块 ( 可选 ) ，建议图片尺寸：225 ( 宽 ) × 240 ( 高 ) px<br />图片格式 <%= imageSpec.FileFormat.Replace("|", " | ") %>，图片大小 <%= imageSpec.Filesize %> KB 以内</td>
        </tr>
        <tbody id="ScenicPanel" runat="server">
        <tr>
          <td>景区主题</td>
          <td><select id="Topic" runat="server"></select></td>
          <td></td>
        </tr>
        <tr>
          <td>景区级别</td>
          <td><select id="Level" runat="server"></select></td>
          <td></td>
        </tr>
        </tbody>
        <tbody id="SelfdrivePanel" runat="server">
        <tr>
          <td>自驾活动主题</td>
          <td><textarea id="EventTheme" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray">用于显示在自驾活动列表页中的简介，建议20字左右</td>
        </tr>
        <tr>
          <td>自驾活动时间</td>
          <td>
            <input id="EventDate" type="text" readonly="readonly" class="text date" runat="server" enableviewstate="false" />
            <script type="text/javascript">
                $("#<%= EventDate.ClientID %>").date_input();
            </script>
          </td>
          <td></td>
        </tr>
        </tbody>
        <tr>
          <td>门票</td>
          <td><input id="Ticket" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>单人出行价</td>
          <td><input id="MySingle" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>多人出行价</td>
          <td><input id="People" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>同行人员价</td>
          <td><input id="Together" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>电话</td>
          <td><input id="Tel" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
        <tr>
          <td>地址</td>
          <td><input id="Address" type="text" class="text" style="width:300px;" runat="server" enableviewstate="false" /></td>
          <td></td>
        </tr>
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
          <td valign="top">
            详情介绍
            <ul class="innerTabs">
              <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false">
                <ItemTemplate>
                  <li><a><%# Eval("Title") %></a></li>
                </ItemTemplate>
              </asp:Repeater>
            </ul>
          </td>
          <td colspan="2" class="contentTd">
              <textarea id="mycontent"></textarea>
              <asp:Repeater ID="Repeater2" runat="server" EnableTheming="false" onitemdatabound="Repeater2_ItemDataBound">
                <ItemTemplate>
                </ItemTemplate>
              </asp:Repeater>
              <script type="text/javascript">
                  if ($(".contentTd textarea.hide").length > 0) {
                      editor = UE.getEditor("mycontent", {});
                      setInnerTabs(editor);
                  }
                  else $("#mycontent").hide();
              </script>
          </td>
        </tr>
        <tr>
          <td>设置置顶</td>
          <td><asp:CheckBox ID="IsTop" runat="server" Text="将本条信息设为置顶" /></td>
          <td></td>
        </tr>
        <tr>
          <td>设置热门推荐</td>
          <td><asp:CheckBox ID="IsHot" runat="server" Text="将本条信息设为热门推荐" /></td>
          <td></td>
        </tr>
        <tr>
          <td>自定义排序</td>
          <td><input id="Sort" type="text" class="text" maxlength="8" value="1" style="width:100px;" runat="server" enableviewstate="false" /></td>
          <td class="gray">最小序号为 “ 1 ”，序号越大则显示位置越靠前</td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>