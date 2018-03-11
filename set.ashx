<%@ WebHandler Language="C#" Class="set" %>

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Services.Description;
using System.Web.Services.Protocols;
using System.Net;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class set : IHttpHandler 
{
    private Member bll_member = new Member();
    private MemberModel member = new MemberModel();
    private string id = "";
    public void ProcessRequest (HttpContext context)
    {
       
        try
        {
            id = context.Request.Form["id"];
            member = bll_member.GetModel(id);
            member.DistrictId += 1;
            bll_member.Update(member);
            context.Response.Write("ok");
        }
        catch (Exception)
        {
            id = "";
            context.Response.Write("no");
        }
        
        context.Response.End();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}