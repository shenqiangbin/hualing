using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_adGroupEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private AdGroup bll_adGroup = new AdGroup();
    public AdGroupModel adGroup = null;
    public FilespecModel filespec = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        
        adGroup = bll_adGroup.GetModel(Request.QueryString["pkid"]);
        if (adGroup == null) adGroup = new AdGroupModel();

        filespec = new Filespec().GetModelByCode("image");
        if (filespec == null) WebUtility.ShowError(WebUtility.ERROR103);

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
        XMLHelper.SetCtrlByXmlData(Display, "AdDisplay", adGroup.Display.ToString());
        
        if (adGroup.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = adGroup.Title;
            Inbuilt.Checked = adGroup.Inbuilt;
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(Display.SelectedValue)) WebUtility.ShowAlertMessage("请选择展示方式！", null);

            if (!String.IsNullOrEmpty(Pic.Value) && Display.SelectedValue == "0" && !Inbuilt.Checked)
            {
                //获取图片宽高
                int imgWidth = 0, imgHeight = 0;
                ImageHelper.GetImageWH(Pic.Value, out imgWidth, out imgHeight);
                adGroup.Width = imgWidth;
                adGroup.Height = imgHeight;
                FileHelper.DeleteFile(Pic.Value, true);
            }

            adGroup.Title = MyTitle.Value;
            adGroup.Display = Convert.ToInt32(Display.SelectedValue);
            adGroup.Inbuilt = Inbuilt.Checked;

            if (adGroup.Pkid > 0)
            {
                //更改
                bll_adGroup.Update(adGroup);
                WebUtility.ShowAlertMessage("保存成功！", "adGroupManage.aspx" + param);
            }
            else
            {
                //增加
                adGroup.Enabled = true;
                adGroup.CreateTime = DateTime.Now.ToString();
                bll_adGroup.Insert(adGroup);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}
