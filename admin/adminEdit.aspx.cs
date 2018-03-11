using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_adminEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private SystemMenu bll_systemMenu = new SystemMenu();
    public AdminModel admin = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("系统_管理员设置")) WebUtility.ShowError(WebUtility.ERROR101);

        admin = bll_admin.GetModel(Request.QueryString["pkid"]);
        if (admin == null) admin = new AdminModel();

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
        sqlWhereList.Add(new SqlWhere(SystemMenuModel.FATHERID, SqlWhere.Oper.Equal, 0));
        sqlWhereList.Add(new SqlWhere(SystemMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
        List<SystemMenuModel> systemMenuList = bll_systemMenu.GetList(sqlWhereList);
        Repeater1.DataSource = systemMenuList;
        Repeater1.DataBind();
        
        if (admin.Pkid > 0)
        {           
            myhead = "编辑";
            Realname.Value = admin.Realname;
            Username.Value = admin.Username;
            Notes.Value = admin.Notes;
            Enabled.Checked = admin.Enabled;

            if (admin.Inbuilt)
            {
                RuleTr1.Visible = false;
                RuleTr2.Visible = true;
            }
        }
        else myhead = "新增";
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        SystemMenuModel systemMenu = (SystemMenuModel)e.Item.DataItem;

        Repeater repeater = (Repeater)e.Item.FindControl("Repeater1_2");
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SystemMenuModel.FATHERID, SqlWhere.Oper.Equal, systemMenu.Pkid));
        sqlWhereList.Add(new SqlWhere(SystemMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
        List<SystemMenuModel> systemMenuList = bll_systemMenu.GetList(sqlWhereList);
        repeater.DataSource = systemMenuList;
        repeater.DataBind();
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (admin.Username != Username.Value)
            {
                if (String.IsNullOrEmpty(Username.Value) || !Regex.IsMatch(Username.Value, @"^\w{5,20}$"))
                    WebUtility.ShowAlertMessage("请输入用户名，用户只能使用5-20位的字母、数字、下划线组合", null);
                if (bll_admin.UnameExists(Username.Value)) WebUtility.ShowAlertMessage("用户名已存在，请重新选择！", null);

                admin.Username = Username.Value;
            }

            if (String.IsNullOrEmpty(Pwd.Value) || StringHelper.StringLength(Pwd.Value) < 6)
                WebUtility.ShowAlertMessage("请输入密码，密码应使用6位以上的字符组成", null);

            if (!String.IsNullOrEmpty(Pwd.Value) && Pwd.Value != "········")
                admin.Pwd = Encryption.Md5(Pwd.Value);

            if (!admin.Inbuilt)
            {
                if (Request.Form["checkAll"] == "all") admin.AccessRule = "all";
                else admin.AccessRule = Request.Form["g2"];
            }

            admin.Realname = Realname.Value;
            admin.Notes = Notes.Value;
            admin.Enabled = Enabled.Checked;

            if (admin.Pkid > 0)
            {
                //更改
                bll_admin.Update(admin);
                WebUtility.ShowAlertMessage("保存成功！", "adminManage.aspx" + param);
            }
            else
            {
                //增加
                admin.Creator = Convert.ToInt32(bll_admin.CookieId);
                admin.CreateTime = DateTime.Now.ToString();
                bll_admin.Insert(admin);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}
