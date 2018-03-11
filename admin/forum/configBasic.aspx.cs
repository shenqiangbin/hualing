using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_forum_configBasic : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Admin bll_admin = new Admin();
    private Member bll_member = new Member();

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("论坛_论坛设置")) WebUtility.ShowError(WebUtility.ERROR101);

        bll_config.Load(new string[] { "bbsPageTitle", "bbsKeywords", "bbsDescn", "bbsAdmin", "bbsHotMin" });

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
        PageTitle.Value = bll_config["bbsPageTitle"];
        Keywords.Value = bll_config["bbsKeywords"];
        Descn.Value = bll_config["bbsDescn"];
        SuperAdmin.Value = bll_config["bbsAdmin"];
        HotMin.Value = bll_config["bbsHotMin"];
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!String.IsNullOrEmpty(SuperAdmin.Value) && !bll_member.UnameExists(SuperAdmin.Value)) WebUtility.ShowAlertMessage("设置的超级版主不存在，请重新设置！", null);
            if (!StringHelper.IsNumber(HotMin.Value)) WebUtility.ShowAlertMessage("热帖最小值应使用数字输入！", null);
            
            bll_config["bbsPageTitle"] = PageTitle.Value;
            if (!String.IsNullOrEmpty(Keywords.Value)) bll_config["bbsKeywords"] = Keywords.Value.Replace("，", ",");
            else bll_config["bbsKeywords"] = Keywords.Value;
            bll_config["bbsDescn"] = Descn.Value;
            bll_config["bbsAdmin"] = SuperAdmin.Value;
            bll_config.SetInt("bbsHotMin", Convert.ToInt32(HotMin.Value));

            bll_config.Update();
            WebUtility.ShowAlertMessage("保存成功！", Request.RawUrl);
        }
    }
}