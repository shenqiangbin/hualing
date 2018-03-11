using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_msgTempEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private MsgTemp bll_msgTemp = new MsgTemp();
    public MsgTempModel msgTemp = null;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("系统_消息模板")) WebUtility.ShowError(WebUtility.ERROR101);

        msgTemp = bll_msgTemp.GetModel(Request.QueryString["pkid"]);
        if (msgTemp == null) WebUtility.ShowError(WebUtility.ERROR102);

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
        ScriptLabel.Visible = SubjectTr.Visible = msgTemp.Mode != 3;
        
        Mode.InnerText = XMLHelper.GetXmlDataVal(msgTemp.Mode.ToString(), "MsgTempMode");
        if (msgTemp.Mode == 1) Subject.Value = msgTemp.Subject;
        MyContent.Value = msgTemp.Content;
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (msgTemp.Mode == 1) msgTemp.Subject = Subject.Value;
            msgTemp.Content = MyContent.Value.Trim();
            bll_msgTemp.Update(msgTemp);
            WebUtility.ShowAlertMessage("保存成功！", "msgTempManage.aspx" + param);
        }
    }
}