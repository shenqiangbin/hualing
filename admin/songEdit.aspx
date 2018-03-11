<%@ Page Language="C#" AutoEventWireup="true" CodeFile="songEdit.aspx.cs" Inherits="admin_articleEdit" %>

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
    <form id="form1" runat="server" >
    <div id="top">
      <h1>加入华领管理 - <%=myhead %></h1>
    </div>
    
    <div id="main">
      <div class="ctrl">
        <a href="songManage.aspx<%= param %>" class="btn">返回</a>
       
      </div>
      <table class="frm">
        <tr>
          <td width="100">姓名<span class="fill"></span></td>
          <td id="MyTitle" runat="server" enableviewstate="false"> </td>
          <td width="350"></td>
        </tr>
        
        <tr>
          <td>性别</td>
          <td id="sex" runat="server" enableviewstate="false" ></td>
          <td ></td>
        </tr>
         <tr>
          <td>出生日期</td>
          <td id="birtime" runat="server" enableviewstate="false"></td>
          <td  ></td>
        </tr>
        <tr>
          <td>籍贯</td>
          <td id="addr" runat="server" enableviewstate="false"></td>
          <td class="gray"></td>
        </tr>
         <tr>
          <td>薪资要求</td>
          <td id="salary" runat="server" enableviewstate="false"></td>
          <td class="gray"></td>
        </tr>
         <tr>
          <td>电话</td>
          <td id="tel" runat="server" enableviewstate="false"></td>
          <td class="gray"></td>
        </tr>
           <tr>
          <td>Email</td>
          <td id="email" runat="server" enableviewstate="false"></td>
          <td class="gray"></td>
        </tr> 
        
         <tr>
          <td>通讯地址</td>
          <td id="address" runat="server" enableviewstate="false"></td>
          <td class="gray"></td>
        </tr> 
        
        <tr>
          <td>教育经历</td>
          <td id="edu" runat="server" enableviewstate="false"></td>
          <td class="gray"></td>
        </tr> 
        
        <tr>
          <td>工作经历</td>
          <td id="works" runat="server" enableviewstate="false"></td>
          <td class="gray"></td>
        </tr> 
        
       <tr>
          <td>自我评价</td>
          <td id="evaluation" runat="server" enableviewstate="false"></td>
          <td class="gray"></td>
        </tr>       
      </table>
      <div class="ctrl"></div>
    </div>
   
    </form>
</body>
</html>