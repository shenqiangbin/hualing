using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_commentManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Comment bll_comment = new Comment();
    private Member bll_member = new Member();

    //设置页面大小
    int iPageSize = 10;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("用户_用户评论")) WebUtility.ShowError(WebUtility.ERROR101);
        
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
        MyContent.Value = Request.QueryString["title"];
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "正常", "屏蔽", Request.QueryString["enab"]);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(CommentModel.CONTENT, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(CommentModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));

        //读取分页数据
        int iRecordsTotal = bll_comment.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<CommentModel> commentList = bll_comment.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定
        if (commentList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = commentList;
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

        if (cmd == "enab") bll_comment.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_comment.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        CommentModel comment = (CommentModel)e.Item.DataItem;
        MemberModel member = bll_member.GetModel(comment.Creator);

        string content = "<span class='gray'>";
        if (member != null) content += bll_member.GetName(member);
        else if (!String.IsNullOrEmpty(comment.Nickname)) content += comment.Nickname;
        else content += "[ 匿名 ]";
        content += "　" + DateHelper.ToShortDate(comment.CreateTime, "yyyy-MM-dd　HH:mm");
        content += "　( " + bll_comment.GetStatus(comment, "point") + " )</span><br />";
        content += StringHelper.TextToHtml(StringHelper.ClearHtml(comment.Content));

        ((HtmlTableCell)e.Item.FindControl("Eval_Content")).InnerHtml = content;
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_comment.GetStatus(comment, "enab");

        string url = "javascript:;";
        if (comment.Relation == ProjectModel._SYMBOL) url = new Project().GetUrl(comment.RelationId);
        else if (comment.Relation == ArticleModel._SYMBOL) url = new Article().GetUrl(comment.RelationId);
        else if (comment.Relation == ProductModel._SYMBOL) url = new Product().GetUrl(comment.RelationId);
        ((HtmlAnchor)e.Item.FindControl("Eval_Url")).HRef = url;
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyContent.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}