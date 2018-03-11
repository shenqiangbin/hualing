using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_orderManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Member bll_member = new Member();
    private Orders bll_orders = new Orders();

    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    NumberFormatInfo nfi = new CultureInfo("zh-CN", false).NumberFormat;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("用户_订单管理")) WebUtility.ShowError(WebUtility.ERROR101);
        
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
        if (!String.IsNullOrEmpty(Request.QueryString["title"])) MyTitle.Value = Request.QueryString["title"];
        if (!String.IsNullOrEmpty(Request.QueryString["uid"])) Username.Value = Request.QueryString["uid"];
        if (!String.IsNullOrEmpty(Request.QueryString["date1"])) Date1.Value = Request.QueryString["date1"];
        if (!String.IsNullOrEmpty(Request.QueryString["date2"])) Date2.Value = Request.QueryString["date2"];
        XMLHelper.SetCtrlByXmlData(Status, "--状态--", "OrderStatus", Request.QueryString["stat"]);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(OrdersModel.MEMBERID, SqlWhere.Oper.Join, MemberModel.PKID));
        sqlWhereList.Add(new SqlWhere(MemberModel.USERNAME, SqlWhere.Oper.Equal, Request.QueryString["uid"]));
        sqlWhereList.Add(new SqlWhere(OrdersModel.TRACKID, SqlWhere.Oper.Equal, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(OrdersModel.CREATETIME, SqlWhere.Oper.MoreEqual, Request.QueryString["date1"]));
        sqlWhereList.Add(new SqlWhere(OrdersModel.CREATETIME, SqlWhere.Oper.LessEqual, Request.QueryString["date2"]));
        sqlWhereList.Add(new SqlWhere(OrdersModel.STATUS, SqlWhere.Oper.Equal, Request.QueryString["stat"]));

        //计算总金额
        decimal total = 0;
        List<string> fieldList = new List<string>();
        fieldList.Add(OrdersModel.PRICE);
        List<OrdersModel> ordersList = bll_orders.GetList(0, 0, fieldList, sqlWhereList, null);
        foreach (OrdersModel model in ordersList) total += model.Price;
        Total.InnerHtml = "总计：<span class='price'>" + total.ToString("C0", nfi) + "</span>";

        //读取分页数据
        int iRecordsTotal = bll_orders.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        ordersList = bll_orders.GetList(pagination.PageIndex, iPageSize, sqlWhereList, null);

        //绑定
        if (ordersList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = ordersList;
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

        if (cmd == "pay") bll_orders.UpdateStatus(ids);
        else if (cmd == "del") bll_orders.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        OrdersModel orders = (OrdersModel)e.Item.DataItem;

        MemberModel member = bll_member.GetModel(orders.MemberId.ToString());
        string username = "#未知#";
        if (member != null) username = member.Username + " ( " + member.Realname + " )";

        ((HtmlTableCell)e.Item.FindControl("Eval_Member")).InnerHtml = username;
        ((HtmlTableCell)e.Item.FindControl("Eval_PayWay")).InnerText = XMLHelper.GetXmlDataVal(orders.PayWay.ToString(), "PayWay");
        ((HtmlTableCell)e.Item.FindControl("Eval_Price")).InnerText = orders.Price.ToString("C0", nfi);
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_orders.GetStatus(orders, "stat");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(orders.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("uid", Username.Value);
        httpHelper.AddUrlParm("date1", Date1.Value);
        httpHelper.AddUrlParm("date2", Date2.Value);
        httpHelper.AddUrlParm("stat", Status.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}