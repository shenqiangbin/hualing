<%@ WebHandler Language="C#" Class="getForumTree" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getForumTree : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private ForumMenu bll_forumMenu = new ForumMenu();

    public void ProcessRequest(HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;
        if (!bll_admin.RuleAuth("全局_导航菜单")) return;

        string result = CreateTree(0, String.Empty).ToString();

        if (result.Length > 0) context.Response.Write(result);
        else context.Response.Write("<tr><td colspan='2' class='nodata'></td></tr>");
    }

    /// <summary>
    /// 递归生成树的方法
    /// </summary>
    private StringBuilder CreateTree(int fatherId, string line)
    {
        StringBuilder strHtml = new StringBuilder();
        List<ForumMenuModel> forumMenuList = bll_forumMenu.GetListByFatherId(fatherId);

        for (int i = 0; i < forumMenuList.Count; i++)
        {
            ForumMenuModel forumMenu = forumMenuList[i];

            string nodeStyle = String.Empty, rankStyle = String.Empty;
            if (forumMenu.HasChild) nodeStyle = forumMenu.IsOpen.ToString();
            if (i == forumMenuList.Count - 1) rankStyle = "last";

            strHtml.Append("<tr lv=\"").Append(forumMenu.ILevel).Append("\" onoff=\"").Append(nodeStyle).Append("\" rank=\"").Append(rankStyle).Append("\" line=\"").Append(line).Append("\">");
            strHtml.Append("<td><u>").Append(forumMenu.Title).Append("</u></td>");
            strHtml.Append("<td>");
            strHtml.Append("<input type=\"hidden\" value=\"").Append(forumMenu.Pkid).Append("\" />");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"ajax_addSiteMenuFromTree('addbbs', 'self', ").Append(forumMenu.Pkid).Append(");\" class=\"icon icon_add\" title=\"仅加入自己到菜单\"></a>");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"ajax_addSiteMenuFromTree('addbbs', 'all', ").Append(forumMenu.Pkid).Append(");\" class=\"icon icon_addall\" title=\"加入自己和子类到菜单\"></a>");
            strHtml.Append("</td>");
            strHtml.Append("</tr>");

            string subLine = line;
            if (i == forumMenuList.Count - 1) subLine += "0";
            else subLine += "1";

            if (forumMenu.HasChild && forumMenu.IsOpen) strHtml.Append(CreateTree(forumMenu.Pkid, subLine));
        }

        return strHtml;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}