using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_pageSectionManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private PageSection bll_pageSection = new PageSection();

    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        
        if (!Page.IsPostBack)
        {
            Action();
            BindInfo();
        }
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //搜索控件
        MyTitle.Value = Request.QueryString["title"];
        
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(PageSectionModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));

        //读取分页数据
        int iRecordsTotal = bll_pageSection.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<PageSectionModel> pageSectionList = bll_pageSection.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定
        if (pageSectionList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = pageSectionList;
        Repeater1.DataBind();
    }

    /// <summary>
    /// 执行操作的方法
    /// </summary>
    private void Action()
    {
        string cmd = Request["cmd"];
        if (String.IsNullOrEmpty(cmd)) return;
        string ids = Request.QueryString["ids"];

        if (cmd == "del") bll_pageSection.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        PageSectionModel pageSection = (PageSectionModel)e.Item.DataItem;
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(pageSection.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}