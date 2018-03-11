<%@ WebHandler Language="C#" Class="opCommonMenu" %>

using System;
using System.Collections.Generic;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class opCommonMenu : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private SystemMenu bll_systemMenu = new SystemMenu();
    
    public void ProcessRequest (HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;

        string menuId = context.Request.QueryString["pkid"];
        SystemMenuModel systemMenu = bll_systemMenu.GetModel(menuId);
        if (systemMenu == null) return;

        AdminModel admin = bll_admin.GetModelByCookie();

        if (context.Request.QueryString["op"] == "add")
        {
            if (String.IsNullOrEmpty(admin.CommonLinks)) admin.CommonLinks = ",";
            if (admin.CommonLinks.IndexOf("," + menuId + ",") < 0) admin.CommonLinks += menuId + ",";
        }

        else if (context.Request.QueryString["op"] == "del")
        {
            if (!String.IsNullOrEmpty(admin.CommonLinks))
                admin.CommonLinks = admin.CommonLinks.Replace(menuId + ",", "");
        }
        
        bll_admin.Update(admin);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}