using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_pageSectionEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private PageSection bll_pageSection = new PageSection();
    public PageSectionModel pageSection = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        pageSection = bll_pageSection.GetModel(Request.QueryString["pkid"]);
        if (pageSection == null) pageSection = new PageSectionModel();

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
        if (pageSection.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = pageSection.Title;
            InitContent.Value = pageSection.InitContent;
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            pageSection.Title = MyTitle.Value;
            pageSection.InitContent = InitContent.Value;

            if (pageSection.Pkid > 0)
            {
                //更改
                bll_pageSection.Update(pageSection);
                WebUtility.ShowAlertMessage("保存成功！", "pageSectionManage.aspx" + param);
            }
            else
            {
                //增加
                pageSection.Content = InitContent.Value;
                pageSection.CreateTime = DateTime.Now.ToString();
                bll_pageSection.Insert(pageSection);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}