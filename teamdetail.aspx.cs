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

public partial class teamdetail : System.Web.UI.Page
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
        banner1.kind = 30;
        Right1.kind = 100;
        //Right1.menu = category.Pkid;
        Master.Index = 4;
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
        bll_article.RefreshPv(model);
        
    }
}