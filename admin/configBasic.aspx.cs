using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_configBasic : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Filespec bll_filespec = new Filespec();
    private GlobalConfig bll_config = new GlobalConfig();
    public FilespecModel foreLogoSpec = null, foreLogoSpec2 = null, backLogoSpec = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("全局_基本设置")) WebUtility.ShowError(WebUtility.ERROR101);

        foreLogoSpec = bll_filespec.GetModelByCode("forelogo");
        foreLogoSpec2 = bll_filespec.GetModelByCode("forelogo2");
        backLogoSpec = bll_filespec.GetModelByCode("backlogo");
        if (foreLogoSpec == null || backLogoSpec == null) WebUtility.ShowError(WebUtility.ERROR103);

        bll_config.Load(new string[] { "pageTitle", "keywords", "descn", "foreLogo", "foreLogo2", "backLogo", "icp", "foot", "foot2" });

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
        PageTitle.Value = bll_config["pageTitle"];
        Keywords.Value = bll_config["keywords"];
        Descn.Value = bll_config["descn"];
        ForeLogo.Value = bll_config["foreLogo"];
        ForeLogo2.Value = bll_config["foreLogo2"];
        BackLogo.Value = bll_config["backLogo"];
        Icp.Value = bll_config["icp"];
        Foot.Value = bll_config["foot"];
        Foot2.Value = bll_config["foot2"];
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            bll_config["pageTitle"] = PageTitle.Value;
            if (!String.IsNullOrEmpty(Keywords.Value)) bll_config["keywords"] = Keywords.Value.Replace("，", ",");
            else bll_config["keywords"] = Keywords.Value;
            bll_config["descn"] = Descn.Value;
            bll_config["foreLogo"] = ForeLogo.Value;
            bll_config["foreLogo2"] = ForeLogo2.Value;
            bll_config["backLogo"] = BackLogo.Value;
            bll_config["icp"] = Icp.Value;
            bll_config["foot"] = Foot.Value;
            bll_config["foot2"] = Foot2.Value;

            bll_config.Update();
            WebUtility.ShowAlertMessage("保存成功！", Request.RawUrl);
        }
    }
}