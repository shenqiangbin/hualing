using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_adFixedEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private AdGroup bll_adGroup = new AdGroup();
    private AdFixed bll_adFixed = new AdFixed();
    public AdFixedModel adFixed = null;
    public AdGroupModel group = null;
    public FilespecModel imageSpec = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        group = bll_adGroup.GetModel(Request.QueryString["gid"]);
        if (group == null) WebUtility.ShowError(WebUtility.ERROR102);

        if (!bll_admin.RuleAuth("广告_" + group.Title)) WebUtility.ShowError(WebUtility.ERROR101);

        imageSpec = new Filespec().GetModelByCode("image");
        if (imageSpec == null) WebUtility.ShowError(WebUtility.ERROR103);
        
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
        PicPanel.Visible = group.Display == 0;
        SortPanel.Visible = !group.Inbuilt;
        
        if (adFixed.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = adFixed.Title;
            URL.Value = adFixed.Url;
            Notes.Value = adFixed.Notes;
            Sort.Value = adFixed.ISort.ToString();

            if (group.Display == 0)
            {
                Pic.Value = adFixed.Pic;
                //Thumb.Value = adFixed.Thumb;
            }
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!group.Inbuilt)
            {
                if (!StringHelper.IsNumber(Sort.Value)) Sort.Value = "1";
                adFixed.ISort = Convert.ToInt32(Sort.Value);
            }

            adFixed.Title = MyTitle.Value;
            adFixed.GroupId = group.Pkid;
            adFixed.Url = URL.Value;
            adFixed.Notes = Notes.Value;

            if (group.Display == 0)
            {
                adFixed.Pic = Pic.Value;
                //adFixed.Thumb = Thumb.Value;
            }

            if (adFixed.Pkid > 0)
            {
                //更改
                bll_adFixed.Update(adFixed);
                WebUtility.ShowAlertMessage("保存成功！", "adFixedManage.aspx" + param);
            }
            else
            {
                //增加
                adFixed.Width = group.Width;
                adFixed.Height = group.Height;
                adFixed.Enabled = true;
                adFixed.Creator = Convert.ToInt32(bll_admin.CookieId);
                adFixed.CreateTime = DateTime.Now.ToString();
                bll_adFixed.Insert(adFixed);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}