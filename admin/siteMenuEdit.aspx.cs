using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_siteMenuEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private SiteMenu bll_siteMenu = new SiteMenu();
    public SiteMenuModel siteMenu = null;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("全局_导航菜单")) WebUtility.ShowError(WebUtility.ERROR101);

        siteMenu = bll_siteMenu.GetModel(Request.QueryString["pkid"]);
        if (siteMenu == null) WebUtility.ShowError(WebUtility.ERROR102);

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
        GroupName.InnerText = bll_siteMenu.GetTitle(siteMenu.GroupId);
        MyTitle.Value = siteMenu.Title;
        Url.Value = siteMenu.Url;
        if (siteMenu.Target == "_blank") Target.Checked = true;
        if (siteMenu.ILevel == 2) FatherId.Value = "0";
        else FatherId.Value = siteMenu.FatherId.ToString();
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(FatherId.Value)) WebUtility.ShowAlertMessage("请填写父级ID！", null);
            if (FatherId.Value == "0") FatherId.Value = siteMenu.GroupId.ToString();

            siteMenu.Title = MyTitle.Value;
            siteMenu.Url = Url.Value;
            if (Target.Checked) siteMenu.Target = "_blank";
            else siteMenu.Target = "_self";
            bll_siteMenu.Update(siteMenu, FatherId.Value, Request.Form["sort"]);
            WebUtility.ShowAlertMessage("保存成功！", "siteMenuManage.aspx" + param);
        }
    }
}