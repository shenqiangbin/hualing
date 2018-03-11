using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_forum_menuManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private ForumMenu bll_forumMenu = new ForumMenu();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("论坛_论坛版块")) WebUtility.ShowError(WebUtility.ERROR101);

        //执行操作
        Action();
    }

    /// <summary>
    /// 递归生成树的方法
    /// </summary>
    public StringBuilder CreateTree(int fatherId)
    {
        StringBuilder strHtml = new StringBuilder();
        List<ForumMenuModel> forumMenuList = bll_forumMenu.GetListByFatherId(fatherId);

        for (int i = 0; i < forumMenuList.Count ; i++)
        {
            ForumMenuModel forumMenu = forumMenuList[i];

            string nodeStyle = String.Empty;
            if (forumMenu.ILevel < ForumMenu.MAX_LEVEL && forumMenu.HasChild) nodeStyle = forumMenu.IsOpen.ToString();

            strHtml.Append("<tr lv=\"").Append(forumMenu.ILevel).Append("\" onoff=\"").Append(nodeStyle).Append("\">");
            strHtml.Append("<td align=\"center\"><input type=\"checkbox\" name=\"g1\" value=\"").Append(forumMenu.Pkid).Append("\" /></td>");
            strHtml.Append("<td><input name=\"title").Append(forumMenu.Pkid).Append("\" value=\"").Append(forumMenu.Title).Append("\" maxlength=\"10\" type=\"text\" class=\"text\" /></td>");
            strHtml.Append("<td>").Append(forumMenu.Pkid).Append("</td>");
            strHtml.Append("<td class=\"gray\">").Append(bll_forumMenu.GetStatus(forumMenu, "reco")).Append("<u>|</u>").Append(bll_forumMenu.GetStatus(forumMenu, "enab")).Append("</td>");
            strHtml.Append("<td>");
            if (i > 0) strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('moveup',").Append(forumMenu.Pkid).Append(",null);\" class=\"icon icon_moveup\" title=\"上移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            if (i < forumMenuList.Count - 1) strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('movedown',").Append(forumMenu.Pkid).Append(",null);\" class=\"icon icon_movedown\" title=\"下移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            strHtml.Append("<a href=\"menuEdit.aspx?pkid=").Append(forumMenu.Pkid).Append("\" class=\"icon icon_edit\" title=\"编辑\"></a>");
            strHtml.Append("<div class=\"operation\">");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('del',").Append(forumMenu.Pkid).Append(",null);\" class=\"icon icon_del\" title=\"删除\"></a>");
            strHtml.Append("<div>");
            strHtml.Append("</td>");
            strHtml.Append("</tr>");

            if (forumMenu.ILevel < ForumMenu.MAX_LEVEL)
            {
                if (forumMenu.HasChild && forumMenu.IsOpen) strHtml.Append(CreateTree(forumMenu.Pkid));

                strHtml.Append("<tr lv=\"").Append(forumMenu.ILevel + 1).Append("\" rank=\"last\">");
                strHtml.Append("<td></td>");
                strHtml.Append("<td colspan=\"4\"><a href=\"javascript:;\" onclick=\"addMenu($(this), ").Append(forumMenu.Pkid).Append(");\" class=\"icon2 icon_add\"> [").Append(forumMenu.Title).Append("] 子菜单</a></td>");
                strHtml.Append("</tr>");
            }
        }

        return strHtml;
    }

    /// <summary>
    /// 执行操作的方法
    /// </summary>
    private void Action()
    {
        string cmd = Request["cmd"];
        if (String.IsNullOrEmpty(cmd)) return;
        string ids = Request.QueryString["ids"];

        if (cmd == "moveup") bll_forumMenu.MoveUp(ids);
        else if (cmd == "movedown") bll_forumMenu.MoveDown(ids);
        else if (cmd == "onoff") bll_forumMenu.UpdateStatus(ids, "onoff");
        else if (cmd == "reco") bll_forumMenu.UpdateStatus(ids, "reco");
        else if (cmd == "enab") bll_forumMenu.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_forumMenu.Delete(ids);
        else if (cmd == "updateall")
        {
            foreach (string key in Request.Form.AllKeys)
            {
                if (key.StartsWith("title"))
                {
                    string title = Request.Form[key];
                    string url = Request.Form[key.Replace("title", "url")];
                    if (String.IsNullOrEmpty(title)) continue;

                    if (key.IndexOf("#") > 0)
                    {
                        string fid = Request.Form[key.Replace("title", "fid")];
                        if (!StringHelper.IsNumber(fid)) continue;

                        ForumMenuModel forumMenu = new ForumMenuModel();
                        forumMenu.Title = title;
                        forumMenu.FatherId = Convert.ToInt32(fid);
                        bll_forumMenu.Insert(forumMenu);
                    }
                    else
                    {
                        string id = key.Replace("title", "");
                        ForumMenuModel forumMenu = bll_forumMenu.GetModel(id);
                        if (forumMenu == null) continue;
                        forumMenu.Title = title;
                        bll_forumMenu.Update(forumMenu);
                    }
                }
            }

            WebUtility.ShowAlertMessage("全部保存成功！", Request.RawUrl);
        }

        Response.Redirect(Request.Url.AbsolutePath);
    }
}