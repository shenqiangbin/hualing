<%@ WebHandler Language="C#" Class="getCommonMenuList" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getCommonMenuList : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private SystemMenu bll_systemMenu = new SystemMenu();
    
    public void ProcessRequest (HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;

        AdminModel admin = bll_admin.GetModelByCookie();
        if (String.IsNullOrEmpty(admin.CommonLinks))
        {
            PrintEmptyPrompt(context);
            return;
        }

        StringBuilder str = new StringBuilder();
        string[] arrVals = admin.CommonLinks.Split(new char[] { ',' });

        foreach (string val in arrVals)
        {
            SystemMenuModel menu = bll_systemMenu.GetModel(val);
            if (menu == null) continue;
            str.Append("<li url=\"").Append(menu.Url).Append("\" val=\"").Append(menu.Pkid.ToString()).Append("\" key=\"").Append(menu.Title).Append("\">");
            str.Append("<span>").Append(menu.Title).Append("</span>");
            if (!String.IsNullOrEmpty(menu.AddPageUrl))
                str.Append("<a class=\"add\" title=\"新增\" url=\"").Append(menu.AddPageUrl).Append("\" val=\"").Append(menu.Pkid.ToString()).Append("\" key=\"").Append(menu.Title).Append("\"></a>");
            str.Append("</li>");
        }

        if (str.Length > 0) context.Response.Write(str.ToString());
        else PrintEmptyPrompt(context);
    }

    private void PrintEmptyPrompt(HttpContext context)
    {
        context.Response.Write("<div class=\"nomenu\">");
        context.Response.Write("[操作提示]<br />");
        context.Response.Write("这里是常用菜单栏<br />");
        context.Response.Write("1.打开顶部导航的任意菜单<br />");
        context.Response.Write("2.在右侧窗口中找到标题<br />");
        context.Response.Write("3.点击标题右侧“<a class=\"btn add\">　</a>”按钮<br />");
        context.Response.Write("4.菜单将加入到这里！<br />");
        context.Response.Write("5.点击“<a class=\"btn del\">　</a>”可移除菜单");
        context.Response.Write("</div>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}