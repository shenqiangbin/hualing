using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_adFixedManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private AdGroup bll_adGroup = new AdGroup();
    private AdFixed bll_adFixed = new AdFixed();

    //设置页面大小
    int iPageSize = 10;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        
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
        bll_adGroup.BindDropDownList(GroupId, Request.QueryString["gid"], "--广告组--");
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(AdGroupModel.PKID, SqlWhere.Oper.Join, AdFixedModel.GROUPID));
        sqlWhereList.Add(new SqlWhere(AdGroupModel.INBUILT, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, Request.QueryString["gid"]));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));

        //读取分页数据
        int iRecordsTotal = bll_adFixed.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<AdFixedModel> adFixedList = bll_adFixed.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定
        if (adFixedList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = adFixedList;
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

        if (cmd == "enab") bll_adFixed.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_adFixed.Delete(ids, true);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        AdFixedModel adFixed = (AdFixedModel)e.Item.DataItem;

        if (String.IsNullOrEmpty(adFixed.Pic)) ((HtmlTableCell)e.Item.FindControl("Eval_Pic")).InnerHtml = "无图";
        else ((HtmlTableCell)e.Item.FindControl("Eval_Pic")).InnerHtml = "<div class=\"pic\"><a href=\"" + adFixed.Url + "\" target=\"_blank\"><img src=\"" + adFixed.Pic + "\" /></a></div>";
        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerHtml = adFixed.Title + "<br /><span class=\"gray\">" + adFixed.Notes + "</span>";
        ((HtmlTableCell)e.Item.FindControl("Eval_GroupName")).InnerHtml = bll_adGroup.GetTitle(adFixed.GroupId);
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_adFixed.GetStatus(adFixed, "enab");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(adFixed.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("gid", GroupId.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}