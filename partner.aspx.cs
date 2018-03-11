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

public partial class partner : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private AdFixed bll_article = new AdFixed();
    protected List<AdFixedModel> articleList = new List<AdFixedModel>();
    //设置页面大小5
    int iPageSize = 8;
    public string param = WebUtility.GetUrlParams("&", true);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        banner1.kind = 33;
        Right1.kind = 6;
        Right1.menu = -1;
        Master.Index = 8;
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        bll_config.Load(new string[] { "pageTitle", "keywords", "descn", "video" });
        //Title
        Page.Title = "合作伙伴" + " - " + bll_config["pageTitle"];
        //KeyWord
        WebUtility.CreateMeta(Page, "keywords", bll_config["keywords"]);
        //Description
        WebUtility.CreateMeta(Page, "description", bll_config["descn"]);

       
        //组合查询字段
        List<string> fieldList = new List<string>();
        fieldList.Add(AdFixedModel.PIC);
        fieldList.Add(AdFixedModel.NOTES);
        fieldList.Add(AdFixedModel.PKID);
        fieldList.Add(AdFixedModel.TITLE);
        fieldList.Add(AdFixedModel.URL);
        fieldList.Add(AdFixedModel.CREATETIME);

        //文章
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(AdFixedModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(AdFixedModel.GROUPID, SqlWhere.Oper.Equal, 7));

        //读取分页数据
        int iRecordsTotal = bll_article.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "/partner/page/$p/", false);
        //pagination.HomePage = category.Url;
        Paging.InnerHtml = pagination.Show();
        articleList = bll_article.GetList(pagination.PageIndex, iPageSize, fieldList, sqlWhereList, null);

    }

    
}
