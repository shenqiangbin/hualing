using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class user_password : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Member bll_member = new Member();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.MemberLoginAuth();

        if (!Page.IsPostBack)
        {
            BindInfo();
        }
    }

    private void BindInfo()
    {
        //Title
        bll_config.Load(new string[] { "pageTitle" });
        Page.Title = "修改密码 - 会员中心 - " + bll_config["pageTitle"];
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string oldPassword = OldPwd.Value;
            string newPassword = NewPwd.Value;
            bool result = bll_member.UpdatePassword(bll_member.CookieId, oldPassword, newPassword);

            if (result)
            {
                bll_member.Login(bll_member.CookieUsername, newPassword);
                WebUtility.ShowAlertMessage("密码修改成功！", "/user/");
            }
            else
            {
                WebUtility.ShowAlertMessage("操作失败！请检查原密码是否正确，且新密码须在6位以上。", Request.RawUrl);
            }
        }
    }
}