<%@ WebHandler Language="C#" Class="changeCity" %>

using System;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class changeCity : IHttpHandler {

    Area bll_area = new Area();
    
    public void ProcessRequest (HttpContext context)
    {
        string cityId = context.Request.QueryString["cityId"];
        string title = context.Request.QueryString["title"];
        bool result = false;
        
        if (!String.IsNullOrEmpty(cityId))
        {
            result = bll_area.ChangeCity(cityId);
        }
        else if (!String.IsNullOrEmpty(title))
        {
            AreaModel area = bll_area.GetModelByTitle(title);
            result = bll_area.ChangeCity(area);
        }

        if (result) context.Response.Redirect(FileHelper.AppHttpRoot);
        else WebUtility.ShowAlertMessage("没有找到相关城市！", null);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}