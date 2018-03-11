<%@ WebHandler Language="C#" Class="getOnePage" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getOnePage : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private OnePage bll_onePage = new OnePage();

    public void ProcessRequest(HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;
        if (!bll_admin.RuleAuth("全局_导航菜单")) return;

        StringBuilder strHtml = new StringBuilder();
        List<OnePageModel> onePageList = bll_onePage.GetList();

        foreach (OnePageModel onePage in onePageList)
        {
            strHtml.Append("<tr>");
            strHtml.Append("<td>").Append(onePage.Title).Append("</td>");
            strHtml.Append("<td>");
            strHtml.Append("<input type=\"hidden\" value=\"").Append(onePage.Pkid).Append("\" />");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"ajax_addSiteMenuFromOnePage(").Append(onePage.Pkid).Append(");\" class=\"icon icon_add\" title=\"加入到菜单\"></a>");
            strHtml.Append("</td>");
            strHtml.Append("</tr>");
        }

        if (onePageList.Count > 0) context.Response.Write(strHtml.ToString());
        else context.Response.Write("<tr><td colspan='2' class='nodata'></td></tr>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}