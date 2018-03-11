﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class topic : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Article bll_article = new Article();
    private Category bll_category = new Category();
    public CategoryModel category = null;
    protected List<ArticleModel> articleList = new List<ArticleModel>();
    protected List<CategoryModel> categoryList = new List<CategoryModel>();
    //设置页面大小5
    int iPageSize = 15;
    protected void Page_Load(object sender, EventArgs e)
    {

        category = bll_category.GetModel(Request.QueryString["cid"]);
        if (category == null) WebUtility.Goto404();

        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        banner1.kind = 33;
        Right1.kind = 6;
        Right1.menu = category.Pkid;
        Master.Index = 8;
   
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //Title
        bll_config.Load(new string[] { "pageTitle", "keywords", "descn" });
        if (!String.IsNullOrEmpty(category.PageTitle)) Page.Title = category.PageTitle;
        else Page.Title = category.Title + " - " + bll_config["pageTitle"];

        //KeyWord
        WebUtility.CreateMeta(Page, "keywords", bll_config["keywords"]);

        //Description
        WebUtility.CreateMeta(Page, "description", bll_config["descn"]);

        //组合查询字段
        List<string> fieldList = new List<string>();
        fieldList.Add(ArticleModel.PIC);
        fieldList.Add(ArticleModel.AUTHOR);
        fieldList.Add(ArticleModel.PKID);
        fieldList.Add(ArticleModel.TITLE);
        fieldList.Add(ArticleModel.FILES);
        fieldList.Add(ArticleModel.SOURCE);
        fieldList.Add(ArticleModel.PUBDATE);
        fieldList.Add(ArticleModel.CREATETIME);

        //文章
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(ArticleModel.ENABLED, SqlWhere.Oper.Equal, true));
        //sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds(category.Pkid.ToString())));
        sqlWhereList.Add(new SqlWhere(ArticleModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds(category.Pkid.ToString())));

        //读取分页数据
        int iRecordsTotal = bll_article.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "/topic/" + category.Pkid.ToString() + "/page/$p/", false);
        //pagination.HomePage = category.Url;
        Paging.InnerHtml = pagination.Show();
        articleList = bll_article.GetList(pagination.PageIndex, iPageSize, fieldList, sqlWhereList, null);
    }
    
}
