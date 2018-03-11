using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_categoryManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();
    public CategoryModel group = null;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        group = bll_category.GetModel(Request.QueryString["gid"]);
        if (group == null) WebUtility.ShowError(WebUtility.ERROR102);

        if (!bll_admin.RuleAuth(group.Title)) WebUtility.ShowError(WebUtility.ERROR101);

        //执行操作
        Action();
    }

    /// <summary>
    /// 递归生成树的方法
    /// </summary>
    public StringBuilder CreateTree(int fatherId)
    {
        StringBuilder strHtml = new StringBuilder();
        List<CategoryModel> categoryList = bll_category.GetListByFatherId(fatherId);

        for (int i = 0; i < categoryList.Count; i++)
        {
            CategoryModel category = categoryList[i];

            string nodeStyle = String.Empty;
            if (category.ILevel < (group.MaxLevel + 1) && category.HasChild) nodeStyle = category.IsOpen.ToString();

            strHtml.Append("<tr lv=\"").Append(category.ILevel - 1).Append("\" onoff=\"").Append(nodeStyle).Append("\">");
            strHtml.Append("<td align=\"center\"><input type=\"checkbox\" name=\"g1\" value=\"").Append(category.Pkid).Append("\" /></td>");
            strHtml.Append("<td><input name=\"title").Append(category.Pkid).Append("\" value=\"").Append(category.Title).Append("\" type=\"text\" class=\"text\" /></td>");
            strHtml.Append("<td>").Append(category.Pkid).Append("</td>");
            strHtml.Append("<td class=\"gray\">").Append(bll_category.GetStatus(category, "enab")).Append("</td>");
            strHtml.Append("<td>").Append(DateHelper.ToShortDate(category.CreateTime)).Append("</td>");
            strHtml.Append("<td>");
            if (i > 0) strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('moveup',").Append(category.Pkid).Append(",'").Append(param).Append("');\" class=\"icon icon_moveup\" title=\"上移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            if (i < categoryList.Count - 1) strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('movedown',").Append(category.Pkid).Append(",'").Append(param).Append("');\" class=\"icon icon_movedown\" title=\"下移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            strHtml.Append("<a href=\"categoryEdit.aspx?pkid=").Append(category.Pkid).Append(param).Append("\" class=\"icon icon_edit\" title=\"编辑\"></a>");
            strHtml.Append("<div class=\"operation\">");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('del',").Append(category.Pkid).Append(",'").Append(param).Append("');\" class=\"icon icon_del\" title=\"删除\"></a>");
            strHtml.Append("<div>");
            strHtml.Append("</td>");
            strHtml.Append("</tr>");

            if (category.ILevel < group.MaxLevel + 1)
            {
                if (category.HasChild && category.IsOpen) strHtml.Append(CreateTree(category.Pkid));

                strHtml.Append("<tr lv=\"").Append(category.ILevel).Append("\" rank=\"last\">");
                strHtml.Append("<td></td>");
                strHtml.Append("<td colspan=\"5\"><a href=\"javascript:;\" onclick=\"addCategory($(this), ").Append(category.Pkid).Append(");\" class=\"icon2 icon_add\"> [").Append(category.Title).Append("] 子类别</a></td>");
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

        if (cmd == "moveup") bll_category.MoveUp(ids);
        else if (cmd == "movedown") bll_category.MoveDown(ids);
        else if (cmd == "onoff") bll_category.UpdateStatus(ids, "onoff");
        else if (cmd == "enab") bll_category.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_category.Delete(ids);
        else if (cmd == "updateall")
        {
            foreach (string key in Request.Form.AllKeys)
            {
                if (key.StartsWith("title"))
                {
                    string title = Request.Form[key];
                    if (String.IsNullOrEmpty(title)) continue;

                    if (key.IndexOf("#") > 0)
                    {
                        string fid = Request.Form[key.Replace("title", "fid")];
                        if (!StringHelper.IsNumber(fid)) continue;

                        CategoryModel category = new CategoryModel();
                        category.Title = title;
                        category.FatherId = Convert.ToInt32(fid);
                        bll_category.Insert(category);
                    }
                    else
                    {
                        string id = key.Replace("title", "");
                        CategoryModel category = bll_category.GetModel(id);
                        if (category == null) continue;
                        category.Title = title;
                        bll_category.Update(category);
                    }
                }
            }

            WebUtility.ShowAlertMessage("全部保存成功！", Request.RawUrl);
        }

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }
}