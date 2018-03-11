using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class index1 : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private AdFixed bll_adFixed = new AdFixed();
    private Article bll_article = new Article();
    private Category bll_category = new Category();
    private Product bll_product = new Product();
    private Course bll_course = new Course();
    protected List<ProductModel> productList1 = new List<ProductModel>();     
    protected List<ArticleModel> articleList = new List<ArticleModel>();     //
    protected List<CategoryModel> categoryList = new List<CategoryModel>();  //类别
    protected List<AdFixedModel> adFixedList = new List<AdFixedModel>();  //轮播大图
    protected List<AdFixedModel> adFixedList1 = new List<AdFixedModel>();  //内训案例
    protected AdFixedModel ad4 = new AdFixedModel();  //1
    protected AdFixedModel ad5 = new AdFixedModel();  //团队上
    protected AdFixedModel ad6 = new AdFixedModel();  //内训优势
    protected AdFixedModel ad7 = new AdFixedModel();  //1

    protected AdFixedModel ad8 = new AdFixedModel();  //华领内训优势
    protected AdFixedModel ad9 = new AdFixedModel();  //
    protected AdFixedModel ad10 = new AdFixedModel();  //
    protected AdFixedModel ad11 = new AdFixedModel();  //
    protected AdFixedModel ad12 = new AdFixedModel();  //
    protected AdFixedModel ad13 = new AdFixedModel();  //
    private PageSection bll_pageSection = new PageSection();
    public PageSectionModel pageSection = null;
    public PageSectionModel pageSection1 = null;
    public string video = "";
    private Member bll_member = new Member();
    public string login = "1";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        Master.Index = 0;
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
        ad4 = bll_adFixed.GetModel(41);
        ad5 = bll_adFixed.GetModel(42);
        ad6 = bll_adFixed.GetModel(43);
        ad7 = bll_adFixed.GetModel(44);
        ad8 = bll_adFixed.GetModel(49);
        ad9 = bll_adFixed.GetModel(50);
        ad10 = bll_adFixed.GetModel(51);
        ad11 = bll_adFixed.GetModel(52);
        ad12 = bll_adFixed.GetModel(53);
        ad13 = bll_adFixed.GetModel(54);
        pageSection = bll_pageSection.GetModel(2);
        pageSection1 = bll_pageSection.GetModel(3);


        //轮播
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 9));
        adFixedList = bll_adFixed.GetList(sqlWhereList);


        //内训案例
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 10));
        adFixedList1 = bll_adFixed.GetList(1,0,sqlWhereList);

        //专家
        List<string> fieldList = new List<string>();
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
        //sqlWhereList.Add(new SqlWhere(ArticleModel.ISTOP, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.Equal, "12"));
        articleList = bll_article.GetList(1, 6, fieldList, sqlWhereList, null);

        // 内训
        categoryList = bll_category.GetListByFatherId(10);

      
         //热门课程
        fieldList.Clear();
        fieldList.Add(ProductModel.ISORT);
        fieldList.Add(ProductModel.ISTOP);
        fieldList.Add(ProductModel.PKID);
        fieldList.Add(ProductModel.TITLE);
        fieldList.Add(ProductModel.PUBDATE);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ProductModel.ISHOT, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds("10")));
        productList1 = bll_product.GetList(1, 7, fieldList, sqlWhereList, null);

        
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