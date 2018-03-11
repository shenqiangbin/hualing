using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class index : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private AdFixed bll_adFixed = new AdFixed();
    private Article bll_article = new Article();
    private Category bll_category = new Category();
    private Product bll_product = new Product();
    private Course bll_course = new Course();
    protected List<CourseModel> CourseList = new List<CourseModel>();     //课程
    protected List<ArticleModel> articleList = new List<ArticleModel>();     //新闻
    protected List<ArticleModel> articleList1 = new List<ArticleModel>();     //考试资讯
    protected List<ArticleModel> articleList2 = new List<ArticleModel>();     //考试心得
    protected List<ArticleModel> articleList3 = new List<ArticleModel>();     //精彩视频
    protected List<ArticleModel> articleList4 = new List<ArticleModel>();     //管理会计俱乐部
    protected List<ProductModel> productList = new List<ProductModel>();  //装修案例
    protected List<CategoryModel> categoryList = new List<CategoryModel>();  //装修案例类别
    protected List<AdFixedModel> adFixedList = new List<AdFixedModel>();  //轮播大图
    protected List<AdFixedModel> adFixedList1 = new List<AdFixedModel>();  //中部轮播小图
    protected List<AdFixedModel> adFixedList3 = new List<AdFixedModel>();  //底部轮播小图
    protected List<AdFixedModel> adFixedList4 = new List<AdFixedModel>();  //合作伙伴
    protected List<AdFixedModel> adFixedList5 = new List<AdFixedModel>();  //友情链接
    protected List<AdFixedModel> adFixedList6 = new List<AdFixedModel>();  //首页CMA考试
    protected AdFixedModel ad4 = new AdFixedModel();  //考试资讯
    protected AdFixedModel ad5 = new AdFixedModel();  //考试心得
    protected AdFixedModel ad6 = new AdFixedModel();  //考试资讯下
    protected AdFixedModel ad7 = new AdFixedModel();  //考试心得下
    protected AdFixedModel ad8 = new AdFixedModel();  //新闻资讯
    protected AdFixedModel ad9 = new AdFixedModel();  //教育体系
    protected AdFixedModel ad10 = new AdFixedModel();  //通栏
    protected AdFixedModel ad11 = new AdFixedModel();  //精彩视频左侧
    protected AdFixedModel ad12 = new AdFixedModel();  //qq
    protected AdFixedModel ad13 = new AdFixedModel();  //
    private PageSection bll_pageSection = new PageSection();
    public PageSectionModel pageSection = null;
    public PageSectionModel pageSection1 = null;
    public PageSectionModel pageSection2 = null;
    public string video = "";
    private Member bll_member = new Member();
    public string login = "1";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        Master.Index = 1;
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        bll_config.Load(new string[] { "pageTitle", "keywords", "descn", "video" });
        //Title
        Page.Title = bll_config["pageTitle"];
        //KeyWord
        WebUtility.CreateMeta(Page, "keywords", bll_config["keywords"]);
        //Description
        WebUtility.CreateMeta(Page, "description", bll_config["descn"]);
        video = bll_config["video"];
        //局部页面 
        ad4 = bll_adFixed.GetModel(7);
        ad5 = bll_adFixed.GetModel(8);
        ad6 = bll_adFixed.GetModel(9);
        ad7 = bll_adFixed.GetModel(10);
        ad8 = bll_adFixed.GetModel(11);
        ad9 = bll_adFixed.GetModel(12);
        ad10 = bll_adFixed.GetModel(13);
        ad11 = bll_adFixed.GetModel(14);
        ad12 = bll_adFixed.GetModel(1);
        //ad13 = bll_adFixed.GetModel(18);
        //pageSection = bll_pageSection.GetModel(2);
        //pageSection1 = bll_pageSection.GetModel(3);
        //pageSection2 = bll_pageSection.GetModel(7);


        //轮播
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 3));
        adFixedList = bll_adFixed.GetList(sqlWhereList);
        //中部轮播小图
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 5));
        adFixedList1 = bll_adFixed.GetList(1,0,sqlWhereList);
        //底部轮播小图
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 6));
        adFixedList3 = bll_adFixed.GetList(1, 0, sqlWhereList);
        //合作伙伴 
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 7));
        adFixedList4 = bll_adFixed.GetList(1, 0, sqlWhereList);
        //友情链接
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 2));
        adFixedList5 = bll_adFixed.GetList(1, 0, sqlWhereList);

        //首页CMA考试
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 8));
        adFixedList6 = bll_adFixed.GetList(1, 0, sqlWhereList);


       
        //新闻资讯
        List<string> fieldList = new List<string>();
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.ISORT);
        fieldList.Add(ArticleModel.ISTOP);
        fieldList.Add(ArticleModel.PIC);
        fieldList.Add(ArticleModel.FILES);
        fieldList.Add(ArticleModel.PUBDATE);
        fieldList.Add(ArticleModel.CREATETIME);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        //sqlWhereList.Add(new SqlWhere(ArticleModel.ISTOP, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds("3")));
        articleList = bll_article.GetList(1, 5, fieldList, sqlWhereList, null);

        // 装修案例
        //categoryList = bll_category.GetListByFatherId(2);

        // 考试资讯
        fieldList.Clear();
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.ISHEAD);
        fieldList.Add(ArticleModel.ISORT);
        fieldList.Add(ArticleModel.ISTOP);
        fieldList.Add(ArticleModel.PIC);
        fieldList.Add(ArticleModel.FILES);
        fieldList.Add(ArticleModel.PUBDATE);
        fieldList.Add(ArticleModel.CREATETIME);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, "16"));
        articleList1 = bll_article.GetList(1, 5, fieldList, sqlWhereList, null);

        // 考试心得
        fieldList.Clear();
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.PIC);
        fieldList.Add(ArticleModel.ISORT);
        fieldList.Add(ArticleModel.ISTOP);
        fieldList.Add(ArticleModel.FILES);
        fieldList.Add(ArticleModel.PUBDATE);
        fieldList.Add(ArticleModel.CREATETIME);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, "4"));
        articleList2 = bll_article.GetList(1, 5, fieldList, sqlWhereList, null);

        // 精彩视频
        fieldList.Clear();
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.PIC);
        fieldList.Add(ArticleModel.FILES);
        fieldList.Add(ArticleModel.PUBDATE);
        fieldList.Add(ArticleModel.ISORT);
        fieldList.Add(ArticleModel.ISTOP);
        fieldList.Add(ArticleModel.CREATETIME);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, "8"));
        articleList3 = bll_article.GetList(1, 10, fieldList, sqlWhereList, null);

        //管理会计俱乐部
        fieldList.Clear();
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.PIC);
        fieldList.Add(ArticleModel.ISORT);
        fieldList.Add(ArticleModel.ISTOP);
        fieldList.Add(ArticleModel.FILES);
        fieldList.Add(ArticleModel.PUBDATE);
        fieldList.Add(ArticleModel.CREATETIME);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, "15"));
        articleList4 = bll_article.GetList(1, 8, fieldList, sqlWhereList, null);

        //课程
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(CourseModel.ENABLED, SqlWhere.Oper.Equal, true));
        CourseList = bll_course.GetList(1, 5, null, sqlWhereList, null);

        // 业绩
        //fieldList.Clear();
        //fieldList.Add(ProductModel.PKID);
        //fieldList.Add(ProductModel.TITLE);
        //fieldList.Add(ProductModel.PIC);
        //sqlWhereList.Clear();
        //sqlWhereList.Add(new SqlWhere(ProductModel.ISHOT, SqlWhere.Oper.Equal, true));
        //sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, true));
        //sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds("5")));
        //productList1 = bll_product.GetList(1, 5, fieldList, sqlWhereList, null);

        
    }
    public List<ProductModel> Getprolist(int cid)
    {
        List<string> fieldList = new List<string>();
        fieldList.Add(ProductModel.PKID);
        fieldList.Add(ProductModel.TITLE);
        fieldList.Add(ProductModel.PIC);
        fieldList.Add(ProductModel.ISORT);
        fieldList.Add(ProductModel.ISTOP);
        fieldList.Add(ProductModel.SUMMARY);
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        //sqlWhereList.Add(new SqlWhere(ProductModel.ISHOT, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.Equal, cid));
        List<ProductModel>  productList = bll_product.GetList(1, 3, fieldList, sqlWhereList, null);
        return productList;
    }
    
}