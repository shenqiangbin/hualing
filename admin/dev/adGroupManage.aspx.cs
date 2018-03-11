using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_adGroupManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private AdGroup bll_adGroup = new AdGroup();

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        
        if (!Page.IsPostBack)
        {
            Action();
            BindInfo();
        }
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //搜索控件
        MyTitle.Value = Request.QueryString["title"];
        XMLHelper.SetCtrlByXmlData(Display, "--展示方式--", "AdDisplay", Request.QueryString["stat"]);
        WebUtility.BindHtmlSelectByBool(Inbuilt, "--系统内置--", "是", "否", Request.QueryString["enab"]);
        
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(AdGroupModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(AdGroupModel.DISPLAY, SqlWhere.Oper.Equal, Request.QueryString["stat"]));
        sqlWhereList.Add(new SqlWhere(AdGroupModel.INBUILT, SqlWhere.Oper.Equal, Request.QueryString["enab"]));
        List<AdGroupModel> adGroupList = bll_adGroup.GetList(sqlWhereList);

        //绑定
        if (adGroupList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = adGroupList;
        Repeater1.DataBind();
    }

    /// <summary>
    /// 执行操作的方法
    /// </summary>
    private void Action()
    {
        string cmd = Request["cmd"];
        if (String.IsNullOrEmpty(cmd)) return;
        string ids = Request.QueryString["ids"];

        if (cmd == "del") bll_adGroup.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        AdGroupModel adGroup = (AdGroupModel)e.Item.DataItem;
        ((HtmlTableCell)e.Item.FindControl("Eval_Display")).InnerText = XMLHelper.GetXmlDataVal(adGroup.Display.ToString(), "AdDisplay");
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_adGroup.GetStatus(adGroup, "in");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(adGroup.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("stat", Display.Value);
        httpHelper.AddUrlParm("enab", Inbuilt.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}