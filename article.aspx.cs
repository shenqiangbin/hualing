using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class article : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Article bll_article = new Article();
    private Category bll_category = new Category();
    public CategoryModel category = null;
    public ArticleModel model = null;
    protected List<CategoryModel> categoryList = new List<CategoryModel>();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        model = bll_article.GetModel(Request.QueryString["pkid"]);
        if (model == null) WebUtility.Goto404();

        category = bll_category.GetModel(model.CategoryId);
        if (category == null) WebUtility.Goto404();

        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        banner1.kind = 31;
        Right1.kind = 4;
       Right1.menu = category.Pkid;
        Master.Index = 6;
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();

        //Title
        bll_config.Load(new string[] { "pageTitle" });
        Page.Title = model.Title + " - " + category.Title + " - " + bll_config["pageTitle"];

        //KeyWord
        HtmlMeta keywords = new HtmlMeta();
        keywords.Name = "keywords";
        keywords.Content = model.Keywords;
        Page.Header.Controls.Add(keywords);

        //Description
        HtmlMeta description = new HtmlMeta();
        description.Name = "description";
        description.Content = model.Descn;
        Page.Header.Controls.Add(description);

        //面包屑导航


        //上一篇
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, model.CategoryId.ToString()));
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        //sqlWhereList.Add(new SqlWhere(ArticleModel.AREAID, SqlWhere.Oper.In, "0," + bll_area.GetIds(bll_area.CookieId)));

        ArticleModel prevModel = bll_article.GetPrev(model, sqlWhereList);
        if (prevModel == null) Prev.InnerHtml = "<a>上一篇：这就是第一篇文章啦~~</a>";
        else Prev.InnerHtml = "<a href=\"" + bll_article.GetUrl(prevModel) + "\" title='" + prevModel.Title + "' >上一篇：" + QianZhu.Utility.StringHelper.CutString(prevModel.Title, 45, "...") + "</a>";

        //下一篇
        //sqlWhereList.RemoveAt(2);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, model.CategoryId.ToString()));
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        ArticleModel nextModel = bll_article.GetNext(model, sqlWhereList);
        if (nextModel == null) Next.InnerHtml = "<a>下一篇：这就是最后一篇文章啦~~</a>";
        else Next.InnerHtml = "<a href=\"" + bll_article.GetUrl(nextModel) + "\" title='" + nextModel.Title + "'>下一篇：" + QianZhu.Utility.StringHelper.CutString(nextModel.Title, 45, "...") + "</a>";

        //浏览记录
        bll_article.RefreshPv(model);
        
    }
}