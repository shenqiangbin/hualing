<%@ WebHandler Language="C#" Class="getCategoryTree" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getCategoryTree : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();

    public void ProcessRequest(HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;
        if (!bll_admin.RuleAuth("全局_导航菜单")) return;

        CategoryModel group = bll_category.GetModel(context.Request.QueryString["gid"]);
        if (group == null) return;

        string result = CreateTree(group.Pkid, String.Empty).ToString();

        if (result.Length > 0) context.Response.Write(result);
        else context.Response.Write("<tr><td colspan='2' class='nodata'></td></tr>");
    }

    /// <summary>
    /// 递归生成树的方法
    /// </summary>
    private StringBuilder CreateTree(int fatherId, string line)
    {
        StringBuilder strHtml = new StringBuilder();
        List<CategoryModel> categoryList = bll_category.GetListByFatherId(fatherId);

        for (int i = 0; i < categoryList.Count; i++)
        {
            CategoryModel category = categoryList[i];

            string nodeStyle = String.Empty, rankStyle = String.Empty;
            if (category.HasChild) nodeStyle = category.IsOpen.ToString();
            if (i == categoryList.Count - 1) rankStyle = "last";

            strHtml.Append("<tr lv=\"").Append(category.ILevel).Append("\" onoff=\"").Append(nodeStyle).Append("\" rank=\"").Append(rankStyle).Append("\" line=\"").Append(line).Append("\">");
            strHtml.Append("<td><u>").Append(category.Title).Append("</u></td>");
            strHtml.Append("<td>");
            strHtml.Append("<input type=\"hidden\" value=\"").Append(category.Pkid).Append("\" />");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"ajax_addSiteMenuFromTree('addcat', 'self', ").Append(category.Pkid).Append(");\" class=\"icon icon_add\" title=\"仅加入自己到菜单\"></a>");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"ajax_addSiteMenuFromTree('addcat', 'all', ").Append(category.Pkid).Append(");\" class=\"icon icon_addall\" title=\"加入自己和子类到菜单\"></a>");
            strHtml.Append("</td>");
            strHtml.Append("</tr>");

            string subLine = line;
            if (i == categoryList.Count - 1) subLine += "0";
            else subLine += "1";

            if (category.HasChild && category.IsOpen) strHtml.Append(CreateTree(category.Pkid, subLine));
        }

        return strHtml;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}