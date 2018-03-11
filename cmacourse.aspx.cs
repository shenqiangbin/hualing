using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class course : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private OnePage bll_onePage = new OnePage();
    private AdFixed bll_adFixed = new AdFixed();
    protected AdFixedModel ad6 = new AdFixedModel();  //banner
    public OnePageModel model = null;
    private SiteMenu bll_siteMenu = new SiteMenu();  //菜单
    protected List<SiteMenuModel> SiteMenuList = new List<SiteMenuModel>();
    protected List<AdFixedModel> adFixedList = new List<AdFixedModel>();  //轮播
    protected void Page_Load(object sender, EventArgs e)
    {
        model = bll_onePage.GetModel(Request.QueryString["pkid"]);
        if (model == null || !model.Enabled) WebUtility.Goto404();

        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        banner1.kind = 34;
        Right1.kind = 7;
        Right1.menu =model.Pkid;
        Master.Index = 2;

    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //Title
        bll_config.Load(new string[] { "pageTitle" });
        if (!String.IsNullOrEmpty(model.PageTitle)) Page.Title = model.PageTitle;
        else Page.Title = model.Title + " - " + bll_config["pageTitle"];

        //KeyWord
        WebUtility.CreateMeta(Page, "keywords", model.Keywords);

        //Description
        WebUtility.CreateMeta(Page, "description", model.Descn);

       
    }
}
