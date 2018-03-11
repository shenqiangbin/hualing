<%@ WebHandler Language="C#" Class="deleteHandler" %>

using System;
using System.Web;
using QianZhu.Utility;

public class deleteHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        HttpHelper.CheckUrlReferrer(null);
        
        try
        {
            string filePath = context.Request.Form["path"];
            FileHelper.DeleteFile(filePath, true);
            context.Response.Write("1");
        }
        catch(Exception ex)
        {
            context.Response.Write(ex.Message);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}