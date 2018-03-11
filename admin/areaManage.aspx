<%@ Page Language="C#" AutoEventWireup="true" CodeFile="areaManage.aspx.cs" Inherits="admin_areaManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/js/qz.select.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("#main table.tree tr").each(function() {
                treeStyle($(this));
                $(this).find("td:eq(1) input").css("width", "200px");
            });
        });

        function addArea(obj, fatherId) {
            count++;
            var objTr = obj.parent().parent();
            var demo = $(".demo tbody").html().replace(new RegExp("-0-", "g"), objTr.attr("lv"));
            demo = demo.replace(new RegExp("-1-", "g"), fatherId);
            demo = demo.replace(new RegExp("#", "g"), "#" + count.toString());
            $(objTr).before(demo);
            treeStyle(objTr.prev());
        }

        function formSubmit() {
            beforeSubmit();
            $("#main input[name=cmd]").val("updateall");
            form1.submit();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="top">
      <div class="help">
        <table>
          <tr>
            <td>
              <asp:Panel ID="Panel1" runat="server" DefaultButton="ConfirmButton">
              <label>当前默认地区为：<strong><%= defaultArea %></strong></label>
              设置默认地区
              <input type="text" id="DefaultArea" runat="server" enableviewstate="false" />
              <script type="text/javascript">
                  $("#<%= DefaultArea.ClientID %>").QzSelect({
                      dataSource: "ajax/getAreaData.ashx",
                      fatherId: 0,
                      chooseEnd: true
                  });
              </script>
              <asp:ImageButton ID="ConfirmButton" ImageUrl="/admin/skin/blue/confirmBtn.gif" runat="server" EnableViewState="false" onclick="ConfirmButton_Click" />
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DefaultArea" 
                  Display="None" EnableViewState="False" ErrorMessage="请选择默认地区" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:ValidationSummary ID="ValidationSummary1" runat="server" EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
              </asp:Panel>
            </td>
          </tr>
        </table>
      </div>
      <h1>地区管理</h1>
      <ul class="tabs">
        <li>设置</li>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="areaEdit.aspx" class="btn">新增</a>
        <a href="javascript:;" onclick="formSubmit();" class="btn">全部保存</a>
        <a href="javascript:;" onclick="operate('hot', null, null);" class="btn">热门/取消</a>
        <a href="javascript:;" onclick="operate('enab', null, null);" class="btn">上线/下线</a>
        <a href="javascript:;" onclick="operate('del', null, null);" class="btn">删除</a>
      </div>
      <table class="tree">
        <tr class="h">
          <td width="4%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
          <td>地区名</td>
          <td width="10%">ID</td>
          <td width="12%">地区代码</td>
          <td width="12%">状态</td>
          <td width="15%">操作</td>
        </tr>
        <%= CreateTree(0).ToString()%>
        <tr lv="1" rank="last">
          <td></td>
          <td colspan="5"><a href="javascript:;" onclick="addArea($(this), 0);" class="icon2 icon_add"> 新增地区</a></td>
        </tr>
      </table>
      <div class="ctrl"></div>
      <input type="hidden" name="cmd" />
    </div>
    </form>
    
    <table class="demo">
      <tbody>
        <tr lv="-0-" class="new">
          <td><input name="fid#" type="hidden" value="-1-" /></td>
          <td colspan="4"><input name="title#" type="text" class="text" style="width:120px" /></td>
          <td>
            <a class="icon icon_empty"></a><a class="icon icon_empty"></a><a class="icon icon_empty"></a>
            <a href="javascript:;" onclick="$(this).parent().parent().remove();" class="icon icon_del" title="删除"></a>
          </td>
        </tr>
      </tbody>
    </table>
</body>
</html>