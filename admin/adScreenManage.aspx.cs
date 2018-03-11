using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_adScreenManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private GlobalConfig bll_config = new GlobalConfig();
    public FilespecModel thumSpec = null, imageSpec = null;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("广告_幕布广告")) WebUtility.ShowError(WebUtility.ERROR101);

        thumSpec = new Filespec().GetModelByCode("thum");
        imageSpec = new Filespec().GetModelByCode("image");
        if (thumSpec == null || imageSpec == null) WebUtility.ShowError(WebUtility.ERROR103);

        bll_config.Load(new string[] { "screenEnabled", "screenWidth", "screenHeight", "screenFile", "screenThumFile", "screenUrl", "screenOffTime" });

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
        Enabled.Checked = bll_config.GetBool("screenEnabled");
        ScreenFile.Value = bll_config["screenFile"];
        ScreenThumFile.Value = bll_config["screenThumFile"];
        if (!String.IsNullOrEmpty(bll_config["screenUrl"])) ScreenUrl.Value = bll_config["screenUrl"];
        ScreenOffTime.Value = bll_config.GetInt("screenOffTime").ToString();
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(ScreenOffTime.Value)) ScreenOffTime.Value = "0";

            bll_config["screenEnabled"] = Enabled.Checked.ToString();
            bll_config["screenFile"] = ScreenFile.Value;
            bll_config["screenThumFile"] = ScreenThumFile.Value;
            bll_config["screenUrl"] = ScreenUrl.Value;
            bll_config["screenOffTime"] = ScreenOffTime.Value;

            int width, height;
            ImageHelper.GetImageWH(ScreenFile.Value, out width, out height);
            bll_config["screenWidth"] = width.ToString();
            ImageHelper.GetImageWH(ScreenThumFile.Value, out width, out height);
            bll_config["screenHeight"] = height.ToString();

            bll_config.Update();
            bll_config.CreateScreenJsFile();
            WebUtility.ShowAlertMessage("保存成功！", Request.RawUrl);
        }
    }
}