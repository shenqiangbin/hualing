using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_adFloatingEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private AdFloating bll_adFloating = new AdFloating();
    private AdFloatingModel adFloating = null;
    public FilespecModel filespec = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("广告_悬浮广告")) WebUtility.ShowError(WebUtility.ERROR101);

        filespec = new Filespec().GetModelByCode("image");
        if (filespec == null) WebUtility.ShowError(WebUtility.ERROR103);
        
        adFloating = bll_adFloating.GetModel(Request.QueryString["pkid"]);
        if (adFloating == null) adFloating = new AdFloatingModel();

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
        XMLHelper.SetCtrlByXmlData(Location, "--选择位置--", "Location", adFloating.Location.ToString());
        
        if (adFloating.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = adFloating.Title;
            MarginTop.Value = adFloating.MarginTop.ToString();
            MarginBottom.Value = adFloating.MarginBottom.ToString();
            MarginLeft.Value = adFloating.MarginLeft.ToString();
            MarginRight.Value = adFloating.MarginRight.ToString();
            Pic.Value = adFloating.Pic;
            URL.Value = adFloating.Url;
            //Notes.Value = adFloating.Notes;
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(Location.Value)) WebUtility.ShowAlertMessage("请选择悬浮位置！", null);
            if (!StringHelper.IsNumber(MarginTop.Value)) MarginTop.Value = "0";
            if (!StringHelper.IsNumber(MarginBottom.Value)) MarginBottom.Value = "0";
            if (!StringHelper.IsNumber(MarginLeft.Value)) MarginLeft.Value = "0";
            if (!StringHelper.IsNumber(MarginRight.Value)) MarginRight.Value = "0";
            
            adFloating.Title = MyTitle.Value;
            adFloating.Location = Convert.ToInt32(Location.Value);
            adFloating.MarginTop = Convert.ToInt32(MarginTop.Value);
            adFloating.MarginBottom = Convert.ToInt32(MarginBottom.Value);
            adFloating.MarginLeft = Convert.ToInt32(MarginLeft.Value);
            adFloating.MarginRight = Convert.ToInt32(MarginRight.Value);
            adFloating.Pic = Pic.Value;
            adFloating.Url = URL.Value;
            //adFloating.Notes = Notes.Value;

            if (adFloating.Pkid > 0)
            {
                //更改
                bll_adFloating.Update(adFloating);
                bll_adFloating.CreateJsFile();
                WebUtility.ShowAlertMessage("保存成功！", "adFloatingManage.aspx" + param);
            }
            else
            {
                //增加
                adFloating.Enabled = true;
                adFloating.Creator = Convert.ToInt32(bll_admin.CookieId);
                adFloating.CreateTime = DateTime.Now.ToString();
                bll_adFloating.Insert(adFloating);
                bll_adFloating.CreateJsFile();
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}