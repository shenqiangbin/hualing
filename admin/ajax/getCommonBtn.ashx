<%@ WebHandler Language="C#" Class="getCommonBtn" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getCommonBtn : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private SystemMenu bll_systemMenu = new SystemMenu();
    
    public void ProcessRequest (HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;

        SystemMenuModel systemMenu = bll_systemMenu.GetModel(context.Request.QueryString["id"]);
        if (systemMenu == null) SystemHelper.PrintEnd("0");

        AdminModel admin = bll_admin.GetModelByCookie();
        
        string op = "add";
        string title = "加入常用菜单";
        
        if (!String.IsNullOrEmpty(admin.CommonLinks) && admin.CommonLinks.IndexOf("," + systemMenu.Pkid.ToString() + ",") >= 0)
        {
            op = "del";
            title = "移出常用菜单";
        }

        context.Response.Write("<a href=\"javascript:;\" onclick=\"ajax_opCommonMenu('" + op + "', " + systemMenu.Pkid.ToString() + ");\" class=\"btn " + op + "\" title=\"" + title + "\"></a>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}