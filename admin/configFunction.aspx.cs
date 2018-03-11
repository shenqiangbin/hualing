using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_configFunction : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private GlobalConfig bll_config = new GlobalConfig();
    public FilespecModel filespec2 = null;
    public string[] str;
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("全局_功能设置")) WebUtility.ShowError(WebUtility.ERROR101);
        filespec2 = new Filespec().GetModelByCode("video");
        bll_config.Load(new string[] { "headScript", "footScript", "smtpServer", "emailUid", "emailPwd", "copyEnabled", "saveEnabled", "banIp", "banWords", "toemail", "video" });

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

        HeadScript.Value = bll_config["headScript"];
        FootScript.Value = bll_config["footScript"];
        //SmtpServer.Value = bll_config["smtpServer"];
        //EmailUid.Value = bll_config["emailUid"];
        //EmailPwd.Value = bll_config["emailPwd"];
        CopyEnabled.Checked = bll_config.GetBool("copyEnabled");
        SaveEnabled.Checked = bll_config.GetBool("saveEnabled");
        BanIp.Value = bll_config["banIp"];
        BanWords.Value = bll_config["banWords"];
        //toemail.Value = bll_config["toemail"];

        flash.Value = bll_config["video"];
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            bll_config["headScript"] = HeadScript.Value;
            bll_config["footScript"] = FootScript.Value;
            //bll_config["smtpServer"] = SmtpServer.Value;
            //bll_config["emailUid"] = EmailUid.Value;
            //bll_config["emailPwd"] = EmailPwd.Value;
            //bll_config["toemail"] = toemail.Value;

            bll_config.SetBool("copyEnabled", CopyEnabled.Checked);
            bll_config.SetBool("saveEnabled", SaveEnabled.Checked);
            bll_config["banIp"] = BanIp.Value;
            bll_config["banWords"] = BanWords.Value;

            bll_config["smtpServer"] = "";
            bll_config["emailUid"] = "";
            bll_config["emailPwd"] = "";

            bll_config["video"] = flash.Value;

            bll_config.Update();
            WebUtility.ShowAlertMessage("保存成功！", Request.RawUrl);
        }
    }
}