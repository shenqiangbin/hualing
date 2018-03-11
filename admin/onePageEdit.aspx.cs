using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_onePageEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private OnePage bll_onePage = new OnePage();
    private UrlRoute bll_urlRoute = new UrlRoute();
    public OnePageModel onePage = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("页面_页面管理")) WebUtility.ShowError(WebUtility.ERROR101);

        onePage = bll_onePage.GetModel(Request.QueryString["pkid"]);
        if (onePage == null) onePage = new OnePageModel();

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
        if (onePage.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = onePage.Title;
            PageTitle.Value = onePage.PageTitle;
            Keywords.Value = onePage.Keywords;
            Descn.Value = onePage.Descn;
            UrlAlias.Value = onePage.UrlAlias;
            if (onePage.Mode == 0) MyContent.Value = onePage.Content;
            else ContentTr.Visible = false;
            FatherId.Value = onePage.FatherId.ToString();
            Sort.Value = onePage.ISort.ToString();
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(FatherId.Value)) FatherId.Value = "0";
            if (!StringHelper.IsNumber(Sort.Value)) Sort.Value = "1";
            
            onePage.Title = MyTitle.Value;
            onePage.PageTitle = PageTitle.Value;
            if (!String.IsNullOrEmpty(Keywords.Value)) onePage.Keywords = Keywords.Value.Replace("，", ",");
            else onePage.Keywords = Keywords.Value;
            onePage.Descn = Descn.Value;
            onePage.UrlAlias = UrlAlias.Value;
            if (onePage.Mode == 0) onePage.Content = MyContent.Value;
            else onePage.Content = null;
            onePage.FatherId = Convert.ToInt32(FatherId.Value);
            onePage.ISort = Convert.ToInt32(Sort.Value);

            if (onePage.Pkid > 0)
            {
                //更改
                bll_onePage.Update(onePage);
                bll_urlRoute.Update();
                WebUtility.ShowAlertMessage("保存成功！", "onePageManage.aspx" + param);
            }
            else
            {
                //增加
                onePage.Enabled = true;
                onePage.CreateTime = DateTime.Now.ToString();
                bll_onePage.Insert(onePage);
                bll_urlRoute.Update();
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}