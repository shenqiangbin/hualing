using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_articleManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Area bll_area = new Area();
    private Category bll_category = new Category();
    private Article bll_article = new Article();
    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("经销商_经销商管理")) WebUtility.ShowError(WebUtility.ERROR101);
       
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
        //WebUtility.BindHtmlSelectByBool(IsHead, "--头条--", "是", "否", Request.QueryString["p1"]);
        WebUtility.BindHtmlSelectByBool(IsTop, "--置顶--", "已置顶", "未置顶", Request.QueryString["top"]);
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);
        
        //查询字段
        List<string> fieldList = new List<string>();
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.KEYWORDS);
        fieldList.Add(ArticleModel.ISTOP);
        fieldList.Add(ArticleModel.ENABLED);
        fieldList.Add(ArticleModel.CREATETIME);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(ArticleModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        //sqlWhereList.Add(new SqlWhere(ArticleModel.ISHEAD, SqlWhere.Oper.Equal, Request.QueryString["p1"]));
        sqlWhereList.Add(new SqlWhere(ArticleModel.ISTOP, SqlWhere.Oper.Equal, Request.QueryString["top"]));
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, "35"));
       

        //读取分页数据
        int iRecordsTotal = bll_article.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<ArticleModel> articleList = bll_article.GetList(pagination.PageIndex, iPageSize, fieldList, sqlWhereList, null);

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
        ArticleModel article = (ArticleModel)e.Item.DataItem;
        string url = bll_article.GetUrl(article);

        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerHtml = StringHelper.CutString(article.Title, 46, " ...");

        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml =  bll_article.GetStatus(article, "top") + "<u>|</u>" + bll_article.GetStatus(article, "enab");
        //((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(article.CreateTime);bll_article.GetStatus(article, "head") + "<u>|</u>" +
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        //httpHelper.AddUrlParm("p1", IsHead.Value);
        httpHelper.AddUrlParm("top", IsTop.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}