using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_main : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Admin bll_admin = new Admin();
    private SystemMenu bll_systemMenu = new SystemMenu();
    public AdminModel admin;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            WebUtility.AdminLoginAuth();
            admin = bll_admin.GetModelByCookie();

            if (!Page.IsPostBack)
            {
                BindInfo();
            }
        }
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        GlobalConfigModel config = bll_config.GetModelByKey("backLogo");
        if (!String.IsNullOrEmpty(config.ValuePc)) Logo.InnerHtml = "<img src=\"" + config.ValuePc + "\" />";

        AdminModel admin = bll_admin.GetModelByCookie();
        Nickname.InnerText = bll_admin.GetName(admin);

        //初始化论坛今日数据
        new ForumMenu().InitTodayData();
    }

    //创建菜单
    public StringBuilder CreateSysMenu(int fatherId, string fatherCode)
    {
        StringBuilder strHtml = new StringBuilder();
        if (fatherId > 0) strHtml.Append("<ul id=\"sub").Append(fatherId).Append("\" class=\"children\">");

        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SystemMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(SystemMenuModel.FATHERID, SqlWhere.Oper.Equal, fatherId));
        List<SystemMenuModel> menuList = bll_systemMenu.GetList(sqlWhereList);

        foreach (SystemMenuModel menu in menuList)
        {
            string ruleCode = menu.Title;
            if (!String.IsNullOrEmpty(fatherCode)) ruleCode = fatherCode + "_" + ruleCode;
            if (!bll_admin.RuleAuth(ruleCode, admin)) continue;

            string rel = String.Empty;
            if (menu.HasChild) rel = " rel=\"sub" + menu.Pkid.ToString() + "\"";

            strHtml.Append("<li>");
            strHtml.Append("<a url=\"").Append(menu.Url).Append("\" val=\"").Append(menu.Pkid).Append("\"").Append(rel).Append(">").Append(menu.Title).Append("</a>");
            //if (!String.IsNullOrEmpty(menu.AddPageUrl)) strHtml.Append(" <span url=\"").Append(menu.AddPageUrl).Append("\" val=\"").Append(menu.Pkid).Append("\" onclick=\"aClick($(this));\" key=\"").Append(menu.Title).Append("\" title=\"新增\"></span>");
            if (menu.HasChild) strHtml.Append(CreateSysMenu(menu.Pkid, menu.Title));
            strHtml.Append("</li>");
        }

        if (fatherId > 0) strHtml.Append("</ul>");
        return strHtml;
    }
}
