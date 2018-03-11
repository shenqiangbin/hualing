using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class prolist : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    protected Category bll_category = new Category();
    private Product bll_product = new Product();
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
            cid = "2";
        }
     
        #endregion
        model = bll_category.GetModel(Request.QueryString["cid"]);
        //SystemHelper.PrintEnd(xp);
        if (model == null || !model.Enabled) WebUtility.Goto404();
     
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        
        banner1.kind = 29;
        Right1.kind = 3;
        Right1.menu = model.Pkid;
        Master.Index = 3;
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

        //Nav
        // Nav.InnerHtml = " > <a class='cor_hs' href='" + onepage.Url + "'>" + onepage.Title + "</a> > " + model.Title;

        List<string> fieldList = new List<string>();
        fieldList.Add(ProductModel.PKID);
        fieldList.Add(ProductModel.TITLE);
        fieldList.Add(ProductModel.PRICE1);
        fieldList.Add(ProductModel.SUMMARY);
        fieldList.Add(ProductModel.CONTENT);
       
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds(cid)));  //类别
        //sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.Equal, cid));
        
        
        //读取分页数据
        //int iRecordsTotal = bll_product.DoCount(sqlWhereList);
        //QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "/prolist/" + cid + "/page/$p/", false);
        //pagination.HomePage = category.Url;
       // Paging.InnerHtml = pagination.Show();
        //productList = bll_product.GetList(pagination.PageIndex, iPageSize, fieldList, sqlWhereList, null);
        productList = bll_product.GetList(1, 0, fieldList, sqlWhereList, null);
    }
  
}