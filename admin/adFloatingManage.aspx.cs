using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_adFloatingManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private AdFloating bll_adFloating = new AdFloating();

    //设置页面大小
    int iPageSize = 10;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("广告_悬浮广告")) WebUtility.ShowError(WebUtility.ERROR101);
        
        if (!Page.IsPostBack)
        {
            Action();
            BindInfo();
        }
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {        
        //搜索控件
        MyTitle.Value = Request.QueryString["title"];
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(AdFloatingModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(AdFloatingModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));

        //读取分页数据
        int iRecordsTotal = bll_adFloating.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<AdFloatingModel> adFloatingList = bll_adFloating.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定
        if (adFloatingList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = adFloatingList;
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

        if (cmd == "enab") bll_adFloating.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_adFloating.Delete(ids);

        bll_adFloating.CreateJsFile();
        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        AdFloatingModel adFloating = (AdFloatingModel)e.Item.DataItem;

        string location = XMLHelper.GetXmlDataVal(adFloating.Location.ToString(), "Location");
        if (adFloating.Location == 1) location += " , 上 ( " + adFloating.MarginTop.ToString() + " ) , 左 ( " + adFloating.MarginLeft.ToString() + " )";
        else if (adFloating.Location == 2) location += " , 上 ( " + adFloating.MarginTop.ToString() + " ) , 右 ( " + adFloating.MarginRight.ToString() + " )";
        else if (adFloating.Location == 3) location += " , 下 ( " + adFloating.MarginBottom.ToString() + " ) , 左 ( " + adFloating.MarginLeft.ToString() + " )";
        else if (adFloating.Location == 4) location += " , 下 ( " + adFloating.MarginBottom.ToString() + " ) , 右 ( " + adFloating.MarginRight.ToString() + " )";

        ((HtmlGenericControl)e.Item.FindControl("Eval_Pic")).InnerHtml = "<a href=\"" + adFloating.Url + "\" target=\"_blank\"><img src=\"" + adFloating.Pic + "\" /></a>";
        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerHtml = adFloating.Title + "<br /><span class=\"gray\">" + location + "</span>";
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_adFloating.GetStatus(adFloating, "enab");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(adFloating.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}