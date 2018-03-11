using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class inc_user : System.Web.UI.UserControl
{
    private Member bll_member = new Member();
    public MemberModel member = new MemberModel();
    private AdFixed bll_adFixed = new AdFixed();
    protected AdFixedModel ad6 = new AdFixedModel();  //
    public int rank = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!bll_member.IdentityAuth()) WebUtility.ShowAlertMessage("请登录！", "/login.html");
        member = bll_member.GetModelByCookie();

        rank = member.ProvinceId + 33;
        try
        {
            ad6 = bll_adFixed.GetModel(rank);
        }
        catch (Exception)
        {
            ad6 = new AdFixedModel();
            ad6.Pic = "";
        }
    }

}