using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_adPopupManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private GlobalConfig bll_config = new GlobalConfig();
    public FilespecModel filespec = null;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("广告_弹出广告")) WebUtility.ShowError(WebUtility.ERROR101);

        filespec = new Filespec().GetModelByCode("image");
        if (filespec == null) WebUtility.ShowError(WebUtility.ERROR103);

        bll_config.Load(new string[] { "popupEnabled", "popupWidth", "popupHeight", "popupFile", "popupUrl", "popupShade", "popupOffTime" });

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
        Enabled.Checked = bll_config.GetBool("popupEnabled");
        PopupFile.Value = bll_config["popupFile"];
        if (!String.IsNullOrEmpty(bll_config["popupUrl"])) PopupUrl.Value = bll_config["popupUrl"];
        PopupShade.Checked = bll_config.GetBool("popupShade");
        PopupOffTime.Value = bll_config.GetInt("popupOffTime").ToString();
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(PopupOffTime.Value)) PopupOffTime.Value = "0";

            bll_config["popupEnabled"] = Enabled.Checked.ToString();
            bll_config["popupFile"] = PopupFile.Value;
            bll_config["popupUrl"] = PopupUrl.Value;
            bll_config["popupShade"] = PopupShade.Checked.ToString();
            bll_config["popupOffTime"] = PopupOffTime.Value;

            int width, height;
            ImageHelper.GetImageWH(PopupFile.Value, out width, out height);
            bll_config["popupWidth"] = width.ToString();
            bll_config["popupHeight"] = height.ToString();

            bll_config.Update();
            bll_config.CreatePopupJsFile();
            WebUtility.ShowAlertMessage("保存成功！", Request.RawUrl);
        }
    }
}