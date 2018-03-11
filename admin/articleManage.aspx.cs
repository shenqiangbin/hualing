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
    public string cid = "";
    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            cid = Request.QueryString["cid"];
        }
        catch (Exception)
        {
            cid = "1";
        }
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("文章_文章管理")) WebUtility.ShowError(WebUtility.ERROR101);
       
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
        CategoryId.Value = Request.QueryString["cid"];
       // AreaId.Value = Request.QueryString["area"];
        //WebUtility.BindHtmlSelectByBool(IsHead, "--头条--", "是", "否", Request.QueryString["p1"]);
        WebUtility.BindHtmlSelectByBool(IsTop, "--置顶--", "已置顶", "未置顶", Request.QueryString["top"]);
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);

        //查询字段
        List<string> fieldList = new List<string>();
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.CATEGORYID);
        fieldList.Add(ArticleModel.AREAID);
        fieldList.Add(ArticleModel.PV);
        fieldList.Add(ArticleModel.ISHEAD);
        fieldList.Add(ArticleModel.ISTOP);
        fieldList.Add(ArticleModel.ENABLED);
        fieldList.Add(ArticleModel.CREATETIME);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(ArticleModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        //sqlWhereList.Add(new SqlWhere(ArticleModel.ISHEAD, SqlWhere.Oper.Equal, Request.QueryString["p1"]));
        sqlWhereList.Add(new SqlWhere(ArticleModel.ISTOP, SqlWhere.Oper.Equal, Request.QueryString["top"]));
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds(Request.QueryString["cid"])));
        //sqlWhereList.Add(new SqlWhere(ArticleModel.AREAID, SqlWhere.Oper.In, bll_area.GetIds(Request.QueryString["area"])));

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

        if (cmd == "head") bll_article.UpdateStatus(ids, "head");
        else if (cmd == "top") bll_article.UpdateStatus(ids, "top");
        else if (cmd == "enab") bll_article.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_article.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ArticleModel article = (ArticleModel)e.Item.DataItem;
        string url = bll_article.GetUrl(article);

        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerHtml = "<a href=\"" + url + "\" title=\"" + article.Title + "\" target=\"_blank\">" + StringHelper.CutString(article.Title, 46, " ...") + "</a>";
        ((HtmlTableCell)e.Item.FindControl("Eval_Category")).InnerText = bll_category.GetTitle(article.CategoryId);
        //((HtmlTableCell)e.Item.FindControl("Eval_Area")).InnerText = bll_area.GetTitle(article.AreaId);
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_article.GetStatus(article, "top") + "<u>|</u>" + bll_article.GetStatus(article, "enab");  //bll_article.GetStatus(article, "head") + "<u>|</u>" + 
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(article.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("cid", CategoryId.Value);
        //httpHelper.AddUrlParm("area", AreaId.Value);
        //httpHelper.AddUrlParm("p1", IsHead.Value);
        httpHelper.AddUrlParm("top", IsTop.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}