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
    public FilespecModel filespec2 = null;
    public string myhead = String.Empty;
    public string cid = "1";
    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            cid=Request.QueryString["cid"];
        }
        catch (Exception)
        {
            cid = "1";
        }
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("文章_文章管理")) WebUtility.ShowError(WebUtility.ERROR101);

        filespec = new Filespec().GetModelByCode("image");
        filespec2 = new Filespec().GetModelByCode("video");
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
            if (cid == "3")
            {
            CategoryId.Value = article.CategoryId.ToString();
            }
            if (cid != "1")
            {
                Keywords.Value = article.Keywords;
                Descn.Value = article.Descn;
            }

            if (cid == "3" || cid == "6" || cid == "7")
            {
            author.Value = article.Author;   //作者- 来源
            Source.Value = article.Source;
            }
                if (cid == "3")
            {
            isHead.Checked = article.IsHead; //优惠或通知
            }
            if (cid != "5" && cid != "6" && cid != "7")
            {
                files.Value = article.Files;//概述  /
            }
            if (cid != "1" && cid != "6" && cid != "7")
            {
                Pic.Value = article.Pic;
            }
         
            MyContent.Value = article.Content;
                
           

            Pubdate.Value = DateHelper.ToShortDate(article.Pubdate);
            IsTop.Checked = article.IsTop;
            Sort.Value = article.ISort.ToString();

        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (cid == "3")
            {
                if (!StringHelper.IsNumber(CategoryId.Value)) WebUtility.ShowAlertMessage("请选择类别！", null);
            }

            if (!StringHelper.IsNumber(Sort.Value)) Sort.Value = "1";

            article.Title = MyTitle.Value;
            if (cid == "3")
            {
                article.CategoryId = Convert.ToInt32(CategoryId.Value);
            }
            else
            {
                article.CategoryId=Convert.ToInt16(cid);
            }
            if (cid == "3" || cid == "6" || cid == "7")
            {
                article.Source = Source.Value;
                article.Author = author.Value;
            }
            if (cid == "3")
            {
                article.IsHead = isHead.Checked;
            }
            if (cid != "1" && cid != "6" && cid != "7")
            {
                article.Pic = Pic.Value;
            }
            if (cid != "1")
            {
                if (!String.IsNullOrEmpty(Keywords.Value)) article.Keywords = Keywords.Value.Replace("，", ",");
                else article.Keywords = Keywords.Value;
                article.Descn = Descn.Value;
               
            }
            article.Content = MyContent.Value;
            if (cid != "5" && cid != "6" && cid != "7")
            {
                article.Files = files.Value;
            }
            article.ISort = Convert.ToInt32(Sort.Value);
            article.IsTop = IsTop.Checked;
            
            if (article.Pkid > 0)
            {
                //更改
                if (DateHelper.ToShortDate(article.Pubdate) != Pubdate.Value) article.Pubdate = Pubdate.Value;
                bll_article.Update(article);
                WebUtility.ShowAlertMessage("保存成功！", "articleManage.aspx" + param);
            }
            else
            {
                //增加
                article.Enabled = true;
                if (String.IsNullOrEmpty(Pubdate.Value)) article.Pubdate = DateTime.Now.ToString();
                else article.Pubdate = Pubdate.Value;
                article.Creator = Convert.ToInt32(bll_admin.CookieId);
                article.CreateTime = DateTime.Now.ToString();
                bll_article.Insert(article);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}