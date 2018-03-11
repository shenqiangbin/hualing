using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_pageSectionEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private PageSection bll_pageSection = new PageSection();
    public PageSectionModel pageSection = null;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("页面_局部版面")) WebUtility.ShowError(WebUtility.ERROR101);

        pageSection = bll_pageSection.GetModel(Request.QueryString["pkid"]);
        if (pageSection == null) WebUtility.ShowError(WebUtility.ERROR102);

        if (!Page.IsPostBack)
        {
            BindInfo();
        }
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        MyContent.Value = pageSection.Content;
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            pageSection.Content = MyContent.Value;
            bll_pageSection.Update(pageSection);
            WebUtility.ShowAlertMessage("保存成功！", "pageSectionManage.aspx" + param);
        }
    }
}