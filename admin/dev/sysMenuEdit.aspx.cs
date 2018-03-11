using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_sysMenuEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private SystemMenu bll_systemMenu = new SystemMenu();
    public SystemMenuModel systemMenu = null;
    public string myhead = String.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        
        systemMenu = bll_systemMenu.GetModel(Request.QueryString["pkid"]);
        if (systemMenu == null) systemMenu = new SystemMenuModel();

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
        if (systemMenu.Pkid > 0)
        {
            myhead = "编辑";
            Pkid.InnerText = systemMenu.Pkid.ToString();
            MyTitle.Value = systemMenu.Title;
            LinkUrl.Value = systemMenu.Url;
            AddPageUrl.Value = systemMenu.AddPageUrl;
            FatherId.Value = systemMenu.FatherId.ToString();
            Enabled.Checked = systemMenu.Enabled;
            IsOpen.Checked = systemMenu.IsOpen;
        }
        else
        {
            myhead = "新增";
            Enabled.Checked = true;
            IsOpen.Checked = true;
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(FatherId.Value)) WebUtility.ShowAlertMessage("请填写父级ID！", null);
            
            systemMenu.Title = MyTitle.Value;
            systemMenu.Url = LinkUrl.Value;
            systemMenu.AddPageUrl = AddPageUrl.Value;
            systemMenu.IsOpen = IsOpen.Checked;
            systemMenu.Enabled = Enabled.Checked;

            if (systemMenu.Pkid > 0)
            {
                //更改
                bll_systemMenu.Update(systemMenu, FatherId.Value, Request.Form["sort"]);
                WebUtility.ShowAlertMessage("保存成功！", "sysMenuManage.aspx");
            }
            else
            {
                //增加
                systemMenu.FatherId = Convert.ToInt32(FatherId.Value);
                systemMenu.CreateTime = DateTime.Now.ToString();
                bll_systemMenu.Insert(systemMenu);
                bll_systemMenu.Update(systemMenu, FatherId.Value, Request.Form["sort"]);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}