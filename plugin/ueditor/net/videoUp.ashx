<%@ WebHandler Language="C#" Class="videoUp" %>
<%@ Assembly Src="Uploader.cs" %>

using System;
using System.Text.RegularExpressions;
using System.Web;
using System.IO;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class videoUp : IHttpHandler
{
    //建立业务逻辑层实例
    private Filespec bll_filespec = new Filespec();
    private MediaLib bll_mediaLib = new MediaLib();

    public void ProcessRequest(HttpContext context)
    {
        string state = "SUCCESS", videoUrl = String.Empty, fileType = String.Empty, oriName = String.Empty;

        try
        {
            FilespecModel filespec = bll_filespec.GetModelByCode(context.Request.Form["code"]);
            MediaLibModel mediaLib = new MediaLibModel();

            if (filespec == null) state = "未知的文件规则";
            else
            {
                HttpPostedFile file = context.Request.Files[0];

                //check file extension
                string ext = Path.GetExtension(file.FileName).ToLower();
                if (filespec.FileFormat.IndexOf(ext.Replace(".", "")) < 0) state = "不允许的文件类型";

                //check file size
                if (file.ContentLength > filespec.Filesize * 1024) state = "文件大小超出限制";
                mediaLib.FileSize = file.ContentLength;

                if (state == "SUCCESS")
                {
                    //get file upload path
                    string virPath = filespec.SavePath;
                    Regex regex = new Regex(@"{([yMdhms]+)}");
                    while (regex.IsMatch(virPath)) virPath = regex.Replace(virPath, DateTime.Now.ToString(regex.Match(virPath).Groups[1].Value), 1);
                    string phyPath = context.Server.MapPath(virPath);

                    //get filename
                    string filename = filespec.NameFormat;
                    if (String.IsNullOrEmpty(filename)) filename = Path.GetFileName(file.FileName);
                    else
                    {
                        regex = new Regex(@"{([yMdhms]+)}");
                        while (regex.IsMatch(filename)) filename = regex.Replace(filename, DateTime.Now.ToString(regex.Match(filename).Groups[1].Value), 1);
                        regex = new Regex(@"{r(\d+)}");
                        while (regex.IsMatch(filename)) filename = regex.Replace(filename, StringHelper.GetRandomString(Convert.ToInt32(regex.Match(filename).Groups[1].Value), "0123456789"), 1);
                        filename = filename + ext;
                    }

                    //upload file
                    FileHelper.CreateDir(phyPath);
                    file.SaveAs(phyPath + filename);
                    videoUrl = virPath + filename;
                    mediaLib.FilePath = videoUrl;

                    //create thumbnail
                    string[] arrImage = null;
                    if (!String.IsNullOrEmpty(filespec.Thumbnail))
                    {
                        arrImage = filespec.Thumbnail.Split(new char[] { '|' });
                        for (int i = 0; i < arrImage.Length; i++)
                        {
                            string[] arrData = arrImage[i].Split(new char[] { ',' });
                            ImageHelper.MakeThumbnail(phyPath + filename, ImageHelper.GetThumbName(filename, i + 1), arrData[0], arrData[1]);
                        }
                    }
                }
            }

            Uploader up = new Uploader();
            fileType = up.getOtherInfo(context, "currentType");
            oriName = up.getOtherInfo(context, "originalName");

            //Insert the media library
            mediaLib.FileType = MediaLib.FileType.Video;
            mediaLib.CreateTime = DateTime.Now.ToString();
            bll_mediaLib.Insert(mediaLib);
        }
        catch (Exception ex)
        {
            SystemHelper.Debug(ex.Message + "\r\n\r\n" + ex.StackTrace);
            state = "抛出异常";
        }

        context.Response.Write("{'state':'" + state + "','url':'" + videoUrl + "','fileType':'" + fileType + "','original':'" + oriName + "'}");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}