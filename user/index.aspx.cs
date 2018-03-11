using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class user_index : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Area bll_area = new Area();
    private Member bll_member = new Member();
    private MemberCard bll_memberCard = new MemberCard();
    public MemberModel member = null;

    public string uname = String.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.MemberLoginAuth();

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
        member = bll_member.GetModelByCookie();
        uname = bll_member.GetName(member);

        //Title
        bll_config.Load(new string[] { "pageTitle" });
        Page.Title = "会员中心 - " + bll_config["pageTitle"];

    }
}
