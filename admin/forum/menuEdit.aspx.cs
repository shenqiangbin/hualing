using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_menuEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private ForumMenu bll_forumMenu = new ForumMenu();
    private UrlRoute bll_urlRoute = new UrlRoute();
    public FilespecModel filespec = null;
    public ForumMenuModel forumMenu = null, group = null;

    public string param = WebUtility.GetUrlParams("?", true);
    public string myhead = String.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("论坛_论坛版块")) WebUtility.ShowError(WebUtility.ERROR101);
        
        forumMenu = bll_forumMenu.GetModel(Request.QueryString["pkid"]);
        if (forumMenu == null) forumMenu = new ForumMenuModel();

        filespec = new Filespec().GetModelByCode("thum");
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
        if (forumMenu.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = forumMenu.Title;
            Descn.Value = forumMenu.Descn;
            if (!String.IsNullOrEmpty(forumMenu.Moderators)) Moderators.Value = forumMenu.Moderators.Replace(",", "\n").Trim();
            Pic.Value = forumMenu.Pic;
            PageTitle.Value = forumMenu.PageTitle;
            Keywords.Value = forumMenu.Keywords;
            UrlAlias.Value = forumMenu.UrlAlias;
            FatherId.Value = forumMenu.FatherId.ToString();
            IsReco.Checked = forumMenu.IsReco;
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(FatherId.Value)) WebUtility.ShowAlertMessage("请填写父版块ID！", null);
            
            forumMenu.Title = MyTitle.Value;
            forumMenu.Descn = Descn.Value;
            forumMenu.Moderators = Moderators.Value;
            forumMenu.PageTitle = PageTitle.Value;
            if (!String.IsNullOrEmpty(Keywords.Value)) forumMenu.Keywords = Keywords.Value.Replace("，", ",");
            else forumMenu.Keywords = Keywords.Value;
            forumMenu.Pic = Pic.Value;
            forumMenu.UrlAlias = UrlAlias.Value;
            forumMenu.IsReco = IsReco.Checked;

            if (forumMenu.Pkid > 0)
            {                
                //更改
                int result = bll_forumMenu.Update(forumMenu, FatherId.Value, Request.Form["sort"]);

                if (result == 101) WebUtility.ShowAlertMessage("没有找到相关父版块！", null);
                else if (result == 102) WebUtility.ShowAlertMessage("所选父版块为最终版块，无法添加子版块，请重新选择父版块！", null);
                else if (result == 103) WebUtility.ShowAlertMessage("没有找到显示位置！", null);

                bll_urlRoute.Update();
                WebUtility.ShowAlertMessage("保存成功！", "menuManage.aspx" + param);
            }
            else
            {
                //增加
                forumMenu.FatherId = Convert.ToInt32(FatherId.Value);
                int result = bll_forumMenu.Insert(forumMenu);

                if (result == 101) WebUtility.ShowAlertMessage("没有找到相关父版块！", null);
                else if (result == 102) WebUtility.ShowAlertMessage("所选父版块为最终版块，无法添加子版块，请重新选择父版块！", null);

                result = bll_forumMenu.Update(forumMenu, FatherId.Value, Request.Form["sort"]);
                if (result == 103) WebUtility.ShowAlertMessage("没有找到显示位置！", null);

                bll_urlRoute.Update();
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}