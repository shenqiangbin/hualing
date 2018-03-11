using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_starManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private ForumUserState bll_forumUserState = new ForumUserState();
    public string groupName = String.Empty;

    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("论坛_论坛明星")) WebUtility.ShowError(WebUtility.ERROR101);
        
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
        Username.Value = Request.QueryString["uid"];

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(ForumUserStateModel.USERID, SqlWhere.Oper.Join, MemberModel.PKID));
        sqlWhereList.Add(new SqlWhere(MemberModel.USERNAME, SqlWhere.Oper.Equal, Request.QueryString["uid"]));
        sqlWhereList.Add(new SqlWhere(ForumUserStateModel.FORUMSTAR, SqlWhere.Oper.Equal, true));

        //组合排序方式
        List<SqlOrder> sqlOrderList = new List<SqlOrder>();
        sqlOrderList.Add(new SqlOrder(ForumUserStateModel.FORUMSTARSORT, true));
        sqlOrderList.Add(new SqlOrder(ForumUserStateModel.PKID, true));

        //读取分页数据
        int iRecordsTotal = bll_forumUserState.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<ForumUserStateModel> forumUserStateList = bll_forumUserState.GetList(pagination.PageIndex, iPageSize, null, sqlWhereList, sqlOrderList);

        //绑定
        if (forumUserStateList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = forumUserStateList;
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

        //if (cmd == "cancel") bll_forumUserState.UpdateStatus(ids, "top");

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ForumUserStateModel forumUserState = (ForumUserStateModel)e.Item.DataItem;
        MemberModel member = (MemberModel)forumUserState.Cache1;

        ((HtmlGenericControl)e.Item.FindControl("Eval_Pic")).InnerHtml = "<img src=\"" + member.Pic + "\" />";
        ((HtmlTableCell)e.Item.FindControl("Eval_Member")).InnerHtml = "<u>用户名：</u>" + member.Username + "<br /><u>真实姓名：</u>" + member.Realname + "<br /><u>昵称：</u>" + member.Nickname;
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("uid", Username.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}