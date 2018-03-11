using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_onePageEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private OnePage bll_onePage = new OnePage();
    private UrlRoute bll_urlRoute = new UrlRoute();
    public OnePageModel onePage = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        onePage = bll_onePage.GetModel(Request.QueryString["pkid"]);
        if (onePage == null) onePage = new OnePageModel();

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
        XMLHelper.SetCtrlByXmlData(Mode, "PageMode", onePage.Mode.ToString());

        if (onePage.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = onePage.Title;
            RawUrl.Value = onePage.RawUrl;
            UrlAlias.Value = onePage.UrlAlias;
            InitContent.Value = onePage.InitContent;
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(Mode.SelectedValue)) WebUtility.ShowAlertMessage("请选择页面形式！", null);

            onePage.Title = MyTitle.Value;
            onePage.Mode = Convert.ToInt32(Mode.SelectedValue);
            onePage.UrlAlias = UrlAlias.Value;

            if (onePage.Mode == 0)
            {
                onePage.RawUrl = null;
                onePage.InitContent = InitContent.Value;
            }
            else
            {
                onePage.RawUrl = RawUrl.Value;
                onePage.InitContent = null;
            }

            if (onePage.Pkid > 0)
            {
                //更改
                bll_onePage.Update(onePage);
               // bll_urlRoute.Update();
                WebUtility.ShowAlertMessage("保存成功！", "onePageManage.aspx" + param);
            }
            else
            {
                //增加
                onePage.Content = InitContent.Value;
                onePage.Inbuilt = true;
                onePage.Enabled = true;
                onePage.CreateTime = DateTime.Now.ToString();
                bll_onePage.Insert(onePage);
               // bll_urlRoute.Update();
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}