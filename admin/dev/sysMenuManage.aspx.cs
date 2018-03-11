using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_sysMenuManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private SystemMenu bll_systemMenu = new SystemMenu();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        
        //执行操作
        Action();
    }

    /// <summary>
    /// 递归生成树的方法
    /// </summary>
    public StringBuilder CreateTree(int fatherId)
    {
        StringBuilder strHtml = new StringBuilder();
        List<SystemMenuModel> systemMenuList = bll_systemMenu.GetListByFatherId(fatherId);

        for (int i = 0; i < systemMenuList.Count ; i++)
        {
            SystemMenuModel systemMenu = systemMenuList[i];

            string nodeStyle = String.Empty;
            if (systemMenu.ILevel < SystemMenu.MAX_LEVEL && systemMenu.HasChild) nodeStyle = systemMenu.IsOpen.ToString();

            strHtml.Append("<tr lv=\"").Append(systemMenu.ILevel).Append("\" onoff=\"").Append(nodeStyle).Append("\">");
            strHtml.Append("<td align=\"center\"><input type=\"checkbox\" name=\"g1\" value=\"").Append(systemMenu.Pkid).Append("\" /></td>");
            strHtml.Append("<td><input name=\"title").Append(systemMenu.Pkid).Append("\" value=\"").Append(systemMenu.Title).Append("\" maxlength=\"10\" type=\"text\" class=\"text\" /></td>");
            strHtml.Append("<td><input name=\"url").Append(systemMenu.Pkid).Append("\" value=\"").Append(systemMenu.Url).Append("\" maxlength=\"100\" type=\"text\" class=\"text\" /></td>");
            strHtml.Append("<td>").Append(systemMenu.Pkid).Append("</td>");
            strHtml.Append("<td class=\"gray\">").Append(bll_systemMenu.GetStatus(systemMenu, "enab")).Append("</td>");
            strHtml.Append("<td>");
            if (i > 0) strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('moveup',").Append(systemMenu.Pkid).Append(",null);\" class=\"icon icon_moveup\" title=\"上移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            if (i < systemMenuList.Count - 1) strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('movedown',").Append(systemMenu.Pkid).Append(",null);\" class=\"icon icon_movedown\" title=\"下移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            strHtml.Append("<a href=\"sysMenuEdit.aspx?pkid=").Append(systemMenu.Pkid).Append("\" class=\"icon icon_edit\" title=\"编辑\"></a>");
            strHtml.Append("<div class=\"operation\">");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('del',").Append(systemMenu.Pkid).Append(",null);\" class=\"icon icon_del\" title=\"删除\"></a>");
            strHtml.Append("<div>");
            strHtml.Append("</td>");
            strHtml.Append("</tr>");

            if (systemMenu.ILevel < SystemMenu.MAX_LEVEL)
            {
                if (systemMenu.HasChild && systemMenu.IsOpen) strHtml.Append(CreateTree(systemMenu.Pkid));

                strHtml.Append("<tr lv=\"").Append(systemMenu.ILevel + 1).Append("\" rank=\"last\">");
                strHtml.Append("<td></td>");
                strHtml.Append("<td colspan=\"5\"><a href=\"javascript:;\" onclick=\"addMenu($(this), ").Append(systemMenu.Pkid).Append(");\" class=\"icon2 icon_add\"> [").Append(systemMenu.Title).Append("] 子菜单</a></td>");
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

        if (cmd == "moveup") bll_systemMenu.MoveUp(ids);
        else if (cmd == "movedown") bll_systemMenu.MoveDown(ids);
        else if (cmd == "onoff") bll_systemMenu.UpdateStatus(ids, "onoff");
        else if (cmd == "enab") bll_systemMenu.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_systemMenu.Delete(ids);
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

                        SystemMenuModel systemMenu = new SystemMenuModel();
                        systemMenu.Title = title;
                        systemMenu.Url = url;
                        systemMenu.FatherId = Convert.ToInt32(fid);
                        bll_systemMenu.Insert(systemMenu);
                    }
                    else
                    {
                        string id = key.Replace("title", "");
                        SystemMenuModel systemMenu = bll_systemMenu.GetModel(id);
                        if (systemMenu == null) continue;
                        systemMenu.Title = title;
                        systemMenu.Url = url;
                        bll_systemMenu.Update(systemMenu);
                    }
                }
            }

            WebUtility.ShowAlertMessage("全部保存成功！", Request.RawUrl);
        }

        Response.Redirect(Request.Url.AbsolutePath);
    }
}