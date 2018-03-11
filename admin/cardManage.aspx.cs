using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_cardManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Area bll_area = new Area();
    private Member bll_member = new Member();
    private MemberCard bll_memberCard = new MemberCard();

    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("产品_惠卡管理")) WebUtility.ShowError(WebUtility.ERROR101);
        
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
        CardNo.Value = Request.QueryString["title"];
        Username.Value = Request.QueryString["uid"];
        AreaId.Value = Request.QueryString["area"];
        WebUtility.BindHtmlSelectByBool(Sold, "--出售状态--", "已出售", "未出售", Request.QueryString["p1"]);
        WebUtility.BindHtmlSelectByBool(Enabled, "--激活状态--", "已激活", "未激活", Request.QueryString["enab"]);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(MemberCardModel.CARDNO, SqlWhere.Oper.Equal, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(MemberCardModel.USERNAME, SqlWhere.Oper.Like, Request.QueryString["uid"]));
        sqlWhereList.Add(new SqlWhere(MemberCardModel.SOLD, SqlWhere.Oper.Equal, Request.QueryString["p1"]));
        sqlWhereList.Add(new SqlWhere(MemberCardModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));
        sqlWhereList.Add(new SqlWhere(MemberCardModel.CITYID, SqlWhere.Oper.In, bll_area.GetIds(Request.QueryString["area"])));

        //读取分页数据
        int iRecordsTotal = bll_memberCard.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<MemberCardModel> memberCardList = bll_memberCard.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定
        if (memberCardList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = memberCardList;
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

        if (cmd == "sold") bll_memberCard.UpdateStatus(ids, "sold");
        else if (cmd == "del") bll_memberCard.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        MemberCardModel memberCard = (MemberCardModel)e.Item.DataItem;

        ((HtmlTableCell)e.Item.FindControl("Eval_Area")).InnerHtml = bll_area.GetNav(memberCard.CityId, "<u>-</u>");
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_memberCard.GetStatus(memberCard, "sold") + "<u>|</u>" + bll_memberCard.GetStatus(memberCard, "enab");
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", CardNo.Value);
        httpHelper.AddUrlParm("uid", Username.Value);
        httpHelper.AddUrlParm("area", AreaId.Value);
        httpHelper.AddUrlParm("p1", Sold.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}