using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_memberEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Member bll_member = new Member();
    public MemberModel member = null;
    public FilespecModel filespec = null;
    public int sex = 1;
    public string param = WebUtility.GetUrlParams("?", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("报名管理")) WebUtility.ShowError(WebUtility.ERROR101);

        member = bll_member.GetModel(Request.QueryString["pkid"]);
        if (member == null) WebUtility.ShowError(WebUtility.ERROR102);

        //filespec = new Filespec().GetModelByCode("user");
        //if (filespec == null) WebUtility.ShowError(WebUtility.ERROR103);

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
        
        //Realname.Value = member.Realname;
        //Nickname.Value = member.Nickname;
        //XMLHelper.SetCtrlByXmlData(Sex, "Sex", member.Sex);
        //sex = member.Sex;
       // Mobi.Value = member.Mobi;
        //QQ.Value = member.Qq;
        //Birthday.Value = DateHelper.ToShortDate(member.Birthday);
        AreaId.Value = member.CityId.ToString();
        //Address.Value = member.Address;
       // Zipcode.Value = member.Zipcode;
    }

}
