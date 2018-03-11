using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_siteMenuGroupManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private SiteMenu bll_siteMenu = new SiteMenu();

    private int total = 0;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        //执行操作
        Action();

        if (!Page.IsPostBack)
        {
            BindInfo();
        }
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        List<SiteMenuModel> siteMenuList = bll_siteMenu.GetListByFatherId(0);
        total = siteMenuList.Count;
        Repeater1.DataSource = siteMenuList;
        Repeater1.DataBind();
    }

    /// <summary>
    /// 执行操作的方法
    /// </summary>
    private void Action()
    {
        string cmd = Request["cmd"];
        if (String.IsNullOrEmpty(cmd)) return;
        string ids = Request.QueryString["ids"];

        if (cmd == "moveup") bll_siteMenu.MoveUp(ids);
        else if (cmd == "movedown") bll_siteMenu.MoveDown(ids);
        else if (cmd == "enab") bll_siteMenu.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_siteMenu.Delete(ids, true);
        else if (cmd == "updateall")
        {
            foreach (string key in Request.Form.AllKeys)
            {
                if (key.StartsWith("title"))
                {
                    string title = Request.Form[key];
                    string maxlevel = Request.Form[key.Replace("title", "maxlevel")];
                    if (String.IsNullOrEmpty(title)) continue;
                    if (!StringHelper.IsNumber(maxlevel)) maxlevel = "1";

                    if (key.IndexOf("#") > 0)
                    {
                        SiteMenuModel siteMenu = new SiteMenuModel();
                        siteMenu.Title = title;
                        siteMenu.FatherId = 0;
                        siteMenu.MaxLevel = Convert.ToInt32(maxlevel);
                        if (siteMenu.MaxLevel < 1) siteMenu.MaxLevel = 1;
                        bll_siteMenu.Insert(siteMenu);
                    }
                    else
                    {
                        string id = key.Replace("title", "");
                        SiteMenuModel siteMenu = bll_siteMenu.GetModel(id);
                        if (siteMenu == null) continue;
                        siteMenu.Title = title;
                        siteMenu.MaxLevel = Convert.ToInt32(maxlevel);
                        if (siteMenu.MaxLevel < 1) siteMenu.MaxLevel = 1;
                        bll_siteMenu.Update(siteMenu);
                    }
                }
            }

            WebUtility.ShowAlertMessage("全部保存成功！", Request.RawUrl);
        }

        Response.Redirect(Request.Url.AbsolutePath);
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        SiteMenuModel siteMenu = (SiteMenuModel)e.Item.DataItem;
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_siteMenu.GetStatus(siteMenu, "enab");

        if (e.Item.ItemIndex == 0) ((HtmlGenericControl)e.Item.FindControl("Eval_MoveUp")).InnerHtml = "<a class=\"icon icon_empty\"></a>";
        else ((HtmlGenericControl)e.Item.FindControl("Eval_MoveUp")).InnerHtml = "<a href=\"javascript:;\" onclick=\"operate('moveup'," + siteMenu.Pkid.ToString() + ",null);\" class=\"icon icon_moveup\" title=\"上移\"></a>";

        if (e.Item.ItemIndex == total - 1) ((HtmlGenericControl)e.Item.FindControl("Eval_MoveDown")).InnerHtml = "<a class=\"icon icon_empty\"></a>";
        else ((HtmlGenericControl)e.Item.FindControl("Eval_MoveDown")).InnerHtml = "<a href=\"javascript:;\" onclick=\"operate('movedown'," + siteMenu.Pkid.ToString() + ",null);\" class=\"icon icon_movedown\" title=\"下移\"></a>";
    }
}