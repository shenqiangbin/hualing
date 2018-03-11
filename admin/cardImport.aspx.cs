using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_cardImport : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Admin bll_admin = new Admin();
    private MemberCard bll_memberCard = new MemberCard();
    public FilespecModel filespec = null;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("产品_惠卡管理")) WebUtility.ShowError(WebUtility.ERROR101);

        filespec = new Filespec().GetModelByCode("excel");
        if (filespec == null) WebUtility.ShowError(WebUtility.ERROR103);
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string filePath = Server.MapPath(FilePath.Value);
            if (!String.IsNullOrEmpty(filePath))
            {
                bll_config.Load(new string[] { "excelUsername", "excelPassword", "cardNoPwdDigits" });
                DataTable dt_excel = ExcelHelper.Import(filePath, 12, bll_config["excelUsername"], bll_config["excelPassword"]);

                int cardNoPwdDigits = bll_config.GetInt("cardNoPwdDigits");
                if (cardNoPwdDigits <= 0)
                {
                    FileHelper.DeleteFile(filePath);
                    WebUtility.ShowAlertMessage("惠卡密码位数必须大于零，请在全局功能中进行设置！", null);
                }

                for (int i = 0; i < dt_excel.Rows.Count; i++)
                {
                    DataRow dr = dt_excel.Rows[i];

                    string cardNo = dr[0].ToString();
                    if (String.IsNullOrEmpty(cardNo) || bll_memberCard.CardNoExists(cardNo)) continue;

                    MemberCardModel memberCard = new MemberCardModel();
                    memberCard.CardNo = cardNo;
                    memberCard.Pwd = StringHelper.GetRandomString(cardNoPwdDigits);
                    if (dr[1].ToString() == "0") memberCard.Sold = false;
                    else memberCard.Sold = true;
                    memberCard.CreateTime = DateTime.Now.ToString();

                    bll_memberCard.Insert(memberCard);
                }

                FileHelper.DeleteFile(filePath);
                WebUtility.ShowAlertMessage("上传成功！", Request.RawUrl);
            }
            else WebUtility.ShowAlertMessage("上传失败，请查看文件格式与大小是否符合系统要求！", null);
        }
    }
}