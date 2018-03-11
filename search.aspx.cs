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

public partial class search : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private SearchIndex bll_searchIndex = new SearchIndex();
       private AdFixed bll_adFixed = new AdFixed();
    protected AdFixedModel ad6 = new AdFixedModel();  //散文诗集
    //设置页面大小
    int iPageSize = 20;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        banner1.kind = 45;
        Right1.kind = 100;
        //Right1.menu = -2;
        Master.Index = 1;
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        string words = Request.QueryString["words"];
        
        //Title
        bll_config.Load(new string[] { "pageTitle" });
        if (String.IsNullOrEmpty(words)) Page.Title = "搜索结果 - " + bll_config["pageTitle"];
        else Page.Title ="搜索结果 - " + bll_config["pageTitle"];

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SearchIndexModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(SearchIndexModel.TITLE, SqlWhere.Oper.Like, words));

        //读取分页数据
        int iRecordsTotal = bll_searchIndex.DoCount(sqlWhereList);
        string homePage = "/search/";
        if (!String.IsNullOrEmpty(words)) homePage += "w-" + HttpUtility.UrlEncode(words) + "/";
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, homePage + "page-$p/", false);
        pagination.HomePage = homePage;
        Paging.InnerHtml = pagination.Show();
        List<SearchIndexModel> searchIndexList = bll_searchIndex.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定文章数据
        Repeater1.DataSource = searchIndexList;
        Repeater1.DataBind();
        ad6 = bll_adFixed.GetModel(18);

    }
}