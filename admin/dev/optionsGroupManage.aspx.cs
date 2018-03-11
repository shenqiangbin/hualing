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

public partial class admin_dev_optionsGroupManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Options bll_options = new Options();

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
        List<OptionsModel> optionsList = bll_options.GetListByFatherId(0);
        total = optionsList.Count;
        Repeater1.DataSource = optionsList;
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

        if (cmd == "moveup") bll_options.MoveUp(ids);
        else if (cmd == "movedown") bll_options.MoveDown(ids);
        else if (cmd == "enab") bll_options.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_options.Delete(ids, true);
        else if (cmd == "updateall")
        {
            foreach (string key in Request.Form.AllKeys)
            {
                if (key.StartsWith("title"))
                {
                    string title = Request.Form[key];
                    string sort = Request.Form[key.Replace("title", "sort")];
                    if (String.IsNullOrEmpty(title)) continue;
                    if (!StringHelper.IsNumber(sort)) sort = "1";

                    if (key.IndexOf("#") > 0)
                    {
                        OptionsModel options = new OptionsModel();
                        options.Title = title;
                        options.FatherId = 0;
                        options.Enabled = true;
                        bll_options.Insert(options);
                    }
                    else
                    {
                        string id = key.Replace("title", "");
                        OptionsModel options = bll_options.GetModel(id);
                        if (options == null) continue;
                        options.Title = title;
                        bll_options.Update(options);
                    }
                }
            }

            WebUtility.ShowAlertMessage("全部保存成功！", Request.RawUrl);
        }

        Response.Redirect(Request.Url.AbsolutePath);
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        OptionsModel options = (OptionsModel)e.Item.DataItem;
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_options.GetStatus(options, "enab");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(options.CreateTime);

        if (e.Item.ItemIndex == 0) ((HtmlGenericControl)e.Item.FindControl("Eval_MoveUp")).InnerHtml = "<a class=\"icon icon_empty\"></a>";
        else ((HtmlGenericControl)e.Item.FindControl("Eval_MoveUp")).InnerHtml = "<a href=\"javascript:;\" onclick=\"operate('moveup'," + options.Pkid.ToString() + ",null);\" class=\"icon icon_moveup\" title=\"上移\"></a>";

        if (e.Item.ItemIndex == total - 1) ((HtmlGenericControl)e.Item.FindControl("Eval_MoveDown")).InnerHtml = "<a class=\"icon icon_empty\"></a>";
        else ((HtmlGenericControl)e.Item.FindControl("Eval_MoveDown")).InnerHtml = "<a href=\"javascript:;\" onclick=\"operate('movedown'," + options.Pkid.ToString() + ",null);\" class=\"icon icon_movedown\" title=\"下移\"></a>";
    }
}