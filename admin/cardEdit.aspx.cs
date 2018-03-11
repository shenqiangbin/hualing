using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_cardEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Admin bll_admin = new Admin();
    private MemberCard bll_memberCard = new MemberCard();
    public MemberCardModel memberCard = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("产品_惠卡管理")) WebUtility.ShowError(WebUtility.ERROR101);

        memberCard = bll_memberCard.GetModel(Request.QueryString["pkid"]);
        if (memberCard == null) memberCard = new MemberCardModel();

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
        if (memberCard.Pkid > 0)
        {
            myhead = "编辑";

            if (memberCard.Enabled)
            {
                Unactivated.Visible = false;
                Activated.Visible = true;

                AreaId.Value = memberCard.CityId.ToString();
                Realname.Value = memberCard.Realname;
                IdentityCard.Value = memberCard.IdentityCard;
                PlateNumber.Value = memberCard.PlateNumber;
                VehicleBrand.Value = memberCard.VehicleBrand;
                LoadPeople.Value = memberCard.LoadPeople;
                Mobi.Value = memberCard.Mobi;
                Email.Value = memberCard.Email;
                Address.Value = memberCard.Address;
            }
            else
            {
                CardNo.Value = memberCard.CardNo;
                Sold.Checked = memberCard.Sold;
            }
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (memberCard.Pkid == 0)
            {
                bll_config.Load(new string[] { "cardNoPwdDigits" });
                int cardNoPwdDigits = bll_config.GetInt("cardNoPwdDigits");
                if (cardNoPwdDigits <= 0) WebUtility.ShowAlertMessage("惠卡密码位数必须大于零，请在全局功能中进行设置！", null);
                memberCard.Pwd = StringHelper.GetRandomString(cardNoPwdDigits);
            }
            
            if (memberCard.Enabled)
            {
                if (StringHelper.IsNumber(AreaId.Value)) memberCard.CityId = Convert.ToInt32(AreaId.Value);
                else memberCard.CityId = 0;
                memberCard.Realname = Realname.Value;
                memberCard.IdentityCard = IdentityCard.Value;
                memberCard.PlateNumber = PlateNumber.Value;
                memberCard.VehicleBrand = VehicleBrand.Value;
                memberCard.LoadPeople = LoadPeople.Value;
                memberCard.Mobi = Mobi.Value;
                memberCard.Email = Email.Value;
                memberCard.Address = Address.Value;
            }
            else
            {
                if (CardNo.Value != memberCard.CardNo && bll_memberCard.CardNoExists(CardNo.Value)) WebUtility.ShowAlertMessage("该卡号已存在，请重新输入！", null);
                memberCard.CardNo = CardNo.Value;
                memberCard.Sold = Sold.Checked;
            }

            if (memberCard.Pkid > 0)
            {
                //更改
                bll_memberCard.Update(memberCard);
                WebUtility.ShowAlertMessage("保存成功！", "cardManage.aspx" + param);
            }
            else
            {
                //增加
                memberCard.CreateTime = DateTime.Now.ToString();
                bll_memberCard.Insert(memberCard);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}