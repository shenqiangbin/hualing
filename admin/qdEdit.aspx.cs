using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_articleEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();
    private Article bll_article = new Article();
    private ArticleModel article = null;
    public FilespecModel filespec = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("经销商_经销商管理")) WebUtility.ShowError(WebUtility.ERROR101);

        filespec = new Filespec().GetModelByCode("thum");
        if (filespec == null) WebUtility.ShowError(WebUtility.ERROR103);

        article = bll_article.GetModel(Request.QueryString["pkid"]);
        if (article == null) article = new ArticleModel();

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
        if (article.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = article.Title;
            Keywords.Value = article.Keywords;
            Descn.Value = article.Descn;
           
            IsTop.Checked = article.IsTop;
            Sort.Value = article.ISort.ToString();

        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(Sort.Value)) Sort.Value = "1";

            article.Title = MyTitle.Value;
            article.CategoryId = 35;
            article.Source = "";
            article.Keywords = Keywords.Value;
            article.Descn = Descn.Value;
            article.Pic = "";
            article.Content = "";
            article.ISort = Convert.ToInt32(Sort.Value);
            article.IsTop = IsTop.Checked;

            article.Author = "";   //概述

            if (article.Pkid > 0)
            {
                //更改
                bll_article.Update(article);
                WebUtility.ShowAlertMessage("保存成功！", "qdManage.aspx" + param);
            }
            else
            {
                //增加
                article.Enabled = true;
                article.Pubdate = DateTime.Now.ToString();
                article.Creator = Convert.ToInt32(bll_admin.CookieId);
                article.CreateTime = DateTime.Now.ToString();
                bll_article.Insert(article);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}