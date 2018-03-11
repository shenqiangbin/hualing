<%@ Page Language="C#" AutoEventWireup="true" CodeFile="configManage.aspx.cs" Inherits="admin_dev_configManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/admin/skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="/admin/skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/admin/ajax/ajax.js" type="text/javascript"></script>
    <script src="/admin/js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        function addType(obj) {
            count++;
            var demo = $(".demo tbody").html();
            demo = demo.replace(new RegExp("#", "g"), "#" + count.toString());
            obj.parent().parent().before(demo);
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
              键名 <input id="KeyName" type="text" class="text" style="width:200px;" runat="server" enableviewstate="false" />
              <asp:ImageButton ID="SearchButton" ImageUrl="/admin/skin/blue/searchBtn.gif" runat="server" EnableViewState="false" onclick="SearchButton_Click" />
            </td>
          </tr>
        </table>
      </div>
      <h1>配置参数管理</h1>
      <ul class="tabs">
        <li>搜索</li>
      </ul>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="javascript:;" onclick="formSubmit();" class="btn">全部保存</a>
        <a href="javascript:;" onclick="operate('del', null, null);" class="btn">删除</a>
        <a href="javascript:;" onclick="window.location.href='?'" class="btn">显示全部</a>
      </div>
      <table class="list">
        <tr class="h">
          <td width="4%" align="center"><input id="checkAll" type="checkbox" title="全选/全取消" /></td>
          <td>参数键名</td>
          <td width="34%">参数值（PC端）</td>
          <td width="34%">参数值（移动端）</td>
          <td width="6%">操作</td>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server" EnableTheming="false">
          <ItemTemplate>
            <tr>
              <td align="center"><input type="checkbox" name="g1" value="<%#Eval("Pkid")%>" /></td>
              <td><input name="key<%#Eval("Pkid")%>" value="<%# Eval("KeyName") %>" maxlength="50" type="text" class="text" style="width:150px" /></td>
              <td><textarea name="valPc<%#Eval("Pkid")%>" class="config"><%# Eval("ValuePc") %></textarea></td>
              <td><textarea name="valMobi<%#Eval("Pkid")%>" class="config"><%# Eval("ValueMobi")%></textarea></td>
              <td><a href="javascript:;" onclick="operate('del',<%#Eval("Pkid")%>,null);" class="icon icon_del" title="删除"></a></td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
        <tr>
          <td></td>
          <td colspan="5" style="padding-bottom:8px"><a href="javascript:;" onclick="addType($(this));" class="icon2 icon_add"> 新增配置参数</a></td>
        </tr>
      </table>
      <div class="ctrl"></div>
      <input type="hidden" name="cmd" />
    </div>
    </form>
    
    <table class="demo">
      <tbody>
        <tr class="new">
          <td></td>
          <td><input name="key#" maxlength="50" type="text" class="text" style="width:150px" /></td>
          <td><input name="valPc#" type="text" class="text" style="width:95%" /></td>
          <td><input name="valMobi#" type="text" class="text" style="width:95%" /></td>
          <td><a href="javascript:;" onclick="$(this).parent().parent().remove();" class="icon icon_del" title="删除"></a></td>
        </tr>
      </tbody>
    </table>
</body>
</html>