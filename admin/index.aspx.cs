using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;

public partial class admin_index : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //自动登录
        if (bll_admin.IdentityAuth()) Response.Redirect("main.aspx");
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            //检测验证码
            WebUtility.CheckCode(Code.Value, null);

            //登录
            bool result = bll_admin.Login(Username.Value, Pwd.Value, AutoLogin.Checked);
            if (result) Response.Redirect("main.aspx");
            else WebUtility.ShowAlertMessage("登录失败，用户或密码错误！", null);
        }
    }
}