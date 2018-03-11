using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_msgTempManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private MsgTemp bll_msgTemp = new MsgTemp();

    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("系统_消息模板")) WebUtility.ShowError(WebUtility.ERROR101);
        
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
        //搜索控件
        MyTitle.Value = Request.QueryString["title"];
        
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(MsgTempModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(MsgTempModel.ENABLED, SqlWhere.Oper.Equal, true));

        //读取分页数据
        int iRecordsTotal = bll_msgTemp.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<MsgTempModel> msgTempList = bll_msgTemp.GetList(pagination.PageIndex, iPageSize, sqlWhereList, null);

        //绑定
        if (msgTempList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = msgTempList;
        Repeater1.DataBind();
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        MsgTempModel msgTemp = (MsgTempModel)e.Item.DataItem;
        ((HtmlTableCell)e.Item.FindControl("Eval_Mode")).InnerHtml = XMLHelper.GetXmlDataVal(msgTemp.Mode.ToString(), "MsgTempMode");
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}