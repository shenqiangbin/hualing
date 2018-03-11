<%@ WebHandler Language="C#" Class="checkCode" %>

using System;
using System.Web;
using System.Web.UI;
using QianZhu.Utility;

public class checkCode : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {
        string width = context.Request.QueryString["w"];
        string height = context.Request.QueryString["h"];
        string fontSize = context.Request.QueryString["f"];

        ImageHelper.GetCheckCode(width, height, fontSize);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}