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

public partial class product : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Area bll_area = new Area();
    private Product bll_product = new Product();
    private Category bll_category = new Category();
    public CategoryModel category = null;
    public ProductModel model = null;
    private AdFixed bll_adFixed = new AdFixed();
    protected AdFixedModel ad6 = new AdFixedModel();  //
    protected List<CategoryModel> categoryList = new List<CategoryModel>();

    protected List<ProductModel> productList = new List<ProductModel>();  //
    public string[] str;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        model = bll_product.GetModel(Request.QueryString["pkid"]);
        if (model == null) WebUtility.Goto404();

        category = bll_category.GetModel(model.CategoryId);
        if (category == null) WebUtility.Goto404();
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
       
        banner1.kind = 34;
        Right1.kind = 7;
       // Right1.menu = category.Pkid;
        Right1.menu =10;
        Master.Index = 2;
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

        //浏览记录
        bll_product.RefreshPv(model);

        sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.Equal, model.CategoryId.ToString()));
        sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, true));
        ProductModel prevModel = bll_product.GetPrev(model, sqlWhereList);
        if (prevModel == null) Prev.InnerHtml = "<a>上一篇：这就是第一篇文章啦~~</a>";
        else Prev.InnerHtml = "<a href=\"" + bll_product.GetUrl(prevModel) + "\" title='" + prevModel.Title + "' >上一篇：" + QianZhu.Utility.StringHelper.CutString(prevModel.Title, 45, "...") + "</a>";

        //下一篇
        //sqlWhereList.RemoveAt(2);
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.Equal, model.CategoryId.ToString()));
        sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, true));
        ProductModel nextModel = bll_product.GetNext(model, sqlWhereList);
        if (nextModel == null) Next.InnerHtml = "<a>下一篇：这就是最后一篇文章啦~~</a>";
        else Next.InnerHtml = "<a href=\"" + bll_product.GetUrl(nextModel) + "\" title='" + nextModel.Title + "'>下一篇：" + QianZhu.Utility.StringHelper.CutString(nextModel.Title, 45, "...") + "</a>";

    }
}