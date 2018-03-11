<%@ WebHandler Language="C#" Class="getSiteMenuTree" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getSiteMenuTree : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private SiteMenu bll_siteMenu = new SiteMenu();
    SiteMenuModel group = null;

    public void ProcessRequest(HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;
        if (!bll_admin.RuleAuth("全局_导航菜单")) return;

        //获取导航组
        group = bll_siteMenu.GetModel(context.Request.QueryString["gid"]);
        if (group == null || group.FatherId != 0) return;

        //生成树
        string result = CreateTree(group.Pkid, String.Empty).ToString();

        if (result.Length > 0) context.Response.Write(result);
        else context.Response.Write("<tr><td colspan='5' class='nodata'>请操作右侧【新增菜单】面板来添加新菜单</td></tr>");
    }

    /// <summary>
    /// 递归生成树的方法
    /// </summary>
    private StringBuilder CreateTree(int fatherId, string line)
    {
        StringBuilder strHtml = new StringBuilder();

        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.FATHERID, SqlWhere.Oper.Equal, fatherId));
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.GROUPID, SqlWhere.Oper.Equal, group.Pkid));
        List<SiteMenuModel> siteMenuList = bll_siteMenu.GetList(sqlWhereList);

        for (int i = 0; i < siteMenuList.Count; i++)
        {
            SiteMenuModel siteMenu = siteMenuList[i];

            string nodeStyle = String.Empty, rankStyle = String.Empty;
            if (siteMenu.ILevel < (group.MaxLevel + 1) && siteMenu.HasChild) nodeStyle = siteMenu.IsOpen.ToString();
            if (i == siteMenuList.Count - 1) rankStyle = "last";

            strHtml.Append("<tr lv=\"").Append(siteMenu.ILevel).Append("\" onoff=\"").Append(nodeStyle).Append("\" rank=\"").Append(rankStyle).Append("\" line=\"").Append(line).Append("\">");
            strHtml.Append("<td align=\"center\"><input type=\"checkbox\" name=\"g1\" value=\"").Append(siteMenu.Pkid).Append("\" /></td>");
            strHtml.Append("<td><u>").Append(siteMenu.Title).Append("</u><input type=\"hidden\" value=\"").Append(siteMenu.Pkid).Append("\" /></td>");
            strHtml.Append("<td class=\"gray\">").Append(siteMenu.Enabled ? "<span class=\"green\">是</span>" : "否").Append("</td>");
            strHtml.Append("<td class=\"gray\">").Append(siteMenu.Target == "_blank" ? "<span class=\"green\">是</span>" : "否").Append("</td>");
            strHtml.Append("<td>");
            if (i > 0) strHtml.Append("<a href=\"javascript:;\" onclick=\"ajax_siteMenuHandler('moveup',").Append(siteMenu.Pkid).Append(");\" class=\"icon icon_moveup\" title=\"上移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            if (i < siteMenuList.Count - 1) strHtml.Append("<a href=\"javascript:;\" onclick=\"ajax_siteMenuHandler('movedown',").Append(siteMenu.Pkid).Append(");\" class=\"icon icon_movedown\" title=\"下移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            strHtml.Append("<a href=\"siteMenuEdit.aspx?pkid=").Append(siteMenu.Pkid).Append("&gid=").Append(group.Pkid).Append("\" class=\"icon icon_edit\" title=\"编辑\"></a>");
            strHtml.Append("<div class=\"operation\">");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"ajax_siteMenuHandler('del',").Append(siteMenu.Pkid).Append(");\" class=\"icon icon_del\" title=\"删除\"></a>");
            strHtml.Append("<div>");
            strHtml.Append("</td>");
            strHtml.Append("</tr>");

            if (siteMenu.ILevel < group.MaxLevel + 1)
            {
                string subLine = line;
                if (i == siteMenuList.Count - 1) subLine += "0";
                else subLine += "1";

                if (siteMenu.HasChild && siteMenu.IsOpen) strHtml.Append(CreateTree(siteMenu.Pkid, subLine));
            }
        }

        return strHtml;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}