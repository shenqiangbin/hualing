using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_starEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Member bll_member = new Member();
    private ForumUserState bll_forumUserState = new ForumUserState();
    public ForumUserStateModel userState = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("论坛_论坛明星")) WebUtility.ShowError(WebUtility.ERROR101);

        userState = bll_forumUserState.GetModel(Request.QueryString["pkid"]);
        if (userState == null || !userState.ForumStar) userState = new ForumUserStateModel();

        if (userState.ForumStar)
        {
            InfoPanel.Visible = true;
            EditPanel.Visible = false;
        }

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
        if (userState.ForumStar)
        {
            myhead = "编辑";
            MemberModel member = bll_member.GetModel(userState.UserId);
            if (member == null) Uname.InnerText = "#未知用户#";
            else Uname.InnerText = member.Username;
            Sort.Value = userState.ForumStarSort.ToString();
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {        
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(Sort.Value)) WebUtility.ShowAlertMessage("自定义排序应使用数字填写！", null);
            userState.ForumStarSort = Convert.ToInt32(Sort.Value);

            if (userState.Pkid > 0)
            {
                bll_forumUserState.Update(userState);
                WebUtility.ShowAlertMessage("保存成功！", "starManage.aspx" + param);
            }
            else
            {
                //增加
                MemberModel member = bll_member.GetModelByUsername(Username.Value);
                if (member == null) WebUtility.ShowAlertMessage("没有找到指定会员！", null);

                userState = bll_forumUserState.GetModelByUserId(member.Pkid);
                if (userState == null)
                {
                    userState = new ForumUserStateModel();
                    userState.UserId = member.Pkid;
                }
                userState.ForumStar = true;
                bll_forumUserState.Update(userState);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}