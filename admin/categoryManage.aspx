<%@ Page Language="C#" AutoEventWireup="true" CodeFile="categoryManage.aspx.cs" Inherits="admin_categoryManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("#main table.tree tr").each(function() {
                treeStyle($(this));
                $(this).find("td:eq(1) input").css("width", "120px");
            });
        });

        function addCategory(obj, fatherId) {
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
      <h1><%= group.Title %>管理</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="categoryEdit.aspx?gid=<%= group.Pkid %>" class="btn">新增</a>
        <a href="javascript:;" onclick="formSubmit();" class="btn">全部保存</a>
        <a href="javascript:;" onclick="operate('enab', null, '<%= param %>');" class="btn">显示/隐藏</a>
        <a href="javascript:;" onclick="operate('del', null, '<%= param %>');" class="btn">删除</a>
      </div>
      <table class="tree">
        <tr class="h">
          <td width="4%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
          <td>类别名称</td>
          <td width="10%">ID</td>
          <td width="10%">状态</td>
          <td width="15%">创建日期</td>
          <td width="16%">操作</td>
        </tr>
        <%= CreateTree(group.Pkid).ToString()%>
        <tr lv="1" rank="last">
          <td></td>
          <td colspan="5"><a href="javascript:;" onclick="addCategory($(this), <%= group.Pkid %>);" class="icon2 icon_add"> 新增类别</a></td>
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