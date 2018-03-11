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

public partial class admin_orderShow : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Product bll_product = new Product();
    private Orders bll_orders = new Orders();
    private OrderDetail bll_orderDetail = new OrderDetail();
    public OrdersModel orders = null;

    public string param = WebUtility.GetUrlParams("?", true);
    NumberFormatInfo nfi = new CultureInfo("zh-CN", false).NumberFormat;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("用户_订单管理")) WebUtility.ShowError(WebUtility.ERROR101);

        orders = bll_orders.GetModel(Request.QueryString["pkid"]);
        if (orders == null) WebUtility.ShowError(WebUtility.ERROR102);
        
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
        //订单
        Price.InnerText = orders.Price.ToString("C0", nfi);
        PayWay.InnerText = XMLHelper.GetXmlDataVal(orders.PayWay.ToString(), "PayWay");
        Status.InnerHtml = bll_orders.GetStatus(orders, "stat");

        MemberModel member = new Member().GetModel(orders.MemberId.ToString());
        string username = "#未知#";
        if (member != null) username = member.Username + " ( " + member.Realname + " )";
        MemberUname.InnerText = username;
        
        //订单明细
        List<OrderDetailModel> orderDetailList = bll_orderDetail.GetListByOrderId(orders.Pkid);
        if (orderDetailList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = orderDetailList;
        Repeater1.DataBind();
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        OrderDetailModel orderDetail = (OrderDetailModel)e.Item.DataItem;

        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerText = bll_product.GetTitle(orderDetail.ProId);
        ((HtmlTableCell)e.Item.FindControl("Eval_Price")).InnerText = orderDetail.Price.ToString("C0", nfi);
        ((HtmlTableCell)e.Item.FindControl("Eval_Notes")).InnerText = orderDetail.Notes.Replace(",", " , ");
    }
}