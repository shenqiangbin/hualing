<%@ WebHandler Language="C#" Class="exit" %>

using System;
using System.Web;
using QianZhu.BLL;
using QianZhu.Utility;

public class exit : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {
        Member bll_member = new Member();
        bll_member.Logout();
        context.Response.Redirect("/login/");
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}