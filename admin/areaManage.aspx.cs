using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_areaManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Admin bll_admin = new Admin();
    private Area bll_area = new Area();

    public string defaultArea = "未设置";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("全局_地区管理")) WebUtility.ShowError(WebUtility.ERROR101);

        bll_config.Load(new string[] { "defaultArea" });
        AreaModel area = bll_area.GetModel(bll_config["defaultArea"]);
        if (area != null) defaultArea = area.Title;

        //执行操作
        Action();
    }

    /// <summary>
    /// 递归生成树的方法
    /// </summary>
    public StringBuilder CreateTree(int fatherId)
    {
        StringBuilder strHtml = new StringBuilder();
        List<AreaModel> areaList = bll_area.GetListByFatherId(fatherId);

        for (int i = 0; i < areaList.Count; i++)
        {
            AreaModel area = areaList[i];

            string nodeStyle = String.Empty;
            if (area.ILevel < Area.MAX_LEVEL) nodeStyle = area.IsOpen.ToString();

            strHtml.Append("<tr lv=\"").Append(area.ILevel).Append("\" onoff=\"").Append(nodeStyle).Append("\">");
            strHtml.Append("<td align=\"center\"><input type=\"checkbox\" name=\"g1\" value=\"").Append(area.Pkid).Append("\" /></td>");
            strHtml.Append("<td><input name=\"title").Append(area.Pkid).Append("\" value=\"").Append(area.Title).Append("\" type=\"text\" class=\"text\" /></td>");
            strHtml.Append("<td>").Append(area.Pkid).Append("</td>");
            strHtml.Append("<td>").Append(area.Code).Append("</td>");
            strHtml.Append("<td class=\"gray\">").Append(bll_area.GetStatus(area, "hot")).Append("<u>|</u>").Append(bll_area.GetStatus(area, "enab")).Append("</td>");
            strHtml.Append("<td>");
            if (i > 0) strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('moveup',").Append(area.Pkid).Append(",null);\" class=\"icon icon_moveup\" title=\"上移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            if (i < areaList.Count - 1) strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('movedown',").Append(area.Pkid).Append(",null);\" class=\"icon icon_movedown\" title=\"下移\"></a>");
            else strHtml.Append("<a class=\"icon icon_empty\"></a>");
            strHtml.Append("<a href=\"areaEdit.aspx?pkid=").Append(area.Pkid).Append("\" class=\"icon icon_edit\" title=\"编辑\"></a>");
            strHtml.Append("<div class=\"operation\">");
            strHtml.Append("<a href=\"javascript:;\" onclick=\"operate('del',").Append(area.Pkid).Append(",null);\" class=\"icon icon_del\" title=\"删除\"></a>");
            strHtml.Append("<div>");
            strHtml.Append("</td>");
            strHtml.Append("</tr>");

            if (area.ILevel < Area.MAX_LEVEL)
            {
                if (area.HasChild && area.IsOpen) strHtml.Append(CreateTree(area.Pkid));

                strHtml.Append("<tr lv=\"").Append(area.ILevel + 1).Append("\" rank=\"last\">");
                strHtml.Append("<td></td>");
                strHtml.Append("<td colspan=\"5\"><a href=\"javascript:;\" onclick=\"addArea($(this), ").Append(area.Pkid).Append(");\" class=\"icon2 icon_add\"> [").Append(area.Title).Append("] 子类别</a></td>");
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

        if (cmd == "moveup") bll_area.MoveUp(ids);
        else if (cmd == "movedown") bll_area.MoveDown(ids);
        else if (cmd == "onoff") bll_area.UpdateStatus(ids, "onoff");
        else if (cmd == "hot") bll_area.UpdateStatus(ids, "hot");
        else if (cmd == "enab") bll_area.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_area.Delete(ids);
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

                        AreaModel area = new AreaModel();
                        area.Title = title;
                        area.FatherId = Convert.ToInt32(fid);
                        bll_area.Insert(area);
                    }
                    else
                    {
                        string id = key.Replace("title", "");
                        AreaModel area = bll_area.GetModel(id);
                        if (area == null) continue;
                        area.Title = title;
                        bll_area.Update(area);
                    }
                }
            }

            WebUtility.ShowAlertMessage("全部保存成功！", Request.RawUrl);
        }

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void ConfirmButton_Click(object sender, ImageClickEventArgs e)
    {
        if (Page.IsValid)
        {
            AreaModel area = bll_area.GetModel(DefaultArea.Value);
            if (area == null) WebUtility.ShowAlertMessage("请选择默认地区！", null);
            bll_config["defaultArea"] = DefaultArea.Value;
            bll_config.Update();
            Response.Redirect(Request.Url.AbsolutePath);
        }
    }
}