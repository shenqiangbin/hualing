using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_agentEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Member bll_member = new Member();
    public MemberModel member = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("用户_代理商管理")) WebUtility.ShowError(WebUtility.ERROR101);

        member = bll_member.GetModel(Request.QueryString["pkid"]);
        if (member == null) member = new MemberModel();

        if (member.AgentArea > 0)
        {
            InfoPanel.Visible = true;
            UnamePanel.Visible = false;
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
        if (member.AgentArea > 0)
        {
            myhead = "编辑";
            AreaId.Value = member.AgentArea.ToString();
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {        
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(AreaId.Value)) WebUtility.ShowAlertMessage("请选择代理地区！", null);

            if (member.AgentArea > 0)
            {
                //更改
                if (AreaId.Value != member.AgentArea.ToString())
                {
                    member.AgentCreateTime = DateTime.Now.ToString();
                    member.AgentArea = Convert.ToInt32(AreaId.Value);
                    bll_member.Update(member);
                }
                WebUtility.ShowAlertMessage("保存成功！", "agentManage.aspx" + param);
            }
            else
            {
                //增加
                member = bll_member.GetModelByUsername(Username.Value);
                if (member == null) WebUtility.ShowAlertMessage("没有找到指定会员！", null);
                member.AgentArea = Convert.ToInt32(AreaId.Value);
                member.AgentCreateTime = DateTime.Now.ToString();
                bll_member.Update(member);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}