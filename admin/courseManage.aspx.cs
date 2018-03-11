using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_CourseManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Course bll_article = new Course();
    //设置页面大小
    int iPageSize = 20;
    public string cid = "";
    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("课程")) WebUtility.ShowError(WebUtility.ERROR101);
       
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
        //MyTitle.Value = Request.QueryString["title"];
        ////WebUtility.BindHtmlSelectByBool(IsHead, "--头条--", "是", "否", Request.QueryString["p1"]);
        //WebUtility.BindHtmlSelectByBool(IsTop, "--置顶--", "已置顶", "未置顶", Request.QueryString["top"]);
       // WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);

        //查询字段
        List<string> fieldList = new List<string>();
        fieldList.Add(CourseModel.PKID);
        fieldList.Add(CourseModel.WAY);
        fieldList.Add(CourseModel.ISSUE);
        fieldList.Add(CourseModel.ISTOP);
        fieldList.Add(CourseModel.ENABLED);
        fieldList.Add(CourseModel.OPENTIME);
        fieldList.Add(CourseModel.CREATETIME);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(CourseModel.WAY, SqlWhere.Oper.Like, Request.QueryString["title"]));
        //sqlWhereList.Add(new SqlWhere(CourseModel., SqlWhere.Oper.Equal, Request.QueryString["p1"]));
        sqlWhereList.Add(new SqlWhere(CourseModel.ISTOP, SqlWhere.Oper.Equal, Request.QueryString["top"]));
        sqlWhereList.Add(new SqlWhere(CourseModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));

        //读取分页数据
        int iRecordsTotal = bll_article.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<CourseModel> articleList = bll_article.GetList(pagination.PageIndex, iPageSize, fieldList, sqlWhereList, null);

        //绑定
        if (articleList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = articleList;
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

        if (cmd == "top") bll_article.UpdateStatus(ids, "top");
        else if (cmd == "enab") bll_article.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_article.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        CourseModel article = (CourseModel)e.Item.DataItem;

        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerHtml = article.Way;
       
        //((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_article.GetStatus(article, "top") + "<u>|</u>" + bll_article.GetStatus(article, "enab");  //bll_article.GetStatus(article, "head") + "<u>|</u>" + 
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(article.Opentime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        //httpHelper.AddUrlParm("title", MyTitle.Value);
        //httpHelper.AddUrlParm("top", IsTop.Value);
        //httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}