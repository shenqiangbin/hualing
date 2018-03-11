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

public partial class admin_dev_optionsManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Options bll_options = new Options();

    public string groupId = String.Empty;
    private int total = 0;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {        
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("全局_选项管理")) WebUtility.ShowError(WebUtility.ERROR101);

        //获取选项组
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(OptionsModel.FATHERID, SqlWhere.Oper.Equal, 0));
        sqlWhereList.Add(new SqlWhere(OptionsModel.ENABLED, SqlWhere.Oper.Equal, true));
        List<OptionsModel> optionsList = bll_options.GetList(sqlWhereList);
        Repeater2.DataSource = optionsList;
        Repeater2.DataBind();

        if (optionsList.Count == 0) WebUtility.ShowError(WebUtility.ERROR102);

        //获取当前选项组ID
        foreach (OptionsModel options in optionsList)
        {
            if (options.Pkid.ToString() == Request.QueryString["gid"])
            { groupId = Request.QueryString["gid"]; break; }
        }
        if (String.IsNullOrEmpty(groupId)) groupId = optionsList[0].Pkid.ToString();

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
        List<OptionsModel> optionsList = bll_options.GetListByFatherId(Convert.ToInt32(groupId));
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
        else if (cmd == "del") bll_options.Delete(ids);
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
                        options.FatherId = Convert.ToInt32(groupId);
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

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        OptionsModel options = (OptionsModel)e.Item.DataItem;
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_options.GetStatus(options, "enab");

        if (e.Item.ItemIndex == 0) ((HtmlGenericControl)e.Item.FindControl("Eval_MoveUp")).InnerHtml = "<a class=\"icon icon_empty\"></a>";
        else ((HtmlGenericControl)e.Item.FindControl("Eval_MoveUp")).InnerHtml = "<a href=\"javascript:;\" onclick=\"operate('moveup'," + options.Pkid.ToString() + ",'" + param + "');\" class=\"icon icon_moveup\" title=\"上移\"></a>";

        if (e.Item.ItemIndex == total - 1) ((HtmlGenericControl)e.Item.FindControl("Eval_MoveDown")).InnerHtml = "<a class=\"icon icon_empty\"></a>";
        else ((HtmlGenericControl)e.Item.FindControl("Eval_MoveDown")).InnerHtml = "<a href=\"javascript:;\" onclick=\"operate('movedown'," + options.Pkid.ToString() + ",'" + param + "');\" class=\"icon icon_movedown\" title=\"下移\"></a>";
    }
}