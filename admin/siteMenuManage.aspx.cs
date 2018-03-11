using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_siteMenuManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();
    private SiteMenu bll_siteMenu = new SiteMenu();
    public string groupId;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("全局_导航菜单")) WebUtility.ShowError(WebUtility.ERROR101);

        //获取导航组
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.FATHERID, SqlWhere.Oper.Equal, 0));
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
        List<SiteMenuModel> siteMenuList = bll_siteMenu.GetList(sqlWhereList);
        Repeater1.DataSource = siteMenuList;
        Repeater1.DataBind();

        if (siteMenuList.Count == 0) WebUtility.ShowError(WebUtility.ERROR102);

        //获取当前导航组ID
        foreach (SiteMenuModel siteMenu in siteMenuList)
        {
            if (siteMenu.Pkid.ToString() == Request.QueryString["gid"])
            { groupId = Request.QueryString["gid"]; break; }
        }
        if (String.IsNullOrEmpty(groupId)) groupId = siteMenuList[0].Pkid.ToString();

        //获取类别组
        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(CategoryModel.FATHERID, SqlWhere.Oper.Equal, 0));
        sqlWhereList.Add(new SqlWhere(CategoryModel.ENABLED, SqlWhere.Oper.Equal, true));
        List<CategoryModel> categoryList = bll_category.GetList(sqlWhereList);
        Repeater2.DataSource = categoryList;
        Repeater2.DataBind();
    }
}