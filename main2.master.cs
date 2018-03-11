using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;
using System.Data;

public partial class main2 : System.Web.UI.MasterPage
{
    //建立业务逻辑层实例
    public GlobalConfig bll_config = new GlobalConfig();

    protected Category bll_category = new Category();
    private Product bll_product = new Product();
    protected List<CategoryModel> categoryList = new List<CategoryModel>();
    private SiteMenu bll_siteMenu = new SiteMenu();  //菜单
    protected List<SiteMenuModel> SiteMenuList = new List<SiteMenuModel>();
    protected List<SiteMenuModel> SiteMenuList1 = new List<SiteMenuModel>();
    public CategoryModel model = null;
    private AdFixed bll_adFixed = new AdFixed();
    protected AdFixedModel ad1 = new AdFixedModel();  //
    protected AdFixedModel ad2 = new AdFixedModel();  //
    protected AdFixedModel ad3 = new AdFixedModel();  //
    protected AdFixedModel ad4 = new AdFixedModel();  //
    protected AdFixedModel ad5 = new AdFixedModel();  //
    protected AdFixedModel ad6 = new AdFixedModel();  //微信
    protected AdFixedModel ad7 = new AdFixedModel();  //咨询2
    private PageSection bll_pageSection = new PageSection();
    public PageSectionModel pageSection = null;
    private int index=0;
    public Member bll_member = new Member();
    public int Index
    {
        get { return index; }
        set { index = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       // pageSection = bll_pageSection.GetModel("3");
        bll_config.Load(new string[] { "pageTitle", "headScript", "footScript", "foot2", "foreLogo2", "hotline" });
        
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
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
       
        //Head script
        if (!String.IsNullOrEmpty(bll_config["headScript"]))
        {
            HtmlGenericControl script = new HtmlGenericControl();
            script.InnerHtml = bll_config["headScript"];
            Page.Header.Controls.Add(script);
        }
        //Foot script
        bll_config["footScript"] += "\n" + bll_config.CheckPageEnabled();

        //固定广告位
        ad1 = bll_adFixed.GetModel(1);  //qq
        ad2 = bll_adFixed.GetModel(2);   //电话
        ad3 = bll_adFixed.GetModel(3);   //邮箱
        ad4 = bll_adFixed.GetModel(4);   //微博
        ad5 = bll_adFixed.GetModel(6);   //热线
        ad6 = bll_adFixed.GetModel(5);   //微信
        ad7 = bll_adFixed.GetModel(100);   //咨询2
        pageSection = bll_pageSection.GetModel(1);
        
        //Main Menu
        List<string> fieldList = new List<string>();
        fieldList.Add(SiteMenuModel.PKID);
        fieldList.Add(SiteMenuModel.TITLE);
        fieldList.Add(SiteMenuModel.URL);
        fieldList.Add(SiteMenuModel.TARGET);
        fieldList.Add(SiteMenuModel.RELATION);
        fieldList.Add(SiteMenuModel.RELATIONID);
        fieldList.Add(SiteMenuModel.HASCHILD);

        sqlWhereList.Clear();
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.FATHERID, SqlWhere.Oper.Equal, 19));
        SiteMenuList = bll_siteMenu.GetList(1, 10, fieldList, sqlWhereList, null);
       
    }
    public List<SiteMenuModel> getMenu(int Pkid,int gid)
    {
        List<string> fieldList = new List<string>();
        fieldList.Add(SiteMenuModel.TITLE);
        fieldList.Add(SiteMenuModel.URL);
        fieldList.Add(SiteMenuModel.TARGET);

        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.GROUPID, SqlWhere.Oper.Equal, gid));
        sqlWhereList.Add(new SqlWhere(SiteMenuModel.FATHERID, SqlWhere.Oper.Equal, Pkid));
        List<SiteMenuModel> siteMenuList2 = bll_siteMenu.GetList(0, 0, fieldList, sqlWhereList, null);
        return siteMenuList2;
    }
   
}