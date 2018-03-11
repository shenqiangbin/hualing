using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_categoryGroupEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Category bll_category = new Category();
    public CategoryModel category = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        
        category = bll_category.GetModel(Request.QueryString["pkid"]);
        if (category == null) category = new CategoryModel();

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
        if (category.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = category.Title;
            MaxLevel.Value = category.MaxLevel.ToString();
            SubUrlRoute.Value = category.SubUrlRoute;
            SubRawUrl.Value = category.SubRawUrl;
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(MaxLevel.Value)) WebUtility.ShowAlertMessage("请填写最大级别！", null);

            if (SubRawUrl.Value != category.SubRawUrl || SubUrlRoute.Value != category.SubUrlRoute)
                bll_category.UpdateChildrenUrl(category, SubRawUrl.Value, SubUrlRoute.Value);

            category.Title = MyTitle.Value;
            category.MaxLevel = Convert.ToInt32(MaxLevel.Value);
            category.SubRawUrl = SubRawUrl.Value;
            category.SubUrlRoute = SubUrlRoute.Value;

            if (category.Pkid > 0)
            {
                //更改
                bll_category.Update(category);
                WebUtility.ShowAlertMessage("保存成功！", "categoryGroupManage.aspx" + param);
            }
            else
            {
                //增加
                category.FatherId = 0;
                bll_category.Insert(category);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}
