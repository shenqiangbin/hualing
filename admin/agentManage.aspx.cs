using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_agentManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Area bll_area = new Area();
    private Member bll_member = new Member();

    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("用户_代理商管理")) WebUtility.ShowError(WebUtility.ERROR101);
        
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
        if (!String.IsNullOrEmpty(Request.QueryString["uid"])) Username.Value = Request.QueryString["uid"];
        AreaId.Value = Request.QueryString["area"];

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(MemberModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(MemberModel.AGENTAREA, SqlWhere.Oper.More, 0));
        sqlWhereList.Add(new SqlWhere(MemberModel.USERNAME, SqlWhere.Oper.Equal, Request.QueryString["uid"]));
        sqlWhereList.Add(new SqlWhere(ArticleModel.AREAID, SqlWhere.Oper.In, bll_area.GetIds(Request.QueryString["area"])));

        List<SqlOrder> sqlOrderList = new List<SqlOrder>();
        sqlOrderList.Add(new SqlOrder(MemberModel.AGENTAREA, false));
        sqlOrderList.Add(new SqlOrder(MemberModel.PKID, false));

        //读取分页数据
        int iRecordsTotal = bll_member.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<MemberModel> memberList = bll_member.GetList(pagination.PageIndex, iPageSize, sqlWhereList, sqlOrderList);

        //绑定
        if (memberList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = memberList;
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

        if (cmd == "cancel") bll_member.CancelAgent(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        MemberModel member = (MemberModel)e.Item.DataItem;

        ((HtmlTableCell)e.Item.FindControl("Eval_Area")).InnerHtml = bll_area.GetNav(member.AgentArea, "<u>-</u>");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(member.AgentCreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("uid", Username.Value);
        httpHelper.AddUrlParm("area", AreaId.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}