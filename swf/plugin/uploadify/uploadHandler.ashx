<%@ WebHandler Language="C#" Class="uploadHandler" %>

using System;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.SessionState;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class uploadHandler : IHttpHandler, IRequiresSessionState {

    //建立业务逻辑层实例
    private Filespec bll_filespec = new Filespec();
    
    public void ProcessRequest(HttpContext context)
    {
        string result = String.Empty;

        foreach (string key in context.Request.Files.AllKeys)
        {
            HttpPostedFile file = context.Request.Files[key];
            if (file == null) SystemHelper.PrintEnd("101");

            FilespecModel filespec = null;
            if (key.ToLower() == "watermark") filespec = bll_filespec.WatermarkSpec;
            else filespec = bll_filespec.GetModelByCode(key);
            if (filespec == null) SystemHelper.PrintEnd("102");

            try
            {
                //check file extension
                string ext = System.IO.Path.GetExtension(file.FileName).ToLower();
                if (filespec.FileFormat.IndexOf(ext.Replace(".", "")) < 0) SystemHelper.PrintEnd("103");

                //check file size
                if (file.ContentLength > filespec.Filesize * 1024) SystemHelper.PrintEnd("106");

                //get file upload path
                string virPath = filespec.SavePath;
                Regex regex = new Regex(@"{([yMdhms]+)}");
                while (regex.IsMatch(virPath)) virPath = regex.Replace(virPath, DateTime.Now.ToString(regex.Match(virPath).Groups[1].Value), 1);
                string phyPath = context.Server.MapPath(virPath);

                //get filename
                string filename = filespec.NameFormat;
                if (String.IsNullOrEmpty(filename)) filename = System.IO.Path.GetFileName(file.FileName);
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

                //paint watermark
                if (filespec.WmSwitch > 0)
                {
                    bll_filespec.PaintWatermark(phyPath + filename, filespec);

                    if (arrImage != null)
                    {
                        for (int i = 0; i < arrImage.Length; i++)
                        {
                            string[] arrData = arrImage[i].Split(new char[] { ',' });
                            if (arrData[2] != "1") continue;
                            SystemHelper.Debug(phyPath + ImageHelper.GetThumbName(filename, i + 1));
                            bll_filespec.PaintWatermark(phyPath + ImageHelper.GetThumbName(filename, i + 1), filespec);
                        }
                    }
                }
                
                //return result
                result += virPath + filename;
            }
            catch(Exception ex) {
                SystemHelper.Debug(ex.Message + "\r\n\r\n" + ex.StackTrace);
                SystemHelper.PrintEnd("108");
            }
            break;
        }

        if (String.IsNullOrEmpty(result)) SystemHelper.PrintEnd("109");
        else context.Response.Write(result);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}