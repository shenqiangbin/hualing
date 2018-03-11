<%@ WebHandler Language="C#" Class="exit" %>

using System;
using System.Web;
using QianZhu.Utility;

public class exit : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {
        QianZhu.BLL.Admin bll_admin = new QianZhu.BLL.Admin();
        bll_admin.Logout();
        context.Response.Redirect("/admin/");
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}