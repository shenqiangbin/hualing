using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class train : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    protected Category bll_category = new Category();
    private Product bll_product = new Product();
    protected List<CategoryModel> categoryList = new List<CategoryModel>();  //装修案例类别
    protected List<ProductModel> productList = new List<ProductModel>();  //
    public CategoryModel model = null;
    protected string cid = "2";    //类别
    //设置页面大小6
    int iPageSize = 12;
    protected string nav = "";
    private PageSection bll_pageSection = new PageSection();
    public PageSectionModel pageSection = null;
    protected void Page_Load(object sender, EventArgs e)
    {
      
        #region ==获取参数==
        try
        {
            cid = Request.QueryString["cid"];
        }
        catch (Exception)
        {
            cid = "10";
        }
     
        #endregion
        model = bll_category.GetModel(Request.QueryString["cid"]);
        //SystemHelper.PrintEnd(xp);
        if (model == null || !model.Enabled) WebUtility.Goto404();
     
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        
        banner1.kind = 34;
        Right1.kind = 7;
        //Right1.menu = model.Pkid;
        Right1.menu = 10;
        Right1.menu2 = model.Pkid;
        Master.Index = 1;

        // 课程
        categoryList = bll_category.GetListByFatherId(10);
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //Title
        bll_config.Load(new string[] { "pageTitle" });
        Page.Title = model.Title + " - " + bll_config["pageTitle"];

        //KeyWord
        WebUtility.CreateMeta(Page, "keywords", model.Keywords);

        //Description
        WebUtility.CreateMeta(Page, "description", model.Descn);

        //List<string> fieldList = new List<string>();
        //fieldList.Add(ProductModel.PKID);
        //fieldList.Add(ProductModel.TITLE);
        //fieldList.Add(ProductModel.PRICE1);
        //fieldList.Add(ProductModel.SUMMARY);
        //fieldList.Add(ProductModel.PIC);
       
        //List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        //sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, true));
        //sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.Equal, cid));
        
        //int iRecordsTotal = bll_product.DoCount(sqlWhereList);
        //QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "/prolist/" + cid + "/page/$p/", false);
        //Paging.InnerHtml = pagination.Show();
        //productList = bll_product.GetList(pagination.PageIndex, iPageSize, fieldList, sqlWhereList, null);

    }
    public List<ProductModel> getprlist(int cid)
   {
       List<string> fieldList = new List<string>();
       fieldList.Add(ProductModel.PKID);
       fieldList.Add(ProductModel.TITLE);
       fieldList.Add(ProductModel.PRICE1);
       fieldList.Add(ProductModel.SUMMARY);
       fieldList.Add(ProductModel.PIC);
       List<SqlWhere> sqlWhereList = new List<SqlWhere>();
       sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, true));
       sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds(cid.ToString())));
       List<ProductModel> productLists = bll_product.GetList(1, 0, fieldList, sqlWhereList, null);
       return productLists;
   }
}