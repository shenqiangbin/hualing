using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_adFixedEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private AdGroup bll_adGroup = new AdGroup();
    private AdFixed bll_adFixed = new AdFixed();
    private AdFixedModel adFixed = null;
    public FilespecModel thumSpec = null, imageSpec = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        thumSpec = new Filespec().GetModelByCode("thum");
        imageSpec = new Filespec().GetModelByCode("image");
        if (thumSpec == null || imageSpec == null) WebUtility.ShowError(WebUtility.ERROR103);
        
        adFixed = bll_adFixed.GetModel(Request.QueryString["pkid"]);
        if (adFixed == null) adFixed = new AdFixedModel();

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
        bll_adGroup.BindDropDownList(GroupId, adFixed.GroupId.ToString(), "--广告组--");
        
        if (adFixed.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = adFixed.Title;
            URL.Value = adFixed.Url;
            Pic.Value = adFixed.Pic;
            Thumb.Value = adFixed.Thumb;
            Notes.Value = adFixed.Notes;
            Sort.Value = adFixed.ISort.ToString();
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(GroupId.Value)) WebUtility.ShowAlertMessage("请选择广告组！", null);
            if (!StringHelper.IsNumber(Sort.Value)) Sort.Value = "1";

            if (adFixed.Pic != Pic.Value)
            {
                //获取图片宽高
                int imgWidth = 0, imgHeight = 0;
                if (!String.IsNullOrEmpty(Pic.Value))
                    ImageHelper.GetImageWH(Pic.Value, out imgWidth, out imgHeight);
                adFixed.Width = imgWidth;
                adFixed.Height = imgHeight;
            }

            adFixed.Title = MyTitle.Value;
            adFixed.GroupId = Convert.ToInt32(GroupId.Value);
            adFixed.Url = URL.Value;
            adFixed.Pic = Pic.Value;
            adFixed.Thumb = Thumb.Value;
            adFixed.Notes = Notes.Value;
            adFixed.ISort = Convert.ToInt32(Sort.Value);

            if (adFixed.Pkid > 0)
            {
                //更改
                bll_adFixed.Update(adFixed);
                WebUtility.ShowAlertMessage("保存成功！", "adFixedManage.aspx" + param);
            }
            else
            {
                //增加
                adFixed.Enabled = true;
                adFixed.Creator = Convert.ToInt32(bll_admin.CookieId);
                adFixed.CreateTime = DateTime.Now.ToString();
                bll_adFixed.Insert(adFixed);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}