using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_configInterface : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private GlobalConfig bll_config = new GlobalConfig();

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("全局_接口设置")) WebUtility.ShowError(WebUtility.ERROR101);

        bll_config.Load(new string[] { "alipayUid", "alipayPartner", "alipayKey", "alipayOrderTitle", "excelUsername", "excelPassword" });

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
        AlipayUid.Value = bll_config["alipayUid"];
        AlipayPartner.Value = bll_config["alipayPartner"];
        AlipayKey.Value = bll_config["alipayKey"];
        AlipayOrderTitle.Value = bll_config["alipayOrderTitle"];
        ExcelUsername.Value = bll_config["excelUsername"];
        ExcelPassword.Value = bll_config["excelPassword"];
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            bll_config["alipayUid"] = AlipayUid.Value;
            bll_config["alipayPartner"] = AlipayPartner.Value;
            bll_config["alipayKey"] = AlipayKey.Value;
            bll_config["alipayOrderTitle"] = AlipayOrderTitle.Value;
            bll_config["excelUsername"] = ExcelUsername.Value;
            bll_config["excelPassword"] = ExcelPassword.Value;

            bll_config.Update();
            WebUtility.ShowAlertMessage("保存成功！", Request.RawUrl);
        }
    }
}