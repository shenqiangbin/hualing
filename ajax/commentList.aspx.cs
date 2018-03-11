using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class ajax_commentList : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Member bll_member = new Member();
    private Comment bll_comment = new Comment();

    //设置页面大小
    int iPageSize = 5;

    public int total = 0;
    
    protected void Page_Load(object sender, EventArgs e)
    {
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
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(CommentModel.RELATION, SqlWhere.Oper.Equal, Request.QueryString["sumbol"]));
        sqlWhereList.Add(new SqlWhere(CommentModel.RELATIONID, SqlWhere.Oper.Equal, Request.QueryString["fkid"]));
        sqlWhereList.Add(new SqlWhere(CommentModel.ENABLED, SqlWhere.Oper.Equal, true));
        
        //读取分页数据
        int iRecordsTotal = bll_comment.DoCount(sqlWhereList);
        Pagination pagination = new Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "javascript:ajax_getCommentList('" + Request.QueryString["eventId"] + "', '" + Request.QueryString["sumbol"] + "', '" + Request.QueryString["fkid"] + "', $p)", false);
        Paging.InnerHtml = pagination.Show();
        List<CommentModel> commentList = bll_comment.GetList(pagination.PageIndex, iPageSize, sqlWhereList, null);

        //绑定
        if (commentList.Count == 0) Paging.InnerHtml = "还没有人发表评论，就等你了！";
        total = commentList.Count;
        Repeater1.DataSource = commentList;
        Repeater1.DataBind();
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        CommentModel comment = (CommentModel)e.Item.DataItem;
        MemberModel member = bll_member.GetModel(comment.Creator);

        string name = "[匿名]";
        if (member != null) name = bll_member.GetName(member);
        else if (!String.IsNullOrEmpty(comment.Nickname)) name = comment.Nickname;

        ((HtmlGenericControl)e.Item.FindControl("Eval_User")).InnerHtml = name + " " + DateHelper.ToShortDate(comment.CreateTime, "yyyy-MM-dd HH:mm") + " 给出 " + bll_comment.GetStatus(comment, "point") + "：";
        ((HtmlGenericControl)e.Item.FindControl("Eval_Content")).InnerHtml = StringHelper.TextToHtml(StringHelper.ClearHtml(comment.Content));
    }
}