using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_msgTempEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private MsgTemp bll_msgTemp = new MsgTemp();
    public MsgTempModel msgTemp = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        msgTemp = bll_msgTemp.GetModel(Request.QueryString["pkid"]);
        if (msgTemp == null) msgTemp = new MsgTempModel();

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
        XMLHelper.SetCtrlByXmlData(Mode, "MsgTempMode", msgTemp.Mode.ToString());

        if (msgTemp.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = msgTemp.Title;
            Notes.Value = msgTemp.Notes;
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(Mode.SelectedValue)) WebUtility.ShowAlertMessage("请选择页面形式！", null);

            msgTemp.Title = MyTitle.Value;
            msgTemp.Mode = Convert.ToInt32(Mode.SelectedValue);
            msgTemp.Notes = Notes.Value;

            if (msgTemp.Pkid > 0)
            {
                //更改
                bll_msgTemp.Update(msgTemp);
                WebUtility.ShowAlertMessage("保存成功！", "msgTempManage.aspx" + param);
            }
            else
            {
                //增加
                msgTemp.Enabled = true;
                msgTemp.CreateTime = DateTime.Now.ToString();
                bll_msgTemp.Insert(msgTemp);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}