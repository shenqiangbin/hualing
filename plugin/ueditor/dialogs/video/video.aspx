<%@ Page Language="C#" AutoEventWireup="true" CodeFile="video.aspx.cs" Inherits="plugin_ueditor_dialogs_video_video" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" src="../internal.js"></script>
    <link rel="stylesheet" type="text/css" href="video.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="wrapper">
        <div id="videoTab">
            <div id="tabHeads" class="tabhead">
                <span tabSrc="upload" class="focus" data-content-id="upload"><var id="lang_tab_uploadV"></var></span>
                <span tabSrc="video" data-content-id="video"><var id="lang_tab_insertV"></var></span>
            </div>
            <!--<span tabSrc="video" data-content-id="videoSearch"><var id="lang_tab_searchV"></var></span>-->
            <div id="tabBodys" class="tabbody">
                <div id="upload" class="panel">
                    <div id="upload_left">
                        <div class="fieldset flash" id="fsUploadProgress"></div>
                        <div class="controller">
                            <span id="spanButtonPlaceHolder"></span>
                            <!--<span id="video_format_advice"><var id="lang_format_advice"></var></span>-->
                            <span id="startUpload" style="display:none;"></span>
                        </div>
                    </div>
                    <div id="uploadVideoInfo">
                        <fieldset>
                            <legend><var id="lang_upload_size"></var></legend>
                            <table>
                                <tr><td><label><var id="lang_upload_width"></var></label></td><td><input class="txt" id="upload_width" type="text"/></td></tr>
                                <tr><td><label><var id="lang_upload_height"></var></label></td><td><input class="txt" id="upload_height" type="text"/></td></tr>
                            </table>
                        </fieldset>
                        <fieldset>
                            <legend><var id="lang_upload_alignment"></var></legend>
                            <div id="upload_alignment"></div>
                        </fieldset>
                    </div>
                </div>
                <div id="video" class="panel" style="display: none">
                   <table><tr><td><label for="videoUrl" class="url"><var id="lang_video_url"></var></label></td><td><input id="videoUrl" type="text"></td></tr></table>
                   <div id="preview"></div>
                   <div id="videoInfo">
                       <fieldset>
                           <legend><var id="lang_video_size"></var></legend>
                           <table>
                               <tr><td><label for="videoWidth"><var id="lang_videoW"></var></label></td><td><input class="txt" id="videoWidth" type="text"/></td></tr>
                               <tr><td><label for="videoHeight"><var id="lang_videoH"></var></label></td><td><input class="txt" id="videoHeight" type="text"/></td></tr>
                           </table>
                       </fieldset>
                       <fieldset>
                          <legend><var id="lang_alignment"></var></legend>
                          <div id="videoFloat"></div>
                      </fieldset>
                   </div>
                </div>
                <!--
                <div id="videoSearch" class="panel" style="display: none">
                    <table style="margin-top: 5px;">
                        <tr>
                            <td><input id="videoSearchTxt"  type="text" /></td>
                            <td>
                                <select id="videoType">
                                    <option value="0"></option>
                                    <option value="29"></option>
                                    <option value="1"></option>
                                    <option value="5"></option>
                                    <option value="15"></option>
                                    <option value="21"></option>
                                    <option value="31"></option>
                                </select>
                            </td>
                            <td><input id="videoSearchBtn" type="button"/></td>
                            <td><input id="videoSearchReset" type="button" /></td>
                        </tr>
                    </table>
                    <div id="searchList"></div>
                </div>
                -->
            </div>
        </div>
    </div>
    <script type="text/javascript" src="video.js"></script>

    <script type="text/javascript" src="../../third-party/swfupload/swfupload.js"></script>
    <script type="text/javascript" src="../../third-party/swfupload/swfupload.queue.js"></script>
    <script type="text/javascript" src="../../third-party/swfupload/fileprogress.js"></script>
    <script type="text/javascript" src="callbacks.js"></script>
    <script type="text/javascript">
        var filespecCode = "<%= filespec.Code %>",
            filespecSize = "<%= filespec.Filesize %>",
            filespecExt = "<%= filespec.FileExt %>",
            sessionId = "<%= Session.SessionID %>";
    </script>
    </form>

<!-- hualingedu.com Baidu tongji analytics -->
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F7adea5fc863b8757d66d5fe9255b1994' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fcdf3d8ab8f1eb88a894574c723a16498' type='text/javascript'%3E%3C/script%3E"));
</script>
</body>
</html>
