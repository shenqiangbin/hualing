using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_categoryEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();
    private UrlRoute bll_urlRoute = new UrlRoute();
    public CategoryModel category = null, group = null;

    public string param = WebUtility.GetUrlParams("?", true);
    public string myhead = String.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        group = bll_category.GetModel(Request.QueryString["gid"]);
        if (group == null) WebUtility.ShowError(WebUtility.ERROR102);

        if (!bll_admin.RuleAuth(group.Title)) WebUtility.ShowError(WebUtility.ERROR101);
        
        category = bll_category.GetModel(Request.QueryString["pkid"]);
        if (category == null || category.GroupId != group.Pkid) category = new CategoryModel();

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
            PageTitle.Value = category.PageTitle;
            Keywords.Value = category.Keywords;
            Descn.Value = category.Descn;
            //UrlAlias.Value = category.UrlAlias;
            if (category.ILevel == 2) FatherId.Value = "0";
            else FatherId.Value = category.FatherId.ToString();
            // Content介绍内容
            if (group.Pkid == 10)
            {
                MyContent.Value=category.Content;
                //MyContent2.Value = category.Content2;
            }
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(FatherId.Value)) WebUtility.ShowAlertMessage("请填写父级ID！", null);
            if (FatherId.Value == "0") FatherId.Value = group.Pkid.ToString();
            
            category.Title = MyTitle.Value;
            category.PageTitle = PageTitle.Value;
            if (!String.IsNullOrEmpty(Keywords.Value)) category.Keywords = Keywords.Value.Replace("，", ",");
            else category.Keywords = Keywords.Value;
            category.Descn = Descn.Value;
           // category.UrlAlias = UrlAlias.Value;

            if (group.Pkid == 10)
            {
                category.Content = MyContent.Value;
                category.Content2 = "";
            }

            if (category.Pkid > 0)
            {                
                //更改
                int result = bll_category.Update(category, FatherId.Value, Request.Form["sort"]);

                if (result == 101) WebUtility.ShowAlertMessage("没有找到相关父类！", null);
                else if (result == 102) WebUtility.ShowAlertMessage("所选父类为最终类，无法添加子类别，请重新选择父类！", null);
                else if (result == 103) WebUtility.ShowAlertMessage("没有找到显示位置！", null);

               // bll_urlRoute.Update();
                WebUtility.ShowAlertMessage("保存成功！", "categoryManage.aspx" + param);
            }
            else
            {
                //增加
                category.FatherId = Convert.ToInt32(FatherId.Value);
                int result = bll_category.Insert(category);

                if (result == 101) WebUtility.ShowAlertMessage("没有找到相关父类！", null);
                else if (result == 102) WebUtility.ShowAlertMessage("所选父类为最终类，无法添加子类别，请重新选择父类！", null);

                result = bll_category.Update(category, FatherId.Value, Request.Form["sort"]);
                if (result == 103) WebUtility.ShowAlertMessage("没有找到显示位置！", null);

               // bll_urlRoute.Update();
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}