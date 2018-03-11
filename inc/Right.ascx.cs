using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class inc_Right : System.Web.UI.UserControl
{
    //建立业务逻辑层实例
    public int kind = 5;
    public int menu = 0;
    public int menu2 = 0;
    private AdFixed bll_adFixed = new AdFixed();
    protected AdFixedModel ad = new AdFixedModel();  //qq
    protected AdFixedModel ad1 = new AdFixedModel();  //
    protected AdFixedModel ad2 = new AdFixedModel();  //
    protected AdFixedModel ad6 = new AdFixedModel();  //微信
    protected AdFixedModel ad7 = new AdFixedModel();  //微博
    protected AdFixedModel ad8 = new AdFixedModel();  //最新课程下
    protected AdFixedModel ad9 = new AdFixedModel();  //考试心得下
    protected AdFixedModel ad10 = new AdFixedModel();  //
    protected AdFixedModel ad11 = new AdFixedModel();  //
    protected AdFixedModel ad12 = new AdFixedModel();  //
    private PageSection bll_pageSection = new PageSection();
    public PageSectionModel pageSection = null;
    protected SiteMenu bll_siteMenu = new SiteMenu();  //菜单
    protected SiteMenuModel siteMenu = new SiteMenuModel();  //菜单
    protected List<SiteMenuModel> SiteMenuList = new List<SiteMenuModel>();
    protected List<SiteMenuModel> SiteMenuList1 = new List<SiteMenuModel>();
    private Article bll_article = new Article();
    protected List<ArticleModel> articleList1 = new List<ArticleModel>();     //最新课程
    protected List<ArticleModel> articleList2 = new List<ArticleModel>();     //考试心得
    protected void Page_Load(object sender, EventArgs e)
    {
        ad = bll_adFixed.GetModel(1);
        ad1 = bll_adFixed.GetModel(46);
        ad2 = bll_adFixed.GetModel(47);
        ad6 = bll_adFixed.GetModel(5);
        ad7 = bll_adFixed.GetModel(23);
        ad8 = bll_adFixed.GetModel(24);
        ad9 = bll_adFixed.GetModel(25);
        ad10 = bll_adFixed.GetModel(90);
        ad11 = bll_adFixed.GetModel(91);
        ad12 = bll_adFixed.GetModel(92);
        pageSection = bll_pageSection.GetModel(4);

        siteMenu = bll_siteMenu.GetModel(kind);

        List<string> fieldList = new List<string>();
        fieldList.Add(SiteMenuModel.PKID);
        fieldList.Add(SiteMenuModel.TITLE);
        fieldList.Add(SiteMenuModel.URL);
        fieldList.Add(SiteMenuModel.TARGET);
        fieldList.Add(SiteMenuModel.RELATION);
        fieldList.Add(SiteMenuModel.RELATIONID);
        fieldList.Add(SiteMenuModel.HASCHILD);

        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.FATHERID, SqlWhere.Oper.Equal, kind));
        SiteMenuList = bll_siteMenu.GetList(1, 0, fieldList, sqlWhereList, null);

        // 考试资讯
        fieldList.Clear();
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.PIC);
        fieldList.Add(ArticleModel.ISHEAD);
        fieldList.Add(ArticleModel.FILES);
        fieldList.Add(ArticleModel.PUBDATE);
        fieldList.Add(ArticleModel.CREATETIME);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, "16"));
        articleList2 = bll_article.GetList(1, 5, fieldList, sqlWhereList, null);
    }
    public List<SiteMenuModel> getMenu(int Pkid,int gid)
    {
        List<string> fieldList = new List<string>();
        fieldList.Add(SiteMenuModel.TITLE);
        fieldList.Add(SiteMenuModel.URL);
        fieldList.Add(SiteMenuModel.TARGET);
        fieldList.Add(SiteMenuModel.RELATIONID);

        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
        //sqlWhereList.Add(new SqlWhere(SiteMenuModel.GROUPID, SqlWhere.Oper.Equal, gid.ToString()));
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.FATHERID, SqlWhere.Oper.Equal, Pkid.ToString()));
        List<SiteMenuModel> siteMenuList2 = bll_siteMenu.GetList(1, 0, fieldList, sqlWhereList, null);
        return siteMenuList2;
    }
}