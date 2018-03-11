using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class user_personal : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Member bll_member = new Member();
    public MemberModel member = null;
    public int sex = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.MemberLoginAuth();
        member = bll_member.GetModelByCookie();

        if (!Page.IsPostBack)
        {
            BindInfo();
        }

        banner1.kind = 43;
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //Title
        bll_config.Load(new string[] { "pageTitle" });
        Page.Title = "个人资料 - 会员中心 - " + bll_config["pageTitle"];

        Realname.Value = member.Realname;
        QQ.Value = member.Qq;
        sex = member.CityId;
        
    }

    protected void SubminButton_Click(object sender, EventArgs e)
    {       
        if (Page.IsValid)
        {
          
            member.Realname = Realname.Value;
            member.Qq = QQ.Value;
            try
            {
                member.CityId = Convert.ToInt32(Request.Form["sex"]);
            }
            catch (Exception)
            {
                member.CityId = 1;
            }

            bll_member.Update(member);
            WebUtility.ShowAlertMessage("保存成功！", Request.RawUrl);
        }
    }
}
