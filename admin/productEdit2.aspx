<%@ Page Language="C#" AutoEventWireup="true" CodeFile="productEdit2.aspx.cs" Inherits="admin_productEdit2" %>

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
    <form id="form1" runat="server" onsubmit="formSubmit();" >
    <div id="top">
      <h1>课程管理 - <%= myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="productManage2.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
     <%-- <tr>
          <td width="100">产品型号<span class="fill">*</span></td>
          <td width="350"><input id="model" type="text" style="width:300px" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator3" runat="server" ControlToValidate="model" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写产品型号" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>--%>
        <tr>
          <td width="100">名称<span class="fill">*</span></td>
          <td width="350"><input id="MyTitle" type="text" style="width:300px" maxlength="100" class="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator1" runat="server" ControlToValidate="MyTitle" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写名称" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
          <td></td>
        </tr>
       
        <%--<tr>
          <td>产品类别<span class="fill">*</span></td>
          <td><input id="CategoryId" type="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator2" runat="server" ControlToValidate="CategoryId" 
                  Display="None" EnableViewState="False" ErrorMessage="请选择产品类别" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <script type="text/javascript">
                  $("#<%= CategoryId.ClientID %>").QzSelect({
                    dataSource: "ajax/getCategoryData.ashx",
                    fatherId: 30,
                    chooseEnd: true
                  });
              </script>
          </td>
          <td></td>
        </tr>--%>
       <%-- <tr>
          <td>机型<span class="fill">*</span></td>
          <td><input id="point" type="text" runat="server" enableviewstate="false" /><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator4" runat="server" ControlToValidate="point" 
                  Display="None" EnableViewState="False" ErrorMessage="请选择机型" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <script type="text/javascript">
                  $("#<%= point.ClientID %>").QzSelect({
                    dataSource: "ajax/getCategoryData.ashx",
                    fatherId: 30,
                    chooseEnd: true
                  });
              </script>
          </td>
          <td></td>
        </tr>--%>
        <%--<tr>
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
          <td>概述</td>
          <td><textarea id="summary" runat="server" enableviewstate="false"></textarea></td>
          <td class="gray"></td>
        </tr>
        <tr>
          <td>图片</td>
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
	      <td class="gray">图片格式 <%= thumSpec.FileFormat.Replace("|", " | ") %>，图 <%= thumSpec.Filesize %> KB 以内</td>
        </tr>--%>
      <%--  <tr>
          <td>产品相册图</td>
          <td colspan="2">
	        <input id="Pictures" type="text" runat="server" enableviewstate="false" class="hide" />
	        <script type="text/javascript">
	            $("#<%= Pictures.ClientID %>").QzImageUpload({
	                "code": "<%= imageSpec.Code %>",
	                "fileExt": "<%= imageSpec.FileExt %>",
	                "sizeLimit": "<%= imageSpec.Filesize %>",
	                "multi": true
	            });
            </script>
	      </td>
        </tr>
        <tr>
          <td>价格<span class="fill">*</span></td>
          <td><input id="Price1" type="text" class="text" maxlength="12" style="width:100px;" value="0" runat="server" enableviewstate="false" /><label>人民币</label><asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator2" runat="server" ControlToValidate="Price1" 
                  Display="None" EnableViewState="False" ErrorMessage="价格填写格式错误" 
                  SetFocusOnError="True" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"></asp:RegularExpressionValidator>
          </td>
          <td class="gray">价格填写格式为：100、80.5、168.58</td>
        </tr>--%>
        <%--<tr>
          <td>原价<br />(只需特价产品时填写)</td>
          <td><input id="Price2" type="text" class="text" maxlength="12" value="0" style="width:100px;" runat="server" enableviewstate="false" /><label>人民币</label><asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator5" runat="server" ControlToValidate="Price2" 
                  Display="None" EnableViewState="False" ErrorMessage="价格式错误" 
                  SetFocusOnError="True" ValidationExpression="^\d{1,9}(\.\d{1,2})?$"></asp:RegularExpressionValidator>
          </td>
          <td></td>
        </tr>--%>
        <%--<tr>
          <td>库存量</td>
          <td><input id="Stock" type="text" class="text" maxlength="8" style="width:100px;" runat="server" enableviewstate="false" /><asp:RegularExpressionValidator 
                  ID="RegularExpressionValidator1" runat="server" ControlToValidate="Stock" 
                  Display="None" EnableViewState="False" ErrorMessage="库存量只能使用数字填写" 
                  SetFocusOnError="True" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            </td>
          <td class="gray">请使用数字填写</td>
        </tr>--%>
        <tr>
          <td>日期</td>
          <td>
            <input id="Pubdate" type="text" readonly="readonly" class="text date" runat="server" enableviewstate="false" />
            <script type="text/javascript">
                $("#<%= Pubdate.ClientID %>").date_input();
            </script>
          </td>
          <td class="gray">不填写则默认为当前日期</td>
        </tr>
       <%-- <tr>
          <td valign="top">详情介绍<span class="fill">*</span></td>
          <td colspan="2"><textarea id="MyContent" runat="server" enableviewstate="false"></textarea><asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator4" runat="server" ControlToValidate="MyContent" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写产品的详情介绍" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <script type="text/javascript">
                  UE.getEditor("<%= MyContent.ClientID %>", {});
              </script>
            </td>
        </tr>--%>
         <tr>
                <td valign="top" >
                    <ul class="innerTabs">
                    <li><a>介绍内容</a></li>
                    </ul>
                </td>
                <td colspan="2" class=""></td>
                <%--<td colspan="2" class="contentTd">
                    <textarea id="mycontent"></textarea>
                   <textarea id="content0" name="content0" style="width: 1100px" class="hide"><%=product.Content %></textarea>
                    <textarea id="content1" name="content1"  style="width: 1100px" class="hide"><%=product.Feature%></textarea>
                     <textarea id="content2" name="content2" style="width: 1100px"  class="hide"><%=product.Application%></textarea>

                    <script type="text/javascript">
                      if ($(".contentTd textarea.hide").length > 0) {
                          editor = UE.getEditor("mycontent", {});
                          setInnerTabs(editor);
                      }
                      else $("#mycontent").hide();
                    </script>
                </td>--%>
            </tr>
            
             <tr>
                
                <td colspan="3" class="contentTd" style=" padding:0 0;">
                    <textarea id="mycontent"></textarea>
                   <textarea id="content0" name="content0"  class="hide"><%=product.Content%></textarea>
                    <script type="text/javascript">
                      if ($(".contentTd textarea.hide").length > 0) {
                          editor = UE.getEditor("mycontent", { initialFrameWidth:"90%"});  //initialFrameHeight: 390
                          setInnerTabs(editor);
                      }
                      else $("#mycontent").hide();
                    </script>
                </td>
            </tr>
        <tr>
          <td>设置置顶</td>
          <td><asp:CheckBox ID="IsTop" runat="server" Text="将本条产品设为置顶" /></td>
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