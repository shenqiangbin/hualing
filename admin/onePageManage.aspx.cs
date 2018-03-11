using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_onePageManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private OnePage bll_onePage = new OnePage();

    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("页面_页面管理")) WebUtility.ShowError(WebUtility.ERROR101);
        
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
        WebUtility.BindHtmlSelectByBool(Inbuilt, "--系统内置--", "是", "否", Request.QueryString["stat"]);
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);
        
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(OnePageModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(OnePageModel.INBUILT, SqlWhere.Oper.Equal, Request.QueryString["stat"]));
        sqlWhereList.Add(new SqlWhere(OnePageModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));

        //读取分页数据
        int iRecordsTotal = bll_onePage.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<OnePageModel> onePageList = bll_onePage.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定
        if (onePageList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = onePageList;
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

        if (cmd == "enab") bll_onePage.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_onePage.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        OnePageModel onePage = (OnePageModel)e.Item.DataItem;

        ((HtmlTableCell)e.Item.FindControl("Eval_Father")).InnerText = bll_onePage.GetTitle(onePage.FatherId);
        ((HtmlTableCell)e.Item.FindControl("Eval_Inbuilt")).InnerHtml = bll_onePage.GetStatus(onePage, "in");
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_onePage.GetStatus(onePage, "enab");
        if (onePage.Inbuilt) ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = "[ 系统内置 ]";
        else ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(onePage.CreateTime);

        e.Item.FindControl("Eval_Del").Visible = !onePage.Inbuilt;
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("stat", Inbuilt.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}