﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pageSectionEdit.aspx.cs" Inherits="admin_pageSectionEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="skin/blue/base.css" rel="stylesheet" type="text/css" />
    <link href="skin/blue/frame.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/qz.base.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.config.js" type="text/javascript"></script>
    <script src="/plugin/ueditor/ueditor.all.js" type="text/javascript"></script>
    <script src="ajax/ajax.js" type="text/javascript"></script>
    <script src="js/frame.js" type="text/javascript"></script>
    <script type="text/javascript">
        var editor;
        function initContent() {
            editor.ready(function() {
                editor.setContent($('.demo').html());
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="beforeSubmit();">
    <div id="top">
      <h1>局部版面管理 - 编辑</h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="pageSectionManage.aspx<%= param %>" class="btn">返回</a>
        <asp:LinkButton ID="SubmitButton" runat="server" CssClass="btn" onclick="SubmitButton_Click">保存</asp:LinkButton>
      </div>
      <table class="frm">
        <tr>
          <td width="100">局部版面名称</td>
          <td width="350"><%= pageSection.Title %></td>
          <td></td>
        </tr>
        <tr>
          <td valign="top">
            局部版面内容<span class="fill">*</span><br />
            <span class="hide init">[ <a href="javascript:;" onclick="initContent()">初始化格式</a> ]</span>
          </td>
          <td colspan="2">
            <textarea id="MyContent" runat="server" enableviewstate="false"></textarea>
            <div class="demo"><%= pageSection.InitContent %></div>
            <script type="text/javascript">
                if (!isNull($('.demo').html())) $(".init").show();
                editor = UE.getEditor("<%= MyContent.ClientID %>", { initialFrameHeight: 300,
                    toolbars: [
                    ['source', '|', 'undo', 'redo', '|', 'bold', 'italic', 'underline', 'strikethrough', '|', 'forecolor', 'selectall',
                    'removeformat', 'cleardoc', '|', 'fontfamily', 'fontsize', '|', 'justifyleft', 'justifycenter', 'justifyright',
                    'justifyjustify', '|', 'link', 'unlink', '|', 'insertimage', 'insertvideo', '|', 'spechars']]
                });
            </script>
            <asp:RequiredFieldValidator 
                  ID="RequiredFieldValidator3" runat="server" ControlToValidate="MyContent" 
                  Display="None" EnableViewState="False" ErrorMessage="请填写页面内容" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
          </td>
        </tr>
      </table>
      <div class="ctrl"></div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableViewState="False" ShowMessageBox="True" ShowSummary="False" />
    </form>
</body>
</html>