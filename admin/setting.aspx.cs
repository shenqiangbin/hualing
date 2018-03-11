using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_setting : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    public AdminModel admin = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        admin = bll_admin.GetModelByCookie();

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
        Nickname.Value = admin.Nickname;
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!String.IsNullOrEmpty(Pwd.Value) && StringHelper.StringLength(Pwd.Value) < 6)
                WebUtility.ShowAlertMessage("请输入密码，密码应使用6位以上的字符组成", null);

            bool changePwd = false;
            if (!String.IsNullOrEmpty(Pwd.Value) && Pwd.Value != "········")
            {
                admin.Pwd = Encryption.Md5(Pwd.Value);
                changePwd = true;
            }
            
            admin.Nickname = Nickname.Value;

            bll_admin.Update(admin);
            if (changePwd) bll_admin.Login(admin.Username, Pwd.Value, false);
            WebUtility.ShowAlertMessage("保存成功！", Request.RawUrl);
        }
    }
}