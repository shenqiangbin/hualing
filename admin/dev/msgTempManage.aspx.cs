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
    private MsgTemp bll_msgTemp = new MsgTemp();

    //设置页面大小
    int iPageSize = 20;

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
        XMLHelper.SetCtrlByXmlData(Mode, "--消息类型--", "MsgTempMode", Request.QueryString["gid"]);
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);
        
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(MsgTempModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(MsgTempModel.MODE, SqlWhere.Oper.Equal, Request.QueryString["gid"]));
        sqlWhereList.Add(new SqlWhere(MsgTempModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));

        //读取分页数据
        int iRecordsTotal = bll_msgTemp.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<MsgTempModel> messageTemplateList = bll_msgTemp.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定
        if (messageTemplateList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = messageTemplateList;
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

        if (cmd == "enab") bll_msgTemp.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_msgTemp.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        MsgTempModel msgTemp = (MsgTempModel)e.Item.DataItem;
        ((HtmlTableCell)e.Item.FindControl("Eval_Mode")).InnerHtml = XMLHelper.GetXmlDataVal(msgTemp.Mode.ToString(), "MsgTempMode");
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_msgTemp.GetStatus(msgTemp, "enab");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(msgTemp.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("gid", Mode.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}